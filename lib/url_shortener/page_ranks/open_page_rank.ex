defmodule UrlShortener.PageRanks.OpenPageRank do
  defstruct [
    :domain,
    :error,
    :page_rank_decimal,
    :page_rank_integer,
    :rank,
    :status_code,
    :last_updated
  ]

  @page_rank_url "https://openpagerank.com/api/v1.0/getPageRank" |> URI.parse()

  def get_page_rank(domains) do
    with {:ok, %{status_code: 200, body: body}} <- request_page_rank(domains),
         {:ok, %{"response" => response, "last_updated" => last_updated}} <- Jason.decode(body) do
      converted =
        response
        |> Enum.map(&map_response_to_struct/1)
        |> Enum.map(&struct(&1, last_updated: last_updated))

      {:ok, converted}
    end
  end

  defp request_page_rank(domains) do
    api_key = Application.get_env(:url_shortener, :open_page_rank_api_key)
    headers = [{"API-OPR", api_key}]

    encoded =
      domains
      |> Enum.with_index(fn domain, index ->
        {"domains[#{index}]", domain}
      end)
      |> URI.encode_query()

    url =
      @page_rank_url
      |> struct(query: encoded)
      |> URI.to_string()
      |> IO.inspect()

    HTTPoison.get(url, headers)
  end

  defp map_response_to_struct(%{
         "domain" => domain,
         "error" => error,
         "page_rank_decimal" => page_rank_decimal,
         "page_rank_integer" => page_rank_integer,
         "rank" => rank,
         "status_code" => status_code
       }) do
    %__MODULE__{
      domain: domain,
      error: error,
      page_rank_decimal: page_rank_decimal,
      page_rank_integer: page_rank_integer,
      rank: rank,
      status_code: status_code,
    }
  end
end

defmodule UrlShortener.Urls do
  @moduledoc """
  The Urls context.
  """

  import Ecto.Query, warn: false
  alias UrlShortener.Repo

  alias UrlShortener.Urls.Url

  alias UrlShortener.PageRanks

  @doc """
  Returns the list of urls.
  """
  def list_urls do
    Repo.all(Url)
  end

  @doc """
  Gets a single url.
  """
  def get_url!(id), do: Repo.get!(Url, id)

  def get_url_by_str(url) do
    Repo.all(
      from u in Url,
        where: u.url == ^url,
        limit: 1
    )
  end

  def get_or_create_url_from_str(url) do
    case get_url_by_str(url) do
      [] -> create_url_from_str(url)
      [url] -> url
    end
  end

  def create_url_from_str(url) do
    short_key = Application.fetch_env!(:url_shortener, :key_byte_count) |> short_key()

    case PageRanks.get_or_create_page_rank_by_domain(url) do
      {:ok, page_rank} ->
        create_url(page_rank, %{
          url: url,
          expires_at: expiration_date(page_rank.rank),
          short_key: short_key
        })

      {:error, _} ->
        create_url(nil, %{
          url: url,
          expires_at: expiration_date(),
          short_key: short_key
        })
    end
  end

  @doc """
  Creates a url.
  """
  def create_url(page_rank, attrs \\ %{}) do
    %Url{}
    |> Url.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:page_rank, page_rank)
    |> Repo.insert()
  end

  @doc """
  Updates a url.
  """
  def update_url(%Url{} = url, attrs) do
    url
    |> Url.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a url.
  """
  def delete_url(%Url{} = url) do
    Repo.delete(url)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking url changes.
  """
  def change_url(%Url{} = url, attrs \\ %{}) do
    Url.changeset(url, attrs)
  end

  defp expiration_date() do
    Application.fetch_env!(:url_shortener, :default_expiration)
    |> expiration_date()
  end

  defp expiration_date(d), do: DateTime.utc_now() |> DateTime.add(d, :seconds)

  def short_key(bytes_count) do
    bytes_count
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64(padding: false)
  end
end

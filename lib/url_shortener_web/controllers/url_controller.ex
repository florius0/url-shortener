defmodule UrlShortenerWeb.UrlController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.Urls
  alias UrlShortener.Urls.Url

  action_fallback UrlShortenerWeb.FallbackController

  def create(conn, %{"url" => url}) do
    with {:ok, %Url{} = url} <- Urls.create_url_from_str(url) do
      conn
      |> put_status(:created)
      |> render("url.json", url: url)
    end
  end

  def create(conn, _), do: send_resp(conn, :bad_request, "Expected query to have a 'url' key")

  def show(conn, %{"key" => key}) do
    case Urls.get_url_by(short_key: key) do
      nil ->
        conn
        |> put_status(:not_found)
        |> send_resp()

      url ->
        conn
        |> put_status(:ok)
        |> render("url.json", url: url)
    end
  end

  def show(conn, _), do: send_resp(conn, :bad_request, "Expected query to have a 'key' key")
end

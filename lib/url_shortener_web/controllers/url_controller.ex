defmodule UrlShortenerWeb.UrlController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.Urls
  alias UrlShortener.Urls.Url
  alias UrlShortenerWeb.ErrorView

  action_fallback UrlShortenerWeb.FallbackController

  def create(conn, %{"url" => url}) do
    with {:ok, %Url{} = url} <- Urls.create_url_from_str(url) do
      conn
      |> put_status(:created)
      |> render("url.json", url: url)
    end
  end

  def create(conn, _) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("errors.json", errors: "Expected query to have a 'url' key")
  end

  def show(conn, %{"key" => key}) do
    case Urls.get_url_by(short_key: key) do
      nil ->
        conn
        |> put_status(:not_found)
        |> put_view(ErrorView)
        |> render("errors.json", errors: ["URL not found"])

      url ->
        conn
        |> put_status(:ok)
        |> render("url.json", url: url)
    end
  end

  def show(conn, _) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("errors.json", errors: ["Expected query to have a 'key' key"])
  end
end

defmodule UrlShortenerWeb.UrlView do
  use UrlShortenerWeb, :view

  def render("url.json", %{url: url}) do
    %{
      url: url.url,
      key: url.short_key,
      expires_at: url.expires_at,
      days_left: days_left(url.expires_at)
    }
  end

  def days_left(datetime) do
    datetime
    |> NaiveDateTime.diff(NaiveDateTime.utc_now(), :day)
  end
end

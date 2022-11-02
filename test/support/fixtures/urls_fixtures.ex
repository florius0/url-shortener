defmodule UrlShortener.UrlsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `UrlShortener.Urls` context.
  """

  @doc """
  Generate a page_rank.
  """
  def page_rank_fixture(attrs \\ %{}) do
    {:ok, page_rank} =
      attrs
      |> Enum.into(%{
        last_updated: ~N[2022-11-01 14:20:00],
        rank: 42,
        url: "some url"
      })
      |> UrlShortener.Urls.create_page_rank()

    page_rank
  end

  @doc """
  Generate a url.
  """
  def url_fixture(attrs \\ %{}) do
    {:ok, url} =
      attrs
      |> Enum.into(%{
        expires_at: ~N[2022-11-01 14:22:00],
        short_key: "some short_key",
        url: "some url"
      })
      |> UrlShortener.Urls.create_url()

    url
  end
end

defmodule UrlShortener.PageRanksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `UrlShortener.PageRanks` context.
  """

  @doc """
  Generate a page_rank.
  """
  def page_rank_fixture(attrs \\ %{}) do
    {:ok, page_rank} =
      attrs
      |> Enum.into(%{
        last_updated: "some last_updated",
        rank: 42,
        url: "some url"
      })
      |> UrlShortener.PageRanks.create_page_rank()

    page_rank
  end
end

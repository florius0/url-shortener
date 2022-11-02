defmodule UrlShortenerWeb.PageRankView do
  use UrlShortenerWeb, :view
  alias UrlShortenerWeb.PageRankView

  def render("index.json", %{page_ranks: page_ranks}) do
    %{data: render_many(page_ranks, PageRankView, "page_rank.json")}
  end

  def render("show.json", %{page_rank: page_rank}) do
    %{data: render_one(page_rank, PageRankView, "page_rank.json")}
  end

  def render("page_rank.json", %{page_rank: page_rank}) do
    %{
      id: page_rank.id,
      url: page_rank.url,
      rank: page_rank.rank,
      last_updated: page_rank.last_updated
    }
  end
end

defmodule UrlShortenerWeb.PageRankController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.PageRanks
  alias UrlShortener.PageRanks.PageRank

  action_fallback UrlShortenerWeb.FallbackController

  def index(conn, _params) do
    page_ranks = PageRanks.list_page_ranks()
    render(conn, "index.json", page_ranks: page_ranks)
  end

  def create(conn, %{"page_rank" => page_rank_params}) do
    with {:ok, %PageRank{} = page_rank} <- PageRanks.create_page_rank(page_rank_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.page_rank_path(conn, :show, page_rank))
      |> render("show.json", page_rank: page_rank)
    end
  end

  def show(conn, %{"id" => id}) do
    page_rank = PageRanks.get_page_rank!(id)
    render(conn, "show.json", page_rank: page_rank)
  end

  def update(conn, %{"id" => id, "page_rank" => page_rank_params}) do
    page_rank = PageRanks.get_page_rank!(id)

    with {:ok, %PageRank{} = page_rank} <- PageRanks.update_page_rank(page_rank, page_rank_params) do
      render(conn, "show.json", page_rank: page_rank)
    end
  end

  def delete(conn, %{"id" => id}) do
    page_rank = PageRanks.get_page_rank!(id)

    with {:ok, %PageRank{}} <- PageRanks.delete_page_rank(page_rank) do
      send_resp(conn, :no_content, "")
    end
  end
end

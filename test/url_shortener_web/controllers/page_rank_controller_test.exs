defmodule UrlShortenerWeb.PageRankControllerTest do
  use UrlShortenerWeb.ConnCase

  import UrlShortener.UrlsFixtures

  alias UrlShortener.Urls.PageRank

  @create_attrs %{
    last_updated: ~N[2022-11-01 14:20:00],
    rank: 42,
    url: "some url"
  }
  @update_attrs %{
    last_updated: ~N[2022-11-02 14:20:00],
    rank: 43,
    url: "some updated url"
  }
  @invalid_attrs %{last_updated: nil, rank: nil, url: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all page_ranks", %{conn: conn} do
      conn = get(conn, Routes.page_rank_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create page_rank" do
    test "renders page_rank when data is valid", %{conn: conn} do
      conn = post(conn, Routes.page_rank_path(conn, :create), page_rank: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.page_rank_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "last_updated" => "2022-11-01T14:20:00",
               "rank" => 42,
               "url" => "some url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.page_rank_path(conn, :create), page_rank: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update page_rank" do
    setup [:create_page_rank]

    test "renders page_rank when data is valid", %{conn: conn, page_rank: %PageRank{id: id} = page_rank} do
      conn = put(conn, Routes.page_rank_path(conn, :update, page_rank), page_rank: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.page_rank_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "last_updated" => "2022-11-02T14:20:00",
               "rank" => 43,
               "url" => "some updated url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, page_rank: page_rank} do
      conn = put(conn, Routes.page_rank_path(conn, :update, page_rank), page_rank: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete page_rank" do
    setup [:create_page_rank]

    test "deletes chosen page_rank", %{conn: conn, page_rank: page_rank} do
      conn = delete(conn, Routes.page_rank_path(conn, :delete, page_rank))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.page_rank_path(conn, :show, page_rank))
      end
    end
  end

  defp create_page_rank(_) do
    page_rank = page_rank_fixture()
    %{page_rank: page_rank}
  end
end

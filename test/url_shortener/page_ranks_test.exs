defmodule UrlShortener.PageRanksTest do
  use UrlShortener.DataCase

  alias UrlShortener.PageRanks

  describe "page_ranks" do
    alias UrlShortener.PageRanks.PageRank

    import UrlShortener.PageRanksFixtures

    @invalid_attrs %{last_updated: nil, rank: nil, url: nil}

    test "list_page_ranks/0 returns all page_ranks" do
      page_rank = page_rank_fixture()
      assert PageRanks.list_page_ranks() == [page_rank]
    end

    test "get_page_rank!/1 returns the page_rank with given id" do
      page_rank = page_rank_fixture()
      assert PageRanks.get_page_rank!(page_rank.id) == page_rank
    end

    test "create_page_rank/1 with valid data creates a page_rank" do
      valid_attrs = %{last_updated: "some last_updated", rank: 42, url: "some url"}

      assert {:ok, %PageRank{} = page_rank} = PageRanks.create_page_rank(valid_attrs)
      assert page_rank.last_updated == "some last_updated"
      assert page_rank.rank == 42
      assert page_rank.url == "some url"
    end

    test "create_page_rank/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PageRanks.create_page_rank(@invalid_attrs)
    end

    test "update_page_rank/2 with valid data updates the page_rank" do
      page_rank = page_rank_fixture()
      update_attrs = %{last_updated: "some updated last_updated", rank: 43, url: "some updated url"}

      assert {:ok, %PageRank{} = page_rank} = PageRanks.update_page_rank(page_rank, update_attrs)
      assert page_rank.last_updated == "some updated last_updated"
      assert page_rank.rank == 43
      assert page_rank.url == "some updated url"
    end

    test "update_page_rank/2 with invalid data returns error changeset" do
      page_rank = page_rank_fixture()
      assert {:error, %Ecto.Changeset{}} = PageRanks.update_page_rank(page_rank, @invalid_attrs)
      assert page_rank == PageRanks.get_page_rank!(page_rank.id)
    end

    test "delete_page_rank/1 deletes the page_rank" do
      page_rank = page_rank_fixture()
      assert {:ok, %PageRank{}} = PageRanks.delete_page_rank(page_rank)
      assert_raise Ecto.NoResultsError, fn -> PageRanks.get_page_rank!(page_rank.id) end
    end

    test "change_page_rank/1 returns a page_rank changeset" do
      page_rank = page_rank_fixture()
      assert %Ecto.Changeset{} = PageRanks.change_page_rank(page_rank)
    end
  end
end

defmodule UrlShortener.UrlsTest do
  use UrlShortener.DataCase

  alias UrlShortener.Urls

  describe "page_ranks" do
    alias UrlShortener.Urls.PageRank

    import UrlShortener.UrlsFixtures

    @invalid_attrs %{last_updated: nil, rank: nil, url: nil}

    test "list_page_ranks/0 returns all page_ranks" do
      page_rank = page_rank_fixture()
      assert Urls.list_page_ranks() == [page_rank]
    end

    test "get_page_rank!/1 returns the page_rank with given id" do
      page_rank = page_rank_fixture()
      assert Urls.get_page_rank!(page_rank.id) == page_rank
    end

    test "create_page_rank/1 with valid data creates a page_rank" do
      valid_attrs = %{last_updated: ~N[2022-11-01 14:20:00], rank: 42, url: "some url"}

      assert {:ok, %PageRank{} = page_rank} = Urls.create_page_rank(valid_attrs)
      assert page_rank.last_updated == ~N[2022-11-01 14:20:00]
      assert page_rank.rank == 42
      assert page_rank.url == "some url"
    end

    test "create_page_rank/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Urls.create_page_rank(@invalid_attrs)
    end

    test "update_page_rank/2 with valid data updates the page_rank" do
      page_rank = page_rank_fixture()
      update_attrs = %{last_updated: ~N[2022-11-02 14:20:00], rank: 43, url: "some updated url"}

      assert {:ok, %PageRank{} = page_rank} = Urls.update_page_rank(page_rank, update_attrs)
      assert page_rank.last_updated == ~N[2022-11-02 14:20:00]
      assert page_rank.rank == 43
      assert page_rank.url == "some updated url"
    end

    test "update_page_rank/2 with invalid data returns error changeset" do
      page_rank = page_rank_fixture()
      assert {:error, %Ecto.Changeset{}} = Urls.update_page_rank(page_rank, @invalid_attrs)
      assert page_rank == Urls.get_page_rank!(page_rank.id)
    end

    test "delete_page_rank/1 deletes the page_rank" do
      page_rank = page_rank_fixture()
      assert {:ok, %PageRank{}} = Urls.delete_page_rank(page_rank)
      assert_raise Ecto.NoResultsError, fn -> Urls.get_page_rank!(page_rank.id) end
    end

    test "change_page_rank/1 returns a page_rank changeset" do
      page_rank = page_rank_fixture()
      assert %Ecto.Changeset{} = Urls.change_page_rank(page_rank)
    end
  end

  describe "urls" do
    alias UrlShortener.Urls.Url

    import UrlShortener.UrlsFixtures

    @invalid_attrs %{expires_at: nil, short_key: nil, url: nil}

    test "list_urls/0 returns all urls" do
      url = url_fixture()
      assert Urls.list_urls() == [url]
    end

    test "get_url!/1 returns the url with given id" do
      url = url_fixture()
      assert Urls.get_url!(url.id) == url
    end

    test "create_url/1 with valid data creates a url" do
      valid_attrs = %{expires_at: ~N[2022-11-01 14:22:00], short_key: "some short_key", url: "some url"}

      assert {:ok, %Url{} = url} = Urls.create_url(valid_attrs)
      assert url.expires_at == ~N[2022-11-01 14:22:00]
      assert url.short_key == "some short_key"
      assert url.url == "some url"
    end

    test "create_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Urls.create_url(@invalid_attrs)
    end

    test "update_url/2 with valid data updates the url" do
      url = url_fixture()
      update_attrs = %{expires_at: ~N[2022-11-02 14:22:00], short_key: "some updated short_key", url: "some updated url"}

      assert {:ok, %Url{} = url} = Urls.update_url(url, update_attrs)
      assert url.expires_at == ~N[2022-11-02 14:22:00]
      assert url.short_key == "some updated short_key"
      assert url.url == "some updated url"
    end

    test "update_url/2 with invalid data returns error changeset" do
      url = url_fixture()
      assert {:error, %Ecto.Changeset{}} = Urls.update_url(url, @invalid_attrs)
      assert url == Urls.get_url!(url.id)
    end

    test "delete_url/1 deletes the url" do
      url = url_fixture()
      assert {:ok, %Url{}} = Urls.delete_url(url)
      assert_raise Ecto.NoResultsError, fn -> Urls.get_url!(url.id) end
    end

    test "change_url/1 returns a url changeset" do
      url = url_fixture()
      assert %Ecto.Changeset{} = Urls.change_url(url)
    end
  end
end

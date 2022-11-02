defmodule UrlShortener.Urls do
  @moduledoc """
  The Urls context.
  """

  import Ecto.Query, warn: false
  alias UrlShortener.Repo

  alias UrlShortener.Urls.PageRank

  @doc """
  Returns the list of page_ranks.
  """
  def list_page_ranks do
    Repo.all(PageRank)
  end

  @doc """
  Gets a single page_rank.

  Raises `Ecto.NoResultsError` if the Page rank does not exist.
  """
  def get_page_rank!(id), do: Repo.get!(PageRank, id)

  def get_page_rank_by_domain(domain) do
    Repo.one(from p in PageRank, where: p.domain == ^domain)
  end

  @doc """
  Creates a page_rank.
  """
  def create_page_rank(attrs \\ %{}) do
    %PageRank{}
    |> PageRank.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a page_rank.
  """
  def update_page_rank(%PageRank{} = page_rank, attrs) do
    page_rank
    |> PageRank.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a page_rank.
  """
  def delete_page_rank(%PageRank{} = page_rank) do
    Repo.delete(page_rank)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking page_rank changes.
  """
  def change_page_rank(%PageRank{} = page_rank, attrs \\ %{}) do
    PageRank.changeset(page_rank, attrs)
  end

  alias UrlShortener.Urls.Url

  @doc """
  Returns the list of urls.
  """
  def list_urls do
    Repo.all(Url)
  end

  @doc """
  Gets a single url.
  """
  def get_url!(id), do: Repo.get!(Url, id)

  def get_url_by_short_key(short_key) do
    Repo.one(from u in Url, where: u.short_key == ^short_key)
  end

  @doc """
  Creates a url.
  """
  def create_url(attrs \\ %{}) do
    %Url{}
    |> Url.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a url.
  """
  def update_url(%Url{} = url, attrs) do
    url
    |> Url.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a url.
  """
  def delete_url(%Url{} = url) do
    Repo.delete(url)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking url changes.
  """
  def change_url(%Url{} = url, attrs \\ %{}) do
    Url.changeset(url, attrs)
  end
end

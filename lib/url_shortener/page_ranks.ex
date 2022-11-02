defmodule UrlShortener.PageRanks do
  @moduledoc """
  The PageRanks context.
  """

  import Ecto.Query, warn: false
  alias UrlShortener.Repo

  alias UrlShortener.PageRanks.PageRank
  alias UrlShortener.PageRanks.OpenPageRank

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
    Repo.one(from p in PageRank, where: p.domain == ^domain) |> Repo.preload(:url)
  end

  def get_or_create_page_rank_by_domain(%URI{path: domain}) when is_binary(domain),
    do: do_get_or_create_page_rank_by_domain(domain)

  def get_or_create_page_rank_by_domain(%URI{host: domain}) when is_binary(domain),
    do: do_get_or_create_page_rank_by_domain(domain)

  def get_or_create_page_rank_by_domain(domain),
    do: domain |> URI.parse() |> get_or_create_page_rank_by_domain()

  defp do_get_or_create_page_rank_by_domain(domain) do
    case get_page_rank_by_domain(domain) do
      nil -> create_page_rank(for: domain)
      page_rank -> page_rank
    end
  end

  @doc """
  Creates a page_rank.
  """
  def create_page_rank(attrs \\ %{})

  def create_page_rank(for: domain) do
    with {:ok, [%{error: "", domain: d, page_rank_integer: r, last_updated: l}]} <-
           OpenPageRank.get_page_rank([domain]) do
      create_page_rank(%{domain: d, rank: r, last_updated: l})
    else
      {:ok, [%{error: e}]} -> {:error, e}
    end
  end

  def create_page_rank(attrs) do
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
end

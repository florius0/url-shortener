defmodule UrlShortener.Urls do
  @moduledoc """
  The Urls context.
  """

  import Ecto.Query, warn: false
  alias UrlShortener.Repo

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

  defp expiration_date() do
    :url_shortener
    |> Application.fetch_env!(:default_expiration)
    |> expiration_date()
  end

  defp expiration_date(d), do: DateTime.utc_now() |> DateTime.add(d, :days)

  @doc """
  Creates a url.
  """
  def create_url(page_rank, attrs \\ %{}) do
    %Url{}
    |> Url.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:page_rank, page_rank)
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

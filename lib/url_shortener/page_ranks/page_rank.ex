defmodule UrlShortener.PageRanks.PageRank do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "page_ranks" do
    field :last_updated, :string
    field :rank, :integer
    field :domain, :string

    has_one :url, UrlShortener.Urls.Url

    timestamps()
  end

  @doc false
  def changeset(page_rank, attrs) do
    page_rank
    |> cast(attrs, [:domain, :rank, :last_updated])
    |> validate_required([:domain, :rank, :last_updated])
  end
end

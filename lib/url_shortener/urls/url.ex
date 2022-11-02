defmodule UrlShortener.Urls.Url do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "urls" do
    field :expires_at, :naive_datetime
    field :short_key, :string
    field :url, :string

    belongs_to :page_rank, UrlShortener.PageRanks.PageRank

    timestamps()
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:url, :short_key, :expires_at])
    |> validate_required([:url, :short_key, :expires_at])
  end
end

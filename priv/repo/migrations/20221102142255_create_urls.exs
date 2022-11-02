defmodule UrlShortener.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :url, :string
      add :short_key, :string
      add :expires_at, :naive_datetime
      add :page_rank_id, references(:page_ranks, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create unique_index(:urls, [:page_rank_id])
  end
end

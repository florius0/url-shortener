defmodule UrlShortener.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :url, :string
      add :short_key, :string
      add :expires_at, :naive_datetime
      add :pare_rank_id, references(:page_ranks, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:urls, [:pare_rank_id])
  end
end

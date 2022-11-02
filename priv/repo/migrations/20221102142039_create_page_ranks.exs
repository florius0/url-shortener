defmodule UrlShortener.Repo.Migrations.CreatePageRanks do
  use Ecto.Migration

  def change do
    create table(:page_ranks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :domain, :string
      add :rank, :integer
      add :last_updated, :string

      timestamps()
    end

    create unique_index(:page_ranks, [:domain])
  end
end

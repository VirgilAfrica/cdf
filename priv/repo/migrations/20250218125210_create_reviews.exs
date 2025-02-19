defmodule Cdf.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :description, :text
      add :date_added, :date
      add :percentage_set, :integer
      add :user_id, references(:users, on_delete: :nothing)
      add :target_id, references(:targets, on_delete: :nothing)
      timestamps(type: :utc_datetime)
    end

    create index(:reviews, [:user_id])
  end
end

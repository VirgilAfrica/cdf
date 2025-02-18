defmodule Cdf.Repo.Migrations.CreateTargets do
  use Ecto.Migration

  def change do
    create table(:targets) do
      add :title, :string
      add :description, :text
      add :final_review_on, :date
      add :percentage_completion, :integer, default: 0
      add :supervisor_id, references(:users, on_delete: :nothing)
      add :assignee_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end
  end
end

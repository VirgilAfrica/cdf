defmodule Cdf.Targets.Target do
  use Ecto.Schema
  import Ecto.Changeset

  schema "targets" do
    field :description, :string
    field :title, :string
    field :final_review_on, :date
    field :percentage_completion, :integer
    has_many(:review, Cdf.Reviews.Review)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(target, attrs) do
    target
    |> cast(attrs, [:title, :description, :final_review_on, :percentage_completion])
    |> validate_required([:title, :description, :final_review_on, :percentage_completion])
  end
end

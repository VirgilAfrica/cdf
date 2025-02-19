defmodule Cdf.Reviews.Review do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reviews" do
    field :description, :string
    field :date_added, :date
    field :percentage_set, :integer
    belongs_to(:target, Cdf.Targets.Target)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:description, :date_added, :percentage_set, :target_id])
    |> validate_required([:description, :date_added, :percentage_set, :target_id])
  end
end

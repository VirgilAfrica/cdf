defmodule Cdf.ReviewsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cdf.Reviews` context.
  """

  @doc """
  Generate a review.
  """
  def review_fixture(attrs \\ %{}) do
    {:ok, review} =
      attrs
      |> Enum.into(%{
        date_added: ~D[2025-02-17],
        description: "some description",
        percentage_set: 42
      })
      |> Cdf.Reviews.create_review()

    review
  end
end

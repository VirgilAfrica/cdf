defmodule Cdf.TargetsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cdf.Targets` context.
  """

  @doc """
  Generate a target.
  """
  def target_fixture(attrs \\ %{}) do
    {:ok, target} =
      attrs
      |> Enum.into(%{
        description: "some description",
        final_review_on: ~D[2025-02-17],
        percentage_completion: 42,
        title: "some title"
      })
      |> Cdf.Targets.create_target()

    target
  end
end

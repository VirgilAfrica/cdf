defmodule Cdf.TargetsTest do
  use Cdf.DataCase

  alias Cdf.Targets

  describe "targets" do
    alias Cdf.Targets.Target

    import Cdf.TargetsFixtures

    @invalid_attrs %{description: nil, title: nil, final_review_on: nil, percentage_completion: nil}

    test "list_targets/0 returns all targets" do
      target = target_fixture()
      assert Targets.list_targets() == [target]
    end

    test "get_target!/1 returns the target with given id" do
      target = target_fixture()
      assert Targets.get_target!(target.id) == target
    end

    test "create_target/1 with valid data creates a target" do
      valid_attrs = %{description: "some description", title: "some title", final_review_on: ~D[2025-02-17], percentage_completion: 42}

      assert {:ok, %Target{} = target} = Targets.create_target(valid_attrs)
      assert target.description == "some description"
      assert target.title == "some title"
      assert target.final_review_on == ~D[2025-02-17]
      assert target.percentage_completion == 42
    end

    test "create_target/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Targets.create_target(@invalid_attrs)
    end

    test "update_target/2 with valid data updates the target" do
      target = target_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title", final_review_on: ~D[2025-02-18], percentage_completion: 43}

      assert {:ok, %Target{} = target} = Targets.update_target(target, update_attrs)
      assert target.description == "some updated description"
      assert target.title == "some updated title"
      assert target.final_review_on == ~D[2025-02-18]
      assert target.percentage_completion == 43
    end

    test "update_target/2 with invalid data returns error changeset" do
      target = target_fixture()
      assert {:error, %Ecto.Changeset{}} = Targets.update_target(target, @invalid_attrs)
      assert target == Targets.get_target!(target.id)
    end

    test "delete_target/1 deletes the target" do
      target = target_fixture()
      assert {:ok, %Target{}} = Targets.delete_target(target)
      assert_raise Ecto.NoResultsError, fn -> Targets.get_target!(target.id) end
    end

    test "change_target/1 returns a target changeset" do
      target = target_fixture()
      assert %Ecto.Changeset{} = Targets.change_target(target)
    end
  end
end

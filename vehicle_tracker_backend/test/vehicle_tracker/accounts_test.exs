defmodule VehicleTracker.AccountsTest do
  use VehicleTracker.DataCase

  alias VehicleTracker.Accounts
  alias VehicleTracker.Accounts.User

  import VehicleTracker.AccountsFixtures

  @invalid_attrs %{username: "", email: "", password_hash: ""}

  describe "users" do
    test "list_users/0 returns all users" do
      user = user_fixture()
      [fetched_user] = Accounts.list_users()
      assert fetched_user.email == user.email
      assert fetched_user.password_hash == user.password_hash
      assert fetched_user.username == user.username
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      fetched_user = Accounts.get_user!(user.id)
      assert fetched_user.email == user.email
      assert fetched_user.password_hash == user.password_hash
      assert fetched_user.username == user.username
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
        username: "some_username",
        email: "test@example.com",
        password_hash: "some password_hash",
        password: "Password@123"
      }

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.username == "some_username"
      assert user.email == "test@example.com"
      assert user.password_hash != nil
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        email: "updated_email@example.com",
        password: "UpdatedPassword@123"
      }

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.email == "updated_email@example.com"
      assert Bcrypt.verify_pass("UpdatedPassword@123", user.password_hash)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      fetched_user = Accounts.get_user!(user.id)
      assert user.email == fetched_user.email
      assert user.password_hash == fetched_user.password_hash
      assert user.username == fetched_user.username
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end
  end
end

# Ensure this file exists and contains the following function
defmodule VehicleTracker.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `VehicleTracker.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        username: "test_user",
        email: "test@example.com",
        password: "Password@123",
        password_hash: Bcrypt.hash_pwd_salt("Password@123")
      })
      |> VehicleTracker.Accounts.create_user()

    user
  end
end

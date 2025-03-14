defmodule VehicleTracker.CustomersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `VehicleTracker.Customers` context.
  """

  @doc """
  Generate a unique customer driving_license_number.
  """
  def unique_customer_driving_license_number, do: "some driving_license_number#{System.unique_integer([:positive])}"

  @doc """
  Generate a unique customer email.
  """
  def unique_customer_email, do: "some email#{System.unique_integer([:positive])}"

  @doc """
  Generate a customer.
  """
  def customer_fixture(attrs \\ %{}) do
    {:ok, customer} =
      attrs
      |> Enum.into(%{
        address: "some address",
        driving_license_number: unique_customer_driving_license_number(),
        email: unique_customer_email(),
        first_name: "some first_name",
        last_name: "some last_name",
        phone: "some phone",
        rental_history: %{}
      })
      |> VehicleTracker.Customers.create_customer()

    customer
  end
end

defmodule VehicleTracker.VehiclesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `VehicleTracker.Vehicles` context.
  """

  @doc """
  Generate a vehicle.
  """
  def vehicle_fixture(attrs \\ %{}) do
    {:ok, vehicle} =
      attrs
      |> Enum.into(%{
        make: "some make",
        model: "some model",
        fuel_type: "some fuel_type",
        mileage: 42,
        year_of_manufacture: 42,
        registration_number: "some registration_number",
        chassis_number: "some chassis_number",
        rental_price_per_day: Decimal.new("100.0"),
        registration_expiry: ~D[2025-03-13],
        status: "available"
      })
      |> VehicleTracker.Vehicles.create_vehicle()

    vehicle
  end
end

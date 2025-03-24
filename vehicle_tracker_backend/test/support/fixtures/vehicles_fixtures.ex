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
        color: "some color",
        door_count: 42,
        first_registration_year: 42,
        fuel_type: "some fuel_type",
        is_available: true,
        make: "some make",
        mileage: 42,
        model: "some model",
        registration_date: ~D[2025-03-13],
        registration_expiry: ~D[2025-03-13],
        return_date: ~D[2025-03-13],
        taken_date: ~D[2025-03-13],
        transmission: "some transmission",
        year_of_manufacture: 42
      })
      |> VehicleTracker.Vehicles.create_vehicle()

    vehicle
  end
end

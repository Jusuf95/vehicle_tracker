defmodule VehicleTracker.VehiclesTest do
  use VehicleTracker.DataCase

  alias VehicleTracker.Vehicles

  describe "vehicles" do
    alias VehicleTracker.Vehicles.Vehicle

    import VehicleTracker.VehiclesFixtures

    @invalid_attrs %{
      make: nil,
      model: nil,
      fuel_type: nil,
      mileage: nil,
      first_registration_year: nil,
      registration_expiry: nil
    }

    test "list_vehicles/0 returns all vehicles" do
      vehicle = vehicle_fixture()
      assert Vehicles.list_vehicles() == [vehicle]
    end

    test "get_vehicle!/1 returns the vehicle with given id" do
      vehicle = vehicle_fixture()
      assert Vehicles.get_vehicle!(vehicle.id) == vehicle
    end

    test "create_vehicle/1 with valid data creates a vehicle" do
      valid_attrs = %{
        make: "some make",
        model: "some model",
        fuel_type: "some fuel_type",
        mileage: 42,
        year_of_manufacture: 2020,
        registration_number: "ABC123",
        chassis_number: "CHASSIS123",
        rental_price_per_day: Decimal.new("100.0"),
        registration_expiry: ~D[2025-03-13],
        status: "available"
      }

      assert {:ok, %Vehicle{} = vehicle} = Vehicles.create_vehicle(valid_attrs)
      assert vehicle.make == "some make"
      assert vehicle.model == "some model"
      assert vehicle.fuel_type == "some fuel_type"
      assert vehicle.mileage == 42
      assert vehicle.year_of_manufacture == 2020
      assert vehicle.registration_expiry == ~D[2025-03-13]
    end

    test "create_vehicle/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Vehicles.create_vehicle(@invalid_attrs)
    end

    test "update_vehicle/2 with valid data updates the vehicle" do
      vehicle = vehicle_fixture()

      update_attrs = %{
        make: "some updated make",
        model: "some updated model",
        fuel_type: "some updated fuel_type",
        mileage: 42,
        first_registration_year: 42,
        registration_expiry: ~D[2025-03-14]
      }

      assert {:ok, %Vehicle{} = vehicle} = Vehicles.update_vehicle(vehicle, update_attrs)
      assert vehicle.make == "some updated make"
      assert vehicle.model == "some updated model"
      assert vehicle.fuel_type == "some updated fuel_type"
      assert vehicle.mileage == 42
      assert vehicle.year_of_manufacture == 42
      assert vehicle.registration_expiry == ~D[2025-03-14]
    end

    test "update_vehicle/2 with invalid data returns error changeset" do
      vehicle = vehicle_fixture()
      assert {:error, %Ecto.Changeset{}} = Vehicles.update_vehicle(vehicle, @invalid_attrs)
      assert vehicle == Vehicles.get_vehicle!(vehicle.id)
    end

    test "delete_vehicle/1 deletes the vehicle" do
      vehicle = vehicle_fixture()
      assert {:ok, %Vehicle{}} = Vehicles.delete_vehicle(vehicle)
      assert_raise Ecto.NoResultsError, fn -> Vehicles.get_vehicle!(vehicle.id) end
    end

    test "change_vehicle/1 returns a vehicle changeset" do
      vehicle = vehicle_fixture()
      assert %Ecto.Changeset{} = Vehicles.change_vehicle(vehicle)
    end
  end
end

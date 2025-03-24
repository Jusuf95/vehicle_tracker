defmodule VehicleTrackerWeb.VehicleController do
  use VehicleTrackerWeb, :controller

  alias VehicleTracker.Vehicles

  def index(conn, params) do
    vehicles = Vehicles.filter_vehicles(params)
    conn
    |> put_status(:ok)
    |> json(%{vehicles: vehicles})
  end

  def show(conn, %{"id" => id}) do
    vehicle = Vehicles.get_vehicle!(id)
    conn
    |> put_status(:ok)
    |> json(%{vehicle: vehicle})
  end

  def create(conn, %{"vehicle" => vehicle_params}) do
    case Vehicles.create_vehicle(vehicle_params) do
      {:ok, vehicle} ->
        conn
        |> put_status(:created)
        |> json(%{message: "Vehicle created successfully", vehicle_id: vehicle.id})

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:error)
        |> json(%{errors: changeset})
    end
  end

  def update(conn, %{"id" => id, "vehicle" => vehicle_params}) do
    vehicle = Vehicles.get_vehicle!(id)

    case Vehicles.update_vehicle(vehicle, vehicle_params) do
      {:ok, vehicle} ->
        conn
        |> put_status(:ok)
        |> json(%{message: "Vehicle updated successfully", vehicle: vehicle})

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:error)
        |> json(%{errors: changeset})
    end
  end

  def delete(conn, %{"id" => id}) do
    vehicle = Vehicles.get_vehicle!(id)

    case Vehicles.delete_vehicle(vehicle) do
      {:ok, _vehicle} ->
        conn
        |> put_status(:ok)
        |> json(%{message: "Vehicle deleted successfully"})

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:error)
        |> json(%{errors: changeset})
    end
  end
end

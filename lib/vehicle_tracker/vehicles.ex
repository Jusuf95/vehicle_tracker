defmodule VehicleTracker.Vehicles do
  @moduledoc """
  The Vehicles context.
  """

  import Ecto.Query, warn: false
  alias VehicleTracker.Repo

  alias VehicleTracker.Vehicles.Vehicle

  @doc """
  Returns the list of vehicles.

  ## Examples

      iex> list_vehicles()
      [%Vehicle{}, ...]

  """
  def list_vehicles do
    Repo.all(Vehicle)
  end

  @doc """
  Gets a single vehicle.

  Raises `Ecto.NoResultsError` if the Vehicle does not exist.

  ## Examples

      iex> get_vehicle!(123)
      %Vehicle{}

      iex> get_vehicle!(456)
      ** (Ecto.NoResultsError)

  """
  def get_vehicle!(id), do: Repo.get!(Vehicle, id)

  def filter_vehicles(filters) do
    query = Vehicle |> apply_filters(filters)
    Repo.all(query)
  end
  @doc """
  Creates a vehicle.

  ## Examples

      iex> create_vehicle(%{field: value})
      {:ok, %Vehicle{}}

      iex> create_vehicle(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_vehicle(attrs \\ %{}) do
    %Vehicle{}
    |> Vehicle.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a vehicle.

  ## Examples

      iex> update_vehicle(vehicle, %{field: new_value})
      {:ok, %Vehicle{}}

      iex> update_vehicle(vehicle, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_vehicle(%Vehicle{} = vehicle, attrs) do
    vehicle
    |> Vehicle.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a vehicle.

  ## Examples

      iex> delete_vehicle(vehicle)
      {:ok, %Vehicle{}}

      iex> delete_vehicle(vehicle)
      {:error, %Ecto.Changeset{}}

  """
  def delete_vehicle(%Vehicle{} = vehicle) do
    Repo.delete(vehicle)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking vehicle changes.

  ## Examples

      iex> change_vehicle(vehicle)
      %Ecto.Changeset{data: %Vehicle{}}

  """
  def change_vehicle(%Vehicle{} = vehicle, attrs \\ %{}) do
    Vehicle.changeset(vehicle, attrs)
  end
  defp apply_filters(query, filters) do
    query
    |> maybe_filter_by_make(filters[:make])
    |> maybe_filter_by_fuel_type(filters[:fuel_type])
    |> maybe_filter_by_transmission(filters[:transmission])
    |> maybe_filter_by_door_count(filters[:door_count])
  end

  defp maybe_filter_by_make(query, nil), do: query
  defp maybe_filter_by_make(query, make), do: from(v in query, where: v.make == ^make)

  defp maybe_filter_by_fuel_type(query, nil), do: query
  defp maybe_filter_by_fuel_type(query, fuel_type), do: from(v in query, where: v.fuel_type == ^fuel_type)

  defp maybe_filter_by_transmission(query, nil), do: query
  defp maybe_filter_by_transmission(query, transmission), do: from(v in query, where: v.transmission == ^transmission)

  defp maybe_filter_by_door_count(query, nil), do: query
  defp maybe_filter_by_door_count(query, door_count), do: from(v in query, where: v.door_count == ^door_count)

end

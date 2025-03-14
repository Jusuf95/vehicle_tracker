defmodule VehicleTracker.Vehicles.Vehicle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vehicles" do
    field(:color, :string)
    field(:make, :string)
    field(:model, :string)
    field(:fuel_type, :string)
    field(:mileage, :integer)
    field(:year_of_manufacture, :integer)
    field(:transmission, :string)
    field(:door_count, :integer)
    field(:first_registration_year, :integer)
    field(:registration_date, :date)
    field(:registration_expiry, :date)
    field(:taken_date, :date)
    field(:return_date, :date)
    field(:is_available, :boolean, default: false)
    field(:user_id, :id)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(vehicle, attrs) do
    vehicle
    |> cast(attrs, [
      :make,
      :model,
      :fuel_type,
      :mileage,
      :year_of_manufacture,
      :transmission,
      :door_count,
      :first_registration_year,
      :registration_date,
      :registration_expiry,
      :color,
      :taken_date,
      :return_date,
      :is_available,
      :user_id
    ])
    |> validate_required([
      :make,
      :model,
      :fuel_type,
      :mileage,
      :year_of_manufacture,
      :transmission,
      :door_count,
      :first_registration_year,
      :registration_date,
      :registration_expiry,
      :color,
      :taken_date,
      :return_date,
      :is_available,
      :user_id
    ])
    |> validate_length(:make, min: 1)
    |> validate_length(:model, min: 1)
    |> validate_length(:fuel_type, min: 1)
    |> validate_length(:transmission, min: 1)
    |> validate_number(:mileage, greater_than_or_equal_to: 0)
    |> validate_number(:year_of_manufacture, greater_than: 1900)
    |> validate_number(:door_count, greater_than_or_equal_to: 1)
    |> validate_number(:first_registration_year, greater_than_or_equal_to: 1900)
  end
end

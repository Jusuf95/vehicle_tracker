defmodule VehicleTracker.Vehicles.Vehicle do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [
    :id,
    :status,
    :make,
    :model,
    :year_of_manufacture,
    :fuel_type,
    :mileage,
    :registration_number,
    :chassis_number,
    :rental_price_per_day,
    :registration_expiry,
    :inserted_at,
    :updated_at
  ]}

  schema "vehicles" do
    field(:status, :string)
    field(:make, :string)
    field(:model, :string)
    field(:year_of_manufacture, :integer)
    field(:fuel_type, :string)
    field(:mileage, :integer)
    field(:registration_number, :string)
    field(:chassis_number, :string)
    field(:rental_price_per_day, :decimal)
    field(:registration_expiry, :date)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(vehicle, attrs) do
    vehicle
    |> cast(attrs, [
      :make,
      :model,
      :year_of_manufacture,
      :fuel_type,
      :mileage,
      :registration_number,
      :chassis_number,
      :rental_price_per_day,
      :status,
      :registration_expiry
    ])
    |> validate_required([
      :make,
      :model,
      :year_of_manufacture,
      :fuel_type,
      :mileage,
      :registration_number,
      :chassis_number,
      :rental_price_per_day,
      :status,
      :registration_expiry
    ])
    |> unique_constraint(:chassis_number)
    |> unique_constraint(:registration_number)
  end
end

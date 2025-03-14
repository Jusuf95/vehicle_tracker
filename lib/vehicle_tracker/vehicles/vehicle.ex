defmodule VehicleTracker.Vehicles.Vehicle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vehicles" do
    field :color, :string
    field :make, :string
    field :model, :string
    field :fuel_type, :string
    field :mileage, :integer
    field :year_of_manufacture, :integer
    field :transmission, :string
    field :door_count, :integer
    field :first_registration_year, :integer
    field :registration_date, :date
    field :registration_expiry, :date
    field :taken_date, :date
    field :return_date, :date
    field :is_available, :boolean, default: false
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(vehicle, attrs) do
    vehicle
    |> cast(attrs, [:make, :model, :fuel_type, :mileage, :year_of_manufacture, :transmission, :door_count, :first_registration_year, :registration_date, :registration_expiry, :color, :taken_date, :return_date, :is_available])
    |> validate_required([:make, :model, :fuel_type, :mileage, :year_of_manufacture, :transmission, :door_count, :first_registration_year, :registration_date, :registration_expiry, :color, :taken_date, :return_date, :is_available])
  end
end

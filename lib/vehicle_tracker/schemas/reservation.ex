defmodule VehicleTracker.Schemas.Reservation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reservations" do
    field :status, :string
    field :pickup_date, :date
    field :return_date, :date
    field :total_price, :decimal
    field :vehicle_id, :id
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(reservation, attrs) do
    reservation
    |> cast(attrs, [:pickup_date, :return_date, :status, :total_price])
    |> validate_required([:pickup_date, :return_date, :status, :total_price])
  end
end

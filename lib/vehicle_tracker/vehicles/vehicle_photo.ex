defmodule VehicleTracker.Vehicles.VehiclePhoto do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vehicle_photos" do
    field :url, :string
    field :vehicle_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(vehicle_photo, attrs) do
    vehicle_photo
    |> cast(attrs, [:url])
    |> validate_required([:url])
  end
end

defmodule VehicleTracker.Schemas.MaintenanceRecord do
  use Ecto.Schema
  import Ecto.Changeset

  schema "maintenance_records" do
    field :description, :string
    field :service_date, :date
    field :cost, :decimal
    field :vehicle_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(maintenance_record, attrs) do
    maintenance_record
    |> cast(attrs, [:service_date, :description, :cost])
    |> validate_required([:service_date, :description, :cost])
  end
end

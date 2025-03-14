defmodule VehicleTracker.Repo.Migrations.CreateMaintenanceRecords do
  use Ecto.Migration

  def change do
    create table(:maintenance_records) do
      add :service_date, :date
      add :description, :string
      add :cost, :decimal
      add :vehicle_id, references(:vehicles, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:maintenance_records, [:vehicle_id])
  end
end

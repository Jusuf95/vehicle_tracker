defmodule VehicleTracker.Repo.Migrations.CreateVehiclePhotos do
  use Ecto.Migration

  def change do
    create table(:vehicle_photos) do
      add :url, :string
      add :vehicle_id, references(:vehicles, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:vehicle_photos, [:vehicle_id])
  end
end

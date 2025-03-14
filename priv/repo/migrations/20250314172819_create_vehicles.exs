defmodule VehicleTracker.Repo.Migrations.CreateVehicles do
  use Ecto.Migration

  def change do
    create table(:vehicles) do
      add :make, :string
      add :model, :string
      add :year_of_manufacture, :integer
      add :fuel_type, :string
      add :mileage, :integer
      add :registration_number, :string
      add :chassis_number, :string
      add :rental_price_per_day, :decimal
      add :status, :string
      add :registration_expiry, :date

      timestamps(type: :utc_datetime)
    end

    create unique_index(:vehicles, [:chassis_number])
    create unique_index(:vehicles, [:registration_number])
  end
end

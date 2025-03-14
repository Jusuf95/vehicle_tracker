defmodule VehicleTracker.Repo.Migrations.CreateVehicles do
  use Ecto.Migration

  def change do
    create table(:vehicles) do
      add :make, :string
      add :model, :string
      add :fuel_type, :string
      add :mileage, :integer
      add :year_of_manufacture, :integer
      add :transmission, :string
      add :door_count, :integer
      add :first_registration_year, :integer
      add :registration_date, :date
      add :registration_expiry, :date
      add :color, :string
      add :taken_date, :date
      add :return_date, :date
      add :is_available, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:vehicles, [:user_id])
  end
end

defmodule VehicleTracker.Repo.Migrations.CreateReservations do
  use Ecto.Migration

  def change do
    create table(:reservations) do
      add :pickup_date, :date
      add :return_date, :date
      add :status, :string
      add :total_price, :decimal
      add :vehicle_id, references(:vehicles, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:reservations, [:vehicle_id])
    create index(:reservations, [:user_id])
  end
end

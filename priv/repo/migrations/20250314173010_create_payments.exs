defmodule VehicleTracker.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :amount, :decimal
      add :payment_date, :date
      add :status, :string
      add :reservation_id, references(:reservations, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:payments, [:reservation_id])
  end
end

defmodule VehicleTracker.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :phone, :string
      add :address, :string
      add :driving_license_number, :string
      add :rental_history, :map

      timestamps(type: :utc_datetime)
    end

    create unique_index(:customers, [:driving_license_number])
    create unique_index(:customers, [:email])
  end
end

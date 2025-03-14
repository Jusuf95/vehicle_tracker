defmodule VehicleTracker.Schemas.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :address, :string
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :phone, :string
    field :driving_license_number, :string
    field :rental_history, :map

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:first_name, :last_name, :email, :phone, :address, :driving_license_number, :rental_history])
    |> validate_required([:first_name, :last_name, :email, :phone, :address, :driving_license_number])
    |> unique_constraint(:driving_license_number)
    |> unique_constraint(:email)
  end
end

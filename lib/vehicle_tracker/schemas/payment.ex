defmodule VehicleTracker.Schemas.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :status, :string
    field :amount, :decimal
    field :payment_date, :date
    field :reservation_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [:amount, :payment_date, :status])
    |> validate_required([:amount, :payment_date, :status])
  end
end

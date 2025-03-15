defmodule VehicleTracker.Reservations do
  import Ecto.Query
  alias VehicleTracker.Repo
  alias VehicleTracker.Schemas.{Reservation, Customer, Payment}
  alias VehicleTracker.Vehicles.Vehicle

  def create_reservation(customer_id, vehicle_id, attrs) do
    Repo.transaction(fn ->
      case Repo.get(Vehicle, vehicle_id) do
        %Vehicle{status: "available"} = vehicle ->
          if has_pending_payments?(customer_id) do
            Repo.rollback("Customer has unpaid debts")
          end

          # Kreiranje rezervacije
          reservation_changeset = Reservation.changeset(%Reservation{}, Map.merge(attrs, %{
            vehicle_id: vehicle_id,
            user_id: customer_id
          }))

          case Repo.insert(reservation_changeset) do
            {:ok, reservation} ->
              Repo.update!(Vehicle.changeset(vehicle, %{status: "reserved"}))

              update_customer_rental_history(customer_id, reservation)

              reservation

            {:error, changeset} ->
              Repo.rollback(changeset)
          end

        _ ->
          Repo.rollback("Vehicle is not available")
      end
    end)
  end

  defp update_customer_rental_history(customer_id, reservation) do
    case Repo.get(Customer, customer_id) do
      %Customer{rental_history: rental_history} = customer ->
        new_entry = %{
          vehicle_id: reservation.vehicle_id,
          pickup_date: reservation.pickup_date,
          return_date: reservation.return_date,
          total_price: reservation.total_price
        }

        updated_history = Map.update(rental_history || %{}, :rentals, [new_entry], fn history ->
          [new_entry | history]
        end)

        Repo.update!(Customer.changeset(customer, %{rental_history: updated_history}))

      _ ->
        :ok
    end
  end

  defp has_pending_payments?(customer_id) do
    query =
      from p in Payment,
        join: r in Reservation, on: p.reservation_id == r.id,
        where: r.user_id == ^customer_id and p.status != "paid",
        select: count(p.id)

    Repo.one(query) > 0
  end
end

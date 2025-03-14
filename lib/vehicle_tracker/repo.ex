defmodule VehicleTracker.Repo do
  use Ecto.Repo,
    otp_app: :vehicle_tracker,
    adapter: Ecto.Adapters.Postgres
end

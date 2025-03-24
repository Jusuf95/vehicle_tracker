defmodule VehicleTrackerWeb.Auth.Guardian do
  use Guardian, otp_app: :vehicle_tracker
  alias VehicleTracker.Accounts

  def subject_for_token(user, _claims), do: {:ok, to_string(user.id)}

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_user_by_email(id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end

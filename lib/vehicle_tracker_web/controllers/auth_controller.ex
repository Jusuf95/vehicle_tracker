defmodule VehicleTrackerWeb.AuthController do
  use VehicleTrackerWeb, :controller
  import Phoenix.Controller

  alias VehicleTracker.Accounts

  def register(conn, %{"email" => email, "username" => username, "password" => password}) do
    case Accounts.create_user(%{email: email, username: username, password: password}) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> json(%{message: "User registered successfully", user: %{id: user.id, email: user.email, username: user.username}})

      {:error, :user_already_exists} ->
        conn
        |> put_status(:conflict)
        |> json(%{error: "Email or username is already taken"})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: translate_errors(changeset)})
    end

  end


  def login(conn, %{"identifier" => identifier, "password" => password}) do
    case Accounts.authenticate_user(identifier, password) do
      {:ok, user} ->
        case VehicleTrackerWeb.Auth.Guardian.encode_and_sign(user, %{}, token_type: "access") do
          {:ok, token, _claims} ->
            conn
            |> put_status(:ok)
            |> json(%{token: token, user: %{id: user.id, email: user.email, username: user.username}})

          {:error, reason} ->
            conn
            |> put_status(:internal_server_error)
            |> json(%{error: "Token generation failed", reason: reason})
        end

      {:error, :not_found} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "User not found"})

      {:error, :unauthorized} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid credentials"})
    end
  end

  defp translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn
      {:user_already_exists, _opts} -> "Email or username is already taken"
      {msg, opts} ->
        Enum.reduce(opts, msg, fn {key, value}, acc ->
          String.replace(acc, "%{#{key}}", to_string(value))
        end)
    end)
  end

end

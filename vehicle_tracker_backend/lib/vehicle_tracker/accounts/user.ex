defmodule VehicleTracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 8)
    |> maybe_validate(:password, ~r/[A-Z]/, "Password must contain at least one uppercase letter")
    |> maybe_validate(:password, ~r/[a-z]/, "Password must contain at least one lowercase letter")
    |> maybe_validate(:password, ~r/\d/, "Password must contain at least one number")
    |> maybe_validate(:password, ~r/[!@#$%^&*]/, "Password must contain at least one special character (!@#$%^&*)")
    |> put_password_hash()
  end

  defp maybe_validate(changeset, field, regex, message) do
    validate_format(changeset, field, regex, message: message)
  end

  defp put_password_hash(changeset) do
    if changeset.valid? do
      password = get_change(changeset, :password)
      put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
    else
      changeset
    end
  end
end

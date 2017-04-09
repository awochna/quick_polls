defmodule QuickPolls.User do
  use Ecto.Schema
  import Doorman.Auth.Bcrypt, only: [hash_password: 1]

  schema "users" do
    field :email, :string
    field :hashed_password, :string
    field :password, :string, virtual: true

    timestamps()
  end

  def create_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, ~w(email password))
    |> hash_password
  end
end

defmodule QuickPolls.User do
  use Ecto.Schema
  import Doorman.Auth.Bcrypt, only: [hash_password: 1]

  alias Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string
    field :hashed_password, :string
    field :password, :string, virtual: true

    has_many :polls, QuickPolls.Poll

    timestamps()
  end

  def create_changeset(struct, params \\ %{}) do
    struct
    |> Changeset.cast(params, ~w(name email password))
    |> Changeset.validate_required([:name, :email, :password])
    |> Changeset.unique_constraint(:email)
    |> hash_password
  end
end

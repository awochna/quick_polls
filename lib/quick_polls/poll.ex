defmodule QuickPolls.Poll do
  use Ecto.Schema

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "polls" do
    field :name, :string

    belongs_to :user, QuickPolls.User

    timestamps()
  end

  def new_changeset(struct) do
    Changeset.change(struct)
  end

  def create_changeset(struct, params \\ %{}) do
    struct
    |> Changeset.cast(params, ~w(name))
    |> Changeset.put_assoc(:user, params["user"])
    |> Changeset.validate_required([:name, :user])
  end

  def edit_changeset(struct) do
    Changeset.change(struct)
  end

  def update_changeset(struct, params) do
    struct
    |> Changeset.cast(params, ~w(name))
    |> Changeset.validate_required([:name, :user])
  end
end

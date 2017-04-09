defmodule QuickPolls.Repo.Migrations.CreateQuickPolls.User do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :hashed_password, :string

      timestamps()
    end

  end
end

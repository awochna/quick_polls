defmodule QuickPolls.Repo.Migrations.AddPolls do
  use Ecto.Migration

  def change do
    create table(:polls, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :user_id, references(:users)

      timestamps()
    end
  end
end

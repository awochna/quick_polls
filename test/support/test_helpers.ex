defmodule QuickPolls.TestHelpers do
  alias QuickPolls.Repo
  alias QuickPolls.User
  alias QuickPolls.Poll

  def insert_user(attrs \\ %{}) do
    num = Base.encode16(:crypto.strong_rand_bytes(8))
    changeset = Map.merge(%{
      name: "Some User",
      email: "user#{num}@example.com",
      password: "some secret"
    }, attrs)

    %User{}
    |> User.create_changeset(changeset)
    |> Repo.insert!()
    |> Map.put(:password, nil)
  end

  def insert_poll(attrs \\ %{})
  def insert_poll(%{user: user} = attrs) do
    changeset = Map.merge(%{
      "name" => "Some Poll",
      "user" => user,
    }, attrs)

    %Poll{}
    |> Poll.create_changeset(changeset)
    |> Repo.insert!()
  end
  def insert_poll(attrs) do
    user = insert_user()
    changeset = Map.merge(%{
      "name" => "Some Poll",
      "user" => user,
    }, attrs)

    %Poll{}
    |> Poll.create_changeset(changeset)
    |> Repo.insert!()
  end
end


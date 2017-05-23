defmodule QuickPolls.Web.QuestionControllerTest do
  use QuickPolls.Web.ConnCase, async: true
  import QuickPolls.TestHelpers

  alias QuickPolls.Repo
  alias QuickPolls.Poll
  alias QuickPolls.Poll.Question

  @valid_question %{"text" => "How do you clean them?", "choices" => ["I don't", "Soap and Water", "Microfiber cloth"]}
  @valid_poll %{"name" => "Glasses"}

  setup context do
    user = insert_user()
    if context[:logged_in] do
      conn = assign(build_conn(), :current_user, user)
      {:ok, [user: user, conn: conn]}
    else
      {:ok, [user: user]}
    end
  end

  @tag :logged_in
  test "creating a poll and question", %{conn: conn} do
    params = Map.put(@valid_poll, "questions", [@valid_question])
    conn = post conn, poll_path(conn, :create), poll: params
    assert redirected_to(conn, 302) =~ "polls"
    assert Enum.count(Repo.all(Question)) == 1
  end
end

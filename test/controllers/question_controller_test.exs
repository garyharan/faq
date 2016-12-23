defmodule Faq.QuestionControllerTest do
  use Faq.ConnCase

  alias Faq.User

  setup_all do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Faq.Repo)

    User.changeset(%User{}, %{name: "test", email: "asdf@example.com", password: "test", password_confirmation: "test", role: "admin"}) |> Repo.insert!
    User.changeset(%User{}, %{name: "test", email: "fdsa@example.com", password: "test", password_confirmation: "test"}) |> Repo.insert!

    :ok
  end

  describe "when we are logged in as admin" do
    setup do
      User.changeset(%User{}, %{name: "test", email: "admin@example.com", password: "test", password_confirmation: "test", role: "admin"})
        |> Repo.insert!

      admin = Ecto.Query.from(u in User, where: u.role == "admin", limit: 1)
        |> Repo.one

      {:ok, conn: assign(build_conn, :current_user, admin), user: admin}
    end

    test "list all entries on index", %{conn: conn} do
      response = get(conn, :index)
      assert html_response(response, 200) =~ "Questions"
    end
  end

  def admin do
    query = Ecto.Query.from(u in User, where: u.role == "admin", limit: 1)
    Repo.one(query)
  end

  # test "lists all entries on index", %{conn: conn} do
  # conn = get conn, question_path(conn, :index)
  # assert html_response(conn, 200) =~ "Listing questions"
  # end
  #
  # test "renders form for new resources", %{conn: conn} do
  # conn = get conn, question_path(conn, :new)
  # assert html_response(conn, 200) =~ "New question"
  # end
  #
  # test "creates resource and redirects when data is valid", %{conn: conn} do
  # conn = post conn, question_path(conn, :create), question: @valid_attrs
  # assert redirected_to(conn) == question_path(conn, :index)
  # assert Repo.get_by(Question, @valid_attrs)
  # end
  #
  # test "does not create resource and renders errors when data is invalid", %{conn: conn} do
  # conn = post conn, question_path(conn, :create), question: @invalid_attrs
  # assert html_response(conn, 200) =~ "New question"
  # end
  #
  # test "shows chosen resource", %{conn: conn} do
  # question = Repo.insert! %Question{}
  # conn = get conn, question_path(conn, :show, question)
  # assert html_response(conn, 200) =~ "Show question"
  # end
  #
  # test "renders page not found when id is nonexistent", %{conn: conn} do
  # assert_error_sent 404, fn ->
  # get conn, question_path(conn, :show, -1)
  # end
  # end
  #
  # test "renders form for editing chosen resource", %{conn: conn} do
  # question = Repo.insert! %Question{}
  # conn = get conn, question_path(conn, :edit, question)
  # assert html_response(conn, 200) =~ "Edit question"
  # end
  #
  # test "updates chosen resource and redirects when data is valid", %{conn: conn} do
  # question = Repo.insert! %Question{}
  # conn = put conn, question_path(conn, :update, question), question: @valid_attrs
  # assert redirected_to(conn) == question_path(conn, :show, question)
  # assert Repo.get_by(Question, @valid_attrs)
  # end
  #
  # test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
  # question = Repo.insert! %Question{}
  # conn = put conn, question_path(conn, :update, question), question: @invalid_attrs
  # assert html_response(conn, 200) =~ "Edit question"
  # end
  #
  # test "deletes chosen resource", %{conn: conn} do
  # question = Repo.insert! %Question{}
  # conn = delete conn, question_path(conn, :delete, question)
  # assert redirected_to(conn) == question_path(conn, :index)
  # refute Repo.get(Question, question.id)
  # end
end

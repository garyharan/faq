defmodule Faq.QuestionController do
  use Faq.Web, :controller

  import Faq.RoleHelper

  alias Faq.Question

  def index(conn, _params) do
    render(conn, "index.html", questions: find_questions(conn))
  end

  def new(conn, _params) do
    changeset = Question.changeset(%Question{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"question" => question_params}) do
    changeset = Question.changeset(%Question{}, question_params)

    case Repo.insert(changeset) do
      {:ok, _question} ->
        conn
        |> put_flash(:info, "Question created successfully.")
        |> redirect(to: question_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    question = Repo.get!(Question, id)
    render(conn, "show.html", question: question)
  end

  def edit(conn, %{"id" => id}) do
    question = Repo.get!(Question, id)
    changeset = Question.changeset(question)
    render(conn, "edit.html", question: question, changeset: changeset)
  end

  def update(conn, %{"id" => id, "question" => question_params}) do
    question = Repo.get!(Question, id)
    changeset = Question.changeset(question, question_params)

    case Repo.update(changeset) do
      {:ok, question} ->
        conn
        |> put_flash(:info, "Question updated successfully.")
        |> redirect(to: question_path(conn, :show, question))
      {:error, changeset} ->
        render(conn, "edit.html", question: question, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    if is_admin(conn) do
      question = Repo.get!(Question, id)

      # Here we use delete! (with a bang) because we expect
      # it to always work (and if it does not, it will raise).
      Repo.delete!(question)

      conn
      |> put_flash(:info, "Question deleted successfully.")
      |> redirect(to: question_path(conn, :index))
    else
      conn
      |> put_flash(:info, "Unable to delete")
      |> redirect(to: question_path(conn, :index))
    end
  end

  defp find_questions(conn) do
    if is_admin(conn) do
      Question |> Repo.all
    else
      Question
      |> Question.answered
      |> Repo.all
    end
  end
end

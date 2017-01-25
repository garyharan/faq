defmodule Faq.QuestionTest do
  use Faq.ModelCase

  alias Faq.Question

  @valid_attrs %{answer: "Why?", question: "It is said that it is because."}
  @invalid_attrs %{}

  def insert_questions(_context) do
    Repo.insert!(%Question{question: "Unanswered", answer: nil})
    Repo.insert!(%Question{question: "Answered",   answer: "My published answer", published_at: Ecto.DateTime.utc(:usec)})
    :ok
  end

  describe "changesets" do
    test "changeset with valid attributes" do
      changeset = Question.changeset(%Question{}, @valid_attrs)
      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      changeset = Question.changeset(%Question{}, @invalid_attrs)
      refute changeset.valid?
    end

    test "changeset includes a published boolean sets the published_at" do
      changeset = Question.changeset(%Question{}, Map.put(@valid_attrs, :published, true))
      |> IO.inspect(structs: false, label: :changeset)
      # save it
      assert %Ecto.DateTime{} = Ecto.Changeset.get_change(changeset, :published_at)
    end

    test "changeset does not includes a published boolean does not set the published_at" do
      changeset = Question.changeset(%Question{}, @valid_attrs)
      |> IO.inspect(structs: false, label: :changeset)
      # save it
      refute Ecto.Changeset.get_change(changeset, :published_at)
    end
  end

  describe "scopes" do
    setup [:insert_questions]

    test "answered responds with answered" do
      answered = Question |> Question.answered |> Repo.all
      assert 1 == answered |> Enum.count
      assert 0 == Enum.find_index(answered, fn q -> q.answer != nil end)
    end

    test "unanswered responds with unanswered" do
      unanswered = Question |> Question.unanswered |> Repo.all
      assert 1 == unanswered |> Enum.count
      assert 0 == Enum.find_index(unanswered, fn q -> q.answer == nil end)
    end

    test "published responds with published" do
      published = Question |> Question.published |> Repo.all
      assert 1 == published |> Enum.count
      assert 0 == Enum.find_index(published, fn q -> q.published_at != nil end)
    end

    test "unpublished responds with unpublished" do
      unpublished = Question |> Question.unpublished |> Repo.all
      assert 1 == unpublished |> Enum.count
      assert 0 == Enum.find_index(unpublished, fn q -> q.published_at == nil end)
    end
  end
end

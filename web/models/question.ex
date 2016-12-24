defmodule Faq.Question do
  use Faq.Web, :model

  schema "questions" do
    field :question, :string
    field :answer, :string
    field :published_at, Ecto.DateTime

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:question, :answer, :published_at])
    |> validate_required([:question])
  end

  def answered(query) do
    from q in query,
      where: not(is_nil(q.answer))
  end

  def published(query) do
    from q in query,
      where: not(is_nil(q.published_at))
  end

  def unanswered(query) do
    from q in query,
      where: is_nil(q.answer)
  end

  def unpublished(query) do
    from q in query,
      where: is_nil(q.published_at)
  end
end

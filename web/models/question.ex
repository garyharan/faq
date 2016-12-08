defmodule Faq.Question do
  use Faq.Web, :model

  schema "questions" do
    field :question, :string
    field :answer, :string
    field :published_at, Ecto.DateTime
    field :published, :boolean

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:question, :answer, :published, :published_at])
    |> validate_required([:question])
  end
end

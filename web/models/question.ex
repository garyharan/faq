defmodule Faq.Question do
  use Faq.Web, :model

  schema "questions" do
    field :question, :string
    field :answer, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:question, :answer])
    |> validate_required([:question])
  end
end

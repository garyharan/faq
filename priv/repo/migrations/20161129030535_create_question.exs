defmodule Faq.Repo.Migrations.CreateQuestion do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :question, :string
      add :answer,   :text
      add :publish,  :boolean

      timestamps()
    end

  end
end

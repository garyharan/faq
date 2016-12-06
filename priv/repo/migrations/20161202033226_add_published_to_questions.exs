defmodule Faq.Repo.Migrations.AddPublishedToQuestions do
  use Ecto.Migration

  def change do
    alter table(:questions) do
      add :published_at, :datetime
      add :published, :boolean
    end
  end
end

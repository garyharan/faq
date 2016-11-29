defmodule Faq.QuestionView do
  use Faq.Web, :view

  def markdown(string) do
    string
    |> Earmark.to_html
    |> raw
  end
end

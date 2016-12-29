defmodule Faq.QuestionView do
  use Faq.Web, :view

  def markdown(string) when is_nil(string), do: "" |> raw

  def markdown(string) do
    string
    |> Earmark.to_html
    |> raw
  end
end

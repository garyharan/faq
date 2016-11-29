defmodule Faq.PageController do
  use Faq.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

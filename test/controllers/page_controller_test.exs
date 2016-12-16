defmodule Faq.PageControllerTest do
  use Faq.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Questions"
  end
end

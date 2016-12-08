defmodule Faq.RoleHelper do
  def is_admin(conn) do
    Coherence.current_user(conn) && Coherence.current_user(conn).role == "admin"
  end
end

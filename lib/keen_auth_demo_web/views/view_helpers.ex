defmodule KeenAuthDemoWeb.ViewHelpers do
  def tenant_id(conn) do
    conn.params["tenant_id"]
  end
end

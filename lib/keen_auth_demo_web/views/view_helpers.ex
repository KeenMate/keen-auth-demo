defmodule KeenAuthDemoWeb.ViewHelpers do
  def tenant_code(conn) do
    conn.params["tenant_code"]
  end
end

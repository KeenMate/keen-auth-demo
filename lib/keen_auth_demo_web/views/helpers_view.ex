defmodule KeenAuthDemoWeb.HelpersView do
  use KeenAuthDemoWeb, :view

  alias Phoenix.HTML.Form

  def input_for_type(:text) do
    &Form.text_input/3
  end

  def input_for_type(:password) do
    &Form.password_input/3
  end
end

defmodule KeenAuthDemoWeb.FormViewHelpers do
  require Logger

  def error_help_text(form, field) do
    Logger.debug("Error help text: #{field}, #{inspect form}")

    if error = field_has_error?(form, field) do
      error_message(error)
    else
      ""
    end
  end

  def field_has_error?(form, field) do
    form.errors[field]
  end

  def error_message(message) do
    """
    <div class="invalid-feedback">
      #{message}
    </div>
    """
  end
end

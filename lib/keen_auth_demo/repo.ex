defmodule KeenAuthDemo.Repo do
  use Ecto.Repo,
    otp_app: :keen_auth_demo,
    adapter: Ecto.Adapters.Postgres

  alias KeenAuthDemo.Database.DbContext

  def register_user(tenant_code, user, user_data) do
    with {:ok, [user]} <- DbContext.register_user(
      tenant_code,
      user.username,
      Bcrypt.hash_pwd_salt(user.password),
      user.email,
      user.display_name,
      Jason.encode!(user_data)
    ) do
      {:ok, user}
    end
  end
end

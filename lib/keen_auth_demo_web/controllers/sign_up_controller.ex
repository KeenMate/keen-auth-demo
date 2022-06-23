defmodule KeenAuthDemoWeb.SignUpController do
  use KeenAuthDemoWeb, :controller

  alias KeenAuthDemo.{NewUser, KeenUser}
  alias KeenAuthDemo.Database.DbContext
  alias KeenAuthDemo.Database.DbContext
  alias KeenAuth.Config
  alias KeenAuthPermissions.Processor
  alias Ecto.Changeset

  require Logger

  @storage Config.get_storage()
  @tenant_id Application.get_env(:keen_auth_permissions, :tenant_id)

  def get(conn, _params) do
    render(conn, "new.html", changeset: NewUser.new_changeset(%NewUser{
      username: "johndoe",
      display_name: "John Doe",
      email: "johndoe@gmail.com",
      birthdate: ~D[1999-05-05]
    }))
  end

  def post(conn, %{"tenant_id" => _tenant_id} = params) do
    changeset = NewUser.validate_changeset(%NewUser{}, params["user"])

    if changeset.valid? do
      new_user = Changeset.apply_changes(changeset)
      with {:ok, conn} <- register_user_and_store(conn, new_user) do
        redirect_back(conn)
      end
    else
      render(conn, "new.html", changeset: %{changeset | action: :insert})
    end
  end

  defp redirect_back(conn) do
    requested_path = get_session(conn, :requested_url)
    conn = delete_session(conn, :requested_url)

    redirect(conn, to: requested_path || Routes.page_path(conn, :index, tenant_code(conn)))
  end

  defp register_user_and_store(conn, user) do
    # user = Map.put(user, :id, nil)
    user_data = %{
      birthdate: user.birthdate
      # password_hash: Bcrypt.hash_pwd_salt(user.password)
    }

    with {:ok, new_user} <- register_user(tenant_code(conn), user, user_data) do
        #  {:ok, user} <- Processor.ensure_user(, user_data, :email, DbContext) do
      @storage.store(conn, :email, %{
        user: KeenUser.from_new_user(new_user),
        token: %{}
      })
    end
  end

  defp register_user(tenant_code, user, user_data) do
    DbContext.register_user(
      tenant_code,
      user.username,
      Bcrypt.hash_pwd_salt(user.password),
      user.email,
      user.display_name,
      Jason.encode!(user_data)
    )
  end
end

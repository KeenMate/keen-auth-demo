defmodule KeenAuthDemoWeb.SignUpController do
  use KeenAuthDemoWeb, :controller

  alias KeenAuthDemo.NewUser
  alias KeenAuthDemo.Database.DbContext
  alias KeenAuthDemo.Database.DbContext
  alias KeenAuth.Config
  alias KeenAuthPermissions.Processor

  require Logger

  @storage Config.get_storage()

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
      with {:ok, conn} <- register_user(conn, changeset.data) do
        redirect_back(conn)
      end
    else
      render(conn, "new.html", changeset: %{changeset | action: :insert})
    end
  end

  defp redirect_back(conn) do
    requested_path = get_session(conn, :requested_url)
    conn = delete_session(conn, :requested_url)

    redirect(conn, to: requested_path || Routes.page_path(conn, :index, tenant_id(conn)))
  end

  defp register_user(conn, user) do
    user_data = %{
      birthdate: user.birthdate
    }

    with {:ok, user} <- Processor.ensure_user(user, user_data, :email, DbContext) do
      @storage.store(conn, :email, %{
        user: user,
        token: %{}
      })
    end
  end
end

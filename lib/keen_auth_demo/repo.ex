defmodule KeenAuthDemo.Repo do
  use Ecto.Repo,
    otp_app: :keen_auth_demo,
    adapter: Ecto.Adapters.Postgres
end

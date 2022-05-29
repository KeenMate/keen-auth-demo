defmodule TestKeenAuth.Repo do
  use Ecto.Repo,
    otp_app: :test_keen_auth,
    adapter: Ecto.Adapters.Postgres
end

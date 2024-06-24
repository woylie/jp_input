defmodule JpInput.Repo do
  use Ecto.Repo,
    otp_app: :jp_input,
    adapter: Ecto.Adapters.Postgres
end

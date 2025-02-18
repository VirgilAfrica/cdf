defmodule Cdf.Repo do
  use Ecto.Repo,
    otp_app: :cdf,
    adapter: Ecto.Adapters.Postgres
end

defmodule SheetText.Repo do
  use Ecto.Repo,
    otp_app: :sheet_text,
    adapter: Ecto.Adapters.Postgres
end

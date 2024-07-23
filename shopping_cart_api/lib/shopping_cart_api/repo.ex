defmodule ShoppingCartApi.Repo do
  use Ecto.Repo,
    otp_app: :shopping_cart_api,
    adapter: Ecto.Adapters.Postgres
end

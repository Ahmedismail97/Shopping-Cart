defmodule ShoppingCartApiWeb.Router do
  use ShoppingCartApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ShoppingCartApiWeb do
    pipe_through :api
  end
end

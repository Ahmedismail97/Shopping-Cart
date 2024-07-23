defmodule ShoppingCartApiWeb.Router do
  use ShoppingCartApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ShoppingCartApiWeb do
    pipe_through :api

    resources "/products", ProductController, except: [:new, :edit]
    post "confirm_purchase", ProductController, :confirm_purchase
  end
end

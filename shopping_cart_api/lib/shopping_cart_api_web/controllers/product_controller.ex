defmodule ShoppingCartApiWeb.ProductController do
  use ShoppingCartApiWeb, :controller

  alias ShoppingCartApi.Products
  alias ShoppingCartApi.Products.Product

  action_fallback ShoppingCartApiWeb.FallbackController

  def index(conn, _params) do
    products = Products.list_products()
    render(conn, :index, products: products)
  end

  def create(conn, %{"product" => product_params}) do
    with {:ok, %Product{} = product} <- Products.create_product(product_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/products/#{product}")
      |> render(:show, product: product)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    render(conn, :show, product: product)
  end

def confirm_purchase(conn, %{"items" => items}) do
    with {:ok, _} <- Products.confirm_purchase(items) do
      send_resp(conn, :no_content, "")
    end
  end
end

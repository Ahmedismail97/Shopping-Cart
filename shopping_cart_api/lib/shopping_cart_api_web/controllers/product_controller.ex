defmodule ShoppingCartApiWeb.ProductController do
  use ShoppingCartApiWeb, :controller

  alias ShoppingCartApi.Products
  alias ShoppingCartApi.Products.Product

  action_fallback ShoppingCartApiWeb.FallbackController

  # GET /products
  # This function is used to list all products in the database. It calls the Products.list_products/0 function to get all products from the database and renders the :index template with the products.
  def index(conn, _params) do
    products = Products.list_products()
    render(conn, :index, products: products)
  end

  # POST /products
  # This function is used to create a new product. It calls the Products.create_product/1 function to create a new product with the given parameters. If the product is created successfully, it renders the :show template with the created product and sets the response status to :created. If the product creation fails, it returns an error response.
  def create(conn, %{"product" => product_params}) do
    with {:ok, %Product{} = product} <- Products.create_product(product_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/products/#{product}")
      |> render(:show, product: product)
    end
  end

  # GET /products/:id
  # This function is used to get a single product by its id. It calls the Products.get_product!/1 function to get the product with the given id from the database. If the product is found, it renders the :show template with the product. If the product is not found, it returns a 404 error response.
  def show(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    render(conn, :show, product: product)
  end

  # POST /confirm_purchase
  # This function is used to confirm a purchase. It calls the Products.confirm_purchase/1 function to confirm the purchase with the given items. If the purchase is confirmed successfully, it returns a 204 No Content response. If the purchase confirmation fails, it returns an error response.
  def confirm_purchase(conn, %{"items" => items}) do
    with {:ok, _} <- Products.confirm_purchase(items) do
      send_resp(conn, :no_content, "")
    end
  end
end

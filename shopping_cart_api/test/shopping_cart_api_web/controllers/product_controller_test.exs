defmodule ShoppingCartApiWeb.ProductControllerTest do
  use ShoppingCartApiWeb.ConnCase

  import ShoppingCartApi.ProductsFixtures

  alias ShoppingCartApi.Products.Product

  @create_attrs %{
    name: "some name",
    description: "some description",
    price: "120.5",
    quantity: 42
  }
  @update_attrs %{
    name: "some updated name",
    description: "some updated description",
    price: "456.7",
    quantity: 43
  }
  @invalid_attrs %{name: nil, description: nil, price: nil, quantity: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all products", %{conn: conn} do
      conn = get(conn, ~p"/api/products")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create product" do
    test "renders product when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/products", product: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/products/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some description",
               "name" => "some name",
               "price" => "120.5",
               "quantity" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/products", product: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_product(_) do
    product = product_fixture()
    %{product: product}
  end

  # add confirm purchase tests here
  describe "confirm purchase" do
    test "confirms the purchase", %{conn: conn} do
      product = create_product(conn)[:product]
      conn = post(conn, ~p"/api/confirm_purchase", items: [%{"id" => product.id, "quantity" => 1}])
      assert conn.status == 204
    end
  end
end

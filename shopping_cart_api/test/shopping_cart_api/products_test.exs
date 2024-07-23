defmodule ShoppingCartApi.ProductsTest do
  use ShoppingCartApi.DataCase

  alias ShoppingCartApi.Products

  describe "products" do
    alias ShoppingCartApi.Products.Product

    import ShoppingCartApi.ProductsFixtures

    @invalid_attrs %{name: nil, description: nil, price: nil, quantity: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Products.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Products.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{name: "some name", description: "some description", price: "120.5", quantity: 42}

      assert {:ok, %Product{} = product} = Products.create_product(valid_attrs)
      assert product.name == "some name"
      assert product.description == "some description"
      assert product.price == Decimal.new("120.5")
      assert product.quantity == 42
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Products.change_product(product)
    end

    test "confirm_purchase/1 confirms the purchase" do
      product = product_fixture()
      assert {:ok, _} = Products.confirm_purchase(%{product.id => 1})
    end
  end
end

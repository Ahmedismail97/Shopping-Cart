defmodule ShoppingCartApi.Products do
  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false
  alias ShoppingCartApi.Repo

  alias ShoppingCartApi.Products.Product

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  def confirm_purchase(items) do
    Repo.transaction(fn ->
      for %{"id" => id, "quantity" => quantity} <- items do
        product = Repo.get!(Product, id)
        new_quantity = product.quantity - quantity

        if new_quantity < 0 do
          {:error, "Not enough stock for #{product.name}"}
        else
          product
          |> change_product(%{quantity: new_quantity})
          |> Repo.update()
        end
      end
    end)
  end
end

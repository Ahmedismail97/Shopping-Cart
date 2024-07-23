# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ShoppingCartApi.Repo.insert!(%ShoppingCartApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias ShoppingCartApi.Repo
alias ShoppingCartApi.Products.Product

products = [
  %Product{
    name: "Macbook Pro",
    description: "The best laptop for developers",
    price: 2000,
    quantity: 10
  },
  %Product{
    name: "iPhone 12",
    description: "The best phone for developers",
    price: 1000,
    quantity: 20
  },
  %Product{
    name: "iPad Pro",
    description: "The best tablet for developers",
    price: 800,
    quantity: 50
  },
  %Product{
    name: "Apple Watch",
    description: "The best watch for developers",
    price: 500,
    quantity: 15
  },
  %Product{
    name: "AirPods Pro",
    description: "The best earbuds for developers",
    price: 250,
    quantity: 30
  },
]

Enum.each(products, fn product ->
  Repo.insert!(product)
end)

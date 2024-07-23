<template>
  <div>
    <header
      class="bg-gradient-to-r from-blue-500 to-blue-700 text-white p-4 flex justify-between items-center shadow-md"
    >
      <ShoppingCart :cart="cart" @purchase-confirmed="handlePurchaseConfirmed" />
    </header>
    <main class="p-4">
      <ProductList @add-to-cart="addToCart" />
    </main>
  </div>
</template>

<script>
import ProductList from './components/ProductList.vue'
import ShoppingCart from './components/ShoppingCart.vue'

export default {
  components: {
    ProductList,
    ShoppingCart
  },
  data() {
    return {
      cart: []
    }
  },
  methods: {
    addToCart(product) {
      const cartItem = this.cart.find((item) => item.id === product.id)
      if (cartItem) {
        cartItem.quantity += 1
      } else {
        this.cart.push({ ...product, quantity: 1 })
      }
    },
    handlePurchaseConfirmed() {
      this.cart = []
    }
  }
}
</script>

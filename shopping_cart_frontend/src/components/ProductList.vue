<template>
  <div class="container mx-auto p-4">
    <h1 class="text-3xl font-bold mb-6">Products</h1>
    <div class="grid grid-cols-1 gap-6 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4">
      <div
        v-for="product in products"
        :key="product.id"
        class="border p-6 rounded-lg shadow-lg bg-white"
      >
        <h2 class="text-xl font-semibold mb-2">{{ product.name }}</h2>
        <p class="text-gray-700 mb-4">{{ product.description }}</p>
        <p class="text-lg font-bold mb-4">${{ product.price }}</p>
        <button
          @click="addToCart(product)"
          class="mt-2 px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-700 transition duration-200"
        >
          Add to Cart
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import api from '@/services/api'

export default {
  //The data() method returns an object with a single property, products, which is an empty array. This array will be populated with the products fetched from the API.
  data() {
    return {
      products: []
    }
  },
  //The created() lifecycle hook is called when the component is created. In this hook, we call the fetchProducts() method to fetch the products from the API.
  created() {
    this.fetchProducts()
  },
  methods: {
    //The fetchProducts() method makes an API request to fetch the products and populates the products array with the response data.
    async fetchProducts() {
      try {
        const response = await api.getProducts()
        this.products = response.data
      } catch (error) {
        console.error('Error fetching products:', error)
      }
    },
    //The addToCart() method is called when the user clicks the "Add to Cart" button on a product. It emits an event with the product data to notify the parent component that a product has been added to the cart.
    addToCart(product) {
      this.$emit('add-to-cart', product)
    }
  }
}
</script>

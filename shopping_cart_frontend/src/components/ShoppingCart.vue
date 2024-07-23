<template>
  <h1 class="text-2xl font-bold">Shopping Cart</h1>
  <div class="relative">
    <button @click="toggleCart" class="relative flex items-center">
      <svg
        class="w-8 h-8"
        fill="none"
        stroke="currentColor"
        viewBox="0 0 24 24"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          stroke-linecap="round"
          stroke-linejoin="round"
          stroke-width="2"
          d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5H21M7 13l-2 8h12l-2-8M7 13h10"
        ></path>
      </svg>
      <span
        v-if="cart.length"
        class="absolute top-0 right-0 inline-block w-5 h-5 bg-red-500 text-white text-xs rounded-full text-center leading-tight"
      >
        {{ cart.length }}
      </span>
    </button>
    <div
      v-if="showCart"
      class="absolute right-0 mt-2 w-64 bg-blue-500 border border-grey-900 rounded shadow-lg"
    >
      <div v-for="item in cart" :key="item.id" class="p-2 border-b border-gray-500">
        <p>{{ item.name }} (x{{ item.quantity }})</p>
        <p class="text-right">{{ (item.price * item.quantity).toFixed(2) }}</p>
      </div>
      <div class="p-2 text-right">
        <button @click="confirmPurchase" class="bg-green-500 text-white px-4 py-2 rounded">
          Confirm Purchase
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import api from '@/services/api'

export default {
  props: ['cart'],
  data() {
    return {
      showCart: false
    }
  },
  methods: {
    // Toggle the visibility of the cart
    toggleCart() {
      this.showCart = !this.showCart
    },
    // This method is called when the user clicks the "Confirm Purchase" button in the cart component and sends a request to the API to confirm the purchase.
    async confirmPurchase() {
      try {
        await api.confirmPurchase(this.cart)
        this.$emit('purchase-confirmed')
        alert('Purchase confirmed!')
      } catch (error) {
        console.error('Error confirming purchase:', error)
        alert('Error confirming purchase.')
      }
    }
  }
}
</script>

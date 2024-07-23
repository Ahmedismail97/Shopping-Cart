import { shallowMount } from '@vue/test-utils'
import { describe, it, expect, beforeEach, afterEach, vi } from 'vitest'
import ProductList from '@/components/ProductList.vue'
import api from '@/services/api'

vi.mock('@/services/api')

describe('ProductList.vue', () => {
  let wrapper

  beforeEach(() => {
    wrapper = shallowMount(ProductList)
  })

  afterEach(() => {
    wrapper.unmount()
  })

  it('initializes with an empty products array', () => {
    expect(wrapper.vm.products).toEqual([])
  })

  it('calls fetchProducts on created', () => {
    const fetchProductsSpy = vi.spyOn(ProductList.methods, 'fetchProducts')
    shallowMount(ProductList)
    expect(fetchProductsSpy).toHaveBeenCalled()
  })

  it('fetches products and updates the products array', async () => {
    const products = [{ id: 1, name: 'Product 1', description: 'Description 1', price: 100 }]
    api.getProducts.mockResolvedValue({ data: { data: products } })

    await wrapper.vm.fetchProducts()

    expect(wrapper.vm.products).toEqual(products)
  })

  it('emits add-to-cart event when addToCart is called', () => {
    const product = { id: 1, name: 'Product 1', description: 'Description 1', price: 100 }
    wrapper.vm.addToCart(product)

    expect(wrapper.emitted('add-to-cart')).toBeTruthy()
    expect(wrapper.emitted('add-to-cart')[0][0]).toEqual(product)
  })

  it('renders products correctly', async () => {
    const products = [
      { id: 1, name: 'Product 1', description: 'Description 1', price: 100 },
      { id: 2, name: 'Product 2', description: 'Description 2', price: 200 }
    ]
    api.getProducts.mockResolvedValue({ data: { data: products } })

    await wrapper.vm.fetchProducts()
    await wrapper.vm.$nextTick()

    const productElements = wrapper.findAll('.border')
    expect(productElements.length).toBe(2)
    expect(productElements.at(0).find('h2').text()).toBe('Product 1')
    expect(productElements.at(1).find('h2').text()).toBe('Product 2')
  })
})
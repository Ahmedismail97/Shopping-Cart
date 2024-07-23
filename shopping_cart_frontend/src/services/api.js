import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:4000/api',
});

export default {
  getProducts: () => api.get('/products'),
  confirmPurchase: (items) => api.post('/confirm_purchase', { items: items }),
};
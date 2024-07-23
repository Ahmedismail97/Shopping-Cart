import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:4000/api',
});

// Request interceptor
api.interceptors.request.use(
  (config) => {
    console.log('Request:', config);
    return config;
  },
  (error) => {
    console.error('Request Error:', error);
    return Promise.reject(error);
  }
);

// Response interceptor
api.interceptors.response.use(
  (response) => {
    console.log('Response:', response);
    return response;
  },
  (error) => {
    console.error('Response Error:', error);
    return Promise.reject(error);
  }
);

const apiService = {
  // This method will be used to fetch the products from the backend API server using the GET method.
  getProducts: async () => {
    try {
      const response = await api.get('/products');
      return response.data;
    } catch (error) {
      console.error('Error fetching products:', error);
      throw error;
    }
  },
  // This method will be used to confirm the purchase of the items in the shopping cart using the POST method.
  confirmPurchase: async (items) => {
    try {
      await api.post('/confirm_purchase', { items });
    } catch (error) {
      console.error('Error confirming purchase:', error);
      throw error;
    }
  },
};

export default apiService;
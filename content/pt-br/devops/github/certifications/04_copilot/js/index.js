// Create a web API using express and JavaScript with routes for products and customers
const express = require('express');
const app = express();
// const bodyParser = require('body-parser');

// // Middleware to parse JSON requests
// app.use(bodyParser.json());

// Sample data
let products = [
  { id: 1, name: 'Product 1', price: 100 },
  { id: 2, name: 'Product 2', price: 200 },
];

let customers = [
  { id: 1, name: 'Customer 1', email: '' },
  { id: 2, name: 'Customer 2', email: '' },
];

let home = {
  message: 'Welcome to the API',
  routes: {
    products: '/products',
    customers: '/customers',
  },
};

// app.path("/products", () => products);
// app.path("/customers", () => customers);

// Route to get all products
app.get('/products', (req, res) => {
  res.json(products);
});

// Route to get all customers
app.get('/customers', (req, res) => {
  res.json(customers);
});

// Route to get home
app.get('/', (req, res) => {
  res.json(home);
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
  console.log('Access the API at http://localhost:3000/products and http://localhost:3000/customers');
});
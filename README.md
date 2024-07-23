# Shopping Cart 

This repository contains the backend API for a simple shopping cart application, built using Elixir/Phoenix with PostgreSQL as the database. The frontend of the application is built using VueJS, and TailwindCSS is used for styling.

## Table of Contents

- [Shopping Cart](#shopping-cart)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Requirements](#requirements)
  - [Installation](#installation)
    - [Backend (Elixir/Phoenix)](#backend-elixirphoenix)
    - [Frontend (VueJS)](#frontend-vuejs)
  - [Usage](#usage)
  - [API Endpoints](#api-endpoints)
    - [Products](#products)
    - [Shopping Cart](#shopping-cart-1)
  - [Database Schema](#database-schema)
  - [Testing](#testing)

## Features

- User authentication and authorization
- CRUD operations for products
- Shopping cart management
- Order processing
- Integration with PostgreSQL database

## Requirements

- Elixir 1.12+
- Phoenix 1.6+
- PostgreSQL 12+
- Node.js 14+ (for frontend integration)
- VueJS (for frontend)
- TailwindCSS (for styling)

## Installation

### Backend (Elixir/Phoenix)

1. Clone the repository:
    ```sh
    git clone https://github.com/Ahmedismail97/Shopping-Cart.git
    cd Shopping-Cart/shopping_cart_api
    ```

2. Install dependencies:
    ```sh
    mix deps.get
    ```

3. Set up the database:
    ```sh
    mix ecto.create
    mix ecto.migrate
    ```

4. Start the Phoenix server:
    ```sh
    mix phx.server
    ```

### Frontend (VueJS)

For the frontend setup, refer to the `README` file in the frontend directory of this repository.

## Usage

Once the server is running, you can access the API at `http://localhost:4000/api`. You can use tools like `Postman` or `cURL` to interact with the API endpoints.

## API Endpoints

### Products

- **Get All Products**
    - `GET /api/products`

- **Get Product by ID**
    - `GET /api/products/:id`

- **Create Product**
    - `POST /api/products`
    - Request Body:
        ```json
        {
          "product": {
            "name": "Product Name",
            "description": "Product Description",
            "price": 100,
            "quantity": 10
          }
        }
        ```

### Shopping Cart

- **Confirm Cart Items**
    - `POST /api/confirm_purchase`

## Database Schema

The database schema includes the following tables:
- **Products**

For detailed schema definitions, refer to the migration files in the `priv/repo/migrations` directory.

## Testing

To run the tests, execute the following command:
- **Backend**
```sh
mix test
```
- **Frontend**
```sh
npm run test:unit
```

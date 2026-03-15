CREATE SCHEMA IF NOT EXISTS ecommerce;

CREATE TABLE ecommerce.categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE ecommerce.users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    city VARCHAR(50),
    signup_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE ecommerce.products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(200) NOT NULL,
    category_id INT NOT NULL,
    price NUMERIC(10,2) CHECK (price > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_category
    FOREIGN KEY(category_id)
    REFERENCES ecommerce.categories(category_id)
);

CREATE TABLE ecommerce.orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(10,2) CHECK (total_amount >= 0),
    order_status VARCHAR(20) DEFAULT 'pending',

    CONSTRAINT fk_user
    FOREIGN KEY(user_id)
    REFERENCES ecommerce.users(user_id)
);

CREATE TABLE ecommerce.order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT CHECK (quantity > 0),
    price NUMERIC(10,2) CHECK (price > 0),

    CONSTRAINT fk_order
    FOREIGN KEY(order_id)
    REFERENCES ecommerce.orders(order_id),

    CONSTRAINT fk_product
    FOREIGN KEY(product_id)
    REFERENCES ecommerce.products(product_id)
);

CREATE TABLE ecommerce.payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    payment_method VARCHAR(50),
    payment_status VARCHAR(20),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_payment_order
    FOREIGN KEY(order_id)
    REFERENCES ecommerce.orders(order_id)
);

CREATE INDEX idx_orders_user
ON ecommerce.orders(user_id);

CREATE INDEX idx_orderitems_order
ON ecommerce.order_items(order_id);

CREATE INDEX idx_orderitems_product
ON ecommerce.order_items(product_id);

CREATE INDEX idx_products_category
ON ecommerce.products(category_id);

CREATE INDEX idx_payments_order
ON ecommerce.payments(order_id);
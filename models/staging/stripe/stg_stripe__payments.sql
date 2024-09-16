SELECT
    id AS customer_id,
    orderid AS order_id,
    paymentmethod AS payment_method,
    status,
    --Raw amount is stored in cents
    amount / 100 AS amount_dollars,
    created AS created_at
FROM {{ source('stripe', 'payment') }}
-- Needed to use this reference instead of the tutorial's recommended raw.stripe.payment
with orders as  (
    select * from {{ ref ('stg_jaffle_shop__orders' )}}
),

payments as  (
    select * from {{ ref('stg_stripe__payments') }}
),

order_payments as (
    select
        order_id,
        sum (case when status='success' then amount_dollars end) as amount_success
    from payments
    group by order_id
),

final as (
    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        coalesce (order_payments.amount_success, 0) as final_amount
    from orders
    left join order_payments using (order_id)
)

select * from final
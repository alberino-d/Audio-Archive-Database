use audio_archive;


-- 1. Revenue is an effective indicator for which products are the most valuable to have in stock. 
-- Throughout the entirety of the Audio Archive company, what are the top three products in terms of
-- customer revenue?

select
	p.title,
	m.name medium,
	sum(col.quantity) units_sold,
	sum(col.quantity * col.unit_price) total_revenue
from customer_order_line col
	join product p using (product_id)
	join medium m using (medium_id)
group by p.product_id
order by total_revenue desc
limit 3;


-- 2. It is crucial to understand which products are most satisfactory to customers to ensure money is
-- being spent most effectively. No revenue is generated when products are returned, so it's crucial
-- to keep track of which ones are returned most often. Which products have been returned at the highest rate?

select p.title,
	m.name medium,
	p.condition_status 'condition',
	coalesce(r.returned, 0) / s.sold return_rate
from product p
	join medium m using (medium_id)
    join (
		select product_id, sum(quantity) sold
        from customer_order_line
        group by product_id
	) s using (product_id)
    left join (
		select product_id, sum(quantity) returned
        from customer_return_line
        group by product_id
	) r using (product_id)
order by return_rate desc
limit 5;


-- 3. Staying ahead of the demands of any business before issues become urgent is a valuable ability to
-- ensuring smooth and efficient operations. Which products are closest to the reorder threshold?

select
	p.title,
	m.name medium,
    l.name location,
    l.location_type,
    i.quantity,
    i.reorder_level,
    i.quantity - i.reorder_level stock_remaining
from inventory i
	join product p using (product_id)
    join medium m using (medium_id)
    join location l using (location_id)
where i.quantity > i.reorder_level
order by stock_remaining
limit 20;


-- 4. Building a historical profile for each customer is crucial when considering the impact of personalized
-- advertisements on the website. For every customer, show total orders, total spending, favorite genre,
-- favorite artist, current cart value, and discounts used.

with

-- Total Orders & Spending
customer_totals as (
	select
		co.user_id,
        count(*) total_orders,
        sum(co.total_price) total_spending
    from customer_order co
    group by co.user_id
),

-- Favorite Genre
favorite_genre as (
	select
		user_id,
        group_concat(
			name
            order by name
            separator ', '
		) favorite_genre
    from (
		select
			co.user_id,
            g.name,
            sum(col.quantity) units_sold,
            dense_rank() over (
				partition by co.user_id
                order by sum(col.quantity) desc
			) rnk
        from customer_order co
			join customer_order_line col using (customer_order_id)
            join classifies c using (product_id)
            join genre g using (genre_id)
		group by co.user_id, g.genre_id
	) x
    where rnk = 1
    group by user_id
),

-- Favorite Artist
favorite_artist as (
	select
		user_id,
        group_concat(
			name
            order by name
            separator ', '
		) favorite_artist
    from (
		select
			co.user_id,
            a.name,
            sum(col.quantity) units_sold,
            dense_rank() over (
				partition by co.user_id
                order by sum(col.quantity) desc
			) rnk
        from customer_order co
			join customer_order_line col using (customer_order_id)
            join creates c using (product_id)
            join artist a using (artist_id)
		group by co.user_id, a.artist_id
	) x
    where rnk = 1
    group by user_id
),

-- Current Cart Value
cart_value as (
	select
		sc.user_id,
        coalesce(sum(scl.quantity * p.price), 0) current_cart_value
    from shopping_cart sc
		left join shopping_cart_line scl using (cart_id)
        left join product p using (product_id)
	group by sc.user_id
),

-- Discounts Used
discounts_used as (
	select
		co.user_id,
        group_concat(
			distinct d.code
            order by d.code
            separator ', '
		) discounts_used
    from customer_order co
		join discount d using (discount_id)
	group by co.user_id
)

select
	u.firstname,
    u.lastname,
    coalesce(ct.total_orders, 0) total_orders,
    coalesce(ct.total_spending, 0) total_spending,
    fg.favorite_genre,
    fa.favorite_artist,
    coalesce(cv.current_cart_value, 0) current_cart_value,
    coalesce(du.discounts_used, 'None') discounts_used
from user u
	left join customer_totals ct using (user_id)
    left join favorite_genre fg using (user_id)
    left join favorite_artist fa using (user_id)
    left join cart_value cv using (user_id)
    left join discounts_used du using (user_id)
order by u.lastname, u.firstname;

-- 5. Understanding which vendors supply the widest variety of products is important because prioritizing those
-- relationships is crucial to ensuring all inventory doesn't take a hit in the future. Which vendors supply the
-- largest variety of products?

select
	v.vendor_id,
	v.name vendor,
    count(distinct vol.product_id) provided_product_amount,
    group_concat(
		distinct concat(p.title, ' (', m.name, ')')
        separator ', '
        ) provided_products
from vendor_order_line vol
	join vendor_order vo using (vendor_order_id)
    join vendor v using (vendor_id)
    join product p using (product_id)
    join medium m using (medium_id)
group by vo.vendor_id
order by provided_product_amount desc;

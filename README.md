# olist-ecommerce-analysis

SQL and Power BI analysis of 100K Brazilian e-commerce orders — investigating how delivery distance and delay affect customer satisfaction





\## Data



Brazilian e-commerce public dataset (Olist) from Kaggle, loaded into SQL Server.



\## SQL views (sql/)



Built incrementally, each one checked against known row counts before being

used downstream:



\- `vw\_delivered\_orders` — delivered orders with a corrected, date-level `is\_late` flag

\- `vw\_order\_review` — one review per order (deduplicated; some review\_ids span multiple orders from the same checkout)

\- `vw\_geolocation\_clean` — average lat/lng per zip prefix, outlier coordinates filtered out

\- `vw\_single\_seller\_distance` — real customer-to-seller distance in km (geography::STDistance), single-seller orders only

\- `vw\_order\_analysis` — unified order-level table joining the above (fact\_orders in Power BI)

\- `vw\_dim\_customer` — one row per person (customer\_unique\_id), most recent address

\- `vw\_dim\_seller` — one row per seller



\## Key findings



\- \*\*Delay → review score:\*\* late deliveries get sharply worse reviews — \~1.9% late for 5-star orders vs \~37% late for 1-star orders.

\- \*\*Distance → delay:\*\* late-delivery rate rises with distance — 4.59% under 200km, up to 10.52% over 1000km.

\- Orders split across multiple sellers (no single distance) have the lowest late rate of any group, at 3.32%.

\- **Late rate spikes are not a single seasonal pattern** — they differ by year and cause.
  November 2017 saw both an order volume surge (4.5K → 7.3K orders) and a late-rate
  spike to 12.4%, consistent with holiday demand straining delivery capacity. March 2018
  saw a late-rate spike to 19% with no matching volume increase, suggesting a different,
  unexplained cause. 2016 data is too sparse (267 orders) for seasonal analysis.

\- "Order_items contains line items for all orders regardless of status; only delivered orders have corresponding rows in fact_orders."

\- " 610 of 32,951 products have no category assigned at all in the source data.
  A further 13 have a Portuguese category name with no matching entry in the
  71-row translation lookup table (e.g. "pc_gamer", "portateis_cozinha_e_preparadores_de_alimentos")."

\## Power BI Dashboard



Star schema: `fact\_orders` (order grain) related to `dim\_customer`

(customer\_unique\_id), `dim\_seller` (seller\_id), and `dim\_date` (order\_date,

with an inactive relationship to delivery\_date).



\*\*Key measures:\*\* Late Percentage, Avg Review Score, Avg Distance (km)



!\[Distance vs late delivery rate](power-bi/screenshots/05\_Mini\_Dashboard.png)


Create VIEW vw_dim_seller as
Select
	seller_id,
	seller_zip_code_prefix,
	seller_city,
	seller_state
from sellers


select
* from vw_dim_seller
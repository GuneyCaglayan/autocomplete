DELIMITER $$
CREATE PROCEDURE `ADMIN_SALE_getSalesByAutocompleteQuery`(IN `p_logged_user_id` INT UNSIGNED, IN `p_agency_id` INT UNSIGNED, IN `p_app_key` VARCHAR(255), IN `p_product_type` VARCHAR(255), IN `p_status` VARCHAR(255), IN `p_option` VARCHAR(255), IN `p_query` VARCHAR(255), IN `p_count` INT UNSIGNED)
    NO SQL
BEGIN
IF p_count = 0 THEN
    SET p_count = 20;
    END IF;
   
IF p_option IN('lastName') THEN
    SELECT DISTINCT sp.last_name
        FROM t_sale s
        JOIN t_product p ON p.id = s.product_type
        JOIN t_sale_pax sp ON s.id = sp.sale_id
        WHERE FIND_IN_SET(s.product_type, p_product_type)
        AND FIND_IN_SET(s.status, p_status)
        AND IF(p_agency_id = 0, TRUE, s.agency_id = p_agency_id)
        AND (
            IF(p_option = 'lastName', sp.last_name LIKE CONCAT(p_query, "%"), FALSE)
        )
-- ORDER BY s.creation_date DESC
  LIMIT 0, p_count;


ELSEIF p_option IN('eticket') THEN
    SELECT s.id, s.voucher_id, p.product_name, s.status, s.creation_date, s.reference_id, sp.e_ticket, sp.last_name, sp.first_name
        FROM t_sale s
        JOIN t_product p ON p.id = s.product_type
        JOIN t_sale_pax sp ON s.id = sp.sale_id
        WHERE FIND_IN_SET(s.product_type, p_product_type)
        AND FIND_IN_SET(s.status, p_status)
        AND IF(p_agency_id = 0, TRUE, s.agency_id = p_agency_id)
        AND (
            IF(p_option = 'eticket', sp.e_ticket LIKE CONCAT(p_query, "%"), FALSE)
        )
ORDER BY s.creation_date DESC
  LIMIT 0, p_count;

ELSEIF p_option IN('saleId', 'searchId', 'pnrNo') THEN
        SELECT s.id, s.voucher_id, s.status, p.product_name, s.creation_date, s.reference_id
        FROM t_sale s
        JOIN t_product p ON p.id = s.product_type
        WHERE FIND_IN_SET(s.product_type, p_product_type)
        AND FIND_IN_SET(s.status, p_status)
        AND IF(p_agency_id = 0, TRUE, s.agency_id = p_agency_id)
        AND (
            IF(p_option = 'saleId', s.id LIKE CONCAT(p_query, "%"), FALSE)
        OR IF(p_option = 'searchId', s.reference_id LIKE CONCAT(p_query, "%"), FALSE)
        OR IF(p_option = 'pnrNo', s.voucher_id LIKE CONCAT(p_query, "%"), FALSE)
        )
        AND FIND_IN_SET(s.product_type, p_product_type)
    ORDER BY s.creation_date DESC
  LIMIT 0, p_count;
    END IF;


END$$

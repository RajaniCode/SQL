-- FUNCTION 1

-- \connect spdb;

DROP FUNCTION sp;

CREATE OR REPLACE FUNCTION sp
(
 cust_id INT,
 OUT shipped INT,
 OUT canceled INT,
 OUT resolved INT,
 OUT disputed INT
)
AS $$
BEGIN
 -- shipped
 SELECT
  count(*) INTO shipped
 FROM
  rental
 WHERE
  customer_id = cust_id
 AND 
  status = 'Shipped';
 
 -- canceled
 SELECT
  count(*) INTO canceled
 FROM
  rental
 WHERE
  customer_id = cust_id
 AND 
  status = 'Canceled';
 
 -- resolved
 SELECT
  count(*) INTO resolved
 FROM
  rental
 WHERE
  customer_id = cust_id
 AND 
  status = 'Resolved';
 
 -- disputed
 SELECT
  count(*) INTO disputed
 FROM
  rental
 WHERE
  customer_id = cust_id
 AND 
  status = 'Disputed';
END; $$
LANGUAGE plpgsql;

-- SELECT sp(6);
SELECT * FROM sp(6);

-- FUNCTION 2

-- \connect spdb;

DROP FUNCTION spin;

CREATE OR REPLACE FUNCTION spin(n int)
    RETURNS TABLE (
        customer_id int,
        customer_name varchar,
        email varchar,
        date_of_birth date,
        income double precision,
        credit_limit decimal,
        create_date date,
        last_update timestamp
 )
AS $$
BEGIN
    RETURN QUERY SELECT * FROM customer LIMIT n;
END; $$
LANGUAGE 'plpgsql';

-- SELECT spin(6);
SELECT * FROM spin(6);

-- NOTE

DROP FUNCTION spin;

CREATE OR REPLACE FUNCTION spin(int) RETURNS setof RECORD AS
'
DECLARE
r RECORD;
BEGIN
    FOR r in EXECUTE ''SELECT customer_id, customer_name, email, date_of_birth, income, credit_limit, create_date, last_update FROM customer LIMIT '' || $1 loop
        RETURN NEXT r;
    END LOOP;
RETURN;
END
'
LANGUAGE 'plpgsql';

SELECT * FROM spin(6) as cust(customer_id int, customer_name varchar, email varchar, date_of_birth date, income double precision, credit_limit decimal, create_date date, last_update timestamp);


-- FUNCTION 3

-- \connect spdb;

DROP FUNCTION spinout;

CREATE OR REPLACE FUNCTION spinout(in_customer_id int, OUT out_count bigint)
AS $$
BEGIN
 -- out_count := (SELECT COUNT(*) FROM customer WHERE customer_id > in_customer_id);
 SELECT COUNT(*) INTO out_count  FROM customer WHERE customer_id > in_customer_id;
END; $$
LANGUAGE plpgsql;

-- SELECT spinout(6);
SELECT * FROM spinout(6);

-- NOTE

CREATE OR REPLACE FUNCTION spinout(in_customer_id int) RETURNS bigint AS $$
    SELECT COUNT(*) FROM customer WHERE customer_id > in_customer_id;
$$ LANGUAGE SQL;

SELECT spinout(6);


-- FUNCTION 4

-- \connect spdb;

DROP FUNCTION spinputoutput;

CREATE OR REPLACE FUNCTION spinputoutput
(
 p_customer_id int, 
 inout p_customerLevel  varchar -- Note -- out p_customerLevel  varchar
)
AS $$
DECLARE creditlimit decimal; 
BEGIN 
 SELECT 
  credit_limit INTO creditlimit
 FROM 
  customer
 WHERE 
  customer_id = p_customer_id; 
 IF creditlimit > 50 THEN
  p_customerLevel := 'PLATINUM';
 ELSIF (creditlimit <= 50 AND creditlimit >= 10) THEN
  p_customerLevel := 'GOLD';
 ELSIF creditlimit < 10 THEN
  p_customerLevel := 'SILVER';
 END IF; 
END; $$
LANGUAGE plpgsql;

-- SELECT spinputoutput(3, '');
SELECT * FROM spinputoutput(3, '');


-- FUNCTION 5

-- \connect spdb;

DROP FUNCTION multiply;

CREATE OR REPLACE FUNCTION multiply
(
 pFac1 INT, 
 pFac2 INT, 
 OUT pProd INT
)
AS $$
BEGIN
  pProd := pFac1 * pFac2;
END; $$
LANGUAGE plpgsql;

-- SELECT multiply(5, 5);
SELECT * FROM multiply(5, 5);

-- NOTE

CREATE OR REPLACE FUNCTION square(
 INOUT a NUMERIC)
AS $$
BEGIN
 a := a * a;
END; $$
LANGUAGE plpgsql;

SELECT square(4);


-- FUNCTION 6

-- \connect spdb;

DROP FUNCTION concat;

CREATE OR REPLACE FUNCTION concat
(
 pStr1 VARCHAR, 
 pStr2 VARCHAR,
 OUT pConCat VARCHAR
)
AS $$
BEGIN
  pConCat := CONCAT(pStr1, pStr2);
END; $$
LANGUAGE plpgsql;

--SELECT * FROM concat('My', 'SQL');
SELECT concat('My', 'SQL');


-- FUNCTION 7

-- \connect spdb;

DROP FUNCTION prepend;

CREATE OR REPLACE FUNCTION prepend(inparam text)
RETURNS SETOF text AS $$
BEGIN
  RETURN NEXT inparam;
  RETURN NEXT 'zyxw' || inparam;
END;
$$ LANGUAGE plpgsql;

-- SELECT prepend('abcdefg');
SELECT * FROM prepend('abcdefg');
-- DDL for database eshop
--

USE eshop;

DROP TABLE IF EXISTS bestallning;
DROP TABLE IF EXISTS kund;
DROP TABLE IF EXISTS kundregistret;
DROP TABLE IF EXISTS plocklista;
DROP TABLE IF EXISTS lagerhylla;
DROP TABLE IF EXISTS lager;
DROP TABLE IF EXISTS faktura;
DROP TABLE IF EXISTS kategorimanager;
DROP TABLE IF EXISTS produkter;
DROP TABLE IF EXISTS produktkategori;
DROP TABLE IF EXISTS handelselog;



CREATE TABLE kundregistret (
	kundid INT AUTO_INCREMENT,
    fornamn VARCHAR(40),
    efternamn VARCHAR(40),
    adress VARCHAR(50),
    telefon VARCHAR(50),
    PRIMARY KEY (kundid)
);

CREATE TABLE produktkategori (
    kategorinamn VARCHAR(50),
    PRIMARY KEY (kategorinamn)
);

CREATE TABLE produkter (
	produktkod INT AUTO_INCREMENT,
    namn VARCHAR(20),
    beskrivning VARCHAR (200),
    pris INT,
    PRIMARY KEY (produktkod)
);

CREATE TABLE kategorimanager (
	produktkod INT,
    kategorinamn VARCHAR(50),
    FOREIGN KEY (produktkod) REFERENCES produkter(produktkod),
    FOREIGN KEY (kategorinamn) REFERENCES produktkategori(kategorinamn)
);


CREATE TABLE handelseLog (
	logid INT AUTO_INCREMENT,
    orderdatum DATE,
    plockdatum DATE,
    fakturadatum DATE,
    PRIMARY KEY (logid)
);


CREATE TABLE lager (
    hylla VARCHAR(20),
    PRIMARY KEY (hylla)
);

CREATE TABLE lagerhylla (
    produktkod INT PRIMARY KEY,
    antal INT,
    hylla VARCHAR(20),
    FOREIGN KEY (produktkod) REFERENCES produkter(produktkod),
    FOREIGN KEY (hylla) REFERENCES lager(hylla)
);

CREATE TABLE kund (
	kundid INT AUTO_INCREMENT,
    PRIMARY KEY (kundid),
    FOREIGN KEY (kundid) REFERENCES kundregistret(kundid)
);


CREATE TABLE faktura(
	fakturaid INT AUTO_INCREMENT,
    produktkod INT,
    antal INT,
    totalPris INT,
    PRIMARY KEY (fakturaid),
    FOREIGN KEY (produktkod) REFERENCES produkter(produktkod)
);


CREATE TABLE bestallning (
	orderid INT AUTO_INCREMENT,
    kundid INT,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    deleted TIMESTAMP NULL,
    ordered TIMESTAMP NULL,
    sent TIMESTAMP NULL,
    antal_rader INT,
    logid INT,
    fakturaid INT,
    PRIMARY KEY (orderid),
    FOREIGN KEY (kundid) REFERENCES kundregistret(kundid),
    FOREIGN KEY (logid) REFERENCES handelselog(logid),
    FOREIGN KEY (fakturaid) REFERENCES faktura(fakturaid)
);

CREATE TABLE plocklista (
	plockid INT AUTO_INCREMENT,
    produktkod INT,
    kundid INT,
    orderid INT,
    antal INT DEFAULT 0,
    PRIMARY KEY (plockid),
    FOREIGN KEY (produktkod) REFERENCES produkter(produktkod),
    FOREIGN KEY (kundid) REFERENCES kundregistret(kundid),
    FOREIGN KEY (orderid) REFERENCES bestallning(orderid)
);

-- 
-- Trigers
--

DROP TABLE IF EXISTS product_log;
CREATE TABLE product_log 
(
	ID INT PRIMARY KEY AUTO_INCREMENT,
    Tidstampel TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Handelse VARCHAR(50),
    Produktnamn VARCHAR(20)
);

DELETE FROM product_log;

-- Triger for INSERTION of a new product.

DROP TRIGGER IF EXISTS product_log_insert;

CREATE TRIGGER product_log_insert
AFTER INSERT
ON produkter FOR EACH ROW
	INSERT INTO product_log (Tidstampel, Handelse, Produktnamn)
    VALUES (CURRENT_TIMESTAMP, "A new product was added", NEW.namn);
	

-- Triger for UPDATING of a product.

DROP TRIGGER IF EXISTS product_log_update;

CREATE TRIGGER product_log_update
AFTER UPDATE
ON produkter FOR EACH ROW
	INSERT INTO product_log (Tidstampel, Handelse, Produktnamn)
    VALUES (CURRENT_TIMESTAMP, "The details were updated.", NEW.namn);

-- Triger for DROPING a product.

DROP TRIGGER IF EXISTS product_log_delete;

CREATE TRIGGER product_log_delete
AFTER DELETE
ON produkter FOR EACH ROW
	INSERT INTO product_log (Tidstampel, Handelse, Produktnamn)
    VALUES (CURRENT_TIMESTAMP, "The product was deleted.", OLD.namn);
	
--
-- Procedures for webclient 
--

-- Show Category
DROP PROCEDURE IF EXISTS show_category;

DELIMITER ;;

CREATE PROCEDURE show_category ()
BEGIN 
	SELECT * FROM produktkategori AS Kategori;
END
;;

DELIMITER ;


-- Show products


DROP PROCEDURE IF EXISTS show_product;

DELIMITER ;;

CREATE PROCEDURE show_product()
BEGIN
	SELECT 
		produkter.produktkod AS Produktkod, 
		produkter.namn AS Namn,
		produkter.beskrivning AS Beskrivning, 
		produkter.pris AS Pris, 
		IF (lagerhylla.antal = 0, 'Slut i lager', lagerhylla.antal) AS Antal,
	GROUP_CONCAT(DISTINCT kategorimanager.kategorinamn) AS Kategori
	FROM 
		produkter
	LEFT OUTER JOIN 
		lagerhylla 
			ON produkter.produktkod = lagerhylla.produktkod
	LEFT OUTER JOIN
		kategorimanager
			ON produkter.produktkod = kategorimanager.produktkod
	GROUP BY
		produkter.produktkod
		;
END;;


DELIMITER ;

-- Add products

DROP PROCEDURE IF EXISTS insert_product;

DELIMITER ;;

CREATE PROCEDURE insert_product (
	p_namn VARCHAR(40),
    p_beskrivning VARCHAR(200),
    p_pris INT
    )
BEGIN
	INSERT INTO
		produkter (namn, beskrivning, pris)
	VALUES 
		(p_namn, p_beskrivning, p_pris);
END;;

DELIMITER ;

-- Get a product

DROP PROCEDURE IF EXISTS get_product;

DELIMITER ;;

CREATE PROCEDURE get_product (
	a_produktkod INT
    )
BEGIN
	SELECT * FROM produkter
		WHERE produktkod = a_produktkod;
END;;

DELIMITER ;

-- Update product

DROP PROCEDURE IF EXISTS update_product;

DELIMITER ;;

CREATE PROCEDURE update_product (
	a_produktkod INT,
    a_namn VARCHAR(20),
    a_beskrivning VARCHAR(200),
    a_pris INT
    )
BEGIN
	UPDATE produkter
		SET namn = a_namn, beskrivning = a_beskrivning, pris = a_pris
	WHERE produktkod = a_produktkod;
END;;

DELIMITER ;


-- Delete product

DROP PROCEDURE IF EXISTS delete_product;

DELIMITER ;;

CREATE PROCEDURE delete_product (
	a_produktkod INT
    )
BEGIN
	DELETE FROM 
		produkter
	WHERE 
		produktkod = a_produktkod;
END;;

DELIMITER ;


-- log <number>

DROP PROCEDURE IF EXISTS log_number;

DELIMITER ;;

CREATE PROCEDURE log_number (
	a_number INT
    )
BEGIN
	SELECT 
		ID,
        Tidstampel,
        Handelse,
        Produktnamn
    FROM product_log
    ORDER BY Tidstampel DESC
    LIMIT a_number;
END;;

DELIMITER ;


-- product

DROP PROCEDURE IF EXISTS product;

DELIMITER ;;

CREATE PROCEDURE product ()
BEGIN
	SELECT 
		produktkod AS Produktkod,
        namn AS Namn,
        beskrivning AS Beskrivning,
        pris AS Pris
	FROM 
		produkter
        ;
END;;

DELIMITER ;


-- shelf

DROP PROCEDURE IF EXISTS shelf;

DELIMITER ;;

CREATE PROCEDURE shelf ()
BEGIN
	SELECT 
		hylla AS Hylla
	FROM 
		lager
        ;
END;;

DELIMITER ;

-- inv

DROP PROCEDURE IF EXISTS inv;

DELIMITER ;;

CREATE PROCEDURE inv()
BEGIN
	SELECT 
		produkter.produktkod AS Produktkod, 
		produkter.namn AS Namn, 
		lagerhylla.antal AS Antal,
        lagerhylla.hylla AS Hylla
	FROM 
		produkter
	LEFT OUTER JOIN 
		lagerhylla 
			ON produkter.produktkod = lagerhylla.produktkod
		;
END;;


DELIMITER ;


-- inv <str>

DROP PROCEDURE IF EXISTS inv_str;

DELIMITER ;;

CREATE PROCEDURE inv_str(
	a_input VARCHAR(200)
)
BEGIN
	SELECT 
		produkter.produktkod AS Produktkod, 
		produkter.namn AS Namn, 
		lagerhylla.antal AS Antal,
        lagerhylla.hylla AS Hylla
	FROM 
		produkter
	LEFT OUTER JOIN 
		lagerhylla 
			ON produkter.produktkod = lagerhylla.produktkod
	WHERE
		produkter.produktkod = a_input
        OR
        produkter.namn LIKE a_input
        OR
        lagerhylla.hylla LIKE a_input
		;
END;;


DELIMITER ;


-- invadd <productid><shelf><number>

DROP PROCEDURE IF EXISTS invadd;

DELIMITER ;;

CREATE PROCEDURE invadd (
	p_kod INT,
    p_number INT,
	p_hylla VARCHAR(20)
    )
BEGIN
	INSERT INTO
		 lagerhylla (produktkod, antal, hylla)
	VALUES 
		(p_kod, p_number, p_hylla)
	ON DUPLICATE KEY UPDATE antal = antal + p_number;
END;;

DELIMITER ;

-- invdel <productid><shelf><number>

DROP PROCEDURE IF EXISTS invdel;

DELIMITER ;;

CREATE PROCEDURE invdel (
	p_kod INT,
    p_number INT,
	p_hylla VARCHAR(20)
    )
BEGIN
	UPDATE lagerhylla
		SET antal = antal - p_number
	WHERE
		produktkod = p_kod
        AND
        hylla = p_hylla
        ;
END;;

DELIMITER ;

-- showCustomer

DROP PROCEDURE IF EXISTS show_customer;

DELIMITER ;;

CREATE PROCEDURE show_customer ()
BEGIN
	SELECT
		kundid AS ID,
        CONCAT(fornamn,' ', efternamn) AS Namn,
        adress AS Adress,
        telefon AS Telefonnummer
	FROM 
		kundregistret;
END;;

DELIMITER ;

-- showCustomer

DROP PROCEDURE IF EXISTS get_customer;

DELIMITER ;;

CREATE PROCEDURE get_customer (
	a_kundid INT
)
BEGIN
	SELECT
		kundid AS ID,
        CONCAT(fornamn,' ', efternamn) AS Namn,
        adress AS Adress,
        telefon AS Telefonnummer
	FROM 
		kundregistret
	WHERE
		kundid = a_kundid
        ;
        
END;;

DELIMITER ;

--
-- Funcion for show_status()
-- 

DROP FUNCTION IF EXISTS show_status;
DELIMITER ;;

CREATE FUNCTION show_status(
	a_created TIMESTAMP,
    a_updated TIMESTAMP,
    a_deleted TIMESTAMP,
    a_ordered TIMESTAMP,
    a_sent TIMESTAMP
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
	IF a_sent IS NOT NULL THEN
		RETURN 'Shickat';
	ELSEIF a_deleted IS NOT NULL THEN
		RETURN 'Raderat';
	ELSEIF a_ordered IS NOT NULL THEN
		RETURN 'Bestallt';
	ELSEIF a_updated IS NOT NULL THEN
		RETURN 'Uppdaterad';
	ELSEIF a_created IS NOT NULL THEN
		RETURN 'Skapat';
	END IF;
END
;;

DELIMITER ;

--
-- Index for produk namn
--
DROP INDEX IF EXISTS namn_index
	ON produkter;
    
CREATE INDEX namn_index
	ON produkter (namn);
    
--
-- Index for kund namn 
-- 
DROP INDEX IF EXISTS index_namn
	ON kundregistret;

CREATE INDEX index_namn
	ON kundregistret(kundid);
    
-- 
-- PROCEDURE FOR CREATING AN ORDER
--
DROP PROCEDURE IF EXISTS create_order;

DELIMITER ;;

CREATE PROCEDURE create_order (
	a_kundid INT
)
BEGIN
	INSERT INTO
		bestallning (kundid)
	VALUES
		 (a_kundid)
		;
END ;;

DELIMITER ;



-- 
-- PROCEDURE FOR SHOWING AN ORDER
--

DROP PROCEDURE IF EXISTS show_order;

DELIMITER ;;

CREATE PROCEDURE show_order ()
BEGIN
	SELECT DISTINCT
	b.orderid ,
	b.kundid ,
    CONCAT(k.fornamn,' ', k.efternamn) AS namn,
	IF(created IS NOT NULL, created, '') AS datum,
    count(p.orderid)  AS antal,
	show_status(created, updated, deleted, ordered, sent) AS 'status' 
	FROM 
		 bestallning AS b
	LEFT JOIN
		kundregistret AS k
			ON k.kundid = b.kundid 
	LEFT JOIN
		plocklista AS p
			ON b.orderid = p.orderid
	GROUP BY
		b.orderid
	ORDER BY
		b.orderid DESC
        ;
END ;;

DELIMITER ;


--
-- INSERTING INTO PLOCK LIST
--

DROP PROCEDURE IF EXISTS insert_product;

DELIMITER ;;

CREATE PROCEDURE insert_product(
	a_produktkod INT,
    a_kundid INT,
	a_orderid INT,
    a_antal INT
)
BEGIN
	INSERT INTO
		plocklista (produktkod, kundid, orderid, antal)
	VALUES (a_produktkod, a_kundid, a_orderid, a_antal);
END ;;

DELIMITER ;

-- shelf

DROP PROCEDURE IF EXISTS update_order;

DELIMITER ;;

CREATE PROCEDURE update_order (
	a_orderid INT,
    a_kundid INT
)
BEGIN
	UPDATE 
		bestallning
	SET 
		ordered = current_timestamp
	WHERE
		kundid = a_kundid
        AND
        orderid = a_orderid
        ;
END;;

DELIMITER ;


--
-- PROCEDURE FOR SHOWING ORDER DETAILS
--

DROP PROCEDURE IF EXISTS show_a_order;

DELIMITER ;;

CREATE PROCEDURE show_a_order(
	a_orderid int)

BEGIN
	SELECT
		b.orderid,
		CONCAT(k.fornamn, ' ', k.efternamn) AS kundnamn,
		pr.*,
		p.antal,
        b.kundid,
        show_status(created, updated, deleted, ordered, sent) AS 'status' 
	FROM
		bestallning AS b
	JOIN
		plocklista AS p
			ON  p.orderid = b.orderid 
	JOIN
		produkter as pr
			ON p.produktkod = pr.produktkod
	JOIN 
		kundregistret AS k
			ON p.kundid = k.kundid
	WHERE 
		p.orderid = a_orderid
		;
END;;

DELIMITER ;

--
-- Procedure for getting a customer id by sending an order id
-- 

DROP PROCEDURE IF EXISTS get_kund_id;

DELIMITER ;;

CREATE PROCEDURE get_kund_id (
	a_orderid INT)
BEGIN
	SELECT 	
		kundid
	FROM 
		bestallning
	WHERE
		orderid = a_orderid
        ;
END ;;

DELIMITER ;


--
-- PROCEDURE FOR SHOWING ORDER DETAILS
--

DROP PROCEDURE IF EXISTS get_order_status;

DELIMITER ;;

CREATE PROCEDURE get_order_status(
	a_orderid int)

BEGIN
	SELECT
        show_status(created, updated, deleted, ordered, sent) AS 'status' 
	FROM
		bestallning AS b
	WHERE 
		orderid = a_orderid
		;
END;;

DELIMITER ;


DROP PROCEDURE IF EXISTS uppdate_lager_status;

DELIMITER ;;

CREATE PROCEDURE uppdate_lager_status (
	a_antal INT,
    a_produktkod INT
)
	BEGIN
	UPDATE 
		lagerhylla
		SET 
			antal = antal - a_antal
	WHERE 
		produktkod = a_produktkod
        ;
END ;;

DELIMITER ;


--
-- order <search> terminal
-- 

DROP PROCEDURE IF EXISTS show_a_order_terminal;

DELIMITER ;;

CREATE PROCEDURE show_a_order_terminal (
	a_orderid INT
)
BEGIN
	SELECT DISTINCT
	b.orderid 'Order ID',
	b.kundid 'Kund ID',
    CONCAT(k.fornamn,' ', k.efternamn) AS Namn,
	IF(created IS NOT NULL, created, '') AS Datum,
    count(p.orderid)  AS Antal,
	show_status(created, updated, deleted, ordered, sent) AS 'Status' 
	FROM 
		 bestallning AS b
	LEFT JOIN
		kundregistret AS k
			ON k.kundid = b.kundid 
	LEFT JOIN
		plocklista AS p
			ON b.orderid = p.orderid
	WHERE 
		b.orderid = a_orderid
        OR
		b.kundid = a_orderid
    GROUP BY
		b.orderid
	ORDER BY
		b.orderid DESC
        ;
END ;;

DELIMITER ;

-- 
-- PROCEDURE FOR SHOWING AN ORDER Terminal
--

DROP PROCEDURE IF EXISTS show_order_terminal;

DELIMITER ;;

CREATE PROCEDURE show_order_terminal ()
BEGIN
	SELECT DISTINCT
	b.orderid 'Order ID',
	b.kundid 'Kund ID',
    CONCAT(k.fornamn,' ', k.efternamn) AS Namn,
	IF(created IS NOT NULL, created, '') AS Datum,
    count(p.orderid)  AS Antal,
	show_status(created, updated, deleted, ordered, sent) AS 'Status' 
	FROM 
		 bestallning AS b
	LEFT JOIN
		kundregistret AS k
			ON k.kundid = b.kundid 
	LEFT JOIN
		plocklista AS p
			ON b.orderid = p.orderid
	GROUP BY
		b.orderid
	ORDER BY
		b.orderid DESC
        ;
END ;;

DELIMITER ;



--
-- PROCEDURE FOR plocklist <orderid>
--

DROP PROCEDURE IF EXISTS create_plocklist;

DELIMITER ;;

CREATE PROCEDURE create_plocklist (
	a_orderid INT
    )
BEGIN
	SELECT 
		p.orderid AS 'Order ID',
		p.produktkod AS 'Produkt Kod',
		pr.namn AS 'Produkt Namn',
		p.antal AS 'Bestallt Antal',
		(lh.antal + p.antal) AS 'Lager antal',
		lh.hylla AS 'Hyllplats',
        IF((lh.antal + p.antal) - p.antal < 0, 'Slut i Lager', 'Finns i lager') AS 'Lagerstatus'
	FROM plocklista AS p
	JOIN
		lagerhylla AS lh
			ON p.produktkod = lh.produktkod
	JOIN
		produkter AS pr
			ON p.produktkod = pr.produktkod
	WHERE 
		p.orderid = a_orderid
		;
END ;;

DELIMITER ;


--
-- PROCEDURE FOR ship <orderid>
--

DROP PROCEDURE IF EXISTS ship_order;

DELIMITER ;;

CREATE PROCEDURE ship_order (
	a_orderid INT
    )
BEGIN
	UPDATE
		bestallning
	SET
		sent = CURRENT_TIMESTAMP
	WHERE 
		orderid = a_orderid
		;
END ;;

DELIMITER ;
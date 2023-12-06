--
-- Insert data into eshop
--
USE eshop;

DELETE FROM kundregistret;
DELETE FROM produktkategori;
DELETE FROM produkter;
DELETE FROM lager;


--
-- Insert into Kundregistret
--
LOAD DATA LOCAL INFILE 'kundregistret.csv'
INTO TABLE kundregistret
CHARSET utf8
FIELDS
    TERMINATED BY ';'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
(fornamn, efternamn, adress, telefon)
;



--
-- Insert into produktkategori
--
LOAD DATA LOCAL INFILE 'produktkategori.csv'
INTO TABLE produktkategori
CHARSET utf8
FIELDS
    TERMINATED BY ';'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;


--
-- Insert into produkter
--
LOAD DATA LOCAL INFILE 'produkt.csv'
INTO TABLE produkter
CHARSET utf8
FIELDS
    TERMINATED BY ';'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
(namn, beskrivning, pris)
;

--
-- Insert into Lager
--
LOAD DATA LOCAL INFILE 'lagerhyllor.csv'
INTO TABLE lager
CHARSET utf8
FIELDS
    TERMINATED BY ';'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;



--
-- Insert into Lagerhylla
--
LOAD DATA LOCAL INFILE 'produkt2lager.csv'
INTO TABLE lagerhylla
CHARSET utf8
FIELDS
    TERMINATED BY ';'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
(produktkod, antal, hylla)
;



--
-- Insert into Lager
--
LOAD DATA LOCAL INFILE 'produkt2kategori.csv'
INTO TABLE kategorimanager
CHARSET utf8
FIELDS
    TERMINATED BY ';'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
(produktkod, kategorinamn)
;


-- Database: "PROJEKT"

-- DROP DATABASE "PROJEKT";

CREATE DATABASE "PROJEKT"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'Polish_Poland.1250'
       LC_CTYPE = 'Polish_Poland.1250'
       CONNECTION LIMIT = -1;



CREATE TABLE Wydawca (
  idWydawca serial PRIMARY KEY,
  wydawca VARCHAR(50)NOT NULL
);
CREATE TABLE Platforma (
  idPlatforma serial PRIMARY KEY,
  Nazwa VARCHAR(30) NOT NULL
);

CREATE TABLE Producent (
  idProducent serial PRIMARY KEY,
  nazwa VARCHAR(40) NOT NULL
);

CREATE TABLE Gatunek (
  idGatunek serial PRIMARY KEY,
  gatunek VARCHAR(20) NOT NULL,
  opis VARCHAR(255)
  );

CREATE TABLE Adres (
  idAdres serial PRIMARY KEY,
  ulica VARCHAR(40) NOT NULL,
  nr_domu VARCHAR(5) NOT NULL,
  kod VARCHAR(10) NOT NULL,
  miasto VARCHAR(20) NOT NULL
);

CREATE TABLE Wysylka (
  idWysylka serial PRIMARY KEY,
  rodzaj_wysylki VARCHAR(100) NOT NULL,
  cena_netto NUMERIC NOT NULL
);

CREATE TABLE Klient (
  idKlient serial PRIMARY KEY,
  idAdres INT NOT NULL,
  CONSTRAINT idAdres_fk_k FOREIGN KEY(idAdres) REFERENCES Adres(idAdres) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE NO ACTION,
  imie VARCHAR(15) NOT NULL,
  nazwisko VARCHAR(30) NOT NULL,
  NIP CHAR(10) UNIQUE,
  PESEL CHAR(9) UNIQUE
  
);
  
CREATE TABLE Sprzedawca (
  idSprzedawca serial PRIMARY KEY,
  idAdres INT NOT NULL,
  CONSTRAINT idAdres_fk_s FOREIGN KEY(idAdres) REFERENCES Adres(idAdres) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE NO ACTION,
  imie VARCHAR(15) NOT NULL,
  nazwisko VARCHAR(30) NOT NULL,
  NIP CHAR(10) UNIQUE
);

CREATE TABLE Gry (
  idGry serial PRIMARY KEY,
  idWydawca INT NOT NULL,
  CONSTRAINT idWydawca_fk FOREIGN KEY(idWydawca) REFERENCES Wydawca(idWydawca) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE NO ACTION,
  idProducent INT NOT NULL,
  CONSTRAINT idProducent_fk FOREIGN KEY(idProducent) REFERENCES Producent(idProducent) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE NO ACTION,
  nazwa VARCHAR(40) NOT NULL,
  rok_wydania DATE NOT NULL,
  cena_netto NUMERIC NOT NULL
);

CREATE TABLE Koszyk (
  idKoszyk serial PRIMARY KEY,
  idKlient INT NOT NULL,
  CONSTRAINT idKlient_fk FOREIGN KEY(idKlient) REFERENCES Klient(idKlient) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE NO ACTION,
  idSprzedawca INT NOT NULL,
  CONSTRAINT idSprzedawca_fk FOREIGN KEY(idSprzedawca) REFERENCES Sprzedawca(idSprzedawca) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE NO ACTION,
  idWysylka INT NOT NULL,
  CONSTRAINT idWysylka_fk FOREIGN KEY(idWysylka) REFERENCES Wysylka(idWysylka) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE NO ACTION,
  cena_razem_netto NUMERIC NOT NULL,
  stawka_vat INT NOT NULL,
  cena_razem_brutto NUMERIC NOT NULL,
  ilosc_razem INT NOT NULL
);

CREATE TABLE Wiele_Platform (
  idGry INT,
  CONSTRAINT idGry_fk_wp FOREIGN KEY(idGry) REFERENCES Gry(idGry) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE NO ACTION,
  idPlatforma INT,
  CONSTRAINT idPlatforma_fk FOREIGN KEY(idPlatforma) REFERENCES Platforma(idPlatforma) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE Wiele_Gatunkow (
  idGatunek INT,
  CONSTRAINT igGatunek_fk FOREIGN KEY(idGatunek) REFERENCES Gatunek(idGatunek) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE NO ACTION,
  idGry INT,
  CONSTRAINT idGry_fk_wg FOREIGN KEY(idGry) REFERENCES Gry(idGry) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE Pozycje (
  idGry INT,
  CONSTRAINT idGry_fk_p FOREIGN KEY(idGry) REFERENCES Gry(idGry) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE NO ACTION,
  idKoszyk INT,
  CONSTRAINT idKoszyk_fk FOREIGN KEY(idKoszyk) REFERENCES Koszyk(idKoszyk) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE NO ACTION
);

INSERT INTO Adres VALUES (1,'Konopnicka','4E','23-980','Rzeszow');
INSERT INTO Adres VALUES (2,'Sikorskiego','6E','53-940','Poznan');
INSERT INTO Adres VALUES (3,'Batorego','9I','32-120','Bialystok');
INSERT INTO Adres VALUES (4,'Długa','5','43-111','Bydgoszcz');
INSERT INTO Adres VALUES (5,'Krotka','88','34-567','Swinoujscie');

INSERT INTO Klient VALUES (1,1,'Tomasz','Czerwinski','1234576423','98787879');
INSERT INTO Klient VALUES (2,1,'Rafal','Czerwinski','2345765323',NULL);
INSERT INTO Klient VALUES (3,1,'Pawel','Czerwinski',NULL,'985456356');
INSERT INTO Klient VALUES (4,2,'Zygmunt','Stary','1456735664','764321456');
INSERT INTO Klient VALUES (5,3,'Stefan','Batory','4444534565','666654564');

INSERT INTO Sprzedawca VALUES (1,3,'Zenek','Inny','4673976453');
INSERT INTO Sprzedawca VALUES (2,4,'Franek','Znany','3456543425');
INSERT INTO Sprzedawca VALUES (3,5,'Bronislawa','Panna','9999999876');
INSERT INTO Sprzedawca VALUES (4,1,'Anna','Czerwinska','2222343222');
INSERT INTO Sprzedawca VALUES (5,2,'Julia','Stara','2343231344');


INSERT INTO Producent VALUES(1,'Activision');
INSERT INTO Producent VALUES(2,'Blizzard Entertainment');
INSERT INTO Producent VALUES(3,'Rockstar Games');
INSERT INTO Producent VALUES(4,'Sony Computer Entertainment');
INSERT INTO Producent VALUES(5,'Konami');
INSERT INTO Producent VALUES(6,'Square Enix');
INSERT INTO Producent VALUES(7,'Gameloft');


INSERT INTO Wydawca VALUES(1,'Activision');
INSERT INTO Wydawca VALUES(2,'Square Enix');
INSERT INTO Wydawca VALUES(3,'Ubisoft');
INSERT INTO Wydawca VALUES(4,'Sony Computer Entertainment');
INSERT INTO Wydawca VALUES(5,'Konami');

INSERT INTO Gatunek VALUES(1,'RPG',NULL);
INSERT INTO Gatunek VALUES(2,'FPS',NULL);
INSERT INTO Gatunek VALUES(3,'Przygodowa',NULL);
INSERT INTO Gatunek VALUES(4,'Slasher',NULL);
INSERT INTO Gatunek VALUES(5,'Wyscigowka',NULL);

INSERT INTO Platforma VALUES(1,'Playstation 3');
INSERT INTO Platforma VALUES(2,'Xbox360');
INSERT INTO Platforma VALUES(3,'PC');
INSERT INTO Platforma VALUES(4,'PSP');
INSERT INTO Platforma VALUES(5,'Wii');

INSERT INTO Wysylka VALUES(1,'Poczta Polska','10');
INSERT INTO Wysylka VALUES(2,'Kurier DHL','15');
INSERT INTO Wysylka VALUES(3,'Odbior osobisty','0');
INSERT INTO Wysylka VALUES(4,'Paczkomat','2');
INSERT INTO Wysylka VALUES(5,'Kurier DHL Pobraniowa','25');

INSERT INTO Gry VALUES (1,2,6,'Final Fantasy XIII-2','2012-11-12','65');
INSERT INTO Gry VALUES (2,1,1,'Call of Duty: Moder Warfare 3','2011-10-09','78');
INSERT INTO Gry VALUES (3,5,5,'Metal Gear Solid: Peace Walker','2010-08-02','50');
INSERT INTO Gry VALUES (4,2,6,'Final Fantasy XIII','2010-01-24','40');
INSERT INTO Gry VALUES (5,3,7,'Assassins Creed III','2012-12-12','100');

INSERT INTO Wiele_Gatunkow VALUES (1,1);
INSERT INTO Wiele_Gatunkow VALUES (1,4);
INSERT INTO Wiele_Gatunkow VALUES (2,2);
INSERT INTO Wiele_Gatunkow VALUES (3,3);
INSERT INTO Wiele_Gatunkow VALUES (3,5);
INSERT INTO Wiele_Gatunkow VALUES (2,3);

INSERT INTO Wiele_Platform VALUES (1,1);
INSERT INTO Wiele_Platform VALUES (1,2);
INSERT INTO Wiele_Platform VALUES (2,1);
INSERT INTO Wiele_Platform VALUES (2,2);
INSERT INTO Wiele_Platform VALUES (2,3);
INSERT INTO Wiele_Platform VALUES (3,4);
INSERT INTO Wiele_Platform VALUES (4,1);
INSERT INTO Wiele_Platform VALUES (4,2);
INSERT INTO Wiele_Platform VALUES (5,1);
INSERT INTO Wiele_Platform VALUES (5,2);
INSERT INTO Wiele_Platform VALUES (5,3);

INSERT INTO Koszyk VALUES (1,1,1,2,'65','23','79.95','1');
INSERT INTO Koszyk VALUES (2,2,2,3,'78','23','95.94','1');
INSERT INTO Koszyk VALUES (3,3,5,1,'50','23','61.5','1');
INSERT INTO Koszyk VALUES (4,4,4,5,'325','23','406.25','3');
INSERT INTO Koszyk VALUES (5,5,3,4,'52','23','63.96','1');

INSERT INTO Pozycje VALUES (1,1);
INSERT INTO Pozycje VALUES (2,2);
INSERT INTO Pozycje VALUES (3,3);
INSERT INTO Pozycje VALUES (5,4);
INSERT INTO Pozycje VALUES (3,5);

--Wyświetla wszystkie gry i podaje jej gatunek
SELECT g.nazwa, ga.gatunek FROM Gry g 
INNER JOIN Wiele_Gatunkow wg ON g.idGry = wg.idGry INNER JOIN Gatunek ga ON wg.idGatunek = ga.idGatunek ORDER BY g.nazwa;

--Wyświetla nazwę, cene netto, platformę oraz producenta gier
SELECT g.nazwa, g.cena_netto, p.Nazwa AS "Platforma", pr.nazwa AS "Producent" FROM Gry g 
INNER JOIN Wiele_Platform wp ON g.idGry = wp.idGry INNER JOIN Platforma p ON p.idPlatforma = wp.idPlatforma INNER JOIN 
Producent pr ON g.idProducent = pr.idProducent ORDER BY g.nazwa;

--Wyświetla gry jakie zostały zakupione oraz ilość zakupionych
SELECT g.nazwa, COUNT(p.idGry) AS "Ilosc Kupionych" FROM Gry g INNER JOIN Pozycje p ON g.idGry = p.idGry GROUP BY g.nazwa;

--Wyśeitla imie, nazwisko i rodzaj wysyłki jaką wybrał dany klient
SELECT kl.imie, kl.nazwisko, w.rodzaj_wysylki FROM Wysylka w INNER JOIN Koszyk k ON w.idWysylka = k.idWysylka INNER JOIN
Klient kl ON k.idKlient = kl.idKlient;

--Wyświetla dane na temat klientów
SELECT k.imie, k.nazwisko, a.kod, a.miasto, a.nr_domu, a.ulica FROM Adres a INNER JOIN Klient k ON a.idAdres = k.idAdres ORDER BY k.nazwisko;

--1) widok 1
--Widok który pokazuje ilość kupionych gier, nie wliczając w to gier które nie zostały zakupione ani razu
--SELECT + CASE sprawdza czy dana gra posiada wysoką sprzedaż (np. >20)
--Dlaczego nietrywialne: jest to bardzo przydadny widok, gdyż warto wiedzieć jak sprzedaje sie dany produkt + automatyczna informacja na temat wysokiej sprzedaży.
CREATE VIEW ilosc_kupionych AS
SELECT g.nazwa, COUNT(p.idGry) AS "ilosc_kupionych" FROM Gry g INNER JOIN Pozycje p ON g.idGry = p.idGry GROUP BY g.nazwa HAVING COUNT(p.idGry)>0

SELECT CASE WHEN ilosc_kupionych >1 THEN 'TAK' ELSE 'NIE' END AS "Czy wysoka sprzedaż", *
FROM ilosc_kupionych;


--2) widok 2
--Widok który wyświetla WSZYSTKIE dane na temat gry, oraz wyświetla te gry których cena jest mniejsza bądź równa 100zł
--SELECT CASE który podaje wartość TAK gdy dana gra ma coś wspólnego z firmą 'Square Enix' (dla małej ilości rekordów nie ma to sensu, lecz gdyby była ich ogromna ilość...)
--Dlaczego nietrywialne: Każda szanujaca sie firma musi posiadac "raport" tego czego posiada. + CASE który może byc przydatny dla klienta (zyczy sobie gier jednego wydawcy)
CREATE VIEW dane_gier AS
SELECT g.nazwa, ga.gatunek, p.Nazwa AS "platforma", g.rok_wydania, g.cena_netto, pr.nazwa AS "producent", w.wydawca
FROM Gry g
INNER JOIN Wiele_Gatunkow wg ON g.idGry = wg.idGry
INNER JOIN Gatunek ga ON wg.idGatunek = ga.idGatunek
INNER JOIN Wiele_Platform wp ON wp.idGry = g.idGry
INNER JOIN Platforma p ON p.idPlatforma = wp.idPlatforma
INNER JOIN Wydawca w ON w.idWydawca = g.idWydawca
INNER JOIN Producent pr ON pr.idProducent = g.idProducent
GROUP BY g.nazwa, g.cena_netto, ga.gatunek, g.rok_wydania, p.Nazwa, pr.nazwa, w.wydawca
HAVING g.cena_netto<=100.00


SELECT CASE WHEN producent ='Square Enix' OR Wydawca ='Square Enix' THEN 'TAK' ELSE 'NIE' END
 AS "Czy Square-Enix ma coś wspólnego", *
FROM dane_gier;


--3) funkcja 1
--Funkcja aktywność klienta, która umożliwa nam sprawdzenie ilu transkacji dokonał dany klient (po numerze id)
--Dlaczego nietrywialne: Funkcja pokazuje nam jak aktywny jest dany klient. Pozwala nam to na sledzenie jego zakupow i w ten sposob mozna zdecydowac czy zasluguje na wiecej promocji.
CREATE FUNCTION aktywnosc_klienta(
id_klient INT)
RETURNS INTEGER AS $$
BEGIN
RETURN(
SELECT COUNT(*) FROM Klient k
INNER JOIN Koszyk ko ON k.idKlient=ko.idKlient
INNER JOIN Pozycje p ON p.idKoszyk=ko.idKoszyk
WHERE k.idKlient=id_klient);
END;
$$
LANGUAGE 'plpgsql'; 

SELECT aktywnosc_klienta(3) AS ile_transakcji;

--4) funkcja 2
--Funkcja która po wpisaniu daty od do wyświetli nam ile gier powstało w danym przedziale lat.
--Dlaczego nietrywialne: Moze zostac uzyte do formularza, danego klienta moze interesowac przedial lat w ktorym zostaly wyprodukowane gry i tym samym zdecydowac o kupnie.
CREATE FUNCTION ile_gierwroku (data_od DATE, date_do DATE) RETURNS INT AS $$
BEGIN
RETURN(SELECT COUNT(*) FROM Gry WHERE rok_wydania BETWEEN data_od AND date_do);
END;
$$
LANGUAGE 'plpgsql';

SELECT ile_gierwroku('2010-01-01','2013-01-01') AS wynik;


--5) funkcja 3
--Funkcja która wyświetli raport rządanej gry(po idGry). Wyświetli sprzedawce oraz kupującego daną grę.
--Dlaczego nietrywialne: Raport DANEJ GRY to bardzo przydana rzecz. Pozwala to na obserwowanie czy dany produkt dobrze sie sprzedaje i przy okazji zostana wyswietleni klienci oraz sprzedawcy.
CREATE FUNCTION raport_kupna(id_szuk_gry INT)
RETURNS TABLE
(Imie_klienta VARCHAR(50), Nazwisko_klienta VARCHAR(50), Imie_sprzedawcy VARCHAR(50), Nazwisko_sprzedawcy VARCHAR(50),
 Gry VARCHAR(30))
 AS $$
 BEGIN
 RETURN QUERY
SELECT k.imie, k.nazwisko, s.imie, s.nazwisko,
g.nazwa
FROM Klient k
JOIN Koszyk ko ON k.idKlient=ko.idKlient
JOIN Pozycje p ON p.idKoszyk=ko.idKoszyk
JOIN Sprzedawca s ON s.idSprzedawca=ko.idSprzedawca
JOIN Gry g ON g.idGry=p.idGry
WHERE g.idGry=id_szuk_gry;

END;
$$
LANGUAGE 'plpgsql';

SELECT * FROM raport_kupna(2);






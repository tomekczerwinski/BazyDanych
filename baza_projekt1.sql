CREATE TABLE Wydawca (
  idWydawca INT IDENTITY(1,1) PRIMARY KEY,
  wydawca VARCHAR(50)NOT NULL,
);

CREATE TABLE Platforma (
  idPlatforma INT IDENTITY(1,1) PRIMARY KEY,
  Nazwa VARCHAR(30) NOT NULL,
);

CREATE TABLE Producent (
  idProducent INT IDENTITY(1,1) PRIMARY KEY,
  nazwa VARCHAR(40) NOT NULL,
);

CREATE TABLE Gatunek (
  idGatunek INT IDENTITY(1,1) PRIMARY KEY,
  gatunek VARCHAR(20) NOT NULL,
  opis VARCHAR(255),
);

CREATE TABLE Adres (
  idAdres INT IDENTITY(1,1) PRIMARY KEY,
  ulica VARCHAR(40) NOT NULL,
  nr_domu VARCHAR(5) NOT NULL,
  kod VARCHAR(10) NOT NULL,
  miasto VARCHAR(20) NOT NULL,
);

CREATE TABLE Wysylka (
  idWysylka INT IDENTITY(1,1) PRIMARY KEY,
  rodzaj_wysylki VARCHAR(100) NOT NULL,
  cena_netto MONEY NOT NULL,
);

CREATE TABLE Klient (
  idKlient INT IDENTITY(1,1) PRIMARY KEY,
  idAdres INT CONSTRAINT idAdres_fk_k FOREIGN KEY(idAdres) REFERENCES Adres(idAdres) NOT NULL,
  imie VARCHAR(15) NOT NULL,
  nazwiko VARCHAR(30) NOT NULL,
  NIP CHAR(10) UNIQUE,
  PESEL CHAR(9) UNIQUE,
);

CREATE TABLE Sprzedawca (
  idSprzedawca INT IDENTITY(1,1) PRIMARY KEY,
  idAdres INT CONSTRAINT idAdres_fk_s FOREIGN KEY(idAdres) REFERENCES Adres(idAdres) NOT NULL,
  imie VARCHAR(15) NOT NULL,
  nazwisko VARCHAR(30) NOT NULL,
  NIP CHAR(10) UNIQUE,
);

CREATE TABLE Gry (
  idGry INT IDENTITY(1,1) PRIMARY KEY,
  idWydawca INT CONSTRAINT idWydawca_fk FOREIGN KEY(idWydawca) REFERENCES Wydawca(idWydawca) NOT NULL,
  idProducent INT CONSTRAINT idProducent_fk FOREIGN KEY(idProducent) REFERENCES Producent(idProducent) NOT NULL,
  nazwa VARCHAR(40) NOT NULL,
  rok_wydania DATE NOT NULL,
  cena_netto MONEY NOT NULL,
);

CREATE TABLE Koszyk (
  idKoszyk INT IDENTITY(1,1) PRIMARY KEY,
  idKlient INT CONSTRAINT idKlient_fk FOREIGN KEY(idKlient) REFERENCES Klient(idKlient) NOT NULL,
  idSprzedawca INT CONSTRAINT idSprzedawca_fk FOREIGN KEY(idSprzedawca) REFERENCES Sprzedawca(idSprzedawca) NOT NULL,
  idWysylka INT CONSTRAINT idWysylka_fk FOREIGN KEY(idWysylka) REFERENCES Wysylka(idWysylka) NOT NULL,
  cena_razem_netto MONEY NOT NULL,
  stawka_vat INT NOT NULL,
  cena_razem_brutto MONEY NOT NULL,
  ilosc_razem INT NOT NULL,
);

CREATE TABLE Wiele_Platform (
  idGry INT CONSTRAINT idGry_fk_wp FOREIGN KEY(idGry) REFERENCES Gry(idGry),
  idPlatforma INT CONSTRAINT idPlatforma_fk FOREIGN KEY(idPlatforma) REFERENCES Platforma(idPlatforma),
);

CREATE TABLE Wiele_Gatunkow (
  idGatunek INT CONSTRAINT igGatunek_fk FOREIGN KEY(idGatunek) REFERENCES Gatunek(idGatunek),
  idGry INT CONSTRAINT idGry_fk_wg FOREIGN KEY(idGry) REFERENCES Gry(idGry),
);

CREATE TABLE Pozycje (
  idGry INT CONSTRAINT idGry_fk_p FOREIGN KEY(idGry) REFERENCES Gry(idGry),
  idKoszyk INT CONSTRAINT idKoszyk_fk FOREIGN KEY(idKoszyk) REFERENCES Koszyk(idKoszyk),
);

INSERT INTO Adres VALUES ('Konopnicka','4E','23-980','Rzeszow');
INSERT INTO Adres VALUES ('Sikorskiego','6E','53-940','Poznan');
INSERT INTO Adres VALUES ('Batorego','9I','32-120','Bialystok');
INSERT INTO Adres VALUES ('Długa','5','43-111','Bydgoszcz');
INSERT INTO Adres VALUES ('Krotka','88','34-567','Swinoujscie');

INSERT INTO Klient VALUES (1,'Tomasz','Czerwinski','1234576423','98787879');
INSERT INTO Klient VALUES (1,'Rafal','Czerwinski','2345765323',NULL);
INSERT INTO Klient VALUES (1,'Pawel','Czerwinski',NULL,'985456356');
INSERT INTO Klient VALUES (2,'Zygmunt','Stary','1456735664','764321456');
INSERT INTO Klient VALUES (3,'Stefan','Batory','4444534565','666654564');

INSERT INTO Sprzedawca VALUES (3,'Zenek','Inny','4673976453');
INSERT INTO Sprzedawca VALUES (4,'Franek','Znany','3456543425');
INSERT INTO Sprzedawca VALUES (5,'Bronislawa','Panna','9999999876');
INSERT INTO Sprzedawca VALUES (1,'Anna','Czerwinska','2222343222');
INSERT INTO Sprzedawca VALUES (2,'Julia','Stara','2343231344');

INSERT INTO Producent VALUES('Activision');
INSERT INTO Producent VALUES('Blizzard Entertainment');
INSERT INTO Producent VALUES('Rockstar Games');
INSERT INTO Producent VALUES('Sony Computer Entertainment');
INSERT INTO Producent VALUES('Konami');
INSERT INTO Producent VALUES('Square Enix');
INSERT INTO Producent VALUES('Gameloft');

INSERT INTO Wydawca VALUES('Activision');
INSERT INTO Wydawca VALUES('Square Enix');
INSERT INTO Wydawca VALUES('Ubisoft');
INSERT INTO Wydawca VALUES('Sony Computer Entertainment');
INSERT INTO Wydawca VALUES('Konami');

INSERT INTO Gatunek VALUES('RPG',NULL);
INSERT INTO Gatunek VALUES('FPS',NULL);
INSERT INTO Gatunek VALUES('Przygodowa',NULL);
INSERT INTO Gatunek VALUES('Slasher',NULL);
INSERT INTO Gatunek VALUES('Wyscigowka',NULL);

INSERT INTO Platforma VALUES('Playstation 3');
INSERT INTO Platforma VALUES('Xbox360');
INSERT INTO Platforma VALUES('PC');
INSERT INTO Platforma VALUES('PSP');
INSERT INTO Platforma VALUES('Wii');

INSERT INTO Wysylka VALUES('Poczta Polska','10');
INSERT INTO Wysylka VALUES('Kurier DHL','15');
INSERT INTO Wysylka VALUES('Odbior osobisty','0');
INSERT INTO Wysylka VALUES('Paczkomat','2');
INSERT INTO Wysylka VALUES('Kurier DHL Pobraniowa','25');

INSERT INTO Gry VALUES (2,6,'Final Fantasy XIII-2','2012','65');
INSERT INTO Gry VALUES (1,1,'Call of Duty: Moder Warfare 3','2011','78');
INSERT INTO Gry VALUES (5,5,'Metal Gear Solid: Peace Walker','2010','50');
INSERT INTO Gry VALUES (2,6,'Final Fantasy XIII','2010','40');
INSERT INTO Gry VALUES (3,7,'Assassins Creed III','2012','100');

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

INSERT INTO Koszyk VALUES (1,1,2,'65','23','79.95','1');
INSERT INTO Koszyk VALUES (2,2,3,'78','23','95.94','1');
INSERT INTO Koszyk VALUES (3,5,1,'50','23','61.5','1');
INSERT INTO Koszyk VALUES (4,4,5,'325','23','406.25','3');
INSERT INTO Koszyk VALUES (5,3,4,'52','23','63.96','1');

INSERT INTO Pozycje VALUES (1,1);
INSERT INTO Pozycje VALUES (2,2);
INSERT INTO Pozycje VALUES (3,3);
INSERT INTO Pozycje VALUES (5,4);
INSERT INTO Pozycje VALUES (3,5);

SELECT g.nazwa, ga.gatunek FROM Gry g INNER JOIN Wiele_Gatunkow wg ON g.idGry = wg.idGry INNER JOIN Gatunek ga  ON wg.idGatunek = ga.idGatunek ORDER BY g.nazwa;
SELECT g.nazwa, g.cena_netto, p.Nazwa AS 'Platforma', pr.nazwa AS 'Producent' FROM Gry g INNER JOIN Wiele_Platform wp ON g.idGry = wp.idGry INNER JOIN Platforma p ON p.idPlatforma = wp.idPlatforma INNER JOIN Producent pr ON g.idProducent = pr.idProducent ORDER BY g.nazwa;
SELECT g.nazwa, COUNT(p.idGry) AS 'Ilosc Kupionych' FROM Gry g INNER JOIN Pozycje p ON g.idGry = p.idGry GROUP BY g.nazwa;
SELECT kl.imie, kl.nazwiko, w.rodzaj_wysylki FROM Wysylka w INNER JOIN Koszyk k ON w.idWysylka = k.idWysylka INNER JOIN Klient kl ON k.idKlient = kl.idKlient;
SELECT k.imie, k.nazwiko, a.kod, a.miasto, a.nr_domu, a.ulica FROM Adres a INNER JOIN Klient k ON a.idAdres = k.idAdres ORDER BY k.nazwiko;



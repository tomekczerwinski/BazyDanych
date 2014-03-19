drop table osoba;

create table osoba(
	id_osoba INT IDENTITY(1,1) PRIMARY KEY,
	imie VARCHAR(20) NOT NULL,
	nazwisko VARCHAR(40) NOT NULL,
	pesel CHAR(11) CONSTRAINT unik_pesel UNIQUE NOT NULL,
	data_ur DATE NOT NULL,
	pensja MONEY NOT NULL
);

CREATE FUNCTION sprPesel(
    @pesel nchar(11)
)
RETURNS bit
AS
BEGIN 
    IF ISNUMERIC(@pesel) = 0
        RETURN 0 
    DECLARE
        @wagi AS TABLE (
			pozycja tinyint IDENTITY(1,1) NOT NULL,
            Weight tinyint NOT NULL
        ) 
    INSERT INTO @wagi VALUES (1), (3), (7), (9), (1), (3), (7), (9), (1), (3), (1) 
    IF (SELECT SUM(CONVERT(TINYINT, SUBSTRING(@pesel, pozycja, 1)) * Weight) % 10 FROM @wagi ) = 0
        RETURN 1 
    RETURN 0 
END

ALTER TABLE osoba ADD CONSTRAINT checkPesel CHECK (dbo.sprPesel(PESEL) = 1);

GO

CREATE TRIGGER sprawdz_pesel ON osoba 
FOR INSERT,UPDATE
AS
BEGIN
	DECLARE @tmp CHAR(11)
	SELECT @tmp=pesel FROM inserted i
	IF(dbo.sprPesel(@tmp) = 0)
	BEGIN
		ROLLBACK
		RAISERROR('NIEPRAWIDLOWY PESEL!!!',1,2)	
	END		
END

GO



INSERT INTO osoba VALUES('beti','turczus',93052701388,'1996-02-27',6500);
INSERT INTO osoba VALUES('Beti2','Turczus2',93052701388,'1993-05-27',1111);
INSERT INTO osoba VALUES('beti3','Turczus3',92031815216,'1993-05-27',1110);

INSERT INTO osoba VALUES('beti4','Turczus4',02031815216,'1993-03-10',6500);

SELECT * FROM osoba;

DROP TRIGGER sprawdz_pesel


INSERT INTO osoba VALUES('beti5','turczus5',92111400990,'1996-03-11',6500);


CREATE TRIGGER m_d ON osoba
AFTER INSERT,UPDATE
AS
BEGIN
DECLARE @imie VARCHAR(20)
DECLARE @nazwisko VARCHAR(40)
DECLARE @id INT

SELECT @imie=UPPER(LEFT(imie,1))+LOWER(RIGHT(imie,LEN(imie)-1)) FROM inserted i;
SELECT @nazwisko=UPPER(LEFT(nazwisko,1))+LOWER(RIGHT(nazwisko,LEN(nazwisko)-1)) FROM inserted i;
SELECT @id=id_osoba FROM inserted

UPDATE osoba SET imie=@imie, nazwisko=@nazwisko WHERE id_osoba=@id
END



CREATE TRIGGER pelnoletnosc ON osoba
AFTER INSERT,UPDATE
AS
BEGIN
DECLARE @wiek DATE
DECLARE @dzis DATE

SELECT @dzis=GETDATE()
SELECT @wiek=data_ur FROM inserted i

IF((year(@dzis)-YEAR(@wiek)<=18) AND (MONTH(@dzis)-MONTH(@wiek)<=0) AND (DAY(@dzis)-DAY(@wiek)<0))
BEGIN
	ROLLBACK
	RAISERROR('TY KUTASIARZU',1,2)
	END
END




DROP TRIGGER m_d


CREATE TRIGGER pensja ON osoba
AFTER INSERT,UPDATE
AS
BEGIN

DECLARE @pen MONEY

SELECT @pen=pensja FROM inserted i

IF(@pen<1111)
BEGIN
	ROLLBACK
	RAISERROR('TY BIEDAKU ALE ZAL',1,2)
	END
END

create table osoba_hist(
	id_hist INT IDENTITY(1,1) PRIMARY KEY,
	id_osoba INT,
	imie VARCHAR(20) NOT NULL,
	nazwisko VARCHAR(40) NOT NULL,
	pesel CHAR(11) NOT NULL,
	data_ur DATE NOT NULL,
	pensja MONEY NOT NULL,
	operacja CHAR(1) NOT NULL,
	data_oper DATE,
);

CREATE TRIGGER modified_D ON osoba
AFTER DELETE
AS
BEGIN
DECLARE @data DATE
DECLARE @id INT, @imie VARCHAR(20), @nazwisko VARCHAR(40), @pesel CHAR(11), @data_ur DATE, @pensja MONEY
SELECT @data=GETDATE()
SELECT @id=id_osoba, @imie=imie, @nazwisko=nazwisko, @pesel=pesel, @data_ur=data_ur, @pensja=pensja FROM deleted
INSERT INTO osoba_hist VALUES(@id, @imie, @nazwisko, @pesel, @data_ur, @pensja, 'D', @data)
END

CREATE TRIGGER modified_U ON osoba
AFTER UPDATE
AS
BEGIN
DECLARE @data DATE
DECLARE @id INT, @imie VARCHAR(20), @nazwisko VARCHAR(40), @pesel CHAR(11), @data_ur DATE, @pensja MONEY
SELECT @data=GETDATE()
SELECT @id=id_osoba, @imie=imie, @nazwisko=nazwisko, @pesel=pesel, @data_ur=data_ur, @pensja=pensja FROM deleted
INSERT INTO osoba_hist VALUES(@id, @imie, @nazwisko, @pesel, @data_ur, @pensja, 'U', @data)
END

drop table osoba_hist

SELECT * FROM osoba

DELETE FROM osoba WHERE id_osoba=2

select * from osoba_hist

UPDATE osoba SET pensja=3800

DELETE FROM osoba WHERE id_osoba=7



CREATE TABLE klient(
	id_klient INT IDENTITY (1,1) PRIMARY KEY,
	imie VARCHAR(20) NOT NULL,
	nazwisko VARCHAR(40) NOT NULL,
	)
	
CREATE TABLE towar(
	id_towar INT IDENTITY (1,1) PRIMARY KEY,
	nazwa VARCHAR(20) NOT NULL,
	opis VARCHAR(40) NOT NULL,
	il_sztuk INT NOT NULL,
	cena_netto MONEY NOT NULL,
	podatek INT,
	)
	
CREATE TABLE zakup(
	id_zakup INT IDENTITY (1,1) PRIMARY KEY,
	id_klient INT CONSTRAINT id_klientFK Foreign key(id_klient) REFERENCES klient(id_klient) NOT NULL,
	data_zakupu DATE
	)
	
CREATE TABLE koszyk(
	id_zakup INT CONSTRAINT id_zakupFK FOREIGN KEY(id_zakup) REFERENCES zakup(id_zakup),
	id_towar INT CONSTRAINT id_towarFK FOREIGN KEY(id_towar) REFERENCES towar(id_towar),
	ilosc INT,
	cena_netto MONEY,
	podatek MONEY,
	)		
	
	
INSERT INTO klient VALUES ('Tomasz','Czerwinski')

INSERT INTO towar VALUES ('Klocki','Fajne Klocki','3','255','5')

INSERT INTO towar VALUES ('LAptop','Fajne sprzety','99','1000','1')

INSERT INTO zakup VALUES ('1','2014-03-12')
INSERT INTO zakup VALUES ('1','2014-03-12')

INSERT INTO koszyk VALUES ('2','2','5','1000','1')

CREATE TRIGGER sprzedaz ON koszyk
FOR INSERT
AS
BEGIN
DECLARE @ilosc INT
DECLARE @il_szt INT
SELECT @ilosc=ilosc FROM INSERTED
SELECT @il_szt=il_sztuk FROM towar
IF(@ilosc>@il_szt)
ROLLBACK
RAISERROR('TY KUTASIARZU!',1,1)
END

CREATE TRIGGER aktualizacja_ilosci ON koszyk
AFTER INSERT
AS
BEGIN
DECLARE @ilosc INT
DECLARE @il_szt INT
DECLARE @koniec INT
SELECT @ilosc=ilosc FROM INSERTED
SELECT @il_szt=il_sztuk FROM towar

SELECT @koniec=@il_szt-@ilosc
IF(@ilosc>@il_szt)
BEGIN
ROLLBACK
RAISERROR('TY KUTASIARZU!',1,1)
END
ELSE BEGIN
UPDATE towar SET il_sztuk=@koniec
END
END

drop trigger aktualizacja_ilosci

SELECT * FROM towar


CREATE VIEW klient_statystyki AS
SELECT k.*, COUNT(z.id_klient) AS "ilosc_zakupow", SUM((ko.cena_netto*ko.podatek)+ko.cena_netto) AS
"ilosc_wyd_kasy" FROM klient k INNER JOIN zakup z ON k.id_klient=z.id_klient 
INNER JOIN koszyk ko ON z.id_zakup=ko.id_zakup
GROUP BY k.id_klient, k.imie, k.nazwisko

SELECT * FROM klient_statystyki

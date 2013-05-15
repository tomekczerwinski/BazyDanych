--dr Robert Fidytek 19.02.2013
--Baza danych wypożyczalni samochodów
--PostgreSQL 9.2

--W celach dydaktycznych ze struktury bazy danych usunięto klucze obce,
--ograniczenia na kolumny i tabele.


--Usuwamy tabele o ile istnieja
DROP TABLE IF EXISTS wypozyczenie;
DROP TABLE IF EXISTS klient;
DROP TABLE IF EXISTS pracownik;
DROP TABLE IF EXISTS samochod;
DROP TABLE IF EXISTS miejsce;


--Tworzymy tabele i dodajemy przykladowe rekordy
CREATE TABLE pracownik (
  id_pracownik  INT         PRIMARY KEY,
  imie          VARCHAR(15) NOT NULL,
  nazwisko      VARCHAR(20) NOT NULL,
  data_zatr     DATE        NOT NULL,
  dzial         VARCHAR(20) NOT NULL,
  stanowisko    VARCHAR(20) NOT NULL,
  pensja        DECIMAL(8,2),
  dodatek       DECIMAL(8,2),
  id_miejsce    INT         NOT NULL,
  telefon       VARCHAR(16)
);


INSERT INTO pracownik
VALUES (1, 'JAN', 'KOWALSKI', '1997-02-01', 'OBSLUGA KLIENTA', 'SPRZEDAWCA', 1100, 123, 1, '987-231-123');

INSERT INTO pracownik
VALUES (2, 'ANNA', 'KAMINSKA', '1997-01-01', 'OBSLUGA KLIENTA', 'SPRZEDAWCA', 1200, 115, 2, '987-231-124');

INSERT INTO pracownik
VALUES (3, 'KRZYSZTOF', 'ADAMSKI', '1997-05-01', 'OBSLUGA KLIENTA', 'KIEROWNIK', 2000, NULL, 3, '987-231-125');

INSERT INTO pracownik
VALUES (4, 'PIOTR', 'MICHALSKI', '1998-06-01', 'TECHNICZNY', 'MECHANIK', 1700, 76, 1, '987-231-131');

INSERT INTO pracownik
VALUES (5, 'BOZENA', 'DOMANSKA', '1997-02-01', 'OBSLUGA KLIENTA', 'SPRZEDAWCA', 1300, 134, 3, '987-231-126');

INSERT INTO pracownik
VALUES (6, 'WOJCIECH', 'BURZALSKI', '1998-12-01', 'TECHNICZNY', 'MECHANIK', 1800, 80, 3, '987-231-132');

INSERT INTO pracownik
VALUES (7, 'MARZENA', 'KOWNACKA', '1997-05-01', 'KSIEWOSC', 'KASJER', 1400, 105, 1, '987-231-141');

INSERT INTO pracownik
VALUES (8, 'DAMIAN', 'MACHALICA', '1997-05-01', 'TECHNICZNY', 'KIEROWNIK', 2200, NULL, 1, '987-231-133');

INSERT INTO pracownik
VALUES (9, 'ALICJA', 'MAKOWIECKA', '1999-07-01', 'OBSLUGA KLIENTA', 'SPRZEDAWCA', 1400, 120, 4, '933-241-525');

INSERT INTO pracownik
VALUES (10, 'WOJCIECH', 'BAGIELSKI', '1998-04-01', 'OBSLUGA KLIENTA', 'SPRZEDAWCA', 1200, 100, 1, '457-531-143');

INSERT INTO pracownik
VALUES (11, 'JAN', 'BAGIELSKI', '1999-04-01', 'TECHNICZNY', 'SPRZEDAWCA', 1200, 100, 1, '457-531-144');



CREATE TABLE klient (
  id_klient       INT         PRIMARY KEY,
  imie            VARCHAR(15) NOT NULL,
  nazwisko        VARCHAR(20) NOT NULL,
  nr_karty_kredyt CHAR(20),
  firma           VARCHAR(40),
  ulica           VARCHAR(24) NOT NULL,
  numer           VARCHAR(8)  NOT NULL,
  miasto          VARCHAR(24) NOT NULL,
  kod             CHAR(6)     NOT NULL,
  nip             CHAR(11),
  telefon         VARCHAR(16)
);


INSERT INTO klient
VALUES (1, 'JAN', 'KOWALSKI', NULL, NULL, 'KOCHANOWSKIE', '3', 'WROCLAW', '37-300', NULL, '167-763-234');

INSERT INTO klient
VALUES (2, 'TOMASZ', 'ADAMCZAK' , 'HH 12345678', 'KOWALSKI S.C.', 'KWIATOWA', '4/9', 'WARSZAWA', '01-900', '543-123-456', '46-744-431');

INSERT INTO klient
VALUES (3, 'PIOTR', 'MALCZYK' , 'HF 12445661', 'ADA S.C.', 'ROZANA', '9', 'WARSZAWA', '01-900', '443-133-251', '16-742-114');

INSERT INTO klient
VALUES (4, 'PAWEL', 'FIODOROWICZ' , 'DD 76545321', 'KRAWIECTWO', 'ARMII KRAJOWEJ', '22A', 'WARSZAWA', '01-200', '555-233-256', '44-342-116');

INSERT INTO klient
VALUES (5, 'ANIELA', 'DALGIEWICZ' ,NULL , 'MODNA PANI', 'BOHATEROW GETTA', '24', 'WROCLAW', '37-200', '456-134-153', '144-188-415');

INSERT INTO klient
VALUES (6, 'JOANNA', 'KWIATKOWSKA', NULL, NULL, 'TUWIMA', '2/5', 'SWIDNICA', '58-100', NULL, '963-733-231');

INSERT INTO klient
VALUES (7, 'BOZENA', 'MALINOWSKA', NULL, NULL, 'LELEWELA', '34/1', 'SWIDNICA', '58-100', NULL, '965-553-778');

INSERT INTO klient
VALUES (8, 'TOMASZ', 'NOWAK', NULL, NULL, 'ZEROMSKIE', '5A/8', 'SWIDNICA', '58-100', NULL, '911-135-536');

INSERT INTO klient
VALUES (9, 'KRZYSZTOF', 'DOMAGALA', NULL, NULL, 'LESNA', '5', 'SWIDNICA', '58-100', NULL, '922-233-232');

INSERT INTO klient
VALUES (10, 'ARKADIUSZ', 'DOCZEKALSKI', NULL, NULL, 'LESNA', '2', 'SWIDNICA', '58-100', NULL, '922-233-267');

INSERT INTO klient
VALUES (11, 'ANNA', 'KOWALSKA' ,'KJ 98765412' , 'MODNIARSTWO', 'POWSTANCOW SLASKICH', '4', 'WROCLAW', '37-200', '422-132-354', '444-283-901');

INSERT INTO klient
VALUES (12, 'KRZYSZTOF', 'DOBROWOLSKI' , NULL, 'KAMIENIARSTWO', 'STRZEMSKA', '124', 'WROCLAW', '37-400', '433-133-332', '443-285-202');

INSERT INTO klient
VALUES (13, 'MARCIN', 'KRZYKALA' , NULL, NULL, 'KONOPNICKIEJ', '1/4', 'WROCLAW', '37-400', NULL, '442-211-109');

INSERT INTO klient
VALUES (14, 'ANETA', 'PAPROCKA' , NULL, NULL, 'TUWIMA', '2', 'WROCLAW', '37-400', NULL, '442-671-899');

INSERT INTO klient
VALUES (15, 'SEBASTIAN', 'KOWNACKI' , NULL, NULL, 'GLOWACKIE', '2/9', 'WROCLAW', '37-400', NULL, '423-681-129');

INSERT INTO klient
VALUES (16, 'MICHAL', 'MICHALSKI' , NULL, NULL, 'KWIATOWA', '9/3', 'WROCLAW', '37-500', NULL, '499-621-921');

INSERT INTO klient
VALUES (17, 'MICHAL', 'SZYKOWNY' , 'WW 12398765', NULL, 'LESNA', '3', 'WARSZAWA', '00-100', NULL, '191-221-622');

INSERT INTO klient
VALUES (18, 'MARCIN', 'MARCINKOWSKI' , 'WQ 14368781', NULL, 'OKREZNA', '33', 'WARSZAWA', '00-200', NULL, '122-127-647');

INSERT INTO klient
VALUES (19, 'RAFAL', 'RAFALSKI' , 'WS 12358672', 'NAPRAWA SAMOCHODOW', 'PRZEMYSLOWA', '1', 'WARSZAWA', '00-200', '999-765-120', '822-324-742');

INSERT INTO klient
VALUES (20, 'ROBERT', 'NOWAK' , 'AS 61333699', 'TAPICERSTWO', 'MOSTOWA', '9B', 'WARSZAWA', '00-100', '987-765-333', '811-311-147');



CREATE TABLE samochod (
  id_samochod  INT         PRIMARY KEY,
  marka        VARCHAR(20) NOT NULL,
  typ          VARCHAR(16) NOT NULL,
  data_prod    DATE        NOT NULL,
  kolor        VARCHAR(16) NOT NULL,
  poj_silnika  SMALLINT    NOT NULL,
  przebieg     INTEGER     NOT NULL
);


INSERT INTO samochod
VALUES (1, 'MERCEDES', '190D', '1999-01-01', 'BIALY', 1800, 23000);

INSERT INTO samochod
VALUES (2, 'MERCEDES', '230D', '1999-01-01', 'NIEBIESKI', 2000, 35000);

INSERT INTO samochod
VALUES (3, 'FIAT', 'SEICENTO', '2000-01-01', 'CZERWONY', 1100, 13000);

INSERT INTO samochod
VALUES (4, 'FIAT', 'SEICENTO', '1999-01-01', 'BIALY', 900, 10000);

INSERT INTO samochod
VALUES (5, 'FIAT', 'TIPO', '1998-01-01', 'BORDOWY', 1400, 43000);

INSERT INTO samochod
VALUES (6, 'POLONEZ', 'CARO', '1997-01-01', 'ZIELONY', 1600, 55000);

INSERT INTO samochod
VALUES (7, 'OPEL', 'CORSA', '2000-01-01', 'ZIELONY', 1100, 11000);

INSERT INTO samochod
VALUES (8, 'OPEL', 'VECTRA', '1999-01-01', 'SZARY', 1800, 36000);

INSERT INTO samochod
VALUES (9, 'MERCEDES', '190D', '1996-01-01', 'BRAZOWY', 1800, 69000);

INSERT INTO samochod
VALUES (10, 'FORD', 'ESCORT', '2000-01-01', 'NIEBIESKI', 1600, 8000);

INSERT INTO samochod
VALUES (11, 'FORD', 'ESCORT', '1999-01-01', 'BIALY', 1600, 23000);

INSERT INTO samochod
VALUES (12, 'FORD', 'KA', '1998-01-01', 'BORDOWY', 1100, 54000);

INSERT INTO samochod
VALUES (13, 'FIAT', 'SEICENTO', '1999-01-01', 'ZLOTY', 1100, 25000);

INSERT INTO samochod
VALUES (14, 'FIAT', 'SEICENTO', '2000-01-01', 'BIALY', 1100, 18000);

INSERT INTO samochod
VALUES (15, 'SEAT', 'IBIZA', '1998-01-01', 'ZOLTY', 1800, 63000);

INSERT INTO samochod
VALUES (16, 'FORD', 'SIERRA', '1995-01-01', 'CZERWONY', 1600, 87000);

INSERT INTO samochod
VALUES (17, 'OPEL', 'CORSA', '2000-01-01', 'ZIELONY', 1400, 9000);

INSERT INTO samochod
VALUES (18, 'FORD', 'KA', '1999-01-01', 'ZOLTY', 1400, 20000);



CREATE TABLE miejsce (
  id_miejsce INT         PRIMARY KEY,
  ulica      VARCHAR(24) NOT NULL,
  numer      VARCHAR(8)  NOT NULL,
  miasto     VARCHAR(24) NOT NULL,
  kod        CHAR(6)     NOT NULL,
  telefon    VARCHAR(16),
  uwagi      VARCHAR(40)
);


INSERT INTO miejsce
VALUES (1, 'LEWARTOWSKIE', '12', 'WARSZAWA', '10-100', '228-277-097', NULL);

INSERT INTO miejsce
VALUES (2, 'ALEJE LIPOWE', '3', 'WROCLAW', '32-134', '388-299-086', NULL);

INSERT INTO miejsce
VALUES (3, 'KOCHANOWSKIE', '8', 'KRAKOW', '91-200', '222-312-498', NULL);

INSERT INTO miejsce
VALUES (4, 'LOTNICZA', '9', 'POZNAN', '22-200', '778-512-044', NULL);



CREATE TABLE wypozyczenie (
  id_wypozyczenie INT          PRIMARY KEY,
  id_klient       INT          NOT NULL,
  id_samochod     INT          NOT NULL,
  id_pracow_wyp   INT          NOT NULL,
  id_pracow_odd   INT,
  id_miejsca_wyp  INT          NOT NULL,
  id_miejsca_odd  INT,
  data_wyp        DATE         NOT NULL,
  data_odd        DATE,
  kaucja          DECIMAL(8,2),
  cena_jedn       DECIMAL(8,2) NOT NULL
);


INSERT INTO wypozyczenie
VALUES (1, 1, 3, 2, 2, 1, 1, '1998-09-18', '1998-09-23', 200, 50);

INSERT INTO wypozyczenie
VALUES (2, 3, 4, 1, 1, 1, 1, '1998-09-26', '1998-09-27', NULL, 50);

INSERT INTO wypozyczenie
VALUES (3, 3, 4, 9, 9, 2, 2, '1998-10-04', '1998-10-04', NULL, 50);

INSERT INTO wypozyczenie
VALUES (4, 4, 3, 10, 10, 3, 3, '1998-10-19', '1998-10-25', NULL, 50);

INSERT INTO wypozyczenie
VALUES (5, 6, 7, 10, 10, 3, 3, '1998-10-29', '1998-11-02', 200, 50);

INSERT INTO wypozyczenie
VALUES (6, 5, 8, 10, 2, 1, 3, '1998-11-07', '1998-11-09', 200, 50);

INSERT INTO wypozyczenie
VALUES (7, 8, 11, 9, 2, 1, 1, '1998-11-20', '1998-11-25', 200, 50);

INSERT INTO wypozyczenie
VALUES (8, 6, 11, 1, 5, 4, 4, '1998-11-28', '1998-12-02', 200, 100);

INSERT INTO wypozyczenie
VALUES (9, 7, 17, 2, 2, 1, 2, '1998-12-01', '1998-12-03', 200, 100);

INSERT INTO wypozyczenie
VALUES (10, 9, 17, 2, 10, 1, 2, '1998-12-15', '1998-12-17', 200, 100);

INSERT INTO wypozyczenie
VALUES (11, 10, 1, 5, 5, 3, 3, '1998-12-20', '1998-12-23', 200, 100);

INSERT INTO wypozyczenie
VALUES (12, 12, 2, 5, 5, 4, 4, '1999-01-04', '1999-01-14', 200, 100);

INSERT INTO wypozyczenie
VALUES (13, 11, 5, 1, 5, 3, 1, '1999-01-24', '1999-01-29', NULL, 100);

INSERT INTO wypozyczenie
VALUES (14, 13, 5, 1, 1, 4, 1, '1999-02-01', '1999-02-05', 200, 100);

INSERT INTO wypozyczenie
VALUES (15, 14, 4, 1, 1, 2, 2, '1999-02-04', '1999-02-04', 200, 100);

INSERT INTO wypozyczenie
VALUES (16, 15, 18, 9, 9, 2, 2, '1999-03-20', '1999-03-23', 200, 100);

INSERT INTO wypozyczenie
VALUES (17, 16, 13, 10, 10, 4, 1, '1999-03-20', '1999-03-22', 200, 100);

INSERT INTO wypozyczenie
VALUES (18, 20, 14, 1, 1, 1, 1, '1999-04-01', '1999-04-05',  NULL, 100);

INSERT INTO wypozyczenie
VALUES (19, 19, 15, 5, 5, 4, 4, '1999-05-04', '1999-05-09', NULL, 100);

INSERT INTO wypozyczenie
VALUES (20, 17, 17, 2, 2, 3, 1, '1999-08-14', '1999-08-17', NULL, 100);

INSERT INTO wypozyczenie
VALUES (21, 18, 9, 2, NULL, 1,  NULL, '1999-12-04',  NULL, NULL, 100);

INSERT INTO wypozyczenie
VALUES (22, 17, 1, 1, NULL, 2,  NULL, '1999-12-22',  NULL, NULL, 100);

INSERT INTO wypozyczenie
VALUES (23, 9, 3, 10, NULL, 2,  NULL, '2000-01-08',  NULL, 200, 100);

INSERT INTO wypozyczenie
VALUES (24, 14, 4, 5, NULL, 1,  NULL, '2000-01-24',  NULL, 200, 100);

INSERT INTO wypozyczenie
VALUES (25, 10, 5, 9, NULL, 2,  NULL, '2000-02-09',  NULL, 200, 100);


--wyświetlenie zawartości tabel
SELECT * FROM pracownik;
SELECT * FROM klient;
SELECT * FROM samochod;
SELECT * FROM miejsce;
SELECT * FROM wypozyczenie;

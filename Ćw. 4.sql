CREATE DATABASE firma;
USE firma;
CREATE SCHEMA rozliczenia;


--Tworzenie tabel

CREATE TABLE rozliczenia.pracownicy (
    id_pracownika INT PRIMARY KEY NOT NULL,
    imie VARCHAR(25) NOT NULL,
    nazwisko VARCHAR(25) NOT NULL,
    adres VARCHAR(80) NOT NULL,
    telefon VARCHAR(12)
);

CREATE TABLE rozliczenia.godziny (
    id_godziny INT PRIMARY KEY NOT NULL,
    data DATE,
    liczba_godzin INT,
    id_pracownika INT NOT NULL
);

CREATE TABLE rozliczenia.pensje (
    id_pensji INT PRIMARY KEY NOT NULL,
    stanowisko VARCHAR(50),
    kwota INT NOT NULL,
    id_premii INT
);

CREATE TABLE rozliczenia.premie (
    id_premii INT PRIMARY KEY NOT NULL,
    rodzaj VARCHAR(50),
    kwota INT NOT NULL
);


-- ustawienie kluczy obcych

ALTER TABLE rozliczenia.godziny ADD FOREIGN key (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);
ALTER TABLE rozliczenia.pensje ADD FOREIGN key (id_premii) REFERENCES rozliczenia.premie(id_premii);


--wypełnianie tabel

INSERT INTO rozliczenia.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES
(1, 'Katarzyna', 'Nowak', 'Długa 25, Gdańsk', '584563211'),
(2, 'Piotr', 'Kowalski', 'Słoneczna 7, Kraków', '123456789'),
(3, 'Anna', 'Wiśniewska', 'Morska 14, Szczecin', '912345678'),
(4, 'Grzegorz', 'Dąbrowski', 'Topolowa 3, Łódź', '429876543'),
(5, 'Alicja', 'Wójcik', 'Rynek 11, Katowice', '326549876'),
(6, 'Marek', 'Lewandowski', 'Kwiatowa 8, Lublin', '815432976'),
(7, 'Karolina', 'Kamińska', 'Polna 2, Rzeszów', '178904321'),
(8, 'Tadeusz', 'Zieliński', 'Sosnowa 6, Białystok', '853216743'),
(9, 'Monika', 'Szymańska', 'Brzozowa 4, Zielona Góra', '682109876'),
(10, 'Paweł', 'Woźniak', 'Świerkowa 12, Gdynia', '581234567');

INSERT INTO rozliczenia.godziny (id_godziny, data, liczba_godzin, id_pracownika)
VALUES
(1, '2024-02-07', 145, 1),
(2, '2024-02-14', 168, 2),
(3, '2024-02-19', 172, 3),
(4, '2024-03-26', 172, 4),
(5, '2024-03-28', 129, 5),
(6, '2024-03-30', 119, 6),
(7, '2024-04-01', 151, 7),
(8, '2024-04-02', 160, 8),
(9, '2024-04-06', 158, 9),
(10, '2024-04-10', 182, 10);

INSERT INTO rozliczenia.premie (id_premii, rodzaj, kwota)
VALUES
(1, 'staż pracy 5 lat', 1000),
(2, 'staż pracy 10 lat', 2500),
(3, 'motywacyjna', 200),
(4, 'motywacyjna', 400),
(5, 'motywacyjna', 600),
(6, 'motywacyjna', 800),
(7, 'uznaniowa', 100),
(8, 'uznaniowa', 250),
(9, 'zespołowa', 500),
(10, 'zespołowa', 700);

INSERT INTO rozliczenia.pensje (id_pensji, stanowisko, kwota, id_premii)
VALUES
(1, 'IT Project Manager', 18000, 7),
(2, 'Systems Administrator', 15100, 10),
(3, 'Database Administrator', 14000, 4),
(4, 'Network Engineer', 12600, 5),
(5, 'Cybersecurity Analyst', 7700, 8),
(6, 'Senior Software Developer', 19800, 2),
(7, 'Mid Software Developer', 15500, 9),
(8, 'Junior Software Developer', 11800, 6),
(9, 'Technical Support Specialist', 6700, 3),
(10, 'Accountant', 8500, 1);


--Za pomocą zapytania SQL wyświetl nazwiska pracowników i ich adresy

SELECT nazwisko, adres FROM rozliczenia.pracownicy;


--Napisz zapytanie, które przekonwertuje datę w tabeli godziny tak, aby wyświetlana była informacja jaki to dzień tygodnia i jaki miesiąc (funkcja DATEPART x2).

SELECT datepart(weekday, data) AS dzien, datepart(Month, data) AS miesiąc FROM rozliczenia.godziny;


--W tabeli pensje zmień nazwę atrybutu kwota na kwota_brutto oraz dodaj nowy o nazwie kwota_netto. Oblicz kwotę netto i zaktualizuj wartości w tabeli.

EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';
ALTER TABLE rozliczenia.pensje ADD kwota_netto INT;
UPDATE rozliczenia.pensje SET kwota_netto = kwota_brutto*0.77;



USE firma;
CREATE SCHEMA księgowosc;


--Tworzenie tabel

CREATE TABLE księgowosc.pracownicy (
    id_pracownika INT PRIMARY KEY NOT NULL,
    imie VARCHAR(25) NOT NULL,
    nazwisko VARCHAR(25) NOT NULL,
    adres VARCHAR(80) NOT NULL,
    telefon VARCHAR(12)
);

CREATE TABLE księgowosc.godziny (
    id_godziny INT PRIMARY KEY NOT NULL,
    data DATE,
    liczba_godzin INT,
    id_pracownika INT NOT NULL
);

CREATE TABLE księgowosc.pensja (
    id_pensji INT PRIMARY KEY NOT NULL,
    stanowisko VARCHAR(50),
    kwota INT NOT NULL,
);

CREATE TABLE księgowosc.premia (
    id_premii INT PRIMARY KEY NOT NULL,
    rodzaj VARCHAR(50),
    kwota INT NOT NULL
);

CREATE TABLE księgowosc.wynagrodzenia (
    id_wynagrodzenia INT PRIMARY KEY NOT NULL,
    data DATE,
    id_pracownika INT NOT NULL,
    id_godziny INT NOT NULL,
    id_pensji INT NOT NULL,
    id_premii INT NOT NULL
);

-- ustawienie kluczy obcych

ALTER TABLE księgowosc.godziny ADD FOREIGN key (id_pracownika) REFERENCES księgowosc.pracownicy(id_pracownika);
ALTER TABLE księgowosc.wynagrodzenia ADD FOREIGN key (id_pracownika) REFERENCES księgowosc.pracownicy(id_pracownika);
ALTER TABLE księgowosc.wynagrodzenia ADD FOREIGN key (id_godziny) REFERENCES księgowosc.godziny(id_godziny);
ALTER TABLE księgowosc.wynagrodzenia ADD FOREIGN key (id_premii) REFERENCES księgowosc.premia(id_premii);
ALTER TABLE księgowosc.wynagrodzenia ADD FOREIGN key (id_pensji) REFERENCES księgowosc.pensja(id_pensji);

--wypełnianie tabel

INSERT INTO księgowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
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

INSERT INTO księgowosc.godziny (id_godziny, data, liczba_godzin, id_pracownika)
VALUES
(1, '2024-02-07', 145, 1),
(2, '2024-02-14', 168, 2),
(3, '2024-02-19', 189, 3),
(4, '2024-03-26', 172, 4),
(5, '2024-03-28', 129, 5),
(6, '2024-03-30', 119, 6),
(7, '2024-04-01', 151, 7),
(8, '2024-04-02', 160, 8),
(9, '2024-04-06', 158, 9),
(10, '2024-04-10', 182, 10);

INSERT INTO księgowosc.premia (id_premii, rodzaj, kwota)
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

INSERT INTO księgowosc.pensja (id_pensji, stanowisko, kwota)
VALUES
(1, 'IT Project Manager', 18000),
(2, 'Systems Administrator', 15100),
(3, 'Database Administrator', 14000),
(4, 'Network Engineer', 12600),
(5, 'Cybersecurity Analyst', 7700),
(6, 'Senior Software Developer', 19800),
(7, 'Mid Software Developer', 15500),
(8, 'Junior Software Developer', 11800),
(9, 'Technical Support Specialist', 6700),
(10, 'Accountant', 8500);

INSERT INTO księgowosc.wynagrodzenia (id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii)
VALUES
(1, '2024-04-01', 1, 1, 1, 1),
(2, '2024-04-02', 2, 2, 2, 2),
(3, '2024-04-03', 3, 3, 3, 3),
(4, '2024-04-04', 4, 4, 4, 4),
(5, '2024-04-05', 5, 5, 5, 5),
(6, '2024-04-06', 6, 6, 6, 6),
(7, '2024-04-07', 7, 7, 7, 7),
(8, '2024-04-08', 8, 8, 8, 8),
(9, '2024-04-09', 9, 9, 9, 9),
(10, '2024-04-10', 10, 10, 10, 10);

---komentarze do tabel

EXEC sys.sp_addextendedproperty 
    @name = N'Pracownicy', 
    @value = N'Tabela z danymi pracowników';
   
EXEC sys.sp_addextendedproperty 
    @name = N'Godziny', 
    @value = N'Tabela z terminami wypłacenia wynagrodzenia';

EXEC sys.sp_addextendedproperty 
    @name = N'Pensja', 
    @value = N'Tabela z pensjami';

EXEC sys.sp_addextendedproperty 
    @name = N'Premia', 
    @value = N'Tabela z premią';

EXEC sys.sp_addextendedproperty 
    @name = N'Wynagrodzenie', 
    @value = N'Tabela z wynagrodzeniem';

-- a)

SELECT id_pracownika, nazwisko FROM księgowosc.pracownicy;

---b)

SELECT wynagrodzenia.id_pracownika,księgowosc.pensja.kwota 
FROM księgowosc.wynagrodzenia
INNER JOIN księgowosc.pensja 
ON księgowosc.wynagrodzenia.id_pensji=księgowosc.pensja.id_pensji
WHERE pensja.kwota > 1000;

---c)

SELECT wynagrodzenia.id_pracownika
FROM księgowosc.wynagrodzenia
INNER JOIN księgowosc.pensja 
ON księgowosc.wynagrodzenia.id_pensji=księgowosc.pensja.id_pensji
WHERE pensja.kwota > 2000 AND id_premii IS NULL;

---d)

SELECT * FROM księgowosc.pracownicy WHERE księgowosc.pracownicy.imie LIKE 'J%';

---e)

SELECT * FROM księgowosc.pracownicy WHERE księgowosc.pracownicy.imie LIKE 'N%' AND księgowosc.pracownicy.imie LIKE '%a';

---f)

SELECT pracownicy.imie, pracownicy.nazwisko, (księgowosc.godziny.liczba_godzin-160) AS Nadgodziny 
FROM księgowosc.pracownicy 
INNER JOIN księgowosc.godziny 
ON księgowosc.godziny.id_pracownika = pracownicy.id_pracownika 
WHERE księgowosc.godziny.liczba_godzin > '160';

---g)

SELECT pracownicy.imie, pracownicy.nazwisko, księgowosc.pensja.kwota
FROM księgowosc.pracownicy
JOIN księgowosc.wynagrodzenia
ON pracownicy.id_pracownika = księgowosc.wynagrodzenia.id_pracownika
JOIN księgowosc.pensja
ON księgowosc.wynagrodzenia.id_pensji = księgowosc.pensja.id_pensji
WHERE księgowosc.pensja.kwota BETWEEN 1500 AND 3000;

---h)

SELECT księgowosc.pracownicy.imie, księgowosc.pracownicy.nazwisko
FROM księgowosc.pracownicy
INNER JOIN księgowosc.godziny 
ON księgowosc.pracownicy.id_pracownika=księgowosc.godziny.id_pracownika
INNER JOIN księgowosc.wynagrodzenia
ON księgowosc.wynagrodzenia.id_pracownika = księgowosc.pracownicy.id_pracownika
INNER JOIN księgowosc.premia
ON księgowosc.premia.id_premii = księgowosc.wynagrodzenia.id_premii
WHERE liczba_godzin > 160 AND księgowosc.premia.id_premii IS NULL;

---i)

SELECT pracownicy.imie, pracownicy.nazwisko, księgowosc.pensja.kwota 
FROM księgowosc.pracownicy
INNER JOIN księgowosc.wynagrodzenia
ON księgowosc.wynagrodzenia.id_pracownika = księgowosc.pracownicy.id_pracownika
INNER JOIN księgowosc.pensja
ON księgowosc.pensja.id_pensji = księgowosc.wynagrodzenia.id_pensji
ORDER BY księgowosc.pensja.kwota;

---j)

SELECT pracownicy.imie, pracownicy.nazwisko, księgowosc.premia.kwota, księgowosc.pensja.kwota   
FROM księgowosc.pracownicy
INNER JOIN księgowosc.wynagrodzenia
ON księgowosc.wynagrodzenia.id_pracownika = księgowosc.pracownicy.id_pracownika
INNER JOIN księgowosc.pensja
ON księgowosc.pensja.id_pensji = księgowosc.wynagrodzenia.id_pensji
INNER JOIN księgowosc.premia
ON księgowosc.premia.id_premii = księgowosc.wynagrodzenia.id_premii
ORDER BY księgowosc.premia.kwota DESC;



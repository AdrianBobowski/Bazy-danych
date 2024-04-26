USE firma;

---a)

ALTER TABLE księgowosc.pracownicy
ALTER COLUMN telefon VARCHAR(20);
UPDATE księgowosc.pracownicy
SET telefon = '(+48)' + telefon;

---b)

UPDATE księgowosc.pracownicy
SET telefon = SUBSTRING(telefon, 1, 8) + '-' + SUBSTRING(telefon, 9, 3) + '-' + SUBSTRING(telefon, 12, 3)

---c)

SELECT TOP 1 id_pracownika, UPPER(imie) AS imie, UPPER(nazwisko) AS nazwisko, UPPER(adres) AS adres, telefon
FROM księgowosc.pracownicy
ORDER BY LEN(nazwisko) DESC;

---d)

SELECT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko, HASHBYTES('md5', CONVERT(VARCHAR, pensja.kwota)) AS md5_pensja 
FROM księgowosc.pracownicy 
JOIN księgowosc.wynagrodzenia ON wynagrodzenia.id_pracownika = pracownicy.id_pracownika
JOIN księgowosc.pensja ON pensja.id_pensji = wynagrodzenia.id_pensji

---f)

SELECT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko, pensja.kwota AS pensja, premia.kwota AS premia
FROM księgowosc.pracownicy 
LEFT JOIN księgowosc.wynagrodzenia 
ON wynagrodzenia.id_pracownika = pracownicy.id_pracownika
LEFT JOIN księgowosc.pensja 
ON pensja.id_pensji = wynagrodzenia.id_pensji
LEFT JOIN księgowosc.premia 
ON premia.id_premii = wynagrodzenia.id_premii

---g)

SELECT CONCAT('Pracownik ', pracownicy.imie, ' ', pracownicy.nazwisko, ', w dniu ', wynagrodzenia.data, ' otrzymał pensję całkowitą na kwotę ',
(pensja.kwota+premia.kwota), ' zł, gdzie wynagrodzenie zasadnicze wynosiło: ', pensja.kwota, ' zł, premia: ',
premia.kwota, ' zł, nadgodziny: ', CASE WHEN godziny.liczba_godzin > 160 THEN (godziny.liczba_godzin - 160) ELSE 0 END, ' godz.')
AS raport
FROM księgowosc.pracownicy 
JOIN księgowosc.wynagrodzenia ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
JOIN księgowosc.pensja ON wynagrodzenia.id_pensji = pensja.id_pensji
JOIN księgowosc.premia ON wynagrodzenia.id_premii = premia.id_premii
JOIN księgowosc.godziny ON wynagrodzenia.id_godziny = godziny.id_godziny
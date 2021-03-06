CREATE VIEW View_Zamówienia
AS
SELECT z.ID_Zamówienia, z.Data_zlozenia_zamowienia, z.Forma_platnosci, SUM(ks.Cena*ks_w_z.Ilość) + w.Koszt AS Łączna_kwota, 
z.Status, z.Data_aktualizacji_statusu, w.Rodzaj AS Rodzaj_wysylki, z.ID_Klienta
FROM Zamówienia AS z
INNER JOIN Książki_w_zamówieniach AS ks_w_z ON ks_w_z.ID_Zamówienia = z.ID_Zamówienia
INNER JOIN Książki AS ks ON ks.ISBN = ks_w_z.ISBN
INNER JOIN Wysyłki AS w ON w.ID_Wysyłki = z.ID_Wysyłki
GROUP BY z.ID_Zamówienia, z.Data_zlozenia_zamowienia, z.Forma_platnosci,
z.Status, z.Data_aktualizacji_statusu, w.Rodzaj, z.ID_Klienta, w.Koszt;

CREATE VIEW Ilości_Książek
AS
SELECT ks_w_z.ID_Zamówienia, ks.autor, ks.tytuł, ks_w_z.Ilość, ks.Cena AS [Cena jednostkowa], (ks.Cena * ks_w_z.Ilość) AS [Cena]
FROM  Książki_w_zamówieniach AS ks_w_z
INNER JOIN Książki AS ks ON ks.ISBN = ks_w_z.ISBN;

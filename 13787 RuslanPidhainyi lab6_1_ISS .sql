



use master                      --Usuwa Baze 
GO
if DB_ID (N'Sneakers_shop') IS NOT NULL
DROP DATABASE Sneakers_shop;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE DATABASE Sneakers_shop             -- Utworzenie bazy danych
COLLATE Polish_100_CI_AS; 
GO


IF DB_ID (N'Sneakers_shop') IS NOT NULL      -- sprawdzam czy jest taka baza
SELECT 'Istnieje'


-----------------------------------------------------------------------------------------------------------------------------------------------------------------


USE [Sneakers_shop]

--tworzymy tabele


CREATE TABLE [dbo].[Klient](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Nazwisko] [nvarchar] (100)  NOT NULL,
	[Imie] [nvarchar] (100) NOT NULL,
	[Telefon] [nvarchar] (25) NULL,
	[Email] [nvarchar] (50)  NULL,
	[Adres] [nvarchar] (50) NOT NULL,
	[Miasto] [nvarchar] (50) Not NULL,
	[KodPocztowy] [nvarchar] (50) NULL)





	CREATE TABLE [dbo].[Zarobki](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Pensja] [decimal] (8,2) NOT NULL)


	CREATE TABLE [dbo].[Pracownik](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Stanowisko] [nvarchar] (50) NOT NULL,
	[Nazwisko] [nvarchar] (100)  NOT NULL,
	[Imie] [nvarchar] (100) NOT NULL,
	[Urodziny] [date] NOT NULL,
	[Pesel] [nvarchar] (100) NOT NULL,
	[Telefon] [nvarchar] (25) NULL,
	[Email] [nvarchar] (50)  NULL,
	[ZarobkiID] [int] NOT NULL FOREIGN KEY REFERENCES Zarobki(ID))




    CREATE TABLE [dbo].[RodzajButow](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Nazwa] [nvarchar] (100) UNIQUE  NOT NULL)

	CREATE TABLE [dbo].[Rozmiar](
	[ID] [int] PRIMARY KEY IDENTITY,
	[EU] [decimal] (8,2) NULL,
	[UK] [decimal] (8,2) NULL,
	[US] [decimal] (8,2) NULL)



	CREATE TABLE [dbo].[Kolory](
    [ID] [int] PRIMARY KEY IDENTITY,
	[NazwaKoloru] [nvarchar] (100) NULL)




	CREATE TABLE [dbo].[Buty](
    [ID] [int] PRIMARY KEY IDENTITY,
	[NazwaFirmy] [nvarchar] (100) NOT NULL,
	[Modele] [nvarchar] (100) NOT NULL,
	[Kolobaracja] [nvarchar] (100) NULL,
	[RodzajButowID] [int] NOT NULL FOREIGN KEY REFERENCES RodzajButow(ID),
	[KolorID]  [int]  FOREIGN KEY REFERENCES Kolory(ID),
	[RozmiarID]  [int]  FOREIGN KEY REFERENCES Rozmiar(ID))

	CREATE TABLE [dbo].[DataZamowieniaSprzedazy](
    [ID] [int] PRIMARY KEY IDENTITY,
	[DataZamowienia] [date] NOT NULL,
	[DataDostarczenia] [date] NOT NULL,
	[DataSprzedazy] [date] NOT NULL)
	



	CREATE TABLE [dbo].[Sprzedano](
	[ID] [int] PRIMARY KEY IDENTITY,
	[PracownikID] [int] NOT NULL FOREIGN KEY REFERENCES Pracownik(ID),
	[KlientID] [int] NOT NULL FOREIGN KEY REFERENCES Klient(ID),
    [ButyID] [int] NOT NULL FOREIGN KEY REFERENCES Buty(ID),
	[DataZamowieniaSprzedazyID] [int] NOT NULL FOREIGN KEY REFERENCES DataZamowieniaSprzedazy(ID),
	[Cena] [decimal] (8,2) NOT NULL)
	

-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--zapewniamy nasza baze 

INSERT INTO Klient ( Nazwisko, Imie, Telefon, Email, Adres, Miasto, KodPocztowy) 
VALUES('Bilenczyk', 'Adam', '234-123-432', 'bilenczy2adam@gmail.com','ul. Obozowa 102', 'Krakow', '300-10'),
      ('Simpson', 'Homer', '911-102-104','springfild@gmail.com', 'ul. Filipa 19', 'Warszawa', '535-18'),
      ('Simpson', 'Bart', NULL,  NULL,'ul. Aleja 36', 'Gdansk', NULL),
      ('Palij', 'Witalij', '103-102-101','witalij1wsei@gmail.com', 'ul. Balakina 2', 'Wroclaw', '999-99'),
      ('Simpson', 'Lisa', '123-456-789', NULL,'ul. Filipa 19', 'Warszawa', NULL),
      ('Anonimus', 'Anonim', NULL, NULL, 'ul. Nixon ST 1', 'Los-Angeles', NULL),
	  ('Chirva', 'Anton', '531-555-038','chirvaa@gmail.com', 'ul. Teatralna 4', 'Krakow', '999-19'),
	  ('Korba', 'Andrzej', '106-112-119','andrzejkorba@gmail.com', 'ul. Jana Kilinskiego 12', 'Wroclaw', '999-99'),
	  ('Bonbar', 'Angelika', '198-223-483','bondarrr@gmail.com', 'ul. swiety Marcin 45', 'Poznan', '123-33'),
	  ('Bondarenko', 'Temofij', NULL,  NULL,'ul. Filipa 6', 'Gdansk', NULL),
      ('Katczenko', 'Kamil', '103-333-269','Kamilll1l@gmail.com', 'ul. Jagiellonska 78', 'Szczecin', '103-60'),
      ('Katczenko', 'Lisa', '131-216-789', NULL,'ul. Filipa 19', 'Poznan', NULL),
	  ('Baran','Marek','123-32-12',NULL,'ul. Grod?ka 56','Krakow','129-11'),
	  ('Baranik','Ola','456-66-89','baran1kola44@gmail.com','ul. Szpitalnia 1','Krakow','123-33'),
	  ('Montano','Toni','234-234-123','tonimontano@gmail.com','ul. Tomasza 14', 'Krakow', NULL)




INSERT INTO Zarobki (Pensja)
VALUES ('3200'),
       ('3800'),
	   ('4000'),
	   ('4500'),
       ('5000')
     


INSERT INTO Pracownik (Nazwisko, Imie, Stanowisko, Urodziny, Pesel, Telefon, Email, ZarobkiID)
 VALUES  ('Belik', 'Niko', 'Sprzedawca', '1990.01.20', '12345678911', '238-902-123', 'niko1belik@gmail.com','1'),
         ('Ternow', 'Alan', 'Sprzedawca', '1996.06.06', '55686098764', '423-643-123', 'alanpublic133@gmail.com','1'),
	     ('Olszewska', 'Karolina', 'Sprzedawca','1989.12.15', '98711144499', '413-777-213', NULL,'1'),
		 ('Kulakow', 'Alan', 'Sprzedawca', '1993.09.10', '12345667754', '921-412-310', NULL ,'1'),
	     ('Duszczenko', 'Polina', 'Sprzedawca','1990.01.20', '12342452343', '982-213-983', 'duszczenko.shop@gmail.com','2'),
		 ('Ostapienko', 'Kamil', 'Sprzedawca','1991.10.14', '12345308911', '200-902-103', 'ostapp3@gmail.com','2'),
		 ('Masek', 'Anton', 'Administrator', '1988.08.17', '55686099724', '189-403-293', 'antonie@gmail.com','3'),
	     ('Furman', 'Kamil', 'Administrator', '1994.12.21', '98722222229', '777-777-213', 'furmanadministracja@gmail.com' ,'3'),
		 ('Zimnik', 'Niko?aj', 'Administrator', '1993.09.10', '12345667754', '121-492-300', 'zimikniko@gmail.com' ,'4'),
	     ('Olszewik', 'Damian', 'Wlasciciel', '1990.10.20', '12313411213', '900-200-900', 'olszewskidamian.shop@gmail.com','5')



INSERT INTO RodzajButow(Nazwa)
VALUES ('Sneakers'),
('Skateboarding'),
('Training'),
('Klasyczne')

INSERT INTO Kolory (NazwaKoloru)
values ('Czarny'),
       ('Bialy'),
	   ('Szary'),
	   ('Zielony'),
	   ('Czerwony')


	   	insert into Rozmiar(EU, UK, US)
	VALUES('40','6.5','7.5'),
	      ('40.7','7','8'),
		  ('41.5','7.5','8.5'),
		  ('42','8','9'),
		  ('42.5','8.5','9.5'),
		  ('43.3','9','10'),
		  ('44','9.5','10.5'),
		  ('44.5','10','11'),
		  ('45.2','10.5','11.5'),
		  ('45.8','11','12'),
		  ('46.5','11.5','12.5'),
		  ('47','12','13')
		 
		 
INSERT INTO Buty (NazwaFirmy, RodzajButowID, Modele,Kolobaracja, KolorID, RozmiarID)
values ('Nike','1','Air Max 90',NULL,'1','1'),
	   ('Nike','1','Air Max 90',NULL,'2','7'),
	   ('Nike','1', 'Air Max 90','Travis Scott','3','1'),
	   ('Nike','1', 'Air Max 90',NULL,'4','3'),
       ('Nike','1', 'Air Max 90',NULL,'5','4'),
       ('Adidas','2','Superstar','Snoop Dogg','1','5'),
	   ('Adidas','2','Superstar',NULL,'2','7'),
	   ('Adidas','2','Superstar',NULL,'3','4'),
	   ('Adidas','2','Superstar',NULL,'4','4'),
	   ('Adidas','2','Superstar',NULL,'5','7'),
	   ('Adidas','2','Gazelle',NULL,'1','4'),
	   ('Adidas','2','Gazelle',NULL,'2','3'),
	   ('Adidas','2','Gazelle',NULL,'3','3'),
	   ('Adidas','2','Gazelle',NULL,'4','3'),
	   ('Adidas','2','Gazelle',NULL,'5','5'),
	   ('Puma','4','Ca Pro Classic',NULL,'1','5'),
	   ('Puma','4','Ca Pro Classic',NULL,'2','5'),
	   ('Puma','4','Ca Pro Classic','Adidas X','3','6'),
	   ('Puma','4','Ca Pro Classic',NULL,'4','6'),
	   ('Kappa','3','Brady',NULL,'1','6'),
	   ('Kappa','3','Brady',NULL,'2','6'),
	   ('New Balance','4','seria 574',NULL,'1','6'),
	   ('New Balance','4','seria 574',NULL,'2','7'),
	   ('New Balance','4','seria 574',NULL,'3','7'),
	   ('New Balance','4','seria 574','Steve Jobs','4','10'),
	   ('New Balance','4','seria 574',NULL,'5','10'),
	   ('New Balance','4','seria 452',NULL,'1','1'),
	   ('New Balance','4','seria 452','Steve Jobs II','2','10'),
	   ('New Balance','4','seria 452',NULL,'4','9'),
	   ('New Balance','4','seria 373',NULL,'1','1'),
	   ('New Balance','4','seria 373',NULL,'2','9'),
	   ('New Balance','4','seria 373',NULL,'3','9'),
	   ('New Balance','4','seria 373',NULL,'4','1')




	INSERT INTO DataZamowieniaSprzedazy (DataZamowienia, DataDostarczenia, DataSprzedazy) 
   VALUES ('2020-12-16','2021-01-16','2021-06-10'),
('2020-12-16','2021-12-16','2021-05-19'),
('2020-12-16','2021-12-16','2021-05-18'),
('2020-12-16','2021-12-16','2021-05-09'),
('2020-12-16','2021-12-16','2021-05-19'),
('2020-12-16','2021-12-16','2021-05-15'),
('2021-02-11','2021-03-11','2021-05-11'),
('2021-02-11','2021-03-11','2021-05-21'),
('2021-02-11','2021-03-11','2021-05-15'),
('2021-02-11','2021-03-11','2021-05-25'),
('2021-02-11','2021-03-11','2021-05-28'),
('2021-02-11','2021-03-11','2021-05-16'),
('2021-02-11','2021-03-11','2021-05-19'),
('2021-02-11','2021-03-11','2021-05-24'),
('2021-02-11','2021-03-11','2021-05-14'),
('2021-02-11','2021-03-11','2021-08-11'),
('2021-04-16','2021-05-16','2021-08-01'),
('2021-04-16','2021-05-16','2021-08-22'),
('2021-04-16','2021-05-16','2021-08-22'),
('2021-04-16','2021-05-16','2021-08-13'),
('2021-04-16','2021-05-16','2021-08-26'),
('2021-04-16','2021-05-16','2021-08-23'),
('2021-04-16','2021-05-16','2021-08-24'),
('2021-04-16','2021-05-16','2021-08-24'),
('2021-04-16','2021-05-16','2021-08-24'),
('2021-04-16','2021-05-16','2021-08-24'),
('2018-04-16','2021-05-16','2021-08-24'),
('2018-04-16','2021-05-16','2021-08-24'),
('2018-04-16','2021-05-16','2021-08-24')




INSERT INTO Sprzedano (PracownikID ,KlientID, ButyID, DataZamowieniaSprzedazyID, Cena) 
VALUES ('1', '7', '12','1','400'),
('1', '11', '12','2','395'),
('2', '8', '13','3','400'),
('3', '4', '14','4', '200'),
('4', '7', '28','5','415'),
('1', '8', '27','6','339'),
('5', '6', '26','7','455'),
('1', '11', '25','8','415'),
('3', '3', '22','9','415'),
('5', '11', '21','10','415'),
('3', '6', '19','11','415'),
('3', '7', '18','12','415'),
('1', '3', '16','13', '200'),
('5', '8', '13','14','200'),
('1', '10', '17','15','395'),
('2', '10', '15','16', '395'),
('4', '2', '9','17','395'),
('4', '1', '10','18','339'),
('2', '10', '8','19','500'),
('2', '10', '29','20', '339'),
('5', '6', '6','21','415'),
('4', '8', '5','22','395'),
('1', '1', '4','23','395'),
('2', '7', '3','24','395'),
('3', '5', '2','25','200'),
('3', '1', '23','26','400'),
('3', '8', '20','27','400'),
('4', '8', '1','28','400'),
('4', '1', '24','29','399')
	  


-----------------------------------------------------------------------------------------------------------------------------------------------------------------


      select * from RodzajButow 
      select * from Rozmiar 
	  select * from Buty 
      select * from DataZamowieniaSprzedazy
	  select * from Klient 
	  select * from Kolory 
	  select * from Pracownik 
	  select * from Zarobki 
	  select * from Sprzedano 

-----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 1  Pokaz Klienta ktory kupić buty pod numerem Telefonu '555' i podaj go dane 


select K.ID, Nazwisko, Imie, Telefon, Email, Miasto  from Klient as K Left join Sprzedano as S
on K.ID = S.ButyID where K.Telefon like '%555%'



-- 2 Pokaz tabele kiedy ma pracowniki urodziny od '1992.01.01' do '1995.12.31' i pokaz jeszcze dane: Imie, Nazwisko



select  Urodziny, Imie, Nazwisko  from Pracownik
where Urodziny between '1992.01.01' and '1995.12.31' 



--3 Stowrzy kopie tablice Pracownik. Wyświetl tą tablice za pomocy UNION or UNION ALL, i pokaz dane: ID, Stanowisko, Nazwisko, Pesel. i posortuj tabele: Nazwisko i Pesel

select ID, Stanowisko, Nazwisko, Pesel 
into Pracownik_1 
from Pracownik 



select ID, Stanowisko, Nazwisko, Pesel from Pracownik  union
select ID, Stanowisko, Nazwisko, Pesel from Pracownik_1 
order by Nazwisko desc, Pesel asc


select ID, Stanowisko, Nazwisko, Pesel from Pracownik  union all
select ID, Stanowisko, Nazwisko, Pesel from Pracownik_1 
order by Nazwisko desc, Pesel asc 



-- 4 Wyświetl tabele spszedawcy ktorzy szprzedali towar klientam ktorzy nie mają email

select distinct K.ID, Imie, Email from KLient as K  full join Sprzedano as S 
on K.ID = S.PracownikID 
where k.email is Null 


-- 5 Pokaz sredne cena butow i liczebnosc i podpisz kolumne 

select B.NazwaFirmy, avg (cena) as 'Srednia cena',  count(*) as 'Liczba butow' from Buty as B left join  Sprzedano as S 
on B.ID = S.ID Group by B.NazwaFirmy order by avg(Cena) asc


--6 Pokaz ile otrzymuje Sprzedawca w miesiec

select P.Stanowisko , Max(Pensja) as 'Wyplata Miesieczna' from Pracownik as P Full Join Zarobki as Z 
on P.ZarobkiID = Z.ID  where  P.Stanowisko = 'Sprzedawca'  group by P.Stanowisko  


--7 Pokaz pierwszych  8 butow rodzaju 'Klasyczny'

Select  Top 8  NazwaFirmy, Modele, Nazwa    from Buty as B Left Join RodzajButow as R
On B.RodzajButowID  = R.ID  WHERE Nazwa = 'Klasyczne' 


--8 Pokaz buty firmy New Balance i do nich dodaj czarny kolor 

select NazwaFirmy, Modele, NazwaKoloru  from Buty as B Left join Kolory as K
on B.KolorID = K.ID where NazwaFirmy = 'New balance' and NazwaKoloru = 'Czarny'



--9 Pokaz najdrozsze buty i udostempni Nazwe Firmy i ich modele

select NazwaFirmy, Modele, MAx(Cena) as Wartosc  from Sprzedano as S left join Buty as B 
on S.ButyID = B.ID group by NazwaFirmy, Modele having MAx(Cena) = 500



--10  Pokaz NazweFirmy i rozmiar butow US i EU od 43.3 

select NazwaFirmy, EU, US  from Buty as B  Full join  Rozmiar as R 
on B.RozmiarID = R.ID where EU >= 43 and NazwaFirmy  is not null order by EU 



--11 Pokaz nazwe butow 'New  balance' w ktorych są kolobaracje, modele i ich  ilosc sprzedanych 

select NazwaFirmy, Modele, Kolobaracja, count(*) as Ilosc_butów  from Buty 
where Kolobaracja like 'Steve%' group by NazwaFirmy, Modele, Kolobaracja








-----------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                         /*widok*/


-- 1 Pokaz informacje KLienow i Spzedawcow(ich Imie i Nazwisko),  Buty (nazwe firmy 'adidas' i ich  Modele) i pokaz  do Butow ich cene


--Stworzy widok

 create view [dbo].[v_SprzedanoButy]
 as 

 select Klient.Imie + ' ' + Klient.Nazwisko as K_ImieNazwisko,
       Pracownik.Imie + ' ' + Pracownik.Nazwisko as P_ImieNazwisko,
       Buty.NazwaFirmy + ' ' + Buty.Modele as B_NazwaModele,
	   Sprzedano.Cena 
	   from Sprzedano
	                 left join Klient
	                    on Sprzedano.KlientID = klient.ID
					 left join Pracownik 
					    on Sprzedano.PracownikID = Pracownik.ID 
					 left join Buty
					    on Sprzedano.ButyID = Buty.ID
					
						

where Buty.NazwaFirmy = 'Adidas'
group by Klient.ID, Klient.Imie + ' ' + Klient.Nazwisko, Pracownik.Imie + ' ' + Pracownik.Nazwisko, Buty.NazwaFirmy + ' ' + Buty.Modele, Sprzedano.Cena 




--Pokaz widok 
select * from v_SprzedanoButy order by cena asc 

--Usun 
IF OBJECT_ID('v_SprzedanoButy') IS NOT NULL
DROP VIEW [dbo].[v_SprzedanoButy]








-- 2 Pokaz Buty (Firme i modele) rodzaj butow 'Klasyczne', ilosc butow za taka cene i ich cene za jaką byli sprzedani

--tworzymy widok 

CREATE VIEW [dbo].[v_ButyKlasyczny]
as 

select distinct Buty.NazwaFirmy + ' ' + Buty.Modele as B_NazwaModele,
       RodzajButow.Nazwa  as R_Nazwa,
	   count(Buty.NazwaFirmy) as 'ilosc butow za taka cene',
	   Sprzedano.Cena as Cena
	                           from Buty 
							            left join RodzajButow 
										          on Buty.RodzajButowID = RodzajButow.ID 
                                         left join Sprzedano 
										           on Buty.ID = Sprzedano.ButyID 

where  Sprzedano.Cena  is not null and RodzajButow.Nazwa = 'Klasyczne'
GROUP BY Buty.NazwaFirmy + ' ' + Buty.Modele,   RodzajButow.Nazwa, Sprzedano.Cena 





--wyswietl widok 

select * from v_ButyKlasyczny order by 'ilosc butow za taka cene' desc 



--Usun 
IF OBJECT_ID('v_ButyKlasyczny') IS NOT NULL
DROP VIEW [dbo].[v_ButyKlasyczny]








--3 Pokaz Buty (Firme i modele 'seria 452') i ich cene za ktorą sprzedali 



--tworzymy widok 

create view [dbo].[v_NewBalance_seria_452]
as

select B.NazwaFirmy, B.Modele, K.NazwaKoloru, R.Nazwa, S.Cena  from   Buty as B full join Kolory as K
                                                                  on B.KolorID = K.ID 
                                                                 full join RodzajButow as R
																 on B.RodzajButowID = R.ID 
																 full join Sprzedano as S
																 on  B.ID = S.ButyID 
where B.Modele =  'seria 452'
group by B.NazwaFirmy, B.Modele, K.Nazwakoloru, R.Nazwa, S.Cena 






--wyswietl  widok 

select * from v_NewBalance_seria_452 order by Cena asc


--Usun 
IF OBJECT_ID('v_NewBalance_seria_452') IS NOT NULL
DROP VIEW [dbo].[v_NewBalance_seria_452]

--lub

DROP VIEW [dbo].[v_NewBalance_seria_452]


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                       /*Procedura*/

-- 1 stworzy procedure w ktorej mozna dodac klientow i informacje o nim w tabele klienci   

CREATE PROCEDURE [Proc_DodajKlienta]                                                       --piszemy parametry
                
				 @Nazwisko nvarchar(100),
				 @Imie nvarchar(100),
				 @Telefon nvarchar(25),
				 @Email nvarchar(50),
				 @Adres nvarchar(50),
				 @Miasto nvarchar(50),
				 @KodPocztowy nvarchar(50)
AS
BEGIN 
                                     --cialo pszechowywanie parametrow
INSERT Klient ( [Nazwisko], [Imie], [Telefon],[Email],[Adres],[Miasto], [KodPocztowy]) 
VALUES( @Nazwisko, @Imie, @Telefon, @Email, @Adres, @Miasto, @KodPocztowy) 

END






-- zeby wykorzystac nasze procedyre (ta procedura swozy do wpisywania dane w tabele 'Kolory' 
EXEC Proc_DodajKlienta 'Kozak', 'Wiktoria', '953-123-657', 'kozakviktoria', 'ul. Filipa 9b', 'Krakow', '312-33' 
EXEC Proc_DodajKlienta 'Kozak', 'Rafal', '932-43-33', 'rafalllhome@gmail.com', 'ul. Koszykarska 19', 'Krakow', null 

--sprzawdż zmiane
select * from Klient 


-- Usun dwa ostatnich wiersza w tabele klient
Delete from Klient where ID >= 16 

-- Zeby usunac procedure
DROP PROCEDURE [Proc_DodajKlienta]






-- 2 Stworz procedure i pokaz w tabele Nazwafirmy butow 'New balance' i ich modele 'seria 452', rodzaj butow, Kolor, rozmiar EU i ich Cena i pokaz ilosc tych butow


CREATE PROCEDURE [Proc_ListaButow] 
@NazwaFirmy nvarchar (100),
@Modele nvarchar (100),
@Ilosc int OUTPUT
AS
BEGIN
	SET NOCOUNT ON 

	SET @Ilosc = (SELECT COUNT(*)
					FROM Buty 
					WHERE NazwaFirmy LIKE @NazwaFirmy AND Modele LIKE @Modele) 

	SELECT Buty.NazwaFirmy, Buty.Modele, RB.Nazwa, K.NazwaKoloru, R.EU, S.Cena
	FROM Buty 
	         LEFT JOIN RodzajButow as RB
			 ON Buty.RodzajButowID = RB.ID

			 LEFT JOIN Kolory as K
			 ON Buty.KolorID = K.ID

			 LEFT JOIN Rozmiar as R
			 ON Buty.RozmiarID = R.ID

			 LEFT JOIN Sprzedano as S
			 on Buty.ID = S.ButyID


	WHERE NazwaFirmy LIKE @NazwaFirmy AND Modele LIKE @Modele and Buty.Modele = 'seria 452' AND  S.Cena IS NOT NULL

END

-- wyswitel
DECLARE @Ilosc INT
EXEC [Proc_ListaButow] 'New%', 'seria 452', @Ilosc OUTPUT  
SELECT @Ilosc as Ilosc


--Usun 
DROP PROCEDURE [Proc_ListaButow] 




-- 3 Stworzy procedure w ktorej mozna wybrac NazweFirmy Butow, Modele, i Ich rozmiar od i do

CREATE PROCEDURE [Proc_WyborButow] 
@NazwaFirmy  nvarchar (100),
@Modele nvarchar (100),
@Od_EU decimal (8,2),
@Do_EU decimal (8,2)

as
select B.NazwaFirmy, B.Modele, R.EU from Rozmiar as R
                                                         left join Buty as B
														 on B.RozmiarID = R.ID 

where @NazwaFirmy like NazwaFirmy and @Modele like Modele and  EU >= @Od_EU and EU <= @Do_EU 
Order by NazwaFirmy, Modele, EU



--ustan  swoj rozmiar 
EXEC Proc_WyborButow  'Adidas','Gazelle', 42,43

--Usun
DROP PROCEDURE [Proc_WyborButow] 





-----------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                       /*Funkcji*/

-- 1 Stworzy funkcje w ktorej mozesz wpisac Cena '395' i wyswietle ci dane: Imie Nazwisko Pracownika(Razem), Imie Nazwisko KLienta(Razem), NazwaFirmy, DataSprzedazy, Cena

-- stworz funknje 

CREATE FUNCTION F_Poszuk
(@Cena decimal(8,2))

RETURNS TABLE 
AS
RETURN 
                 SELECT  Pracownik.Imie +' '+ Pracownik.Nazwisko as ImieNazwisko_Pracownika, 
				         Klient.Imie + '  ' + Klient.Nazwisko as ImieNazwisko_Klienta,
						 Buty.NazwaFirmy , DataZamowieniaSprzedazy.DataSprzedazy,
				         Sprzedano.Cena FROM Sprzedano 
				                       
									    LEFT JOIN Pracownik 
										ON Sprzedano.PracownikID = Pracownik.ID 
										
										LEFT JOIN Klient 
										ON Sprzedano.KlientID = Klient.ID 

										LEFT JOIN Buty  
										ON Sprzedano.ButyID = Buty.ID 

										LEFT JOIN DataZamowieniaSprzedazy
										ON Sprzedano.DataZamowieniaSprzedazyID = DataZamowieniaSprzedazy.ID
								
				                 WHERE Sprzedano.Cena = @Cena 


--Pokaz wynik
SELECT * FROM F_Poszuk(395)

-- usun funkcje 
DROP FUNCTION F_Poszuk







  



--2 stworz funkcje w ktorej ci pokaz ilosc butow konkratnej firmy bez kolobaracji
 

CREATE FUNCTION [F_IloscButow] 
(@NazwaFirmy nvarchar(100)) --Передается наш параметр 

RETURNS INT
AS
BEGIN 
        

	DECLARE @RESULT INT 
	SELECT @RESULT = count(ID) FROM Buty 
	where NazwaFirmy = @NazwaFirmy and  Kolobaracja is null
	RETURN @RESULT 

END


--Pokaz 
SELECT [dbo].[F_IloscButow] ('Adidas')


--Usun 
DROP FUNCTION F_IloscButow









--3 stworzy funkcje. i znajdz za numerem '23' ID Butow,  klienta  


CREATE FUNCTION F_Poszuk_Klienta
(@Buty_ID int)

RETURNS TABLE 
AS
RETURN 
                 SELECT  Klient.Imie + '  ' + Klient.Nazwisko as ImieNazwisko_Klienta,
				         Klient.Telefon,
						 DataZamowieniaSprzedazy.DataSprzedazy,
				         Sprzedano.Cena FROM Sprzedano 
										
										LEFT JOIN Klient 
										ON Sprzedano.KlientID = Klient.ID 

										LEFT JOIN DataZamowieniaSprzedazy
										ON Sprzedano.DataZamowieniaSprzedazyID = DataZamowieniaSprzedazy.ID
								
				                 WHERE Sprzedano.ButyID = @Buty_ID

--Pokaz wynik
SELECT * FROM  F_Poszuk_Klienta('23')

-- usun funkcje 
DROP FUNCTION F_Poszuk_Klienta








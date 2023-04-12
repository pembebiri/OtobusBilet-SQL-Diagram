SELECT *FROM Urunler where UrunAdi not like '%c%' and UrunAdi not like '%a%'

--PersonelIDsi 4 olan ve nakliyeci ucreti 15 ile 45 arasýnda olan
--Personel sýrlayarak son 3 kaydý getiren satýþlarý listeleyiniz.

Select top 3 *From Satislar where PersonelID=4 and NakliyeUcreti between 15 and 45 order by SevkTarihi desc

-- aggregate fonksiyonlar
-- 5 tane fonksiyon türü vardýr.
-- select ile from arasýna yazýlýr.
-- kullanýlýrken yanýna kolon getirilemez(þimdilik)
-- (count, sum, avg, max,min)

Select COUNT(KategoriAdi) from Kategoriler

Select sum (HedefStokDuzeyi) from Urunler 

Select SUM(HedefStokDuzeyi) from Urunler where TedarikciID=7

Select Sum(BirimFiyati*HedefStokDuzeyi) from Urunler

Select Avg(BirimFiyati) FROM Urunler

Select MAX(HedefStokDuzeyi) from Urunler

Select Min(BirimFiyati) from Urunler

Select KategoriID, count(UrunAdi) ÜrünAdetleri 
from Urunler group by KategoriID

-- Hangi tedarikçiden kaç adet ürün alýnmýþtýr.

Select TedarikciID, count(UrunAdi) as ÜrünAdetleri from Urunler group by TedarikciID

-- Urunler tablosunda hangi kategoriden kaç adet vardýr ve toplam kaç adettir.

Select KategoriID, count(KategoriID),SUM(HedefStokDuzeyi) ÜrünAdetleri 
from Urunler group by KategoriID

-- SubQuery

Select KategoriID, COUNT(KategoriID) KategoreiSayýsý, SUM(HedefStokDuzeyi) kategoriStokToplamasý, 
SUM(HedefStokDuzeyi*BirimFiyati) toplamsatis
from Urunler group by KategoriID

-- Hangi Tedarikçiden kaç adet tedarik yapýlmýþ

Select TedarikciID, COUNT(TedarikciID) TedarikSayýsý, SUM(HedefStokDuzeyi) TedarikçiStokToplamasý, 
SUM(BirimFiyati*HedefStokDuzeyi) ToplamFiyat
from Urunler group by TedarikciID

-- Ülkelere sevkedilen Ürünlerin toplam nakliye ücretleri

Select SevkUlkesi,  SUM(NakliyeUcreti) Toplam, COUNT(NakliyeUcreti) Adet, AVG(NakliyeUcreti) Ortalama
from Satislar group by SevkUlkesi

--Hangi personel hagi müþteriye kaç adet ve kaç lira satýþ yapmýþtýr

Select MusteriID, PersonelID, COUNT(SatisID) Satis
from Satislar group by PersonelID, MusteriID order by MusteriID, Satis desc

--Ortalamasý iyi olan personele ödül

Select *From Urunler Where BirimFiyati>5


Select UrunAdi, (Select SirketAdi From Tedarikciler where TedarikciID=Urunler.TedarikciID), 
(select KategoriAdi from Kategoriler where KategoriID=Urunler.KategoriID),
BirimFiyati, HedefStokDuzeyi from Urunler

-- Satýþlar tablosunu, müþteri adý ünvaný, personel adý, soyadý ile ekrana yazdýr.

Select (Select MusteriAdi From Musteriler where MusteriID=Satislar.MusteriID),
 (Select MusteriUnvani From Musteriler where MusteriID=Satislar.MusteriID),
(Select Adi From Personeller where PersonelID=Satislar.PersonelID),
(Select SoyAdi From Personeller where PersonelID=Satislar.PersonelID)
from Satislar

--Ürünler tablosu ile birlikte her bir ürünün toplam
-- satýþ adedinin bilgisini gösteren sorguyu ekrana yazar.

Select UrunAdi,(Select SUM(SatisID) as 'Satýþ Sayýsý' 
From [Satis Detaylari] WHERE SatisID=Satislar.SatisID )
, (Select SUM(Miktar) AS 'Satýþ Adedi' 
from [Satis Detaylari])
from Urunler

Select *from Satislar

Select (select MusteriAdi From Musteriler Where MusteriID=Satislar.MusteriID) as Musteriler
, (Select Adi From Personeller Where PersonelID=Satislar.PersonelID) as Satýcýlar
From Satislar

-- SATIÞLARDAN MAKSÝMUM SATIÞ FÝYATINI ALIN

Select (select MAX(BirimFiyati) from [Satis Detaylari] 
where SatisID=[Satis Detaylari].SatisID) From Satislar

Select UrunAdi ,(select MAX(BirimFiyati) from [Satis Detaylari] 
where UrunID=Urunler.UrunID) as MaksimumFiyat from Urunler Order by 2 desc

Select * From Urunler where TedarikciID=
(Select TedarikciID From Tedarikciler
Where MusteriAdi='Karkki Oy')

--satýþlardaki satýþ id ile satýþ detaylarýndaki en yüksek birim fiyatý bulma
--ve en yüksek ürün id sini bulma
select (select Urunadi from Urunler where UrunID=(select max(UrunID) 
from [Satis Detaylari] SD where sd.SatisID=s.SatisID)) ,
(select max(sd.BirimFiyati) from [Satis Detaylari] SD where sd.SatisID=s.SatisID), 
* from Satislar S

select (select max(UrunID) from [Satis Detaylari] SD where sd.SatisID=s.SatisID) ,
(select max(sd.BirimFiyati) from [Satis Detaylari] SD where sd.SatisID=s.SatisID),
* from Satislar S

select *from [Satis Detaylari] sd where sd.SatisID =10250
select max(UrunID) from [Satis Detaylari] SD where sd.SatisID=10250

-- adý robert olan personelin yaptýðý satýþlar

select UrunAdi,
(select KategoriID from Kategoriler where KategoriID=u.KategoriID),
(select SirketAdi from Tedarikciler where TedarikciID=u.TedarikciID)
from Urunler u

select* from Kategoriler
select * from Urunler
where KategoriID=
(Select KategoriID from Kategoriler
where KategoriAdi='produce')

select *from Satislar where PersonelID in (select PersonelID from
Personeller where  Adi='Robert' or Adi='Nancy')

--Çay ürünlerinin satýþlarý chai

Select *from Satislar where SatisID in 
(select COUNT(UrunID) from [Satis Detaylari] where SevkAdi='Chai')

Select *From [Satis Detaylari] sd
Where UrunID=(Select UrunID From Urunler u Where UrunAdi='Chai')

--personel adý Nancy veya Janet olan, 
--nakliyecisi speedy express olan satýþlarý

select *from Satislar where PersonelID in (select PersonelID from
Personeller where  Adi='Janet' or Adi='Nancy' ) and
ShipVia=(select NakliyeciID from Nakliyeciler where SirketAdi=
'speedy express')

--1997 yýlýnda yapýlan satýþlarda ne kadar ciro edildiðini

select (Select SatisID, Sum(Miktar*BirimFiyati*(1-Ýndirim)) 
from [Satis Detaylari] where SatisID=Satislar.SatisID )
from Satislar
where SatisTarihi between '1997.01.01' and '1997.12.31'

select sum(sd.BirimFiyati*sd.Miktar*(1-sd.Ýndirim)) 
from [Satis Detaylari] sd 
where sd.SatisID in 
(select s.SatisID from Satislar s 
where s.SatisTarihi between '1997.01.01' and '1997.12.31')


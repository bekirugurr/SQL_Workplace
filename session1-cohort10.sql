/*============================================================================
                          SELECT
=============================================================================*/
/*tracks tablosundaki name leri sorgula*/
SELECT name FROM tracks;

/*tracks tablosundaki besteci (Composer) ve şarkı isimelerini (name) sorgula*/
SELECT Composer, name FROM tracks;

/* tracks tablosundaki bütün bilgileri sorgula*/
SELECT * FROM tracks;

/*===========================================================================
                          DISTINCT (different/unique)
============================================================================*/
/* tracks tablosundaki composer bilgilerini göster(tekrarlı olabilir */
SELECT Composer FROM tracks;

/*tracks tablosundaki composer bilgilerini göster(tekrarsız olarak */
SELECT DISTINCT Composer FROM tracks;
/*tracks tablosundaki AlbumId ve MediaTypeId bilgilerini tekrarsız göster */
SELECT DISTINCT AlbumId, MediaTypeId FROM tracks;
/*============================================================================
                            WHERE (conditions, (if e benziyor))
=============================================================================*/
/* tracks tablosunda composer ı Jimi Hendrix olan parçaların isimlerini getir */
SELECT name FROM tracks WHERE Composer='Jimi Hendrix';
--Her ne kadar case sensitive olsa da isimlerin harflerini büyüklükleri aynı olmalı
--Mesela Jimi Hendrix olarak kayıplıyken Jimi hendrix yazarsak çalışmaz
--Her ikili altalta da yazılabilir 
SELECT name 
FROM tracks 
WHERE Composer='Jimi Hendrix';

/* invoices tablosundaki Total kısmı 10$'dan büyük olan faturaların bütün bilgilerini göster */
SELECT * 
FROM invoices 
WHERE total>10; 

/*============================================================================
                            LIMIT 
=============================================================================*/
-- Kaç satır çıktı vermesini istiyorsak onu LIMIT  ile sınırlandırırız
-- WHERE sütun isminden sonra LIMIT 4 yaparsak en üstteki 4 satırı verir

/*invoices tablosunda Total değeri 10$'dan büyük olan ilk 4 kayıt'ın InvoiceId, 
	InvoiceDate ve total bilgilerini sorgulayiniz */
SELECT InvoiceId, InvoiceDate, total
FROM invoices
WHERE total > 10
LIMIT 4;

/*============================================================================
                            ORDER BY 
=============================================================================*/
--Bir attributun özelliğinin artan ASC veya azalan DESC olmasına göre sıralar
--ASC ve DESC olarak belirtmezsek default olarak ASC şeklinde sıralar
--Genel syntax "SELECT * FROM table ORDER BY attribute ASC(DESC);"
--ORDER BY ı WHERE ile de kullanabiliriz. Ama ORDER BY WHERE den sonra gelmeli

/*invoices tablosunda Total değeri 10$'dan büyük olan kayıtları Total değerine göre 
	ARTAN sırada sıralayarak sorgulayiniz */

SELECT *
FROM invoices
WHERE total>10
ORDER BY total;

/*invoices tablosunda Total değeri 10$'dan büyük olan kayıtlardan işlem tarihi 
	(InvoiceDate) 	en yeni olan 10 kaydın tüm bilgilerini listeyiniz */ 
SELECT *
FROM invoices
WHERE total>10
ORDER BY InvoiceDate DESC
LIMIT 10 ;

/*============================================================================
                        ***** LOGİCAL OPERATORS *****
						      AND, OR, NOT	
=============================================================================*/
-- Birden fazla sorguyu birleştirmek için kullanılır
/*=====     AND     =====*/
--Birden fazla şartı hepsini taşıyan rowları çıkarır 
--python daki and in aynısı
SELECT *
FROM employees
WHERE Title = 'Data_Scientist' and Gender = 'Male';
--Yukarıda erkek olan data scientistlerin olduğu rowları döndürür

/*=====     OR     =====*/
--Birden fazla şartlardan birnii taşıyan rowları çıkarır 
--python daki or in aynısı
SELECT *
FROM employees
WHERE Title = 'Data_Scientist' or Gender = 'Male';
--Yukarıda erkek olanları veya  data scientistlerin olduğu rowları döndürür

/*=====     NOT     =====*/
--O şartı sağlamayantaşıyan rowları çıkarır 
--python daki not in aynısı
SELECT *
FROM employees
WHERE NOT Gender = 'Male';
--Yukarıda cinsiyeti erkek olmayanların olduğu rowları döndürür

/* invoices tablosunda ülkesi (BillingCountry) USA olmayan kayıtları total değerine
	göre  AZALAN sırada listeyiniz */ 
SELECT *
FROM invoices
WHERE NOT BillingCountry = 'USA'  -- WHERE BillingCountry <> 'USA' de aynı işi görüyor 
ORDER BY total DESC;

/* invoices tablosunda, ülkesi (BillingCountry) USA veya Germany olan kayıtları, 
	InvoiceId sırasına göre artan sırada listeyiniz */ 
SELECT *
FROM invoices
WHERE BillingCountry = 'USA' or BillingCountry = 'Germany'
ORDER BY InvoiceId ASC;


	/* invoices tablosunda fatura tarihi (InvoiceDate) 01-01-2012 ile 03-01-2012 
	tarihleri arasındaki faturaların tüm bilgilerini listeleyiniz */ 
SELECT *
FROM invoices
WHERE InvoiceDate >= '2012-01-01' AND InvoiceDate <= '2013-01-02 00:00:00';
-- Tarih için yapılan query lerde ÖNCE YIL SONRA AY SONRA GÜN YAZILMASI şart. 
--'Yani YYYY-MM-DD' şeklinde yazılması lazım
--Saati yazmaz ise 2013-01-02 yi içeren satırı almadı. O yazden ona saati de ekledik. BU ÖNEMLİ 
-- Her sıralmaadan sonra Brows Data kısmından kontrol et 

/*=====     BETWEEN OPERATOR     =====*/
-- AND kullanıp ayrı ayrı hem büyüktür hem küçüktür yazmak yerine
--Daha kısa yazmak ve daha okunabilir olması için BETWEEN kullanabiliriz
--BETWEEN hem alt sınırı hem üst sınırı DAHİL eder 

/*=====     NOT BETWEEN     =====*/
-- Belirli bir aralık arasında olmayan rowları getirir 
--Syntax: WHERE 

/* invoices tablosunda fatura tarihi (InvoiceDate) 2009 ila 2011 tarihleri arasındaki
	en yeni faturayı listeleyen sorguyu yazınız */ 
SELECT *
FROM invoices
WHERE InvoiceDate BETWEEN '2009-01-01' AND '2011-12-31'
ORDER BY InvoiceDate DESC
LIMIT 1;

/*=====     IN OPERATOR     =====*/
--Seçenekler listesinde istediğimiz seçenek varsa o row u çıkarıyor
--IN, OR vazifesini görürken BETWEEN, AND gibi çalışıyor 
--Syntax: 
--SELECT * FROM employees WHERE job_title IN ('Operation Directors','HR Manager','Sales Manager');
-- IN deki liste içerisinde karakterler arasında (virgülden sora) boşluk olursa hata veriyor
--NOT IN de kullanılabilir

SELECT FirstName, LastName, country
FROM customers
WHERE country IN('Belgium','Norway','USA','Canada');

/*============================================================================
                              LIKE OPERATORS (%, _) 
=============================================================================*/
-- İfadenin bir kısmını biliyor diğerini bilmiyorsak bunları kullanabiliriz
-- % birden çok karakteri ifade ederken, _ bir karakteri ifade ediyor
-- 'At%' yazarsak At ile başlayan hücrelerin uzunlukları bakmadan gösterir
-- '%an%' şeklinde olunca başı sonu fark etmeksizin (farklı uzunluklarda olabilir) için 'an' geçenleri verir
-- '__al_' ı ararsak 5 karakterli olup 3. ve 4. karakteri 'al' olan (1.,2.,3. karakterinin ne olduğu..
--..fark etmeksizin) karakterleri verir


SELECT name, Composer
FROM tracks
WHERE Composer LIKE '%Bach'; 


/* albulms tablosunda Title (başlık) sutununda Greatest içeren kayıtların tüm bilgilerini 
	listeyen sorguyu yazınız*/
SELECT *
FROM albums
WHERE Title LIKE '%Greatest%';

/* invoices tablosunda, 2010 ve 2019 arası bir tarihte (InvoiceDate) Sadece şubat
	aylarında gerçekleşmiş olan faturaların	tüm bilgilerini listeleyen sorguyu yazınız*/
SELECT *
FROM invoices
WHERE InvoiceDate LIKE'201_-02%';



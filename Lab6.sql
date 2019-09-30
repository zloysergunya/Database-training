/*Вывести наименования товаров, количество которых на складе максимально (на
складе должно быть как минимум два товара, количество которых одинаково и
равно максимальному).*/
SELECT Goods.name AS [Максимальное количество товаров] FROM Goods
	WHERE Goods.id IN
		(SELECT Warehouse.id_Goods FROM Warehouse 
				WHERE Warehouse.Count = (SELECT max(Warehouse.count) FROM Warehouse));

/*Вывести в порядке, обратном алфавитному, наименования товаров, количество
которых на складе находится в заданном диапазоне*/
SELECT Goods.name AS [Обратный алфавитный порядок товаров] FROM Goods
	WHERE Goods.id IN
		(SELECT Warehouse.id_Goods FROM Warehouse
			WHERE Warehouse.Count BETWEEN 50 and 200) 
	ORDER BY Goods.name DESC;

/*Вывести поставщиков, которые хотя бы раз осуществили поставку, в алфавитном
порядке*/
SELECT * FROM Supplier 
	WHERE Supplier.id IN
		(SELECT Warehouse.id_Supplier FROM Warehouse) 
	ORDER BY Supplier.name ASC;

/*30 дней с даты последней покупки действует дополнительная скидка на все товары.
Вывести список покупателей, имеющих возможность воспользоваться указанной
скидкой.*/
SELECT * FROM Client
	WHERE Client.id IN
		(SELECT Deal.id_Client FROM Deal 
			WHERE DATEDIFF(dd, Deal.Date, getdate()) <= 30);

/*Вывести список товаров, названия которых начинающиеся с букв «д» и «л»,
стоимость которых не более 20% от максимальной*/
SELECT * FROM Goods
	WHERE Goods.name like '[АС]%' and (Goods.id IN 
		(SELECT Warehouse.id_Goods FROM Warehouse
			WHERE Warehouse.Price <= (SELECT max(Warehouse.Price)*0.23 FROM Warehouse)));

/*Вывести поставщиков, которые не поставляют товары, названия которых
начинающиеся с букв «д» и «л».*/
SELECT * FROM Supplier
	WHERE Supplier.id NOT IN 
		(SELECT Warehouse.id_Supplier FROM Warehouse 
			WHERE Warehouse.id_Goods IN
				(SELECT Goods.id FROM Goods 
					WHERE Goods.name like '[ВГ]%'));

/*Показать список клиентов с указанием их пола («мужчина» или «женщина»)*/
SELECT *,
	CASE 
		WHEN Client.gender = 'м' THEN 'Мужской'
		WHEN Client.gender = 'ж' THEN 'Женский'
	END AS [Пол]
	FROM Client;

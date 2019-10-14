-- Показать какой поставщик поставил каждый товар на склад (INNER JOIN).
SELECT Goods.name AS [Наименование товара], Supplier.name AS [Компания-поставщик]
	FROM Goods INNER JOIN Warehouse
		ON Warehouse.id_Goods =	Goods.id
		INNER JOIN Supplier
		ON Supplier.id = Warehouse.id_Supplier;

-- Вывести список товаров, которыми торгует фирма, и их поставщиков вне зависимости от наличия поставок (LEFT JOIN).SELECT Goods.name AS [Наименование товара], Supplier.name AS [Компания-поставщик], Warehouse.Count AS [Количество]	FROM Goods LEFT JOIN Warehouse		ON Warehouse.id_Goods =	Goods.id		LEFT JOIN Supplier		ON Supplier.id = Warehouse.id_Supplier;/*Вывести информацию о покупаемых со склада товарах и их покупателях, включая
товары, отсутствующие в списке реализованных товаров (RIGHT JOIN).*/
SELECT g.name AS [Наименование товара], ISNULL(c.name, 'Не определён') AS [Имя клиента], 
	ISNULL(CAST(d.Count AS CHAR(15)), 'Не продавалcя') AS [Количество товара]
	FROM Client c RIGHT JOIN Deal d
		ON c.id = d.id_Client
		RIGHT JOIN Warehouse w
		ON w.id = d.id_Warehouse
		RIGHT JOIN Goods g
		ON w.id_Goods = g.id;

/*Вывести список поставщиков, которые хотя бы раз осуществляли поставку на склад (полусоединение).*/
SELECT Supplier.name AS [Компания-поставщик]
	FROM Supplier JOIN Warehouse
		ON Supplier.id = Warehouse.id_Supplier;

/*Выведите список сотрудников с указанием их прямых начальников (самосоединение). 
Для главного начальника в столбец «Начальник» вывести «не определен».*/
SELECT w2.name AS [Работник], ISNULL(w1.name, 'Не определён') AS [Начальник]
	FROM Worker w1 RIGHT JOIN Worker w2
		ON w1.id = w2.id_Head;
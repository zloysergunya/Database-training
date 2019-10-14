/*Провести оценку количества товара на складе по наименованиям: менее 10 – мало,
от 10 до 100 – достаточно, более 100 – избыточно.*/
SELECT g.name AS [Название товара], SUM(w.Count) AS [Количество товара], CASE 
	WHEN SUM(w.Count) > 0 and SUM(w.Count) < 10 
		THEN 'Мало'
	WHEN SUM(w.Count) BETWEEN 10 AND 100 
		THEN 'Достаточно'
	ELSE 'Много' END  AS [Оценка количества товара]
FROM Warehouse w JOIN Goods g ON w.id_Goods = g.id 
	GROUP BY g.name;

/*Вывести наименования товаров, количество которых на складе от 1 до 10.*/
SELECT g.name AS [Название товара], SUM(w.Count) AS [Количество товара]
FROM Warehouse w JOIN Goods g ON w.id_Goods = g.id 
	GROUP BY g.name 
	HAVING SUM(w.Count) < 10;

/*Определить тройку товаров, выручка за которые самая большая.*/
SELECT top 3 g.name AS [Название товара], SUM(d.Count * w.Price) AS [Выручка]
FROM Warehouse w JOIN Goods g ON w.id_Goods = g.id 
	JOIN Deal d ON w.id = d.id_Warehouse
	GROUP BY g.name
	ORDER BY [Выручка] DESC;

/*Определить суммарную стоимость продаж каждого товара по месяцам.*/
SELECT g.name AS [Название товара], DATEPART(YEAR, d.Date) AS [Год], DATENAME(MONTH, d.Date) AS [Месяц], SUM(d.Count * w.Price) AS [Cуммарная стоимость продаж]
FROM Goods g JOIN Warehouse w ON g.id = w.id_Goods
	JOIN Deal d ON d.id_Warehouse = w.id
	GROUP BY g.name, DATEPART(YEAR, d.Date), DATENAME(MONTH, d.Date)
	ORDER BY [Cуммарная стоимость продаж] DESC;

/*Показать месяца, в которых продажи Молока 3,2% (или любого другого товара,
хранящегося на складе с разными ID) были ниже 300 денег.*/
SELECT g.name AS [Название товара], DATEPART(YEAR, d.Date) AS [Год], DATENAME(MONTH, d.Date) AS [Месяц], SUM(d.Count * w.Price) AS [Cуммарная стоимость продаж]
FROM Goods g JOIN Warehouse w ON g.id = w.id_Goods
	JOIN Deal d ON d.id_Warehouse = w.id
	WHERE g.id = 2
	GROUP BY g.name, DATEPART(YEAR, d.Date), DATENAME(MONTH, d.Date)
	HAVING SUM(d.Count * w.Price) > 300
	ORDER BY [Cуммарная стоимость продаж] DESC;
-- Вывести количество сделок, зафиксированных в БД.
SELECT COUNT(*) AS [Count Deal]
	FROM Deal;

-- Определить среднее арифметическое значение количества товаров на складе.
SELECT AVG(Warehouse.Count) AS [AVG Count Goods]
	FROM Warehouse;

-- Определить общее количество товаров на складе.
SELECT SUM(Warehouse.Count) AS [SUM Count Goods]
	FROM Warehouse;

-- Определить максимальное количество товаров на складе.
SELECT MAX(Warehouse.Count) AS [Max Count Goods]
	FROM Warehouse;

-- Вывести значение косинуса для угла 60º
SELECT COS(RADIANS(60.0)) AS COS;

-- Получить целое случайное число в диапазоне (-7; 2)
SELECT ROUND((RAND()*(-6 - 1) + 1), 0) AS RAND;

-- Определить (вывести в виде числа от 1 до 7) текущий день недели
SELECT DATEPART(DW, GETDATE()) [Index Day today];

-- Сортировать поставщиков в алфавитном (обратном) порядке.
SELECT * 
	FROM Supplier
		ORDER BY Supplier.name DESC;

-- Вывести поставщика(ов) с самым длинным названием.
SELECT * 
	FROM Supplier
		WHERE len(Supplier.name) = (SELECT max(len(Supplier.name)) FROM Supplier);

-- Вывести всех покупателей с фамилией, начинающейся на букву «В».SELECT *
	FROM Client
		WHERE Client.name LIKE 'С%';

-- Вывести всех покупателей с фамилией, начинающейся с букв в диапазоне от "В" до "К", где вторая буква «о».
SELECT *
	FROM Client
		WHERE Client.surname like '[В-У]о%';

-- Определите количество сделок за текущий календарный месяц
SELECT COUNT(id) AS [Количество сделок за текущий календарный месяц]
	FROM Deal
		WHERE YEAR(Deal.Date) = YEAR(GETDATE()) and MONTH(Deal.Date) = MONTH(GETDATE());

-- Определите количество сделок, зафиксированных в заданные дни недели (например, по вторникам и средам).
SELECT COUNT(id) AS [Количество сделок, зафиксированных в заданные дни недели]
	FROM Deal
		WHERE DATEPART(DW, Deal.Date) IN (1, 5)
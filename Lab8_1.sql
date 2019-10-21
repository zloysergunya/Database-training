/*Ранжируйте сотрудников по объемам продаж и выведите тройку лидеров.*/
SELECT top 3 wr.name [Имя сотрудника], SUM(d.Count * w.Price) [Объём продаж], RANK() over(ORDER BY(SUM(d.Count * w.Price)) DESC) [Место]
	FROM Worker wr JOIN Deal d 
		ON wr.id = d.id_Worker
		JOIN Warehouse w
		ON w.id = d.id_Warehouse
	GROUP BY wr.name;

/*Вывести суммы сделок по месяцам для каждого сотрудника и показать разницу с
предыдущим месяцем, в котором были зафиксированы сделки.*/
SELECT wr.name, DATEPART(YEAR, d.Date) AS [Год], 
				DATENAME(MONTH, d.Date) AS [Месяц], 
				SUM(d.Count * w.Price) [Сумма],	
				SUM(d.Count * w.Price)-(LAG(SUM(d.Count * w.Price), 1, 0) OVER(PARTITION BY w.name ORDER BY w.name, 
					DATEPART(YEAR, d.Date), 
					DATENAME(MONTH, d.Date))) AS [Разница]
FROM Worker wr JOIN Deal d ON wr.id = d.id_Worker
	JOIN Warehouse w ON d.id_Warehouse = w.id
	GROUP BY wr.name, DATEPART(YEAR, d.Date), DATENAME(MONTH, d.Date);
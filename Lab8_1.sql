/*���������� ����������� �� ������� ������ � �������� ������ �������.*/
SELECT top 3 wr.name [��� ����������], SUM(d.Count * w.Price) [����� ������], RANK() over(ORDER BY(SUM(d.Count * w.Price)) DESC) [�����]
	FROM Worker wr JOIN Deal d 
		ON wr.id = d.id_Worker
		JOIN Warehouse w
		ON w.id = d.id_Warehouse
	GROUP BY wr.name;

/*������� ����� ������ �� ������� ��� ������� ���������� � �������� ������� �
���������� �������, � ������� ���� ������������� ������.*/
SELECT wr.name, DATEPART(YEAR, d.Date) AS [���], 
				DATENAME(MONTH, d.Date) AS [�����], 
				SUM(d.Count * w.Price) [�����],	
				SUM(d.Count * w.Price)-(LAG(SUM(d.Count * w.Price), 1, 0) OVER(PARTITION BY w.name ORDER BY w.name, 
					DATEPART(YEAR, d.Date), 
					DATENAME(MONTH, d.Date))) AS [�������]
FROM Worker wr JOIN Deal d ON wr.id = d.id_Worker
	JOIN Warehouse w ON d.id_Warehouse = w.id
	GROUP BY wr.name, DATEPART(YEAR, d.Date), DATENAME(MONTH, d.Date);
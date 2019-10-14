/*�������� ������ ���������� ������ �� ������ �� �������������: ����� 10 � ����,
�� 10 �� 100 � ����������, ����� 100 � ���������.*/
SELECT g.name AS [�������� ������], SUM(w.Count) AS [���������� ������], CASE 
	WHEN SUM(w.Count) > 0 and SUM(w.Count) < 10 
		THEN '����'
	WHEN SUM(w.Count) BETWEEN 10 AND 100 
		THEN '����������'
	ELSE '�����' END  AS [������ ���������� ������]
FROM Warehouse w JOIN Goods g ON w.id_Goods = g.id 
	GROUP BY g.name;

/*������� ������������ �������, ���������� ������� �� ������ �� 1 �� 10.*/
SELECT g.name AS [�������� ������], SUM(w.Count) AS [���������� ������]
FROM Warehouse w JOIN Goods g ON w.id_Goods = g.id 
	GROUP BY g.name 
	HAVING SUM(w.Count) < 10;

/*���������� ������ �������, ������� �� ������� ����� �������.*/
SELECT top 3 g.name AS [�������� ������], SUM(d.Count * w.Price) AS [�������]
FROM Warehouse w JOIN Goods g ON w.id_Goods = g.id 
	JOIN Deal d ON w.id = d.id_Warehouse
	GROUP BY g.name
	ORDER BY [�������] DESC;

/*���������� ��������� ��������� ������ ������� ������ �� �������.*/
SELECT g.name AS [�������� ������], DATEPART(YEAR, d.Date) AS [���], DATENAME(MONTH, d.Date) AS [�����], SUM(d.Count * w.Price) AS [C�������� ��������� ������]
FROM Goods g JOIN Warehouse w ON g.id = w.id_Goods
	JOIN Deal d ON d.id_Warehouse = w.id
	GROUP BY g.name, DATEPART(YEAR, d.Date), DATENAME(MONTH, d.Date)
	ORDER BY [C�������� ��������� ������] DESC;

/*�������� ������, � ������� ������� ������ 3,2% (��� ������ ������� ������,
����������� �� ������ � ������� ID) ���� ���� 300 �����.*/
SELECT g.name AS [�������� ������], DATEPART(YEAR, d.Date) AS [���], DATENAME(MONTH, d.Date) AS [�����], SUM(d.Count * w.Price) AS [C�������� ��������� ������]
FROM Goods g JOIN Warehouse w ON g.id = w.id_Goods
	JOIN Deal d ON d.id_Warehouse = w.id
	WHERE g.id = 2
	GROUP BY g.name, DATEPART(YEAR, d.Date), DATENAME(MONTH, d.Date)
	HAVING SUM(d.Count * w.Price) > 300
	ORDER BY [C�������� ��������� ������] DESC;
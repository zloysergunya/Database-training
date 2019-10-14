-- �������� ����� ��������� �������� ������ ����� �� ����� (INNER JOIN).
SELECT Goods.name AS [������������ ������], Supplier.name AS [��������-���������]
	FROM Goods INNER JOIN Warehouse
		ON Warehouse.id_Goods =	Goods.id
		INNER JOIN Supplier
		ON Supplier.id = Warehouse.id_Supplier;

-- ������� ������ �������, �������� ������� �����, � �� ����������� ��� ����������� �� ������� �������� (LEFT JOIN).SELECT Goods.name AS [������������ ������], Supplier.name AS [��������-���������], Warehouse.Count AS [����������]	FROM Goods LEFT JOIN Warehouse		ON Warehouse.id_Goods =	Goods.id		LEFT JOIN Supplier		ON Supplier.id = Warehouse.id_Supplier;/*������� ���������� � ���������� �� ������ ������� � �� �����������, �������
������, ������������� � ������ ������������� ������� (RIGHT JOIN).*/
SELECT g.name AS [������������ ������], ISNULL(c.name, '�� ��������') AS [��� �������], 
	ISNULL(CAST(d.Count AS CHAR(15)), '�� ��������c�') AS [���������� ������]
	FROM Client c RIGHT JOIN Deal d
		ON c.id = d.id_Client
		RIGHT JOIN Warehouse w
		ON w.id = d.id_Warehouse
		RIGHT JOIN Goods g
		ON w.id_Goods = g.id;

/*������� ������ �����������, ������� ���� �� ��� ������������ �������� �� ����� (��������������).*/
SELECT Supplier.name AS [��������-���������]
	FROM Supplier JOIN Warehouse
		ON Supplier.id = Warehouse.id_Supplier;

/*�������� ������ ����������� � ��������� �� ������ ����������� (��������������). 
��� �������� ���������� � ������� ���������� ������� ��� ���������.*/
SELECT w2.name AS [��������], ISNULL(w1.name, '�� ��������') AS [���������]
	FROM Worker w1 RIGHT JOIN Worker w2
		ON w1.id = w2.id_Head;
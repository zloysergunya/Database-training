-- ����������� ����������� � ���������� (��������) �������.
SELECT * 
	FROM Supplier
		ORDER BY Supplier.name DESC;

-- ������� ����������(��) � ����� ������� ���������.
SELECT * 
	FROM Supplier
		WHERE len(Supplier.name) = (SELECT max(len(Supplier.name)) FROM Supplier);

-- ������� ���� ����������� � ��������, ������������ �� ����� �».SELECT *
	FROM Client
		WHERE Client.name LIKE '�%';

-- ������� ���� ����������� � ��������, ������������ � ���� � ��������� �� "�" �� "�", ��� ������ ����� ��.
SELECT *
	FROM Client
		WHERE Client.surname like '[�-�]�%';

-- ���������� ���������� ������ �� ������� ����������� �����
SELECT COUNT(id) AS [���������� ������ �� ������� ����������� �����]
	FROM Deal
		WHERE YEAR(Deal.Date) = YEAR(GETDATE()) and MONTH(Deal.Date) = MONTH(GETDATE());

-- ���������� ���������� ������, ��������������� � �������� ��� ������ (��������, �� ��������� � ������).
SELECT COUNT(id) AS [���������� ������, ��������������� � �������� ��� ������]
	FROM Deal
		WHERE DATEPART(DW, Deal.Date) IN (1, 5)
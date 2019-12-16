USE Decanate;
Go

/*����� �����*/
CREATE VIEW Groupss AS 
	SELECT groups.id as [id ������], disciplines.semestr as [�������], COUNT(disciplines.id) AS [���������� ���������] 
		FROM disciplines
			INNER JOIN Groups ON Disciplines.spec = Groups.id_Specialty
			GROUP BY Groups.id, disciplines.semestr
GO

SELECT * FROM Groupss
GO

/*������� ���������� ������*/
CREATE VIEW Scores AS 
	SELECT Students.lastName AS [�������], Students.firstName AS [���], Students.middleName AS [��������], Students.group_id [id ������], semestr AS [�������], COUNT(score) AS [���������� ������]
	FROM Studing
		JOIN Students ON Studing.num_zach = Students.num_zach AND (Studing.score ='���' OR Studing.score ='���')
		JOIN Disciplines ON Studing.id_disc = Disciplines.id
	GROUP BY Students.lastName, Students.firstName, Students.middleName, Students.group_id, semestr
GO

SELECT * FROM Scores
GO

/*����� ����������*/
CREATE VIEW Honours_pupils AS 
	SELECT Scores.�������, Scores.���, Scores.��������, Groupss.[id ������], Groupss.�������
		FROM Groupss 
			INNER JOIN Scores ON Scores.[id ������] = Groupss.[id ������]
			WHERE Groupss.������� = Scores.������� AND Scores.[���������� ������] = Groupss.[���������� ���������]
GO

SELECT * FROM Honours_pupils
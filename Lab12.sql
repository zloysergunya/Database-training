USE Decanate;
Go

/*Выбор групп*/
CREATE VIEW Groupss AS 
	SELECT groups.id as [id Группы], disciplines.semestr as [Семестр], COUNT(disciplines.id) AS [Количество дисциплин] 
		FROM disciplines
			INNER JOIN Groups ON Disciplines.spec = Groups.id_Specialty
			GROUP BY Groups.id, disciplines.semestr
GO

SELECT * FROM Groupss
GO

/*Подсчет количества оценок*/
CREATE VIEW Scores AS 
	SELECT Students.lastName AS [Фамилия], Students.firstName AS [Имя], Students.middleName AS [Отчество], Students.group_id [id Группы], semestr AS [Семестр], COUNT(score) AS [Количество оценок]
	FROM Studing
		JOIN Students ON Studing.num_zach = Students.num_zach AND (Studing.score ='Отл' OR Studing.score ='Зач')
		JOIN Disciplines ON Studing.id_disc = Disciplines.id
	GROUP BY Students.lastName, Students.firstName, Students.middleName, Students.group_id, semestr
GO

SELECT * FROM Scores
GO

/*Выбор отличников*/
CREATE VIEW Honours_pupils AS 
	SELECT Scores.Фамилия, Scores.Имя, Scores.Отчество, Groupss.[id Группы], Groupss.Семестр
		FROM Groupss 
			INNER JOIN Scores ON Scores.[id Группы] = Groupss.[id Группы]
			WHERE Groupss.Семестр = Scores.Семестр AND Scores.[Количество оценок] = Groupss.[Количество дисциплин]
GO

SELECT * FROM Honours_pupils
USE Decanate;

/*Создать функцию, определяющую средний бал по указанной дисциплине.
Принимая идентификатор дисциплины, как входной параметр (например,
ID_Disciplin), функция возвращает вещественное значение среднего балла среди
всех студентов, сдававших экзамен.*/
IF OBJECT_ID ('Average_score', N'FN') IS NOT NULL  
    DROP FUNCTION Average_score;
GO

CREATE FUNCTION Average_score (@dc_id INT)
RETURNS float(20)
	BEGIN
		DECLARE @quantity_five REAL, 
		@quantity_four REAL, 
		@quantity_three REAL, 
		@quantity_two REAL, 
		@mark nvarchar(5)

		SET @quantity_five = 0;
		SET @quantity_four = 0;
		SET @quantity_three = 0;
		SET @quantity_two = 0;

		DECLARE i CURSOR FOR SELECT Studing.score FROM Studing WHERE Studing.id_disc = @dc_id

		OPEN i 
		FETCH NEXT FROM i INTO @mark
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF (@mark = N'Отл') SET @quantity_five = @quantity_five + 1;
			IF (@mark = N'Хор') SET @quantity_four = @quantity_four + 1;
			IF (@mark = N'Уд') SET @quantity_three = @quantity_three + 1;
			IF (@mark = N'Неуд') SET @quantity_two = @quantity_two + 1;
			FETCH NEXT FROM i INTO @mark
		END 
		CLOSE i

		DEALLOCATE i

		RETURN (((5 * @quantity_five) + (4 * @quantity_four) + (3 * @quantity_three) + (2 * @quantity_two)) / (@quantity_five + @quantity_four + @quantity_three + @quantity_two))
END;

GO
SELECT dbo.Average_score(5) as [Среднее значение];

/*Создать процедуру, формирующую список зачетов и экзаменов, которые
необходимо сдать студентам указанной группы в указанный семестр (входные
параметры – группа и семестр).*/
IF OBJECT_ID('Session', 'P') IS NOT NULL  
    DROP PROCEDURE Session;  
GO

CREATE PROCEDURE Session @id_group INT, @semestr INT
AS  
	SELECT d.nameOfDisciplines as [Название дисциплины], d.accountability as [Тип отчётности]
	FROM Disciplines d
	WHERE (@semestr = d.semestr) 
		AND (d.spec = (SELECT Groups.id_Specialty	
							FROM Groups
								WHERE id = @id_group)) ORDER BY d.accountability DESC;
RETURN
GO

EXECUTE Session 5, 2;
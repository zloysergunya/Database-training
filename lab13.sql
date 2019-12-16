USE Decanate;

/*При удалении некоторой дисциплины, триггер не дает удалить дисциплины, по
которым хотя бы один человек получил экзамен (зачет).*/
IF OBJECT_ID('discDelete', 'TRIGGER') IS NOT NULL  
    DROP TRIGGER discDelete;  
GO

CREATE TRIGGER discDelete 
	ON Disciplines INSTEAD OF DELETE 
	AS IF (SELECT count(Studing.id_disc)
		From Studing
			Where Studing.id_disc IN (SELECT id From deleted)) <> 0
		BEGIN
			ROLLBACK TRAN
			PRINT N'Ошибка! Эту дисциплину удалить нельзя!'
		END 
GO

DELETE FROM disciplines	
	WHERE id = 25;
GO

/*Назначить нового старосту в некоторую группу. Если назначаемый на должность
старосты студент не состоит в этой группе, следует отменить транзакцию.*/
IF OBJECT_ID('updMonitor', 'TRIGGER') IS NOT NULL  
    DROP TRIGGER updMonitor;  
GO

CREATE TRIGGER updMonitor
	ON Groups
		FOR UPDATE
			AS BEGIN
				IF (SELECT Inserted.monitor FROM Inserted) NOT IN
					(SELECT Students.num_zach
						FROM Students
							WHERE Students.group_id in (SELECT Inserted.id FROM Inserted))
				BEGIN
					ROLLBACK TRAN
					PRINT N'Ошибка! Студент не состоит в данной группе!'
				END
			END

GO

UPDATE Groups
SET Groups.monitor = 180611
WHERE Groups.id = 5
GO

/*Не позволить добавить информацию о сданном экзамене (или зачете), если
дисциплина не соответствует специальности студента.*/
IF OBJECT_ID('insStuding', 'TRIGGER') IS NOT NULL  
    DROP TRIGGER insStuding;  
GO

CREATE TRIGGER insStuding
	ON Studing
	FOR INSERT
	AS 
	BEGIN
		DECLARE @zachetka INT
		SELECT @zachetka = (SELECT num_zach FROM Inserted)
		IF (SELECT d.spec 
				FROM Disciplines d
				JOIN Inserted i ON i.id_disc = d.id) <>
			(SELECT g.id_Specialty
				FROM Groups g
					WHERE g.id = (SELECT s.group_id 
									FROM Students s 
									JOIN Inserted i ON s.num_zach = i.num_zach))
		BEGIN
			ROLLBACK TRAN
			PRINT N'Ошибка! Данному студенту нельзя добавить эту дисциплину!'
		END
	 END

GO

INSERT Studing
	VALUES (180646, 1, '2018-12-29', N'Хор');
GO

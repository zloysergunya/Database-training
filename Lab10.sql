use Decanate;
	
INSERT Groups
	VALUES (N' »18-01¡', 2, 0, 0);

UPDATE Students
	SET group_id = 5 WHERE group_id = 4;

UPDATE Groups
	SET monitor = (SELECT monitor FROM Groups WHERE id = 4),
		curator = (SELECT curator FROM Groups WHERE id = 4)
	WHERE Groups.id = 5;

UPDATE Disciplines
	SET spec = 2 WHERE spec = 4;

DELETE FROM Groups
	WHERE id = 4;
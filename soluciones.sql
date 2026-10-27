CREATE TABLE Imagenes (
id INT PRIMARY KEY AUTO_INCREMENT,
productoId INT NOT NULL,
url VARCHAR(255) NOT NULL,
esPrincipal BOOLEAN,
fechaSubida DATE DEFAULT CURDATE(),
FOREIGN KEY (productoId) REFERENCES Productos(id)
ON UPDATE CASCADE
ON DELETE CASCADE
);


-- consulta

SELECT
p.nombre AS Producto,
COUNT(i.id) AS total_fotos
FROM Productos p
LEFT JOIN Imagenes i ON i.productoId = p.id
GROUP BY p.id, p.nombre
HAVING total_fotos < 3
ORDER BY total_fotos ASC;


-- trigger

DELIMITER //

CREATE TRIGGER tg_validacion_fotos
BEFORE INSERT ON Imagenes
FOR EACH ROW
BEGIN
DECLARE total_fotos INT;

SELECT COUNT(*) INTO total_fotos
FROM Imagenes
WHERE productoId = NEW.productoId;

IF total_fotos >= 5 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Error: Máximo de 5 fotos alcanzado.';
END IF;

END //

DELIMITER ;

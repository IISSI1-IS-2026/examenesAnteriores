CREATE TABLE Imagen (
id INT PRIMARY KEY AUTO_INCREMENT,
productoId INT NOT NULL,
url VARCHAR(255) NOT NULL,
esPrincipal BOOLEAN,
fechaSubida DATE DEFAULT CURDATE(),
FOREIGN KEY (productoId) REFERENCES Producto(id)
ON UPDATE CASCADE
ON DELETE CASCADE
);


-- consulta

SELECT
p.nombre AS Producto,
COUNT(i.id) AS total_fotos
FROM Producto p
LEFT JOIN Imagen i ON i.id = p.id
GROUP BY p.id, p.nombre
HAVING total_fotos < 3
ORDER BY total_fotos ASC;


-- trigger

DELIMITER //

CREATE TRIGGER tg_validacion_fotos
BEFORE INSERT ON Imagen
FOR EACH ROW
BEGIN
DECLARE total_fotos INT;
DECLARE desc_producto TEXT;

SELECT COUNT(*) INTO total_fotos
FROM Imagen
WHERE productoId = NEW.productoId;

IF total_fotos >= 5 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Error: Máximo de 5 fotos alcanzado.';
END IF;

IF NEW.esPrincipal = TRUE THEN
  UPDATE Imagen SET esPrincipal=FALSE where productoId=NEW.productoId;


END //

DELIMITER ;

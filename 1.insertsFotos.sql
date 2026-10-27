-- ======================================================================
-- Datos de prueba para la tabla de imágenes/fotos del Ejercicio 1
-- ======================================================================
-- Se asume una tabla "Imagenes" con columnas:
--   id INT PRIMARY KEY AUTO_INCREMENT,
--   productoId INT NOT NULL,
--   url VARCHAR(255) NOT NULL,
--   esPrincipal BOOLEAN,
--   fechaSubida DATE  (opcional, puede ser NULL)
--
-- Ejecuta este script DESPUÉS de 0.creacionTablas.sql, 0.poblarBd.sql
-- y de haber creado tu propia tabla Imagenes (Ejercicio 1).
--
-- Recordatorio de productos (ver 0.poblarBd.sql):
--  1 Smartphone        (Físico)     6 Curso Online        (Digital)
--  2 Laptop             (Físico)     7 Película             (Digital)
--  3 Libro Electrónico  (Digital)    8 Audífonos            (Físico)
--  4 Videojuego         (Digital)    9 Tableta Gráfica      (Físico)
--  5 Camiseta           (Físico)    10 Documental           (Digital)
-- ======================================================================

-- ----------------------------------------------------------------------
-- BLOQUE 1: productos con 1 o 2 fotos  -> para el Ejercicio 2 (<3 fotos)
-- ----------------------------------------------------------------------
-- Producto 9 (Tableta Gráfica): 1 foto
INSERT INTO Imagenes (productoId, url, esPrincipal, fechaSubida) VALUES
(9, '/img/tableta-grafica/01.jpg', TRUE, '2024-01-10');

-- Producto 7 (Película, Digital): 1 foto, sin fecha (campo opcional -> NULL)
INSERT INTO Imagenes (productoId, url, esPrincipal, fechaSubida) VALUES
(7, '/img/pelicula/portada.jpg', TRUE, NULL);

-- Producto 4 (Videojuego, Digital): 2 fotos
INSERT INTO Imagenes (productoId, url, esPrincipal, fechaSubida) VALUES
(4, '/img/videojuego/01.jpg', TRUE, '2024-02-01'),
(4, '/img/videojuego/02.jpg', FALSE, '2024-02-05');

-- Producto 6 (Curso Online, Digital): 2 fotos
INSERT INTO Imagenes (productoId, url, esPrincipal, fechaSubida) VALUES
(6, '/img/curso-online/01.jpg', TRUE, '2024-03-01'),
(6, '/img/curso-online/02.jpg', FALSE, '2024-03-15');

-- Productos 5 (Camiseta) y 10 (Documental) se dejan A PROPÓSITO sin
-- ninguna fila insertada -> deben aparecer con 0 fotos en el Ejercicio 2
-- (comprueba que tu consulta usa LEFT JOIN, si no, no aparecerán).

-- ----------------------------------------------------------------------
-- BLOQUE 2: productos con 3, 4 o 5 fotos -> deben QUEDAR FUERA del
-- resultado del Ejercicio 2, y sirven para el límite de 5 fotos y para
-- la fecha de última foto en productos Digitales (otroejercicio.md)
-- ----------------------------------------------------------------------
-- Producto 1 (Smartphone, Físico): 3 fotos
INSERT INTO Imagenes (productoId, url, esPrincipal, fechaSubida) VALUES
(1, '/img/smartphone/frontal.jpg', TRUE, '2024-01-05'),
(1, '/img/smartphone/trasera.jpg', FALSE, '2024-01-06'),
(1, '/img/smartphone/lateral.jpg', FALSE, '2024-01-07');

-- Producto 8 (Audífonos, Físico): 3 fotos
INSERT INTO Imagenes (productoId, url, esPrincipal, fechaSubida) VALUES
(8, '/img/audifonos/01.jpg', TRUE, '2024-01-20'),
(8, '/img/audifonos/02.jpg', FALSE, '2024-01-21'),
(8, '/img/audifonos/03.jpg', FALSE, '2024-01-22');

-- Producto 3 (Libro Electrónico, Digital): 4 fotos (última el 2024-06-30)
INSERT INTO Imagenes (productoId, url, esPrincipal, fechaSubida) VALUES
(3, '/img/libro-electronico/portada.jpg', TRUE, '2024-04-01'),
(3, '/img/libro-electronico/indice.jpg', FALSE, '2024-04-10'),
(3, '/img/libro-electronico/muestra1.jpg', FALSE, '2024-05-20'),
(3, '/img/libro-electronico/muestra2.jpg', FALSE, '2024-06-30');

-- Producto 2 (Laptop, Físico): 5 fotos -> ya en el LÍMITE MÁXIMO.
-- Útil para probar el trigger del Ejercicio 3: una vez creado el
-- trigger, intentar insertar una 6ª foto para el producto 2 debe fallar.
INSERT INTO Imagenes (productoId, url, esPrincipal, fechaSubida) VALUES
(2, '/img/laptop/01.jpg', TRUE, '2024-01-01'),
(2, '/img/laptop/02.jpg', FALSE, '2024-01-02'),
(2, '/img/laptop/03.jpg', FALSE, '2024-01-03'),
(2, '/img/laptop/04.jpg', FALSE, '2024-01-04'),
(2, '/img/laptop/05.jpg', FALSE, '2024-01-05');

-- Producto 10 (Documental, Digital) se deja SIN fotos a propósito:
-- al usar JOIN (no LEFT JOIN) en otroejercicio.md, este producto NO
-- debería aparecer en el resultado. Es un buen caso límite a comentar.

-- ======================================================================
-- Resumen de fotos por producto con estos datos:
--   1 Smartphone        -> 3   (excluido del Ejercicio 2)
--   2 Laptop             -> 5   (límite máximo, para el trigger)
--   3 Libro Electrónico  -> 4   (excluido del Ejercicio 2; Digital)
--   4 Videojuego         -> 2   (incluido en el Ejercicio 2; Digital)
--   5 Camiseta           -> 0   (incluido en el Ejercicio 2)
--   6 Curso Online       -> 2   (incluido en el Ejercicio 2; Digital)
--   7 Película           -> 1   (incluido en el Ejercicio 2; Digital, fecha NULL)
--   8 Audífonos          -> 3   (excluido del Ejercicio 2)
--   9 Tableta Gráfica    -> 1   (incluido en el Ejercicio 2)
--  10 Documental         -> 0   (incluido en el Ejercicio 2; Digital sin fotos)
-- ======================================================================


-- ======================================================================
-- PRUEBAS MANUALES OPCIONALES (ejecutar DESPUÉS de crear el trigger del
-- Ejercicio 3). Descomenta una a una para comprobar el comportamiento.
-- ======================================================================

-- 1) Debe FALLAR: el producto 2 (Laptop) ya tiene 5 fotos (límite alcanzado)
-- INSERT INTO Imagenes (productoId, url, esPrincipal, fechaSubida) VALUES
-- (2, '/img/laptop/06.jpg', FALSE, '2024-01-06');

-- 2) Debe FUNCIONAR: el producto 3 tiene 4 fotos, puede llegar a 5
-- INSERT INTO Imagenes (productoId, url, esPrincipal, fechaSubida) VALUES
-- (3, '/img/libro-electronico/muestra3.jpg', FALSE, '2024-07-01');

-- 3) Comprobar ON UPDATE CASCADE / ON DELETE CASCADE del Ejercicio 1
--    usando el producto 4 (Videojuego), que NO aparece en LineasPedido:
-- UPDATE Productos SET id = 44 WHERE id = 4;
-- SELECT * FROM Imagenes WHERE productoId = 44; -- deben aparecer las 2 fotos reasignadas
-- DELETE FROM Productos WHERE id = 44;
-- SELECT * FROM Imagenes WHERE productoId = 44; -- debe devolver 0 filas


-- ======================================================================
-- CONSULTAS DE VERIFICACIÓN (comentadas, son las de los ejercicios)
-- ======================================================================

-- Ejercicio 2: productos con menos de 3 fotos, ordenados ascendentemente
-- SELECT p.nombre, COUNT(i.id) AS total_fotos
-- FROM Productos p
-- LEFT JOIN Imagenes i ON i.productoId = p.id
-- GROUP BY p.id, p.nombre
-- HAVING total_fotos < 3
-- ORDER BY total_fotos ASC;

-- otroejercicio.md: fecha de la última foto por producto Digital
-- SELECT p.nombre AS Producto, MAX(i.fechaSubida) AS Ultima_Subida
-- FROM Productos p
-- JOIN TiposProducto tp ON p.tipoProductoId = tp.id
-- JOIN Imagenes i ON p.id = i.productoId
-- WHERE tp.nombre = 'Digitales'
-- GROUP BY p.id;

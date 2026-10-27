Escribe una consulta SQL que devuelva el nombre del producto y la fecha de la última foto subida, pero únicamente para aquellos productos cuyo  tipo de producto sea 'Digitales'

```sql
SELECT 
    p.nombre AS Producto, 
    MAX(i.fechaSubida) AS Ultima_Subida
FROM Productos p
JOIN TiposProducto tp ON p.tipoProductoId = tp.id
JOIN Imagenes i ON p.id = i.productoId
WHERE tp.nombre = 'Digitales'
GROUP BY p.id;
```

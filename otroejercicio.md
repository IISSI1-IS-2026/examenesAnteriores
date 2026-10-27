Escribe una consulta SQL que devuelva el nombre del producto y la fecha de la última foto subida, pero únicamente para aquellos productos cuyo  tipo de producto sea 'Digitales'

```sql
SELECT 
    p.nombre AS Producto, 
    MAX(i.fechaSubida) AS Ultima_Subida
FROM Producto p
JOIN TipoProducto tp ON p.tipoProductoId = tp.id
JOIN Imagen i ON p.id = i.productoId
WHERE tp.nombre = 'Digitales'
GROUP BY p.id;
```

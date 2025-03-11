Aquí tienes un conjunto de pautas y recomendaciones detalladas para validar manualmente la migración del esquema desde MongoDB a PostgreSQL, así como la correcta implementación y optimización del nuevo esquema en la base de datos de destino.

### Pautas para la Verificación de la Migración del Esquema

#### 1. Verificación de la Estructura de las Tablas

- **Paso 1:** Conéctate a la base de datos PostgreSQL utilizando una herramienta como pgAdmin, DBeaver o la línea de comandos de PostgreSQL.

- **Paso 2:** Verifica que todas las tablas han sido creadas correctamente.
  ```sql
  \dt
  ```
- **Paso 3:** Verifica la estructura de cada tabla utilizando:
  ```sql
  \d Categoria
  \d MetodoPago
  \d Producto
  \d Usuario
  \d Pedido
  \d ItemPedido
  \d Descuento
  \d PedidosDescuentos
  \d ProductosRelacionados
  \d UsuariosMetodosPago
  ```
  - Punto de Control: Asegúrate de que cada tabla contenga los campos correctos, tipos de datos apropiados y restricciones definidas.

#### 2. Verificación de las Restricciones

- Paso 4: Verifica que las claves primarias y foráneas están definidas correctamente.

  - Para claves primarias:

  ```sql
  SELECT * FROM information_schema.table_constraints
  WHERE table_name = 'Categoria' AND constraint_type = 'PRIMARY KEY';
  ```

  - Para claves foráneas:

  ```sql
  SELECT * FROM information_schema.table_constraints
  WHERE table_name = 'ItemPedido' AND constraint_type = 'FOREIGN KEY';
  ```

- Punto de Control: Asegúrate de que todas las relaciones de claves foráneas están correctamente establecidas y apuntan a las tablas correspondientes.

#### 3. Validación de los Tipos de Datos

**Paso 5**: Asegúrate de que los tipos de datos utilizados en PostgreSQL son compatibles con los de MongoDB y que se han convertido correctamente.
Verifica que los campos de tipo BOOLEAN sean representados como TRUE/FALSE.
Verifica que los campos SERIAL y BIGSERIAL estén definidos correctamente para los IDs autoincrementales.

#### 4. Pruebas de Consultas

**Paso 6**: Ejecuta algunas consultas comunes que se usarán en la aplicación para asegurarte de que el esquema se comporta como se espera. Por ejemplo:
Listar todos los productos:

```sql
SELECT * FROM Producto;
```

Obtener el total de pedidos por usuario:

```sql
SELECT usuario_id, COUNT(*) AS total_pedidos
FROM Pedido
GROUP BY usuario_id;
```

Comprobar los descuentos aplicados a un pedido específico:

```sql
SELECT * FROM PedidosDescuentos
WHERE pedido_id = 1;
```

- Punto de Control: Asegúrate de que las consultas devuelven los resultados esperados. 5. Optimización del Esquema

#### 5. Optimización del Esquema

**Paso 7**: Revisa el uso de índices. Asegúrate de que se han creado índices en los campos que se utilizan frecuentemente en consultas, especialmente en claves foráneas y campos únicos.

- Crear un índice en email en la tabla Usuario si no existe:

```sql
CREATE INDEX idx_usuario_email ON Usuario(email);
```

- Crear un índice en nombre en la tabla Producto si no existe:

```sql
CREATE INDEX idx_producto_nombre ON Producto(nombre);
```

**Paso 8**: Revisa las restricciones de CHECK y asegúrate de que se aplican correctamente. Por ejemplo, verifica que las restricciones de precio y stock están funcionando.

#### 6. Mantenimiento de la Integridad Referencial

- Paso 9: Realiza pruebas manuales para asegurarte de que las restricciones de integridad referencial funcionan como se espera. Por ejemplo, intenta insertar un registro en ItemPedido con un pedido_id que no existe en Pedido y verifica que se produce un error.

#### Conclusión

Siguiendo estas pautas, podrás validar que la migración del esquema desde MongoDB a PostgreSQL se ha realizado correctamente y que el nuevo esquema está optimizado para las consultas y el rendimiento. Recuerda documentar cualquier inconsistencia o error encontrado durante el proceso para su posterior corrección.

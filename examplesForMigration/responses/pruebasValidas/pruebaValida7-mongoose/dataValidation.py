import psycopg2
import pymongo

# Conexión a la base de datos PostgreSQL
pg_conn = psycopg2.connect(
    dbname='nombre_base_datos_postgresql',
    user='usuario',
    password='contraseña',
    host='localhost'
)
pg_cursor = pg_conn.cursor()

# 1. Verificar tablas
pg_cursor.execute(
    "SELECT table_name FROM information_schema.tables WHERE table_schema='public';"
)
tablas = pg_cursor.fetchall()
print('Tablas en PostgreSQL:', tablas)

# 2. Verificar columnas de cada tabla
for tabla in [
    'Categoria', 'Producto', 'ProductoRelacionado', 'ItemPedido',
    'Descuento', 'Pedido', 'MetodoPago', 'Usuario',
    'UsuariosMetodosPago', 'PedidosDescuentos', 'ProductosRelacionados'
]:
    pg_cursor.execute(
        f"SELECT column_name FROM information_schema.columns WHERE table_name='{tabla}';"
    )
    columnas = pg_cursor.fetchall()
    print(f'Columnas en {tabla}:', columnas)

# 3. Verificar tipos de datos
for tabla in [
    'Categoria', 'Producto', 'ProductoRelacionado', 'ItemPedido',
    'Descuento', 'Pedido', 'MetodoPago', 'Usuario'
]:
    pg_cursor.execute(
        f"SELECT column_name, data_type FROM information_schema.columns WHERE table_name='{tabla}';"
    )
    tipos_datos = pg_cursor.fetchall()
    print(f'Tipos de datos en {tabla}:', tipos_datos)

# 4. Verificar claves primarias
for tabla in [
    'Categoria', 'Producto', 'ProductoRelacionado', 'ItemPedido',
    'Descuento', 'Pedido', 'MetodoPago', 'Usuario'
]:
    pg_cursor.execute(
        f"SELECT constraint_name FROM information_schema.table_constraints WHERE table_name='{tabla}' AND constraint_type='PRIMARY KEY';"
    )
    claves_primarias = pg_cursor.fetchall()
    print(f'Claves primarias en {tabla}:', claves_primarias)

# 5. Verificar claves foráneas
for tabla in [
    'ProductoRelacionado', 'ItemPedido', 'UsuariosMetodosPago',
    'PedidosDescuentos', 'ProductosRelacionados'
]:
    pg_cursor.execute(
        f"SELECT constraint_name FROM information_schema.table_constraints WHERE table_name='{tabla}' AND constraint_type='FOREIGN KEY';"
    )
    claves_foraneas = pg_cursor.fetchall()
    print(f'Claves foráneas en {tabla}:', claves_foraneas)

# 6. Verificar índices
pg_cursor.execute(
    "SELECT indexname, tablename FROM pg_indexes WHERE schemaname='public';"
)
indices = pg_cursor.fetchall()
print('Índices en las tablas:', indices)

# 7. Realizar consultas de prueba
# Contar registros en cada tabla
for tabla in [
    'Categoria', 'Producto', 'ProductoRelacionado', 'ItemPedido',
    'Descuento', 'Pedido', 'MetodoPago', 'Usuario'
]:
    pg_cursor.execute(f"SELECT COUNT(*) FROM {tabla};")
    conteo = pg_cursor.fetchone()[0]
    print(f'Registros en {tabla}:', conteo)

# 8. Verificar integridad de datos
# Ejemplo: Verificar que todos los productos tienen una categoría válida
pg_cursor.execute(
    "SELECT COUNT(*) FROM Producto WHERE id_categoria NOT IN (SELECT id FROM Categoria);"
)
productos_invalidos_categoria = pg_cursor.fetchone()[0]
print('Productos con categoría inválida:', productos_invalidos_categoria)

# Cerrar conexión
pg_cursor.close()
pg_conn.close()
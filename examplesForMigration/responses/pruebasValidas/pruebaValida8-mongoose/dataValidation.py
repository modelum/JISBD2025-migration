import psycopg2

# Conexión a PostgreSQL
db_postgres = psycopg2.connect(
    dbname='nombre_base_datos_postgres',
    user='usuario',
    password='contraseña',
    host='localhost',
    port='5432'
)
cursor = db_postgres.cursor()

# 1. Validar búsqueda de productos por nombre
print('Validando búsqueda de productos por nombre...')
cursor.execute("SELECT * FROM Producto WHERE nombre ILIKE '%camisa%';")
productos_por_nombre = cursor.fetchall()
print('Productos encontrados por nombre:', productos_por_nombre)

# 2. Validar obtener productos en un rango de precio
print('Validando obtener productos en un rango de precio...')
cursor.execute("SELECT * FROM Producto WHERE precio BETWEEN 10 AND 50;")
productos_rango_precio = cursor.fetchall()
print('Productos en rango de precio:', productos_rango_precio)

# 3. Validar contar productos por fabricante
print('Validando contar productos por fabricante...')
cursor.execute("SELECT fabricante, COUNT(*) as total FROM Producto GROUP BY fabricante;")
productos_por_fabricante = cursor.fetchall()
print('Conteo de productos por fabricante:', productos_por_fabricante)

# 4. Buscar pedidos de un usuario
print('Validando búsqueda de pedidos de un usuario...')
cursor.execute("SELECT pedidos FROM Usuario WHERE id = 123;")
pedidos_usuario = cursor.fetchall()
print('Pedidos del usuario con id 123:', pedidos_usuario)

# 5. Obtener productos relacionados
print('Validando obtener productos relacionados...')
cursor.execute("SELECT ref_productos_relacionados FROM Producto WHERE id = 456;")
productos_relacionados = cursor.fetchall()
print('Productos relacionados para el producto con id 456:', productos_relacionados)

# 6. Filtrar usuarios premium
print('Validando filtrado de usuarios premium...')
cursor.execute("SELECT * FROM Usuario WHERE premium = TRUE;")
usarios_premium = cursor.fetchall()
print('Usuarios premium:', usarios_premium)

# Cerrar conexión
cursor.close()
db_postgres.close()
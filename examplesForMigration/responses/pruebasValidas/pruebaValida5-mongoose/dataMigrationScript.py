import pymongo
import psycopg2
from psycopg2 import sql

# Conexiones a las bases de datos
mongo_client = pymongo.MongoClient('mongodb://localhost:27017/')
mongo_db = mongo_client['nombre_base_datos_mongodb']

pg_conn = psycopg2.connect(
    dbname='nombre_base_datos_postgresql',
    user='tu_usuario_postgresql',
    password='tu_contraseña_postgresql',
    host='localhost'
)
pg_cursor = pg_conn.cursor()

# Migrar datos de Categoria
categorias = mongo_db.categoria.find()
for categoria in categorias:
    pg_cursor.execute(
        sql.SQL('INSERT INTO Categoria (descripcion) VALUES (%s)'),
        (categoria['descripcion'],)
    )

# Migrar datos de Producto
productos = mongo_db.producto.find()
for producto in productos:
    # Obtener el id de la categoría usando la descripción
    pg_cursor.execute(
        sql.SQL('SELECT id FROM Categoria WHERE descripcion = %s'),
        (producto['categorias']['descripcion'],)
    )
    categoria_id = pg_cursor.fetchone()[0]
    pg_cursor.execute(
        sql.SQL('INSERT INTO Producto (nombre, precio, descripcion, imagenURL, fabricante, stock, categorias) VALUES (%s, %s, %s, %s, %s, %s, %s)'),
        (
            producto['nombre'],
            producto['precio'],
            producto['descripcion'],
            producto['imagenURL'],
            producto['fabricante'],
            producto['stock'],
            categoria_id
        )
    )

# Migrar datos de Usuario
usuarios = mongo_db.usuario.find()
for usuario in usuarios:
    pg_cursor.execute(
        sql.SQL(
            'INSERT INTO Usuario (nombre, email, password, direccion, pais, fechaRegistro, _usuarios_recomendadoPor, valoracionTienda, premium, fecha_premium, premium_fee) '
            'VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)'
        ),
        (
            usuario['nombre'],
            usuario['email'],
            usuario['password'],
            usuario['direccion'],
            usuario['pais'],
            usuario['fechaRegistro'],
            usuario.get('_usuarios_recomendadoPor'),
            usuario['valoracionTienda'],
            usuario['premium'],
            usuario.get('fecha_premium'),
            usuario.get('premium_fee')
        )
    )

# Migrar datos de MetodoPago
metodos_pago = mongo_db.metodopago.find()
for metodo in metodos_pago:
    pg_cursor.execute(
        sql.SQL('INSERT INTO MetodoPago (nombreMetodo, infoMetodo) VALUES (%s, %s)'),
        (metodo['nombreMetodo'], metodo['infoMetodo'])
    )

# Migrar datos de Pedido
pedidos = mongo_db.pedido.find()
for pedido in pedidos:
    pg_cursor.execute(
        sql.SQL('INSERT INTO Pedido (fechaPedido, precioTotal, usuario_id) VALUES (%s, %s, (SELECT id FROM Usuario WHERE email = %s))'),
        (pedido['fechaPedido'], pedido['precioTotal'], pedido['usuario_email'])
    )

# Migrar datos de ItemPedido
for pedido in pedidos:
    for item in pedido['items']:
        pg_cursor.execute(
            sql.SQL(
                'INSERT INTO ItemPedido (cantidad, subtotal, nombreItem, _productos_productoId, pedido_id) '
                'VALUES (%s, %s, %s, (SELECT id FROM Producto WHERE nombre = %s), (SELECT id FROM Pedido WHERE fechaPedido = %s))'
            ),
            (
                item['cantidad'],
                item['subtotal'],
                item['nombreItem'],
                item['_productos_productoId'],
                pedido['fechaPedido']
            )
        )

# Migrar datos de Descuento
descuentos = mongo_db.descuento.find()
for descuento in descuentos:
    pg_cursor.execute(
        sql.SQL('INSERT INTO Descuento (descripcion, ratioDescuento) VALUES (%s, %s)'),
        (descuento['descripcion'], descuento['ratioDescuento'])
    )

# Migrar datos de PedidosDescuentos
for pedido in pedidos:
    for descuento in pedido['descuentos']:
        pg_cursor.execute(
            sql.SQL(
                'INSERT INTO PedidosDescuentos (pedido_id, descuento_id) '
                'VALUES ((SELECT id FROM Pedido WHERE fechaPedido = %s), (SELECT id FROM Descuento WHERE descripcion = %s))'
            ),
            (
                pedido['fechaPedido'],
                descuento['descripcion']
            )
        )

# Crear tablas intermedias: UsuariosMetodosPago
for usuario in usuarios:
    for metodo in usuario['metodosDePago']:
        pg_cursor.execute(
            sql.SQL(
                'INSERT INTO UsuariosMetodosPago (usuario_id, metodo_id) '
                'VALUES ((SELECT id FROM Usuario WHERE email = %s), (SELECT id FROM MetodoPago WHERE nombreMetodo = %s))'
            ),
            (
                usuario['email'],
                metodo['nombreMetodo']
            )
        )

# Crear tablas intermedias: ProductosRelacionados
productos = mongo_db.producto.find()
for producto in productos:
    for relacionado in producto['ref_productos_relacionados']:
        pg_cursor.execute(
            sql.SQL(
                'INSERT INTO ProductosRelacionados (producto_id, id_producto_relacionado) '
                'VALUES ((SELECT id FROM Producto WHERE nombre = %s), (SELECT id FROM Producto WHERE id = %s))'
            ),
            (
                producto['nombre'],
                relacionado['id_producto_relacionado']
            )
        )

# Confirmar cambios y cerrar conexiones
pg_conn.commit()
pg_cursor.close()
mongo_client.close()
pg_conn.close()
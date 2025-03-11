import psycopg2
import pymongo

# Conexiones a las bases de datos
mongo_client = pymongo.MongoClient('mongodb://localhost:27017/')
mongo_db = mongo_client['nombre_base_datos_mongodb']

pg_conn = psycopg2.connect(
    dbname='nombre_base_datos_postgresql',
    user='usuario',
    password='contraseña',
    host='localhost'
)
pg_cursor = pg_conn.cursor()

# Migrar Categorias
categorias = mongo_db.categorias.find()
for categoria in categorias:
    pg_cursor.execute(
        'INSERT INTO Categoria (descripcion) VALUES (%s) RETURNING id;',
        (categoria['descripcion'],)
    )
    categoria_id = pg_cursor.fetchone()[0]

# Migrar Productos
productos = mongo_db.productos.find()
for producto in productos:
    pg_cursor.execute(
        'INSERT INTO Producto (nombre, precio, descripcion, imagenURL, fabricante, stock, id_categoria) VALUES (%s, %s, %s, %s, %s, %s, %s) RETURNING id;',
        (
            producto['nombre'],
            producto['precio'],
            producto.get('descripcion'),
            producto.get('imagenURL'),
            producto['fabricante'],
            producto['stock'],
            categoria_id
        )
    )
    producto_id = pg_cursor.fetchone()[0]

    # Migrar Productos Relacionados
    for relacionado in producto.get('ref_productos_relacionados', []):
        pg_cursor.execute(
            'INSERT INTO ProductoRelacionado (id_producto_relacionado) VALUES (%s);',
            (relacionado['id_producto_relacionado'],)
        )

# Migrar Descuentos
descuentos = mongo_db.descuentos.find()
for descuento in descuentos:
    pg_cursor.execute(
        'INSERT INTO Descuento (descripcion, ratioDescuento) VALUES (%s, %s);',
        (descuento['descripcion'], descuento['ratioDescuento'])
    )

# Migrar Pedidos
pedidos = mongo_db.pedidos.find()
for pedido in pedidos:
    pg_cursor.execute(
        'INSERT INTO Pedido (fechaPedido, precioTotal) VALUES (%s, %s) RETURNING id;',
        (pedido['fechaPedido'], pedido['precioTotal'])
    )
    pedido_id = pg_cursor.fetchone()[0]

    # Migrar Items de Pedido
    for item in pedido['items']:
        pg_cursor.execute(
            'INSERT INTO ItemPedido (id_producto, nombreItem, cantidad, subtotal) VALUES (%s, %s, %s, %s);',
            (item['_productos_productoId'], item['nombreItem'], item['cantidad'], item['subtotal'])
        )

    # Migrar Descuentos de Pedido
    for descuento in pedido.get('descuentos', []):
        pg_cursor.execute(
            'INSERT INTO PedidosDescuentos (id_pedido, id_descuento) VALUES (%s, %s);',
            (pedido_id, descuento['id'])
        )

# Migrar Usuarios
usuarios = mongo_db.usuarios.find()
for usuario in usuarios:
    pg_cursor.execute(
        'INSERT INTO Usuario (nombre, email, password, direccion, pais, fechaRegistro, _usuarios_recomendadoPor, valoracionTienda, premium, fecha_premium, premium_fee) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) RETURNING id;',
        (
            usuario['nombre'],
            usuario['email'],
            usuario['password'],
            usuario.get('direccion'),
            usuario['pais'],
            usuario['fechaRegistro'],
            usuario.get('_usuarios_recomendadoPor'),
            usuario['valoracionTienda'],
            usuario['premium'],
            usuario.get('fecha_premium'),
            usuario.get('premium_fee')
        )
    )
    usuario_id = pg_cursor.fetchone()[0]

    # Migrar Métodos de Pago
    for metodo in usuario.get('metodosDePago', []):
        pg_cursor.execute(
            'INSERT INTO MetodoPago (nombreMetodo, infoMetodo) VALUES (%s, %s) RETURNING id;',
            (metodo['nombreMetodo'], metodo['infoMetodo'])
        )
        metodo_pago_id = pg_cursor.fetchone()[0]
        pg_cursor.execute(
            'INSERT INTO UsuariosMetodosPago (id_usuario, id_metodoPago) VALUES (%s, %s);',
            (usuario_id, metodo_pago_id)
        )

# Confirmar cambios y cerrar conexiones
pg_conn.commit()
pg_cursor.close()
pg_conn.close()
mongo_client.close()
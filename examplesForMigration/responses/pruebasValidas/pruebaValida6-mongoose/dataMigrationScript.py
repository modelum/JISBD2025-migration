import psycopg2
import pymongo

# Conexiones a las bases de datos
mongo_client = pymongo.MongoClient('mongodb://localhost:27017/')
mongo_db = mongo_client['nombre_base_datos_mongo']

postgres_conn = psycopg2.connect(
    dbname='nombre_base_datos_postgres',
    user='usuario',
    password='contraseña',
    host='localhost',
    port='5432'
)
postgres_cursor = postgres_conn.cursor()

# Migrar Categorias
categorias = mongo_db.categoria.find()
for categoria in categorias:
    postgres_cursor.execute(
        "INSERT INTO Categoria (descripcion) VALUES (%s) RETURNING id;",
        (categoria['descripcion'],)
    )
    categoria_id = postgres_cursor.fetchone()[0]

# Migrar Productos
productos = mongo_db.producto.find()
for producto in productos:
    postgres_cursor.execute(
        "INSERT INTO Producto (nombre, precio, descripcion, imagenURL, fabricante, stock) VALUES (%s, %s, %s, %s, %s, %s) RETURNING id;",
        (
            producto['nombre'],
            producto['precio'],
            producto['descripcion'],
            producto['imagenURL'],
            producto['fabricante'],
            producto['stock']
        )
    )
    producto_id = postgres_cursor.fetchone()[0]

    # Migrar categorias
    for categoria in producto['categorias']:
        postgres_cursor.execute(
            "INSERT INTO ProductosRelacionados (producto_id, relacionado_id) VALUES (%s, %s);",
            (producto_id, categoria['id'])
        )

    # Migrar productos relacionados
    for relacionado in producto['ref_productos_relacionados']:
        postgres_cursor.execute(
            "INSERT INTO ProductoRelacionado (id_producto_relacionado, producto_id) VALUES (%s, %s);",
            (relacionado['id_producto_relacionado'], producto_id)
        )

# Migrar Usuarios
usuarios = mongo_db.usuario.find()
for usuario in usuarios:
    postgres_cursor.execute(
        "INSERT INTO Usuario (nombre, email, password, direccion, pais, fechaRegistro, _usuarios_recomendadoPor, valoracionTienda, premium, fecha_premium, premium_fee) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) RETURNING id;",
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
    usuario_id = postgres_cursor.fetchone()[0]

    # Migrar metodos de pago
    for metodo in usuario['metodosDePago']:
        postgres_cursor.execute(
            "INSERT INTO MetodoPago (nombreMetodo, infoMetodo) VALUES (%s, %s) RETURNING id;",
            (metodo['nombreMetodo'], metodo['infoMetodo'])
        )
        metodo_id = postgres_cursor.fetchone()[0]
        postgres_cursor.execute(
            "INSERT INTO UsuariosMetodosPago (usuario_id, metodo_id) VALUES (%s, %s);",
            (usuario_id, metodo_id)
        )

    # Migrar pedidos
    for pedido in usuario['pedidos']:
        postgres_cursor.execute(
            "INSERT INTO Pedido (fechaPedido, precioTotal) VALUES (%s, %s) RETURNING id;",
            (pedido['fechaPedido'], pedido['precioTotal'])
        )
        pedido_id = postgres_cursor.fetchone()[0]

        # Migrar descuentos
        for descuento in pedido['descuentos']:
            postgres_cursor.execute(
                "INSERT INTO Descuento (descripcion, ratioDescuento) VALUES (%s, %s) RETURNING id;",
                (descuento['descripcion'], descuento['ratioDescuento'])
            )
            descuento_id = postgres_cursor.fetchone()[0]
            postgres_cursor.execute(
                "INSERT INTO PedidosDescuentos (pedido_id, descuento_id) VALUES (%s, %s);",
                (pedido_id, descuento_id)
            )

        # Migrar items
        for item in pedido['items']:
            postgres_cursor.execute(
                "INSERT INTO ItemPedido (_productos_productoId, nombreItem, cantidad, subtotal) VALUES (%s, %s, %s, %s) RETURNING id;",
                (item['_productos_productoId'], item['nombreItem'], item['cantidad'], item['subtotal'])
            )
            item_id = postgres_cursor.fetchone()[0]
            postgres_cursor.execute(
                "INSERT INTO PedidosItems (pedido_id, item_id) VALUES (%s, %s);",
                (pedido_id, item_id)
            )

# Confirmar cambios y cerrar conexiones
postgres_conn.commit()
postgres_cursor.close()
postgres_conn.close()
mongo_client.close()
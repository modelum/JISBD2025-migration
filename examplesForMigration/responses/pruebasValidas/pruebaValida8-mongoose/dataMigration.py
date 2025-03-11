import psycopg2
import pymongo

# Conexión a MongoDB
db_mongo = pymongo.MongoClient('mongodb://localhost:27017/')['nombre_base_datos']

# Conexión a PostgreSQL
db_postgres = psycopg2.connect(
    dbname='nombre_base_datos_postgres',
    user='usuario',
    password='contraseña',
    host='localhost',
    port='5432'
)
cursor = db_postgres.cursor()

# Migrar Categoria
for categoria in db_mongo.categoria.find():
    cursor.execute(
        'INSERT INTO Categoria (descripcion) VALUES (%s) RETURNING id;',
        (categoria['descripcion'],)
    )
    categoria_id = cursor.fetchone()[0]

# Migrar Producto
for producto in db_mongo.producto.find():
    cursor.execute(
        'INSERT INTO Producto (id, nombre, precio, descripcion, imagenURL, fabricante, stock) VALUES (%s, %s, %s, %s, %s, %s, %s);',
        (
            producto['id'],
            producto['nombre'],
            producto['precio'],
            producto['descripcion'],
            producto['imagenURL'],
            producto['fabricante'],
            producto['stock']
        )
    )

    # Migrar categorías de producto
    categorias = producto['categorias']
    cursor.execute(
        'INSERT INTO ProductosRelacionados (producto_id, producto_relacionado_id) VALUES (%s, %s);',
        (producto['id'], categorias['id'])
    )

    # Migrar productos relacionados
    for relacionado in producto['ref_productos_relacionados']:
        cursor.execute(
            'INSERT INTO ProductoRelacionado (id_producto_relacionado) VALUES (%s);',
            (relacionado['id_producto_relacionado'],)
        )

# Migrar Descuento
for descuento in db_mongo.descuento.find():
    cursor.execute(
        'INSERT INTO Descuento (id, descripcion, ratioDescuento) VALUES (%s, %s, %s);',
        (descuento['id'], descuento['descripcion'], descuento['ratioDescuento'])
    )

# Migrar MetodoPago
for metodo_pago in db_mongo.metodopago.find():
    cursor.execute(
        'INSERT INTO MetodoPago (nombreMetodo, infoMetodo) VALUES (%s, %s);',
        (metodo_pago['nombreMetodo'], metodo_pago['infoMetodo'])
    )

# Migrar Usuario
for usuario in db_mongo.usuario.find():
    cursor.execute(
        'INSERT INTO Usuario (id, nombre, email, password, direccion, pais, fechaRegistro, _usuarios_recomendadoPor, valoracionTienda, premium, fecha_premium, premium_fee) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);',
        (
            usuario['id'],
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

    # Migrar metodos de pago de usuario
    for metodo in usuario['metodosDePago']:
        cursor.execute(
            'INSERT INTO UsuariosMetodosPago (usuario_id, metodo_pago_id) VALUES (%s, (SELECT id FROM MetodoPago WHERE nombreMetodo = %s));',
            (usuario['id'], metodo['nombreMetodo'])
        )

    # Migrar pedidos
    for pedido in usuario['pedidos']:
        cursor.execute(
            'INSERT INTO Pedido (id, fechaPedido, precioTotal) VALUES (%s, %s, %s) RETURNING id;',
            (pedido['id'], pedido['fechaPedido'], pedido['precioTotal'])
        )
        pedido_id = cursor.fetchone()[0]

        # Migrar descuentos de pedido
        for descuento in pedido['descuentos']:
            cursor.execute(
                'INSERT INTO PedidosDescuentos (pedido_id, descuento_id) VALUES (%s, %s);',
                (pedido_id, descuento['id'])
            )

        # Migrar items de pedido
        for item in pedido['items']:
            cursor.execute(
                'INSERT INTO ItemPedido (_productos_productoId, nombreItem, cantidad, subtotal) VALUES ((SELECT id FROM Producto WHERE id = %s), %s, %s, %s);',
                (item['_productos_productoId'], item['nombreItem'], item['cantidad'], item['subtotal'])
            )

# Guardar cambios y cerrar conexiones
db_postgres.commit()
cursor.close()
db_postgres.close()
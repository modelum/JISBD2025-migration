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

# Validar Categorias
mongo_categorias = mongo_db.categoria.find()
postgres_cursor.execute("SELECT COUNT(*) FROM Categoria;")
postgres_categoria_count = postgres_cursor.fetchone()[0]
assert postgres_categoria_count == mongo_categorias.count(), "El conteo de categorias no coincide."

# Validar Productos
mongo_productos = mongo_db.producto.find()
postgres_cursor.execute("SELECT COUNT(*) FROM Producto;")
postgres_producto_count = postgres_cursor.fetchone()[0]
assert postgres_producto_count == mongo_productos.count(), "El conteo de productos no coincide."

# Validar Usuarios
mongo_usuarios = mongo_db.usuario.find()
postgres_cursor.execute("SELECT COUNT(*) FROM Usuario;")
postgres_usuario_count = postgres_cursor.fetchone()[0]
assert postgres_usuario_count == mongo_usuarios.count(), "El conteo de usuarios no coincide."

# Validar Productos Relacionados
postgres_cursor.execute("SELECT COUNT(*) FROM ProductoRelacionado;")
postgres_producto_relacionado_count = postgres_cursor.fetchone()[0]
# Aquí se debe validar la lógica de los productos relacionados si es necesario

# Validar ItemPedido
postgres_cursor.execute("SELECT COUNT(*) FROM ItemPedido;")
postgres_itempedido_count = postgres_cursor.fetchone()[0]
# Aquí se debe validar la lógica de los items de pedido si es necesario

# Validar Pedidos
mongo_pedidos = mongo_db.pedido.find()
postgres_cursor.execute("SELECT COUNT(*) FROM Pedido;")
postgres_pedido_count = postgres_cursor.fetchone()[0]
assert postgres_pedido_count == mongo_pedidos.count(), "El conteo de pedidos no coincide."

# Validar Descuentos
postgres_cursor.execute("SELECT COUNT(*) FROM Descuento;")
postgres_descuento_count = postgres_cursor.fetchone()[0]
# Aquí se debe validar la lógica de los descuentos si es necesario

# Validar Metodos de Pago
mongo_metodos_pago = mongo_db.metodoPago.find()
postgres_cursor.execute("SELECT COUNT(*) FROM MetodoPago;")
postgres_metodo_pago_count = postgres_cursor.fetchone()[0]
assert postgres_metodo_pago_count == mongo_metodos_pago.count(), "El conteo de métodos de pago no coincide."

# Validar integridad referencial
# Comprobar que todas las claves foráneas tengan registros correspondientes
# Ejemplo para Usuario recomendado
postgres_cursor.execute("SELECT COUNT(*) FROM Usuario WHERE _usuarios_recomendadoPor IS NOT NULL;")
usuarios_recomendados_count = postgres_cursor.fetchone()[0]
assert usuarios_recomendados_count == mongo_db.usuario.count_documents({'_usuarios_recomendadoPor': {'$exists': True}}), "Los usuarios recomendados no coinciden."

# Confirmar cambios y cerrar conexiones
postgres_conn.commit()
postgres_cursor.close()
postgres_conn.close()
mongo_client.close()
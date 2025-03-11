CREATE TABLE Categoria (
  id BIGSERIAL PRIMARY KEY,
  descripcion VARCHAR NOT NULL
);

CREATE TABLE Producto (
  id BIGSERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL,
  precio DECIMAL NOT NULL,
  descripcion TEXT,
  imagenURL TEXT,
  fabricante VARCHAR NOT NULL,
  stock INTEGER NOT NULL
);

CREATE TABLE ProductoRelacionado (
  id_producto_relacionado BIGSERIAL REFERENCES Producto(id) ON DELETE CASCADE,
  producto_id BIGSERIAL REFERENCES Producto(id) ON DELETE CASCADE,
  PRIMARY KEY (id_producto_relacionado, producto_id)
);

CREATE TABLE ItemPedido (
  id BIGSERIAL PRIMARY KEY,
  _productos_productoId BIGINT REFERENCES Producto(id) ON DELETE CASCADE,
  nombreItem VARCHAR NOT NULL,
  cantidad INTEGER NOT NULL,
  subtotal DECIMAL NOT NULL
);

CREATE TABLE Descuento (
  id BIGSERIAL PRIMARY KEY,
  descripcion VARCHAR NOT NULL,
  ratioDescuento DECIMAL NOT NULL
);

CREATE TABLE Pedido (
  id BIGSERIAL PRIMARY KEY,
  fechaPedido TIMESTAMP NOT NULL,
  precioTotal DECIMAL NOT NULL
);

CREATE TABLE PedidosDescuentos (
  pedido_id BIGINT REFERENCES Pedido(id) ON DELETE CASCADE,
  descuento_id BIGINT REFERENCES Descuento(id) ON DELETE CASCADE,
  PRIMARY KEY (pedido_id, descuento_id)
);

CREATE TABLE MetodoPago (
  id BIGSERIAL PRIMARY KEY,
  nombreMetodo VARCHAR NOT NULL,
  infoMetodo VARCHAR NOT NULL
);

CREATE TABLE UsuariosMetodosPago (
  usuario_id BIGSERIAL REFERENCES Usuario(id) ON DELETE CASCADE,
  metodo_id BIGSERIAL REFERENCES MetodoPago(id) ON DELETE CASCADE,
  PRIMARY KEY (usuario_id, metodo_id)
);

CREATE TABLE Usuario (
  id BIGSERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL,
  email VARCHAR UNIQUE NOT NULL,
  password VARCHAR NOT NULL,
  direccion TEXT,
  pais VARCHAR NOT NULL,
  fechaRegistro TIMESTAMP NOT NULL,
  _usuarios_recomendadoPor BIGSERIAL REFERENCES Usuario(id) ON DELETE
  SET
    NULL,
    valoracionTienda INTEGER NOT NULL,
    premium BOOLEAN NOT NULL,
    fecha_premium TIMESTAMP,
    premium_fee DECIMAL
);

CREATE TABLE Pedidos (
  usuario_id BIGINT REFERENCES Usuario(id) ON DELETE CASCADE,
  pedido_id BIGINT REFERENCES Pedido(id) ON DELETE CASCADE,
  PRIMARY KEY (usuario_id, pedido_id)
);

CREATE INDEX idx_usuario_email ON Usuario(email);

CREATE INDEX idx_producto_nombre ON Producto(nombre);
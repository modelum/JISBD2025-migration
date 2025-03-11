CREATE TABLE Categoria (
  id SERIAL PRIMARY KEY,
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
  id SERIAL PRIMARY KEY,
  id_producto_relacionado BIGINT REFERENCES Producto(id) ON DELETE CASCADE
);

CREATE TABLE ItemPedido (
  id SERIAL PRIMARY KEY,
  _productos_productoId BIGINT REFERENCES Producto(id) ON DELETE CASCADE,
  nombreItem VARCHAR NOT NULL,
  cantidad INTEGER NOT NULL,
  subtotal DECIMAL NOT NULL
);

CREATE TABLE Descuento (
  id SERIAL PRIMARY KEY,
  descripcion VARCHAR NOT NULL,
  ratioDescuento DECIMAL NOT NULL
);

CREATE TABLE Pedido (
  id BIGSERIAL PRIMARY KEY,
  fechaPedido TIMESTAMP NOT NULL,
  precioTotal DECIMAL NOT NULL
);

CREATE TABLE MetodoPago (
  id SERIAL PRIMARY KEY,
  nombreMetodo VARCHAR NOT NULL,
  infoMetodo TEXT NOT NULL
);

CREATE TABLE Usuario (
  id BIGSERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL,
  email VARCHAR UNIQUE NOT NULL,
  password VARCHAR NOT NULL,
  direccion TEXT,
  pais VARCHAR NOT NULL,
  fechaRegistro TIMESTAMP NOT NULL,
  _usuarios_recomendadoPor BIGINT REFERENCES Usuario(id) ON DELETE
  SET
    NULL,
    valoracionTienda INTEGER NOT NULL,
    premium BOOLEAN NOT NULL,
    fecha_premium TIMESTAMP,
    premium_fee DECIMAL
);

CREATE TABLE UsuariosMetodosPago (
  usuario_id BIGINT REFERENCES Usuario(id) ON DELETE CASCADE,
  metodo_pago_id BIGINT REFERENCES MetodoPago(id) ON DELETE CASCADE,
  PRIMARY KEY (usuario_id, metodo_pago_id)
);

CREATE TABLE PedidosDescuentos (
  pedido_id BIGINT REFERENCES Pedido(id) ON DELETE CASCADE,
  descuento_id BIGINT REFERENCES Descuento(id) ON DELETE CASCADE,
  PRIMARY KEY (pedido_id, descuento_id)
);

CREATE TABLE ProductosRelacionados (
  producto_id BIGINT REFERENCES Producto(id) ON DELETE CASCADE,
  producto_relacionado_id BIGINT REFERENCES ProductoRelacionado(id) ON DELETE CASCADE,
  PRIMARY KEY (producto_id, producto_relacionado_id)
);

CREATE INDEX idx_usuario_email ON Usuario(email);

CREATE INDEX idx_producto_nombre ON Producto(nombre);
CREATE TABLE Categoria (
  id SERIAL PRIMARY KEY,
  descripcion VARCHAR(255)
);

CREATE TABLE MetodoPago (
  id SERIAL PRIMARY KEY,
  nombreMetodo VARCHAR(255) NOT NULL,
  infoMetodo TEXT NOT NULL
);

CREATE TABLE Producto (
  id BIGSERIAL PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  precio DECIMAL(10, 2) NOT NULL,
  descripcion TEXT,
  imagenURL TEXT,
  fabricante VARCHAR(255) NOT NULL,
  stock INTEGER NOT NULL,
  categorias INTEGER NOT NULL REFERENCES Categoria(id),
  UNIQUE (nombre)
);

CREATE TABLE Usuario (
  id BIGSERIAL PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  direccion TEXT,
  pais VARCHAR(255) NOT NULL,
  fechaRegistro TIMESTAMP NOT NULL,
  _usuarios_recomendadoPor BIGSERIAL REFERENCES Usuario(id),
  valoracionTienda INTEGER NOT NULL,
  premium BOOLEAN NOT NULL,
  fecha_premium TIMESTAMP,
  premium_fee DECIMAL(10, 2)
);

CREATE TABLE Pedido (
  id BIGSERIAL PRIMARY KEY,
  fechaPedido TIMESTAMP NOT NULL,
  precioTotal DECIMAL(10, 2) NOT NULL,
  usuario_id BIGSERIAL NOT NULL REFERENCES Usuario(id)
);

CREATE TABLE ItemPedido (
  id BIGSERIAL PRIMARY KEY,
  cantidad INTEGER NOT NULL,
  subtotal DECIMAL(10, 2) NOT NULL,
  nombreItem VARCHAR(255) NOT NULL,
  _productos_productoId BIGSERIAL NOT NULL REFERENCES Producto(id),
  pedido_id BIGSERIAL NOT NULL REFERENCES Pedido(id)
);

CREATE TABLE Descuento (
  id BIGSERIAL PRIMARY KEY,
  descripcion VARCHAR(255) NOT NULL,
  ratioDescuento DECIMAL(5, 2) NOT NULL
);

CREATE TABLE PedidosDescuentos (
  pedido_id BIGSERIAL NOT NULL REFERENCES Pedido(id),
  descuento_id BIGSERIAL NOT NULL REFERENCES Descuento(id),
  PRIMARY KEY (pedido_id, descuento_id)
);

CREATE TABLE ProductosRelacionados (
  producto_id BIGSERIAL NOT NULL REFERENCES Producto(id),
  id_producto_relacionado BIGSERIAL NOT NULL REFERENCES Producto(id),
  PRIMARY KEY (producto_id, id_producto_relacionado)
);

CREATE TABLE UsuariosMetodosPago (
  usuario_id BIGSERIAL NOT NULL REFERENCES Usuario(id),
  metodo_pago_id BIGSERIAL NOT NULL REFERENCES MetodoPago(id),
  PRIMARY KEY (usuario_id, metodo_pago_id)
);
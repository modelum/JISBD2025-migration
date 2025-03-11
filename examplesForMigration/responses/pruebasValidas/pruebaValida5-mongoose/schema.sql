CREATE TABLE Categoria (
  id SERIAL PRIMARY KEY,
  descripcion VARCHAR NOT NULL
);

CREATE TABLE Producto (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL,
  precio DECIMAL NOT NULL,
  descripcion TEXT,
  imagenURL TEXT,
  fabricante VARCHAR NOT NULL,
  stock INTEGER NOT NULL
);

CREATE TABLE ProductoRelacionado (
  id_producto_relacionado INTEGER NOT NULL,
  producto_id INTEGER NOT NULL,
  PRIMARY KEY (id_producto_relacionado, producto_id),
  FOREIGN KEY (id_producto_relacionado) REFERENCES Producto(id),
  FOREIGN KEY (producto_id) REFERENCES Producto(id)
);

CREATE TABLE ItemPedido (
  id SERIAL PRIMARY KEY,
  _productos_productoId INTEGER NOT NULL,
  nombreItem VARCHAR NOT NULL,
  cantidad INTEGER NOT NULL,
  subtotal DECIMAL NOT NULL,
  FOREIGN KEY (_productos_productoId) REFERENCES Producto(id)
);

CREATE TABLE Descuento (
  id SERIAL PRIMARY KEY,
  descripcion VARCHAR NOT NULL,
  ratioDescuento DECIMAL NOT NULL
);

CREATE TABLE Pedido (
  id SERIAL PRIMARY KEY,
  fechaPedido TIMESTAMP NOT NULL,
  precioTotal DECIMAL NOT NULL
);

CREATE TABLE UsuariosMetodosPago (
  usuario_id INTEGER NOT NULL,
  metodo_id INTEGER NOT NULL,
  PRIMARY KEY (usuario_id, metodo_id),
  FOREIGN KEY (usuario_id) REFERENCES Usuario(id),
  FOREIGN KEY (metodo_id) REFERENCES MetodoPago(id)
);

CREATE TABLE MetodoPago (
  id SERIAL PRIMARY KEY,
  nombreMetodo VARCHAR NOT NULL,
  infoMetodo VARCHAR NOT NULL
);

CREATE TABLE Usuario (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR NOT NULL,
  email VARCHAR NOT NULL UNIQUE,
  password VARCHAR NOT NULL,
  direccion TEXT,
  pais VARCHAR NOT NULL,
  fechaRegistro TIMESTAMP NOT NULL,
  _usuarios_recomendadoPor INTEGER,
  valoracionTienda INTEGER NOT NULL,
  premium BOOLEAN NOT NULL,
  fecha_premium TIMESTAMP,
  premium_fee DECIMAL,
  FOREIGN KEY (_usuarios_recomendadoPor) REFERENCES Usuario(id)
);

CREATE TABLE PedidosDescuentos (
  pedido_id INTEGER NOT NULL,
  descuento_id INTEGER NOT NULL,
  PRIMARY KEY (pedido_id, descuento_id),
  FOREIGN KEY (pedido_id) REFERENCES Pedido(id),
  FOREIGN KEY (descuento_id) REFERENCES Descuento(id)
);

CREATE TABLE ProductosRelacionados (
  producto_id INTEGER NOT NULL,
  relacionado_id INTEGER NOT NULL,
  PRIMARY KEY (producto_id, relacionado_id),
  FOREIGN KEY (producto_id) REFERENCES Producto(id),
  FOREIGN KEY (relacionado_id) REFERENCES Producto(id)
);

CREATE TABLE PedidosItems (
  pedido_id INTEGER NOT NULL,
  item_id INTEGER NOT NULL,
  PRIMARY KEY (pedido_id, item_id),
  FOREIGN KEY (pedido_id) REFERENCES Pedido(id),
  FOREIGN KEY (item_id) REFERENCES ItemPedido(id)
);
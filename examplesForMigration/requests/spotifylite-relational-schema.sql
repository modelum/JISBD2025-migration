
-- Script de creacion del esquema en Oracle SQL

-- Eliminacion de tablas, para ejecucion repetida
DROP TABLE LISTA_CANCION;
DROP TABLE LISTA;
DROP TABLE USUARIO;
DROP TABLE CANCION;
DROP TABLE ALBUM;
DROP TABLE SOLISTA;
DROP TABLE MUSICO_INSTRUMENTO;
DROP TABLE MUSICO CASCADE CONSTRAINTS;
DROP TABLE BANDA;


-- Definicion del esquema logico especifico

CREATE TABLE USUARIO (
  id_usuario    CHAR(4)     NOT NULL,
  nombre   	    VARCHAR(20) NOT NULL, 
  email 	      VARCHAR(20) NULL, 
  telefono	    CHAR(12)    NULL, -- +34123456789 -- tambien NUMBER(9)
  tipo          VARCHAR(20) DEFAULT 'GRATUITO' NOT NULL,
  cuota         NUMBER(4,2) NOT NULL,
  invitador     CHAR(4)     NULL,
  ultimo_acceso DATE        NOT NULL,
  --
  CONSTRAINT usuario_pk PRIMARY KEY (id_usuario),
  --
  CONSTRAINT usuario_ak1 UNIQUE(email),
  CONSTRAINT usuario_ak2 UNIQUE(telefono),
  --
  CONSTRAINT usuario_fk_usuario FOREIGN KEY (invitador)
    REFERENCES USUARIO(id_usuario),
    -- on delete SET NULL on update CASCADE
  CONSTRAINT usuario_tipo_ok 
    CHECK (tipo IN ('GRATUITO', 'PREMIUM INDIVIDUAL',
                   'PREMIUM DOS', 'PREMIUM FAMILIAR')),
  CONSTRAINT usuario_ak_ok 
    CHECK ((email IS NOT NULL AND telefono IS NULL) 
           OR (email IS NULL AND telefono IS NOT NULL)),
  CONSTRAINT usuario_invitado_ok CHECK (id_usuario <> invitador)
);

CREATE TABLE LISTA(
  usuario      CHAR(4)     NOT NULL,
  num_lista    NUMBER(2)   NOT NULL,
  nombre       VARCHAR(20) NOT NULL,
  descripcion  VARCHAR(30) NULL,
  CONSTRAINT lista_pk PRIMARY KEY (usuario, num_lista),
  CONSTRAINT lista_fk_usuario FOREIGN KEY (usuario)
    REFERENCES USUARIO(id_usuario),
    -- on delete: CASCADE on update: CASCADE
  CONSTRAINT lista_num_ok CHECK (num_lista > 0)
);


CREATE TABLE LISTA_CANCION ( -- tipo relacion ANADIDA_A
  usuario  CHAR(4)   NOT NULL,
  lista    NUMBER(2) NOT NULL,
  --
  album    CHAR(4)   NOT NULL,
  cancion  NUMBER(2) NOT NULL,
  --
  fecha    DATE	     NOT NULL,
  
  CONSTRAINT lista_cancion_pk PRIMARY KEY (usuario, lista, album, cancion),
-- 
  CONSTRAINT lista_cancion_fk_lista FOREIGN KEY (usuario,lista) 
    REFERENCES LISTA(usuario,num_lista),
    -- on delete CASCADE on update CASCADE
  CONSTRAINT lista_cancion_fk_cancion FOREIGN KEY (album, cancion)
	REFERENCES CANCION(album, posicion)
    -- on delete CASCADE on update CASCADE
 );

/* Hay un #ciclo referencial# entre BANDA y MUSICO.
La manera de definir correctamente ambas tablas es 
1) Crear tabla BANDA sin la referencia a MUSICO. 
2) Crear tabla MUSICO completa, con la clave ajena hacia BANDA.
3) Alterar BANDA para incluir la clave ajena hacia MUSICO. 
*/ 
CREATE TABLE BANDA (
  id_artista  CHAR(4)     NOT NULL, 
  nombre      VARCHAR(20) NOT NULL, 
  pais_origen VARCHAR(20) NULL,
  a_fundacion NUMBER(4)	  NOT NULL, 
  lider       CHAR(4)     NOT NULL,
  CONSTRAINT banda_pk PRIMARY KEY (id_artista),
  CONSTRAINT banda_ak1 UNIQUE (nombre),
  CONSTRAINT banda_ak2 UNIQUE (lider)  
);

CREATE TABLE MUSICO (
  id_musico	CHAR(4)     NOT NULL,
  nombre    VARCHAR(20) NOT NULL,
  banda	    CHAR(4)	    NOT NULL,
  CONSTRAINT musico_pk PRIMARY KEY (id_musico),
  CONSTRAINT musico_fk_banda FOREIGN KEY (banda) 
    REFERENCES BANDA(id_artista)
  --on delete NO ACTION/CASCADE on update CASCADE
);

ALTER TABLE BANDA 
ADD CONSTRAINT banda_fk_musico 
    FOREIGN KEY (lider) REFERENCES MUSICO(id_musico)
  -- on delete NO ACTION on update CASCADE
;

CREATE TABLE SOLISTA (
  id_artista  CHAR(4)       NOT NULL,
  nombre      VARCHAR(20)   NOT NULL,
  pais_origen VARCHAR(20)   NULL,
  bio_breve		VARCHAR(60)   NULL,
  CONSTRAINT solista_pk PRIMARY KEY (id_artista),
  CONSTRAINT solista_ak UNIQUE (nombre)
);

CREATE TABLE ALBUM (
  id_album CHAR(4) 	   NOT NULL,
  titulo   VARCHAR(30) NOT NULL,
  anno     NUMBER(4)   NOT NULL,
  genero   VARCHAR(10) NOT NULL,
  solista  CHAR(4)     NULL,
  banda	   CHAR(4)	   NULL,
  CONSTRAINT album_pk PRIMARY KEY (id_album),
  CONSTRAINT album_fk_solista FOREIGN KEY (solista) 
	  REFERENCES SOLISTA (id_artista),
    -- on delete NO ACTION/CASCADE on update CASCADE
  CONSTRAINT album_fk_banda FOREIGN KEY (banda) 
	  REFERENCES BANDA (id_artista),
    -- on delete NO ACTION/CASCADE on update CASCADE
  CONSTRAINT album_genero_ok 
    CHECK (genero IN ('POP', 'ROCK', 'INDIE', 'HIP HOP', 'K-POP', 'CLASICA', 'LATINO', 'FLAMENCO', 'OTRO')),
  -- Es un album de un solista xor de una banda:
  CONSTRAINT album_grabado_por_ok CHECK 
    ( ((solista IS NOT NULL) AND (banda IS NULL))
      OR
      ((solista IS NULL) AND (banda IS NOT NULL)) )
);

CREATE TABLE CANCION (
  album	         CHAR(4)     NOT NULL,
  posicion       NUMBER(2)   NOT NULL, 
  titulo         VARCHAR(30) NOT NULL, 
  duracion       NUMBER(4,2) NOT NULL, -- min,ss
  cuantas_listas NUMBER(3)   DEFAULT 0 NOT NULL, 
  CONSTRAINT cancion_pk PRIMARY KEY (album, posicion),
  CONSTRAINT cancion_fk_album FOREIGN KEY (album)
    REFERENCES ALBUM (id_album),
    -- on delete CASCADE on update CASCADE
  CONSTRAINT cancion_posicion_ok CHECK (posicion > 0),
  CONSTRAINT cancion_duracion_ok CHECK (duracion > 0),
  CONSTRAINT cancion_cuenta_ok   CHECK (cuantas_listas >= 0)
); 

CREATE TABLE MUSICO_INSTRUMENTO (
  musico      CHAR(4) 	  NOT NULL,
  instrumento VARCHAR(10) NOT NULL, 
  CONSTRAINT mi_pk PRIMARY KEY (musico, instrumento),
  CONSTRAINT mi_fk_musico FOREIGN KEY (musico) 
    REFERENCES MUSICO (id_musico),
    -- on delete CASCADE on update CASCADE
  CONSTRAINT instrumento_ok 
    CHECK (instrumento IN ('VOZ', 'GUITARRA', 'BAJO', 'PIANO', 'BATERIA', 'OTRO'))
);

-- THE END
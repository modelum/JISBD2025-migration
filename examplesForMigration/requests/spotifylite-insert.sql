-- fichero bd1-p3-insert-profesores.sql

-- Bases de Datos 2023/24 
-- PRACTICA P3. DMD
--   Ejercicio 1. 
---------------------------------------------------------------------------------
--INSERCION de datos en LAS TABLAS DEL ESQUEMA "MUSICA"
--No se ha incluido tildes para evitar problemas de codificacion de caracteres --
---------------------------------------------------------------------------------

-- Los DELETE permiten la ejecucion repetida de este script, mientras se depura
DELETE FROM LISTA_CANCION;
DELETE FROM LISTA;
DELETE FROM USUARIO;
--DELETE FROM CANCION;
--DELETE FROM ALBUM;
--DELETE FROM MUSICO_INSTRUMENTO;
ALTER TABLE BANDA DISABLE CONSTRAINT banda_fk_musico;
DELETE FROM MUSICO;
DELETE FROM BANDA;
--DELETE FROM SOLISTA;
ALTER TABLE BANDA ENABLE CONSTRAINT banda_fk_musico;

/*
-- SOLISTA
INSERT INTO SOLISTA (id_artista, nombre, pais_origen, bio_breve)
  VALUES ('S001', 'DAVID BOWIE', 'Reino Unido', NULL);
INSERT INTO SOLISTA (id_artista, nombre, pais_origen, bio_breve)
  VALUES ('S002', 'PRINCE', 'Estados Unidos', NULL);
INSERT INTO SOLISTA (id_artista, nombre, pais_origen, bio_breve)
  VALUES ('S003', 'TINA TURNER', 'Estados Unidos', NULL);  
INSERT INTO SOLISTA (id_artista, nombre, pais_origen, bio_breve)
  VALUES ('S004', 'SINEAD O CONNOR', 'Irlanda', NULL);  
INSERT INTO SOLISTA (id_artista, nombre, pais_origen, bio_breve)
  VALUES ('S005', 'SADE', 'Nigeria', NULL); 
*/
-- BANDA

-- desactivar la clave ajena, debido al ciclo referencial
ALTER TABLE BANDA DISABLE CONSTRAINT banda_fk_musico;

INSERT INTO BANDA ( id_artista, nombre, pais_origen, a_fundacion, lider)
VALUES ('B001', 'EURYTHMICS', 'Reino Unido', 1980, 'M001');
INSERT INTO BANDA ( id_artista, nombre, pais_origen, a_fundacion, lider)
VALUES ('B002', 'QUEEN', 'Reino Unido', 1970, 'M003');
INSERT INTO BANDA ( id_artista, nombre, pais_origen, a_fundacion, lider)
VALUES ('B003', 'RADIO FUTURA', 'Espana', 1979, 'M007');
INSERT INTO BANDA ( id_artista, nombre, pais_origen, a_fundacion, lider)
VALUES ('B004', 'VETUSTA MORLA', 'Espana', 1998, 'M010');
INSERT INTO BANDA ( id_artista, nombre, pais_origen, a_fundacion, lider)
VALUES ('B005', 'THE STROKES', 'Estados Unidos', 1998, 'M015');

-- MUSICO
-- EURYTHMICS
INSERT INTO MUSICO (id_musico, nombre, banda)
VALUES ('M001', 'ANNIE LENNOX', 'B001');
INSERT INTO MUSICO (id_musico, nombre, banda)
VALUES ('M002', 'DAVID A. STEWART', 'B001');
-- QUEEN
INSERT INTO MUSICO (id_musico, nombre, banda)
VALUES ('M003', 'FREDDY MERCURY', 'B002');
INSERT INTO MUSICO (id_musico, nombre, banda)
VALUES ('M004', 'BRIAN MAY', 'B002');
INSERT INTO MUSICO (id_musico, nombre, banda)
VALUES ('M005', 'ROGER TAYLOR', 'B002');
INSERT INTO MUSICO (id_musico, nombre, banda)
VALUES ('M006', 'JOHN DEACON', 'B002');
-- RADIO FUTURA
INSERT INTO MUSICO (id_musico, nombre, banda)
VALUES ('M007', 'SANTIAGO AUSERON', 'B003');
INSERT INTO MUSICO (id_musico, nombre, banda)
VALUES ('M008', 'LUIS AUSERON', 'B003');
INSERT INTO MUSICO (id_musico, nombre, banda)
VALUES ('M009', 'ENRIQUE SIERRA', 'B003');
-- VETUSTA MORLA
INSERT INTO MUSICO (id_musico, nombre, banda)
VALUES ('M010', 'PUCHO', 'B004');
INSERT INTO MUSICO (id_musico, nombre, banda)
VALUES ('M011', 'DAVID EL INDIO', 'B004');
INSERT INTO MUSICO (id_musico, nombre, banda)
VALUES ('M012', 'JORGE GONZALEZ', 'B004');
INSERT INTO MUSICO (id_musico, nombre, banda)
VALUES ('M013', 'GUILLERMO GALVAN', 'B004');
INSERT INTO MUSICO (id_musico, nombre, banda)
VALUES ('M014', 'JUANMA LATORRE', 'B004');
-- THE STROKES
INSERT INTO MUSICO (id_musico, nombre, banda)
VALUES ('M015', 'JULIAN CASABLANCAS', 'B005');
INSERT INTO MUSICO (id_musico, nombre, banda)
VALUES ('M016', 'NICK VALENSI', 'B005');
INSERT INTO MUSICO (id_musico, nombre, banda)
VALUES ('M017', 'ALBERT HAMMOND JR.', 'B005');
INSERT INTO MUSICO (id_musico, nombre, banda)
VALUES ('M018', 'NICOLAI GRAITURE', 'B005');
INSERT INTO MUSICO (id_musico, nombre, banda)
VALUES ('M019', 'FABRIZIO MORETTI', 'B005');

-- Reactivar la integridad referencial
ALTER TABLE BANDA ENABLE CONSTRAINT banda_fk_musico;
/*
-- MUSICO_INSTRUMENTO

-- THE STROKES
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M015', 'VOZ');
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M016', 'GUITARRA');
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M017', 'GUITARRA');
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M018', 'BAJO');
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M019', 'BATERIA');


-- VETUSTA MORLA
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M010', 'VOZ');
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M011', 'BATERIA');
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M012', 'OTRO');
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M013', 'GUITARRA');
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M014', 'GUITARRA');
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M014', 'PIANO');

-- EURYTHMICS
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M001', 'VOZ');
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M002', 'GUITARRA');
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M002', 'BAJO');
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M002', 'PIANO');

-- QUEEN
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M003', 'VOZ');
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M003', 'PIANO');
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M004', 'GUITARRA');
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M005', 'BATERIA');
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M006', 'BAJO');

-- RADIO FUTURA
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M007', 'VOZ');
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M007', 'GUITARRA');
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M008', 'BAJO');
INSERT INTO MUSICO_INSTRUMENTO (musico, instrumento)
VALUES ('M009', 'GUITARRA');

-- ALBUM

-- DAVID BOWIE
INSERT INTO ALBUM (id_album, titulo, anno, genero, solista, banda)
VALUES ('A007', 'Space oddity', 1969, 'POP', 'S001', NULL);

INSERT INTO ALBUM (id_album, titulo, anno, genero, solista, banda)
VALUES ('A011', 'Diamond dogs', 1974, 'POP', 'S001', NULL);

-- PRINCE
INSERT INTO ALBUM (id_album, titulo, anno, genero, solista, banda)
VALUES ('A008', 'Prince', 1979, 'POP', 'S002', NULL);

-- SADE
INSERT INTO ALBUM (id_album, titulo, anno, genero, solista, banda)
VALUES ('A009', 'Love deluxe', 1992, 'POP', 'S005', NULL);

-- TINA TURNER
INSERT INTO ALBUM (id_album, titulo, anno, genero, solista, banda)
VALUES ('A010', 'Private dancer', 1984, 'ROCK', 'S003', NULL);

-- SINEAD O'CONNOR
INSERT INTO ALBUM (id_album, titulo, anno, genero, solista, banda)
VALUES ('A012', 'I dont want what I havent got', 1990, 'POP', 'S004', NULL);

-- RADIO FUTURA

INSERT INTO ALBUM (id_album, titulo, anno, genero, solista, banda)
VALUES ('A001', 'De un pais en llamas', 1985, 'ROCK', NULL, 'B003');
-- 
INSERT INTO ALBUM (id_album, titulo, anno, genero, solista, banda)
VALUES ('A002', 'La cancion de Juan Perro', 1987, 'ROCK', NULL, 'B003');

INSERT INTO ALBUM (id_album, titulo, anno, genero, solista, banda)
VALUES ('A003', 'Escuela de calor. Directo', 1989, 'ROCK', NULL, 'B003');

-- QUEEN
INSERT INTO ALBUM (id_album, titulo, anno, genero, solista, banda)
VALUES ('A004', 'A kind of magic', 1975, 'ROCK', NULL, 'B002');

INSERT INTO ALBUM (id_album, titulo, anno, genero, solista, banda)
VALUES ('A005', 'A night at the opera', 1986, 'ROCK', NULL, 'B002');

-- EURYTHMICS
INSERT INTO ALBUM (id_album, titulo, anno, genero, solista, banda)
VALUES ('A006', 'Sweet dreams are made of this', 1975, 'POP', NULL, 'B001');

-- VETUSTA MORLA
INSERT INTO ALBUM (id_album, titulo, anno, genero, solista, banda)
VALUES ('A013', 'Mismo sitio, distinto lugar', 2017, 'INDIE', NULL, 'B004');

-- THE STROKES
INSERT INTO ALBUM (id_album, titulo, anno, genero, solista, banda)
VALUES ('A014', 'Is this it', 2001, 'INDIE', NULL, 'B005');


-- CANCION
-- Se asigna el valor 0 al calculado "cuantas_listas". Se calcula al final. 
-- 7 canciones por album, aunque contenga mas en la realidad.

-- VETUSTA MORLA
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A013', 1, 'Deseame suerte', 3.49, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A013', 2, 'El discurso del rey', 3.42, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A013', 3, 'Palmeras en La Mancha', 3.37, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A013', 4, 'Consejo de sabios', 5.18, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A013', 5, '23 de junio', 3.27, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A013', 6, 'Guerra Civil', 3.35, 0); 
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A013', 7, 'Mismo sitio, distinto lugar', 3.41, 0);

-- THE STROKES
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A014', 1, 'Is this it', 2.35, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A014', 2, 'The modern age', 3.32, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A014', 3, 'Soma', 2.38, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A014', 4, 'Someday', 3.05, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A014', 5, 'Hard to explain', 3.45, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A014', 6, 'Last nite', 3.18, 0); 
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A014', 7, 'New York City cops', 3.36, 0);

-- DAVID BOWIE
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A007', 1, 'Space oddity', 5.15, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A007', 2, 'Letter to Hermione', 2.28, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A007', 3, 'Cygnet committee', 9.33, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A007', 4, 'Janine', 3.18, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A007', 5, 'Wild eyed boy from Freecloud', 4.45, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A007', 6, 'God knows I am good', 3.13, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A007', 7, 'Memory of a free festival', 7.05, 0);
--
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A011', 1, 'Future legend', 1.05, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A011', 2, 'Diamond dogs', 5.56, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A011', 3, 'Sweet thing', 3.39, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A011', 4, 'Candidate', 2.40, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A011', 5, 'Rebel rebel', 4.30, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A011', 6, 'We are the dead', 4.59, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A011', 7, '1984', 3.27, 0); -- versionada por Tina Turner


-- PRINCE
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A008', 1, 'I wanna be your lover', 5.49, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A008', 2, 'Why you wanna treat me so bad?', 3.49, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A008', 3, 'Sexy dancer', 4.18, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A008', 4, 'Whith you', 4.00, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A008', 5, 'Bambi', 4.22, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A008', 6, 'Stil waiting', 4.12, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A008', 7, 'I feel for you', 3.24, 0);

-- TINA TURNER
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A010', 1, 'I might have been queen', 4.10, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A010', 2, 'What is love got to do with it', 3.49, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A010', 3, 'Show some respect', 3.18, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A010', 4, 'I cannot stand the rain', 3.41, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A010', 5, 'Private dancer', 7.11, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A010', 6, 'Help!', 4.30, 0); -- version de la de The Beatles
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A010', 7, '1984', 3.09, 0); -- version de 'A011', 7 de David Bowie

-- SINEAD O'CONNOR
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A012', 1, 'Feel so different', 6.47, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A012', 2, 'Three babies', 4.47, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A012', 3, 'The emperors new clothes', 5.16, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A012', 4, 'Black boys on mopeds', 3.53, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A012', 5, 'Nothing compares 2 U', 5.10, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A012', 6, 'Jum in the river', 4.12, 0); 
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A012', 7, 'You cause as much sorrow', 5.04, 0);



-- SADE
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A009', 1, 'No ordinary love', 7.20, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A009', 2, 'Feel no pain', 5.08, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A009', 3, 'Like a tattoo', 3.38, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A009', 4, 'Kiss of life', 5.50, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A009', 5, 'Cherish the day', 5.34, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A009', 6, 'Pearls', 4.34, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A009', 7, 'Mermaid', 4.23, 0);

--RADIO FUTURA
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A001', 1, 'No tocarte', 4.29, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A001', 2, 'La ciudad interior', 4.30, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A001', 3, 'El tonto Simon', 5.12, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A001', 4, 'El viento de Africa', 3.32, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A001', 5, 'Las lineas de la mano', 4.26, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A001', 6, 'Un vaso de agua (al enemigo)', 3.57, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A001', 7, 'La vida en la frontera', 5.42, 0);
--
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A002', 1, 'En un baile de perros', 2.29, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A002', 2, 'A cara o cruz', 5.41, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A002', 3, 'Lluvia del porvenir', 5.12, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A002', 4, 'La negra flor', 5.20, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A002', 5, '37 grados', 4.28, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A002', 6, 'Annabel Lee', 3.45, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A002', 7, 'Paseo con la negra flor', 7.49, 0);
--
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A003', 1, 'Escuela de calor', 3.34, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A003', 2, 'Han caido los dos', 3.48, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A003', 3, 'A cara o cruz', 6.02, 0); -- version de la A002,2 de R.F.
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A003', 4, 'Luna de Agosto', 3.27, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A003', 5, 'El tonto Simon', 4.45, 0); -- version de la A001,3 de R.F.
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A003', 6, 'No tocarte', 3.50, 0); -- version de la A001,1 de R.F.
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A003', 7, 'El canto del gallo', 5.43, 0);

-- QUEEN
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A004', 1, 'One vision', 5.12, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A004', 2, 'A kind of magic', 4.25, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A004', 3, 'One year of love', 4.30, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A004', 4, 'Friends will be friends', 4.10, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A004', 5, 'Who wants to live forever', 5.20, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A004', 6, 'Don t lose your head', 4.40, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A004', 7, 'Princes of the universe', 3.34, 0);
--
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A005', 1, 'Death on two legs', 3.44, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A005', 2, 'I am in love with my car', 3.05, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A005', 3, 'You are my best friend', 2.50, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A005', 4, '39', 3.31, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A005', 5, 'Love of my life', 3.34, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A005', 6, 'Good company', 3.24, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A005', 7, 'Bohemian rhapsody', 5.55, 0);

-- EURYTHMICS
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A006', 1, 'Love is a stranger', 3.43, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A006', 2, 'I have got an angel', 2.45, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A006', 3, 'I could give you (a mirror)', 3.51, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A006', 4, 'The walk', 4.40, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A006', 5, 'Sweet dreams are made of this', 3.36, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A006', 6, 'Somebody told me', 3.29, 0);
INSERT INTO CANCION (album, posicion, titulo, duracion, cuantas_listas)
VALUES ('A006', 7, 'This city never sleeps', 6.33, 0);
*/
-- USUARIO
INSERT INTO USUARIO (id_usuario, nombre, email, telefono, tipo, cuota, invitador, ultimo_acceso)
VALUES ('U001', 'CASILDA', NULL, '+34555111000', 'PREMIUM INDIVIDUAL', 12, NULL, TO_DATE('15/01/2023', 'dd/mm/yyyy'));
INSERT INTO USUARIO (id_usuario, nombre, email, telefono, tipo, cuota, invitador, ultimo_acceso)
VALUES ('U590', 'NICANOR', 'nica@mail.com', NULL, 'GRATUITO', 0, 'U001', TO_DATE('25/02/2019', 'dd/mm/yyyy'));
INSERT INTO USUARIO (id_usuario, nombre, email, telefono, tipo, cuota, invitador, ultimo_acceso)
VALUES ('U112', 'TULIO', NULL, '+34555222000', 'PREMIUM DOS', 15, 'U001', TO_DATE('09/11/2022', 'dd/mm/yyyy'));
INSERT INTO USUARIO (id_usuario, nombre, email, telefono, tipo, cuota, invitador, ultimo_acceso)
VALUES ('U840', 'ANACLETA', 'anac@mail.com', NULL, 'GRATUITO', 0, 'U001', TO_DATE('14/02/2019', 'dd/mm/yyyy'));
INSERT INTO USUARIO (id_usuario, nombre, email, telefono, tipo, cuota, invitador, ultimo_acceso)
VALUES ('U252', 'MELANIO', NULL, '+34555333000', 'GRATUITO', 0, 'U112', TO_DATE('06/10/2019', 'dd/mm/yyyy'));
INSERT INTO USUARIO (id_usuario, nombre, email, telefono, tipo, cuota, invitador, ultimo_acceso)
VALUES ('U464', 'SILVANA', 'silv@mail.com', NULL, 'GRATUITO', 0, 'U112', TO_DATE('24/05/2020', 'dd/mm/yyyy'));
INSERT INTO USUARIO (id_usuario, nombre, email, telefono, tipo, cuota, invitador, ultimo_acceso)
VALUES ('U035', 'BONIFACIO', NULL, '+34555444000', 'PREMIUM INDIVIDUAL', 12, 'U590', TO_DATE('16/06/2022', 'dd/mm/yyyy'));
INSERT INTO USUARIO (id_usuario, nombre, email, telefono, tipo, cuota, invitador, ultimo_acceso)
VALUES ('U236', 'JEREMIAS', 'jere@mail.com', NULL, 'PREMIUM DOS', 14, 'U840', TO_DATE('29/01/2023', 'dd/mm/yyyy'));
INSERT INTO USUARIO (id_usuario, nombre, email, telefono, tipo, cuota, invitador, ultimo_acceso)
VALUES ('U371', 'ROSAURA', NULL, '+34555555000', 'PREMIUM FAMILIAR', 25, NULL, TO_DATE('26/10/2018', 'dd/mm/yyyy'));
INSERT INTO USUARIO (id_usuario, nombre, email, telefono, tipo, cuota, invitador, ultimo_acceso)
VALUES ('U747', 'URBANO', 'urba@mail.com', NULL, 'GRATUITO', 0, 'U464', TO_DATE('30/11/2019', 'dd/mm/yyyy'));
INSERT INTO USUARIO (id_usuario, nombre, email, telefono, tipo, cuota, invitador, ultimo_acceso)
VALUES ('U624', 'RENATA', 'rena@mail.com', NULL, 'GRATUITO', 0, 'U464', TO_DATE('21/12/2018', 'dd/mm/yyyy'));
INSERT INTO USUARIO (id_usuario, nombre, email, telefono, tipo, cuota, invitador, ultimo_acceso)
VALUES ('U555', 'TURIANO', 'turi@mail.com', NULL, 'GRATUITO', 0, 'U035', TO_DATE('15/06/2019', 'dd/mm/yyyy'));

-- LISTA
INSERT INTO LISTA (usuario, num_lista, nombre, descripcion)
VALUES ('U001', 1, 'FIESTA!', 'Musica disco');
INSERT INTO LISTA (usuario, num_lista, nombre, descripcion)
VALUES ('U001', 2, 'RELAX', NULL);
INSERT INTO LISTA (usuario, num_lista, nombre, descripcion)
VALUES ('U001', 3, 'VIAJES', 'Para no dormirse al volante');

INSERT INTO LISTA (usuario, num_lista, nombre, descripcion)
VALUES ('U840', 1, 'RUNNING OUT', 'Correr por el monte');
INSERT INTO LISTA (usuario, num_lista, nombre, descripcion)
VALUES ('U840', 2, 'RUNNING IN', 'Correr por la ciudad');


INSERT INTO LISTA (usuario, num_lista, nombre, descripcion)
VALUES ('U464', 1, 'MI LISTA', 'Mientras programo SQL');

INSERT INTO LISTA (usuario, num_lista, nombre, descripcion)
VALUES ('U236', 1, 'FAVORITAS', NULL);
INSERT INTO LISTA (usuario, num_lista, nombre, descripcion)
VALUES ('U236', 2, 'TEMAZOS', 'Para venirse arriba');

INSERT INTO LISTA (usuario, num_lista, nombre, descripcion)
VALUES ('U371', 1, 'MI LISTA', NULL);

INSERT INTO LISTA (usuario, num_lista, nombre, descripcion)
VALUES ('U747', 1, 'MI LISTA', NULL);
INSERT INTO LISTA (usuario, num_lista, nombre, descripcion)
VALUES ('U747', 2, 'MI OTRA LISTA', NULL);

-- LISTA_CANCION
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U001', 1, 'A001', 1, TO_DATE('01/01/2021', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U001', 1, 'A002', 2, TO_DATE('01/01/2021', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U001', 1, 'A003', 7, TO_DATE('03/03/2021', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U001', 1, 'A004', 4, TO_DATE('01/01/2021', 'dd/mm/yyyy'));

INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U001', 2, 'A001', 2, TO_DATE('22/06/2022', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U001', 2, 'A002', 4, TO_DATE('09/04/2022', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U001', 2, 'A003', 6, TO_DATE('03/03/2022', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U001', 2, 'A004', 2, TO_DATE('01/01/2023', 'dd/mm/yyyy'));

INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U001', 3, 'A010', 3, TO_DATE('10/05/2022', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U001', 3, 'A011', 5, TO_DATE('21/07/2022', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U001', 3, 'A012', 7, TO_DATE('30/03/2022', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U001', 3, 'A013', 3, TO_DATE('07/07/2022', 'dd/mm/yyyy'));

INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U840', 1, 'A006', 5, TO_DATE('01/01/2019', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U840', 1, 'A014', 6, TO_DATE('10/01/2019', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U840', 1, 'A012', 5, TO_DATE('12/01/2019', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U840', 1, 'A010', 6, TO_DATE('12/01/2019', 'dd/mm/yyyy'));

INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U840', 2, 'A014', 2, TO_DATE('01/02/2019', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U840', 2, 'A006', 2, TO_DATE('10/02/2019', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U840', 2, 'A002', 5, TO_DATE('12/02/2019', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U840', 2, 'A002', 1, TO_DATE('12/02/2019', 'dd/mm/yyyy'));

INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U464', 1, 'A002', 6, TO_DATE('14/09/2019', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U464', 1, 'A011', 5, TO_DATE('10/05/2020', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U464', 1, 'A003', 4, TO_DATE('10/05/2020', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U464', 1, 'A014', 3, TO_DATE('10/05/2020', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U464', 1, 'A001', 6, TO_DATE('20/05/2020', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U464', 1, 'A010', 5, TO_DATE('21/05/2020', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U464', 1, 'A002', 4, TO_DATE('22/05/2020', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U464', 1, 'A013', 3, TO_DATE('24/05/2020', 'dd/mm/yyyy'));

INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U236', 1, 'A005', 1, TO_DATE('12/01/2021', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U236', 1, 'A005', 2, TO_DATE('12/01/2021', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U236', 1, 'A005', 3, TO_DATE('12/01/2021', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U236', 1, 'A005', 4, TO_DATE('12/01/2021', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U236', 1, 'A005', 5, TO_DATE('12/01/2021', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U236', 1, 'A005', 6, TO_DATE('12/01/2021', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U236', 1, 'A005', 7, TO_DATE('12/01/2021', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U236', 1, 'A004', 1, TO_DATE('12/01/2021', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U236', 1, 'A004', 2, TO_DATE('12/01/2021', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U236', 1, 'A004', 3, TO_DATE('12/01/2021', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U236', 1, 'A004', 4, TO_DATE('12/01/2021', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U236', 1, 'A004', 5, TO_DATE('12/01/2021', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U236', 1, 'A004', 6, TO_DATE('12/01/2021', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U236', 1, 'A004', 7, TO_DATE('12/01/2021', 'dd/mm/yyyy'));

INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U236', 2, 'A007', 1, TO_DATE('29/08/2022', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U236', 2, 'A007', 2, TO_DATE('29/08/2022', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U236', 2, 'A013', 3, TO_DATE('20/08/2022', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U236', 2, 'A013', 4, TO_DATE('22/09/2022', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U236', 2, 'A013', 5, TO_DATE('31/08/2022', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U236', 2, 'A009', 3, TO_DATE('28/02/2023', 'dd/mm/yyyy'));

INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U371', 1, 'A009', 1, TO_DATE('26/01/2018', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U371', 1, 'A009', 7, TO_DATE('12/04/2018', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U371', 1, 'A008', 1, TO_DATE('30/05/2018', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U371', 1, 'A006', 1, TO_DATE('22/07/2018', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U371', 1, 'A006', 7, TO_DATE('31/08/2018', 'dd/mm/yyyy'));

INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U747', 1, 'A003', 1, TO_DATE('26/01/2019', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U747', 1, 'A009', 3, TO_DATE('27/01/2019', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U747', 1, 'A008', 3, TO_DATE('12/02/2019', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U747', 1, 'A011', 2, TO_DATE('28/02/2019', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U747', 1, 'A006', 7, TO_DATE('28/02/2019', 'dd/mm/yyyy'));

INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U747', 2, 'A003', 1, TO_DATE('29/01/2019', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U747', 2, 'A008', 3, TO_DATE('12/02/2019', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U747', 2, 'A009', 3, TO_DATE('22/03/2019', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U747', 2, 'A011', 2, TO_DATE('30/03/2019', 'dd/mm/yyyy'));
INSERT INTO LISTA_CANCION (usuario, lista, album, cancion, fecha)
VALUES ('U747', 2, 'A006', 7, TO_DATE('31/03/2019', 'dd/mm/yyyy'));


-- confirmar los datos introducidos 
COMMIT;     
/*
-- Calcular el valor de la columna calculada CANCION.cuantas_listas

UPDATE CANCION C
  SET cuantas_listas = (SELECT COUNT(*) 
                        FROM LISTA_CANCION L
                        WHERE L.album = C.album 
                          AND L.cancion = C.posicion);
-- 98 filas actualizadas
COMMIT;
*/
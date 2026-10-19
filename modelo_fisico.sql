
BEGIN;

CREATE TABLE estudiante (
    id_estudiante INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    apellido VARCHAR(80) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_estudiante_correo CHECK (POSITION('@' IN correo) > 1)
);

CREATE TABLE perfil (
    id_perfil INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_estudiante INTEGER NOT NULL UNIQUE,
    biografia VARCHAR(300),
    semestre SMALLINT,
    CONSTRAINT chk_perfil_semestre CHECK (semestre BETWEEN 1 AND 12),
    CONSTRAINT fk_perfil_estudiante FOREIGN KEY (id_estudiante)
      REFERENCES estudiante (id_estudiante)
      ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE materia (
    id_materia INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(300)
);

CREATE TABLE publicacion (
    id_publicacion INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_estudiante INTEGER NOT NULL,
    id_materia INTEGER NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    contenido TEXT NOT NULL,
    fecha_publicacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_publicacion_titulo CHECK (LENGTH(TRIM(titulo)) > 0),
    CONSTRAINT chk_publicacion_contenido CHECK (LENGTH(TRIM(contenido)) > 0),
    CONSTRAINT fk_publicacion_estudiante FOREIGN KEY (id_estudiante)
      REFERENCES estudiante (id_estudiante)
      ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_publicacion_materia FOREIGN KEY (id_materia)
      REFERENCES materia (id_materia)
      ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE INDEX idx_publicacion_estudiante ON publicacion (id_estudiante);
CREATE INDEX idx_publicacion_materia ON publicacion (id_materia);
COMMIT;

-- COMPROBACIÓN OPCIONAL: ejecutar por separado después de crear las tablas.
-- INSERT INTO estudiante(nombre,apellido,correo) VALUES ('Ana','Gomez','ana@ejemplo.edu');
-- INSERT INTO materia(nombre,descripcion) VALUES ('Bases de datos','Consultas y modelado');
-- INSERT INTO perfil(id_estudiante,biografia,semestre) VALUES (1,'Me gusta aprender SQL',3);
-- INSERT INTO publicacion(id_estudiante,id_materia,titulo,contenido) VALUES (1,1,'Duda de claves','¿Cómo funciona una clave foránea?');
-- SELECT p.titulo, e.nombre, m.nombre AS materia FROM publicacion p JOIN estudiante e ON e.id_estudiante=p.id_estudiante JOIN materia m ON m.id_materia=p.id_materia;

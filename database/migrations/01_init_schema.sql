-- DROP SCHEMA indiedev_hub;

CREATE SCHEMA indiedev_hub AUTHORIZATION "user";

-- DROP SEQUENCE indiedev_hub.colaboraciones_id_seq;

CREATE SEQUENCE indiedev_hub.colaboraciones_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE indiedev_hub.colaboraciones_id_seq OWNER TO "user";
GRANT ALL ON SEQUENCE indiedev_hub.colaboraciones_id_seq TO "user";

-- DROP SEQUENCE indiedev_hub.proyectos_id_seq;

CREATE SEQUENCE indiedev_hub.proyectos_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE indiedev_hub.proyectos_id_seq OWNER TO "user";
GRANT ALL ON SEQUENCE indiedev_hub.proyectos_id_seq TO "user";

-- DROP SEQUENCE indiedev_hub.tareas_id_seq;

CREATE SEQUENCE indiedev_hub.tareas_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE indiedev_hub.tareas_id_seq OWNER TO "user";
GRANT ALL ON SEQUENCE indiedev_hub.tareas_id_seq TO "user";

-- DROP SEQUENCE indiedev_hub.usuarios_id_seq;

CREATE SEQUENCE indiedev_hub.usuarios_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE indiedev_hub.usuarios_id_seq OWNER TO "user";
GRANT ALL ON SEQUENCE indiedev_hub.usuarios_id_seq TO "user";
-- indiedev_hub.usuarios definition

-- Drop table

-- DROP TABLE indiedev_hub.usuarios;

CREATE TABLE indiedev_hub.usuarios (
	id serial4 NOT NULL,
	nombre varchar(50) NOT NULL,
	email varchar(100) NOT NULL,
	"password" varchar(100) NOT NULL,
	rol varchar(20) NULL,
	fecha_registro date DEFAULT CURRENT_DATE NULL,
	CONSTRAINT usuarios_email_key UNIQUE (email),
	CONSTRAINT usuarios_pkey PRIMARY KEY (id),
	CONSTRAINT usuarios_rol_check CHECK (((rol)::text = ANY ((ARRAY['programador'::character varying, 'artista'::character varying, 'diseñador'::character varying])::text[])))
);

-- Permissions

ALTER TABLE indiedev_hub.usuarios OWNER TO "user";
GRANT ALL ON TABLE indiedev_hub.usuarios TO "user";


-- indiedev_hub.proyectos definition

-- Drop table

-- DROP TABLE indiedev_hub.proyectos;

CREATE TABLE indiedev_hub.proyectos (
	id serial4 NOT NULL,
	nombre varchar(100) NOT NULL,
	descripcion text NULL,
	genero varchar(30) NULL,
	fecha_creacion date DEFAULT CURRENT_DATE NULL,
	creador_id int4 NULL,
	CONSTRAINT proyectos_pkey PRIMARY KEY (id),
	CONSTRAINT proyectos_creador_id_fkey FOREIGN KEY (creador_id) REFERENCES indiedev_hub.usuarios(id)
);

-- Permissions

ALTER TABLE indiedev_hub.proyectos OWNER TO "user";
GRANT ALL ON TABLE indiedev_hub.proyectos TO "user";


-- indiedev_hub.tareas definition

-- Drop table

-- DROP TABLE indiedev_hub.tareas;

CREATE TABLE indiedev_hub.tareas (
	id serial4 NOT NULL,
	proyecto_id int4 NOT NULL,
	titulo varchar(100) NOT NULL,
	descripcion text NULL,
	responsable_id int4 NULL,
	estado varchar(20) DEFAULT 'pendiente'::character varying NULL,
	fecha_limite date NULL,
	CONSTRAINT tareas_estado_check CHECK (((estado)::text = ANY ((ARRAY['pendiente'::character varying, 'en_progreso'::character varying, 'completada'::character varying])::text[]))),
	CONSTRAINT tareas_pkey PRIMARY KEY (id),
	CONSTRAINT tareas_proyecto_id_fkey FOREIGN KEY (proyecto_id) REFERENCES indiedev_hub.proyectos(id),
	CONSTRAINT tareas_responsable_id_fkey FOREIGN KEY (responsable_id) REFERENCES indiedev_hub.usuarios(id)
);

-- Permissions

ALTER TABLE indiedev_hub.tareas OWNER TO "user";
GRANT ALL ON TABLE indiedev_hub.tareas TO "user";


-- indiedev_hub.colaboraciones definition

-- Drop table

-- DROP TABLE indiedev_hub.colaboraciones;

CREATE TABLE indiedev_hub.colaboraciones (
	id serial4 NOT NULL,
	usuario_id int4 NOT NULL,
	proyecto_id int4 NOT NULL,
	rol varchar(50) NOT NULL,
	fecha_union date DEFAULT CURRENT_DATE NULL,
	CONSTRAINT colaboraciones_pkey PRIMARY KEY (id),
	CONSTRAINT colaboraciones_usuario_id_proyecto_id_key UNIQUE (usuario_id, proyecto_id),
	CONSTRAINT colaboraciones_proyecto_id_fkey FOREIGN KEY (proyecto_id) REFERENCES indiedev_hub.proyectos(id),
	CONSTRAINT colaboraciones_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES indiedev_hub.usuarios(id)
);

-- Permissions

ALTER TABLE indiedev_hub.colaboraciones OWNER TO "user";
GRANT ALL ON TABLE indiedev_hub.colaboraciones TO "user";




-- Permissions

GRANT ALL ON SCHEMA indiedev_hub TO "user";-- DROP SCHEMA indiedev_hub;

CREATE SCHEMA indiedev_hub AUTHORIZATION "user";

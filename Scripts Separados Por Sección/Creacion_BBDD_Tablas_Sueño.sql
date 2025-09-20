-- ******************** Creación de base de datos. ********************

CREATE DATABASE IF NOT EXISTS analisis_sueno;
USE analisis_sueno;

CREATE TABLE generos (
	id_genero INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50)
);

-- Información básica del usuario
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    edad INT NOT NULL CHECK (edad >= 0),
    email VARCHAR(150) NOT NULL UNIQUE,
    fecha_registro DATE DEFAULT (CURRENT_DATE),
    id_genero INT NOT NULL,
    FOREIGN KEY (id_genero) REFERENCES generos(id_genero)
		ON DELETE RESTRICT
        ON UPDATE CASCADE,
	peso_kg DECIMAL(5,2) CHECK (peso_kg > 0),
    altura_cm INT CHECK (altura_cm > 0),
    ocupacion VARCHAR(50)
);

CREATE TABLE tipos_dispositivos (
	id_tipo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50)
);

-- Marca/modelo de dispositivos utilizados para recolectar datos; cada dispositivo está vinculado a un usuario
CREATE TABLE dispositivos (
    id_dispositivo INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    id_tipo INT NOT NULL,
    anio_fabricacion INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (id_tipo) REFERENCES tipos_dispositivos(id_tipo)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);

CREATE TABLE calidad_percibida (
	id_calidad_percibida INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

-- Registra cada sesión de sueño de los usuarios
CREATE TABLE sesiones_sueno (
    id_sesion INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_dispositivo INT NOT NULL,
    fecha DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    lugar VARCHAR(100),
    duracion_total_minutos INT CHECK(duracion_total_minutos >=0),
    id_calidad_percibida INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (id_dispositivo) REFERENCES dispositivos(id_dispositivo)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (id_calidad_percibida) REFERENCES calidad_percibida(id_calidad_percibida)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);

CREATE TABLE fases_sueno (
    id_fase INT PRIMARY KEY AUTO_INCREMENT,
    id_sesion INT NOT NULL,
    tipo_fase ENUM('REM', 'Profundo', 'Ligero') NOT NULL,
    inicio_fase TIME DEFAULT (CURRENT_TIME),
    fin_fase TIME NOT NULL,
    duracion_minutos INT NOT NULL CHECK(duracion_minutos >=0),
    FOREIGN KEY (id_sesion) REFERENCES sesiones_sueno(id_sesion)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE interrupciones (
    id_interrupcion INT PRIMARY KEY AUTO_INCREMENT,
    id_sesion INT NOT NULL,
    hora_interrupcion TIME DEFAULT (CURRENT_TIME),
    duracion_minutos INT NOT NULL CHECK(duracion_minutos >=0),
    FOREIGN KEY (id_sesion) REFERENCES sesiones_sueno(id_sesion)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE nivel_ruido (
	id_nivel_ruido INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE nivel_iluminacion (
	id_nivel_iluminacion INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE factores_externos (
    id_factor INT PRIMARY KEY AUTO_INCREMENT,
    id_sesion INT NOT NULL,
    temperatura_centigrados DECIMAL(3,1),
    id_nivel_ruido INT NOT NULL,
    id_nivel_iluminacion INT NOT NULL,
    FOREIGN KEY (id_sesion) REFERENCES sesiones_sueno(id_sesion)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (id_nivel_ruido) REFERENCES nivel_ruido(id_nivel_ruido)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
    FOREIGN KEY (id_nivel_iluminacion) REFERENCES nivel_iluminacion(id_nivel_iluminacion)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);
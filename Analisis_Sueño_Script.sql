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

-- ******************** Carga de datos inicial. ********************

-- Generos
INSERT INTO generos (nombre) VALUES
('Masculino'), ('Femenino'), ('Otro');

-- Usuarios
INSERT INTO usuarios (nombre, apellido, edad, email, id_genero, peso_kg, altura_cm, ocupacion) VALUES
('Ana', 'Martínez', 29, 'ana.martinez@example.com', 2, 68, 165, 'Ingeniera'),
('Luis', 'Gómez', 35, 'luis.gomez@example.com', 1, 85, 175, 'Abogado'),
('Patricia', 'Lozano', 42, 'pat.lozano@example.com', 2, 72, 160, 'Doctora'),
('Carlos', 'Reyes', 27, 'carlos.reyes@example.com', 1, 95, 180, 'Profesor'),
('Sofía', 'Torres', 31, 'sofia.torres@example.com', 2, 60, 162, 'Arquitecta'),
('Jorge', 'Vera', 45, 'jorge.vera@example.com', 1, 90, 178, 'Contador'),
('Lucía', 'Paredes', 38, 'lucia.paredes@example.com', 2, 55, 170, 'Diseñadora'),
('Andrés', 'Mendoza', 22, 'andres.mendoza@example.com', 1, 78, 172, 'Estudiante'),
('Valeria', 'Salazar', 34, 'valeria.salazar@example.com', 2, 65, 168, 'Psicóloga'),
('Diego', 'Navarro', 40, 'diego.navarro@example.com', 1, 88, 176, 'Ingeniero');

-- Tipos_dispositivos
INSERT INTO tipos_dispositivos (nombre) VALUES
('Reloj'), ('Celular'), ('Tablet'), ('Otro');

-- Dispositivos
INSERT INTO dispositivos (id_usuario, marca, modelo, id_tipo, anio_fabricacion) VALUES
(1, 'Fitbit', 'Charge 5', 1, 2022),
(2, 'Garmin', 'Vivosmart 4', 1, 2021),
(3, 'Xiaomi', 'Mi Band 6', 1, 2022),
(4, 'Apple', 'iPhone 14', 2, 2023),
(5, 'Samsung', 'Galaxy S23', 2, 2023),
(6, 'Huawei', 'Band 7', 1, 2022),
(7, 'Polar', 'Ignite 2', 1, 2021),
(8, 'Withings', 'Sleep Analyzer', 1, 2020),
(9, 'Oura', 'Ring Gen3', 1, 2023),
(10, 'Amazfit', 'Bip U Pro', 1, 2022);

-- Calidad_percibida
INSERT INTO calidad_percibida (nombre) VALUES
('Mala'), ('Media'), ('Buena');

-- Sesiones_sueño
INSERT INTO sesiones_sueno (id_usuario, id_dispositivo, fecha, lugar, duracion_total_minutos, id_calidad_percibida) VALUES
(1, 1, '2025-09-10 22:30:00', 'Dormitorio', 420, 3),
(2, 2, '2025-09-10 23:00:00', 'Dormitorio', 360, 2),
(3, 3, '2025-09-09 21:45:00', 'Dormitorio', 480, 3),
(4, 4, '2025-09-08 00:15:00', 'Hotel', 300, 1),
(5, 5, '2025-09-07 23:30:00', 'Dormitorio', 390, 2),
(6, 6, '2025-09-06 22:00:00', 'Sala', 450, 3),
(7, 7, '2025-09-05 23:15:00', 'Oficina', 330, 1),
(8, 8, '2025-09-04 22:45:00', 'Dormitorio', 400, 2),
(9, 9, '2025-09-03 23:00:00', 'Dormitorio', 420, 3),
(10, 10, '2025-09-02 22:30:00', 'Dormitorio', 360, 2),
(1, 1, '2025-09-01 22:15:00', 'Hotel', 390, 3),
(2, 2, '2025-08-31 23:00:00', 'Dormitorio', 300, 1),
(3, 3, '2025-08-30 22:45:00', 'Sala', 480, 3),
(4, 4, '2025-08-29 00:00:00', 'Dormitorio', 270, 1),
(5, 5, '2025-08-28 23:30:00', 'Dormitorio', 420, 2),
(6, 6, '2025-08-27 22:00:00', 'Hotel', 450, 3),
(7, 7, '2025-08-26 23:15:00', 'Sala', 330, 1),
(8, 8, '2025-08-25 22:45:00', 'Dormitorio', 400, 2),
(9, 9, '2025-08-24 23:00:00', 'Dormitorio', 420, 3),
(10, 10, '2025-08-23 22:30:00', 'Hotel', 360, 2);
 
-- Fases_sueño
INSERT INTO fases_sueno (id_sesion, tipo_fase, inicio_fase, fin_fase, duracion_minutos) VALUES
(1, 'Ligero', '22:30:00', '01:30:00', 180), (1, 'Profundo', '01:30:00', '04:00:00', 150), (1, 'REM', '04:00:00', '05:30:00', 90),
(2, 'Ligero', '23:00:00', '01:00:00', 120), (2, 'Profundo', '01:00:00', '03:00:00', 120), (2, 'REM', '03:00:00', '05:00:00', 120),
(3, 'Ligero', '21:45:00', '00:45:00', 180), (3, 'Profundo', '00:45:00', '03:45:00', 180), (3, 'REM', '03:45:00', '05:45:00', 120),
(4, 'Ligero', '00:15:00', '01:45:00', 90), (4, 'Profundo', '01:45:00', '03:15:00', 90), (4, 'REM', '03:15:00', '05:15:00', 120),
(5, 'Ligero', '23:30:00', '01:30:00', 120), (5, 'Profundo', '01:30:00', '03:45:00', 135), (5, 'REM', '03:45:00', '05:15:00', 135),
(6, 'Ligero', '22:00:00', '01:00:00', 180), (6, 'Profundo', '01:00:00', '04:00:00', 180), (6, 'REM', '04:00:00', '05:30:00', 90),
(7, 'Ligero', '23:15:00', '00:45:00', 90), (7, 'Profundo', '00:45:00', '02:45:00', 120), (7, 'REM', '02:45:00', '04:45:00', 120),
(8, 'Ligero', '22:45:00', '01:15:00', 150), (8, 'Profundo', '01:15:00', '03:45:00', 150), (8, 'REM', '03:45:00', '05:25:00', 100),
(9, 'Ligero', '23:00:00', '01:00:00', 120), (9, 'Profundo', '01:00:00', '04:00:00', 180), (9, 'REM', '04:00:00', '05:30:00', 120),
(10, 'Ligero', '22:30:00', '00:00:00', 90), (10, 'Profundo', '00:00:00', '02:15:00', 135), (10, 'REM', '02:15:00', '04:30:00', 135),
(11, 'Ligero', '22:15:00', '00:15:00', 120), (11, 'Profundo', '00:15:00', '02:45:00', 150), (11, 'REM', '02:45:00', '04:45:00', 120),
(12, 'Ligero', '22:45:00', '01:15:00', 150), (12, 'Profundo', '01:15:00', '04:15:00', 180), (12, 'REM', '04:15:00', '06:15:00', 120),
(13, 'Ligero', '22:30:00', '01:30:00', 180), (13, 'Profundo', '01:30:00', '04:30:00', 180), (13, 'REM', '04:30:00', '06:30:00', 120),
(14, 'Ligero', '00:00:00', '01:00:00', 60), (14, 'Profundo', '01:00:00', '03:00:00', 120), (14, 'REM', '03:00:00', '04:30:00', 90),
(15, 'Ligero', '23:30:00', '01:30:00', 120), (15, 'Profundo', '01:30:00', '03:45:00', 135), (15, 'REM', '03:45:00', '05:45:00', 165),
(16, 'Ligero', '22:00:00', '01:30:00', 150), (16, 'Profundo', '01:30:00', '04:30:00', 180), (16, 'REM', '04:30:00', '06:30:00', 120),
(17, 'Ligero', '23:15:00', '00:45:00', 90), (17, 'Profundo', '00:45:00', '02:45:00', 120), (17, 'REM', '02:45:00', '04:45:00', 120),
(18, 'Ligero', '22:45:00', '01:45:00', 180), (18, 'Profundo', '01:45:00', '04:00:00', 135), (18, 'REM', '04:00:00', '05:25:00', 85),
(19, 'Ligero', '23:00:00', '01:00:00', 120), (19, 'Profundo', '01:00:00', '04:00:00', 180), (19, 'REM', '04:00:00', '05:30:00', 120),
(20, 'Ligero', '23:30:00', '00:45:00', 75), (20, 'Profundo', '00:45:00', '03:00:00', 135), (20, 'REM', '03:00:00', '05:00:00', 150);

-- Interrupciones
INSERT INTO interrupciones (id_sesion, hora_interrupcion, duracion_minutos) VALUES
(1, '23:45:00', 10), (1, '02:00:00', 5),
(2, '00:30:00', 8), (2, '03:15:00', 6),
(3, '01:15:00', 12), (3, '04:00:00', 7),
(4, '01:30:00', 5), (5, '00:45:00', 10),
(5, '02:30:00', 6), (6, '02:00:00', 7),
(6, '03:45:00', 5), (7, '00:30:00', 8),
(8, '01:15:00', 6), (8, '03:30:00', 5),
(9, '02:45:00', 10), (10, '00:45:00', 7),
(10, '03:00:00', 6), (11, '01:30:00', 8),
(12, '02:15:00', 7), (12, '04:30:00', 5),
(13, '00:30:00', 10), (14, '01:00:00', 6),
(14, '02:30:00', 5), (15, '03:00:00', 7),
(16, '00:45:00', 8), (16, '03:30:00', 6),
(17, '01:15:00', 5), (18, '02:00:00', 9),
(19, '01:30:00', 6), (19, '04:00:00', 5),
(20, '00:30:00', 7), (20, '02:15:00', 6);

-- Nivel_ruido
INSERT INTO nivel_ruido (nombre) VALUES
('Bajo'), ('Medio'), ('Alto');

-- Nivel_iluminacion
INSERT INTO nivel_iluminacion (nombre) VALUES
('Baja'), ('Media'), ('Alta');

-- Factores_externos
INSERT INTO factores_externos (id_sesion, temperatura_centigrados, id_nivel_ruido, id_nivel_iluminacion) VALUES
(1, 23.0, 1, 1), (2, 25.0, 2, 2), (3, 27.0, 3, 2),
(4, 21.0, 2, 1), (5, 22.5, 1, 1), (6, 24.5, 2, 3),
(7, 28.0, 3, 2), (8, 23.5, 2, 3), (9, 22.0, 1, 1),
(10, 26.5, 2, 1), (11, 23.0, 1, 1), (12, 25.5, 2, 2),
(13, 21.5, 1, 1), (14, 27.0, 3, 2), (15, 22.5, 1, 1),
(16, 24.0, 2, 2), (17, 23.0, 1, 2), (18, 28.0, 3, 3),
(19, 22.0, 1, 1), (20, 25.0, 2, 2);

-- ******************** Consultas SQL para responder las preguntas de análisis. ********************

-- ¿Cuál es la duración promedio del sueño por usuario?
SELECT u.nombre, u.apellido, ROUND(AVG(s.duracion_total_minutos), 2) AS duracion_promedio_minutos, ROUND(AVG(s.duracion_total_minutos)/60, 2) AS duracion_promedio_horas
FROM usuarios u
JOIN sesiones_sueno s
ON u.id_usuario = s.id_usuario
GROUP BY u.id_usuario, u.nombre, u.apellido
ORDER BY duracion_promedio_minutos DESC;

-- ¿Qué porcentaje del sueño corresponde a cada fase (REM, profundo, ligero)?
SELECT tipo_fase, ROUND(AVG(porcentaje_por_sesion), 2) AS porcentaje_promedio
FROM (
    SELECT f.id_sesion, f.tipo_fase, f.duracion_minutos * 100.0 / SUM(f.duracion_minutos) OVER (PARTITION BY f.id_sesion) AS porcentaje_por_sesion
    FROM fases_sueno f
) t
GROUP BY tipo_fase
ORDER BY porcentaje_promedio DESC;

-- ¿Qué factores externos afectan más la calidad del sueño?
SELECT f.temperatura_centigrados, n.nombre AS nivel_ruido, i.nombre AS nivel_iluminacion, ROUND(AVG(s.id_calidad_percibida), 2) AS promedio_calidad
FROM sesiones_sueno s
JOIN factores_externos f
ON s.id_sesion = f.id_sesion
JOIN nivel_ruido n
ON f.id_nivel_ruido = n.id_nivel_ruido
JOIN nivel_iluminacion i
ON f.id_nivel_iluminacion = i.id_nivel_iluminacion
GROUP BY f.temperatura_centigrados, n.nombre, i.nombre
ORDER BY promedio_calidad ASC;

-- Consultas adicionales que se consideraron relevantes.

-- Interrupciones y calidad de sueño.
SELECT s.id_sesion, u.nombre, u.apellido, COUNT(i.id_interrupcion) AS total_interrupciones, ROUND(s.id_calidad_percibida, 2) AS calidad_sueno
FROM sesiones_sueno s
JOIN usuarios u
ON s.id_usuario = u.id_usuario
LEFT JOIN interrupciones i
ON s.id_sesion = i.id_sesion
GROUP BY s.id_sesion, u.nombre, u.apellido, s.id_calidad_percibida
ORDER BY total_interrupciones DESC;

-- Ocupación y calidad de sueño.
SELECT u.nombre, u.apellido, u.ocupacion, ROUND(AVG(s.id_calidad_percibida), 2) AS promedio_calidad
FROM sesiones_sueno s
JOIN usuarios u ON s.id_usuario = u.id_usuario
GROUP BY u.nombre, u.apellido, u.ocupacion
ORDER BY promedio_calidad ASC;

-- Comparar duración total de sueño vs calidad percibida.
SELECT RANK() OVER(ORDER BY ROUND(s.duracion_total_minutos/60, 2) DESC) AS Ranking, 
		s.id_sesion, u.nombre, u.apellido, ROUND(s.duracion_total_minutos/60, 2) AS duracion_total_horas, c.nombre AS calidad
FROM sesiones_sueno s
JOIN usuarios u
ON s.id_usuario = u.id_usuario
JOIN calidad_percibida c
ON s.id_calidad_percibida = c.id_calidad_percibida;

-- Relación peso/altura (IMC aproximado) vs calidad del sueño.
SELECT u.nombre, u.apellido, ROUND(u.peso_kg / ((u.altura_cm/100)*(u.altura_cm/100)), 1) AS imc, ROUND(AVG(s.id_calidad_percibida), 2) AS calidad_promedio
FROM usuarios u
JOIN sesiones_sueno s
ON u.id_usuario = s.id_usuario
GROUP BY u.id_usuario, u.nombre, u.apellido
ORDER BY imc DESC;

-- Lugar de descanso y calidad de sueño.
WITH promedio_calidad_lugar AS (
	SELECT lugar, ROUND(AVG(id_calidad_percibida), 2) AS promedio_calidad
    FROM sesiones_sueno
    GROUP BY lugar
)
SELECT u.nombre, u.apellido, s.lugar, (SELECT promedio_calidad FROM promedio_calidad_lugar WHERE lugar = s.lugar) AS promedio_calidad
FROM sesiones_sueno s
JOIN usuarios u
ON s.id_usuario = u.id_usuario
ORDER BY promedio_calidad DESC;

-- Identificar por usuario
SELECT u.nombre, u.apellido, c.nombre AS calidad, f.temperatura_centigrados, f.id_nivel_iluminacion, f.id_nivel_ruido
FROM usuarios u
JOIN sesiones_sueno s
ON u.id_usuario = s.id_usuario
JOIN calidad_percibida c
ON s.id_calidad_percibida = c.id_calidad_percibida
JOIN factores_externos f
ON s.id_sesion = f.id_sesion;

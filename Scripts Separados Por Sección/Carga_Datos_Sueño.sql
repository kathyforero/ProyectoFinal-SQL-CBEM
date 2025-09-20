-- ******************** Carga de datos inicial. ********************

USE analisis_sueno;
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
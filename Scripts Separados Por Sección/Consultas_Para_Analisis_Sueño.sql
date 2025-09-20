-- ******************** Consultas SQL para responder las preguntas de análisis. ********************

USE analisis_sueno;
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

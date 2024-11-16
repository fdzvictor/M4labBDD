--1: Cogemos el parque en el que el promedio de sensación térmica se acerque más a 20 grados:
SELECT 
    f.category,
    m.localidad, 
    m.latitud, 
    m.longitud, 
    AVG(a.sen_termica_c) AS promedio_sen_termica
FROM 
    aemet a
JOIN 
    municipios m ON a.denominado = m.denominador
JOIN
    foursquare f ON f.denominado = m.denominador
GROUP BY 
    m.localidad, m.latitud, m.longitud, f.category
HAVING
    f.category = 'Park'
ORDER BY 
    ABS(AVG(a.sen_termica_c) - 20)  
LIMIT 1;  


--2: Cogemos el municipio donde haya habido cielo despejado más horas
SELECT
    m.localidad,
    m.latitud,
    m.longitud,
    COUNT(a.cielo) AS cielos
FROM 
    aemet a
JOIN
    municipios m ON a.denominado = m.denominador
WHERE
    a.cielo = 'Cielo despejado'
GROUP BY
    m.localidad,
    m.latitud,
    m.longitud
order by
	cielos DESC
LIMIT 5;

--3 Escoger las localidades que tengan un castillo y un estudio de gabación

SELECT 
    m.localidad, 
    m.latitud, 
    m.longitud
FROM
    municipios m
JOIN
    foursquare f ON f.denominado = m.denominador
WHERE
    f.category IN ('Castle', 'Film Studio')
GROUP BY
    m.localidad, m.latitud, m.longitud

--4 Dónde ha nevado más?
SELECT
    m.localidad,
    m.latitud,
    m.longitud,
    a.nieve_mm AS nevada
FROM 
    aemet a
JOIN
    municipios m ON a.denominado = m.denominador
GROUP BY
    m.localidad,
    m.latitud,
    m.longitud,
    a.nieve_mm 
order by
	nieve_mm asc 
LIMIT 5;

--5 Cuáles son los sitios más húmedos?

SELECT
    m.localidad,
    m.latitud,
    m.longitud,
    a.humedad_relativa AS humedad
FROM 
    aemet a
JOIN
    municipios m ON a.denominado = m.denominador
GROUP BY
    m.localidad,
    m.latitud,
    m.longitud,
    a.humedad_relativa 
order by
	humedad_relativa desc
LIMIT 5;
	
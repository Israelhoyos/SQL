CREATE DATABASE colegio CHARACTER SET UTF8mb4 COLLATE utf8mb4_bin;

use colegio;

CREATE TABLE asignatura (  
id INT(6) NOT NULL auto_increment,
nombre VARCHAR(25) NOT NULL,
PRIMARY KEY  (id) 
)ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

CREATE TABLE alumno ( 
id INT(6) NOT NULL auto_increment,
nombre VARCHAR(25) NOT NULL,
apellido VARCHAR (25) NOT NULL,
fecha_nacimiento DATE NOT NULL,
PRIMARY KEY  (id) ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

CREATE TABLE nota (
id INT(6) NOT NULL auto_increment,
asignatura_id INT,  calificacion FLOAT NOT NULL,
fecha_examen DATE NOT NULL,
convocatoria INT(6),
alumno_id INT,
INDEX alum_ind (alumno_id),
FOREIGN KEY (alumno_id)
REFERENCES alumno(id)
ON DELETE CASCADE,
INDEX asignat_ind (asignatura_id),
FOREIGN KEY (asignatura_id)
REFERENCES asignatura(id)
ON DELETE CASCADE,
PRIMARY KEY (id) 
)ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;


CREATE TABLE labor_extra (   puesto VARCHAR(50) NOT NULL,
alumno_id INT NOT NULL,
INDEX alum_ind (alumno_id),
FOREIGN KEY (alumno_id)
REFERENCES alumno(id)
ON DELETE CASCADE,
PRIMARY KEY (puesto, alumno_id) )
ENGINE=InnoDB
DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;



INSERT INTO asignatura(nombre) VALUES ('Matemáticas');
INSERT INTO asignatura(nombre) VALUES ('Lengua');

select * from asignatura;


INSERT INTO alumno(nombre, apellido, fecha_nacimiento) VALUES ('Juan', 'Quesada', '1980-09-03');
INSERT INTO alumno(nombre, apellido, fecha_nacimiento) VALUES ('Manuel', 'Rico', '1992-11-10');
INSERT INTO alumno(nombre, apellido, fecha_nacimiento) VALUES ('Pedro', 'Riesgo', '1980-01-05');
INSERT INTO alumno(nombre, apellido, fecha_nacimiento) VALUES ('Maria', 'Valenzuela', '1986-12-19');  

select * from alumno;


INSERT INTO nota(asignatura_id, calificacion, fecha_examen,convocatoria, alumno_id) VALUES (1, 7, '2018-12-19', 1, 1);
INSERT INTO nota(asignatura_id, calificacion, fecha_examen,convocatoria, alumno_id) VALUES (2, 5, '2018-11-03', 2, 1);
INSERT INTO nota(asignatura_id, calificacion, fecha_examen,convocatoria, alumno_id) VALUES (1, 3, '2018-11-03', 3, 2);
INSERT INTO nota(asignatura_id, calificacion, fecha_examen,convocatoria, alumno_id) VALUES (2, 8, '2018-11-03', 1, 2);
INSERT INTO nota(asignatura_id, calificacion, fecha_examen,convocatoria, alumno_id) VALUES (1, 2, '2018-07-05', 2, 3);
INSERT INTO nota(asignatura_id, calificacion, fecha_examen,convocatoria, alumno_id) VALUES (2, 5, '2018-11-03', 1, 3);
INSERT INTO nota(asignatura_id, calificacion, fecha_examen,convocatoria, alumno_id) VALUES (1, 9, '2018-09-13', 3, 4);
INSERT INTO nota(asignatura_id, calificacion, fecha_examen,convocatoria, alumno_id) VALUES (2, 5, '2018-11-23', 1, 4);


select * from nota;

INSERT INTO labor_extra(puesto, alumno_id) VALUES ('Delegado', 1);
INSERT INTO labor_extra(puesto, alumno_id) VALUES ('Director', 2);

select * from labor_extra;


SELECT * #COLUMNAS DE LAS TABLAS*/
FROM nota #TABLAS DE LAS QUE SACAMOS LA COLUMNA
WHERE 1=1 #FILTROS DE CONSULTA
ORDER BY fecha_examen; #ORDENA POR LA COLUMNA SELECCIONADA;

SELECT * FROM nota WHERE fecha_examen = '2018-11-03' ORDER BY alumno_id;


ALTER TABLE alumno ADD COLUMN apellido2 VARCHAR(25) AFTER apellido;

select * from alumno;

select * from alumno WHERE id=1;

UPDATE alumno SET apellido2 = "Palazon" WHERE id=1;
UPDATE alumno SET apellido2 = "Gomez" WHERE id=2;
UPDATE alumno SET apellido2 = "Leost" WHERE id=3;

SELECT * FROM alumno
WHERE nombre="Maria"
AND apellido = "Valenzuela";

UPDATE alumno SET apellido2= "Martin" WHERE nombre ="Maria" and apellido ="Valenzuela";

select * from alumno;

SELECT a.nombre, asig.nombre as asignatura, n.calificacion
FROM alumno a 
INNER JOIN nota n ON a.id = n.alumno_id
INNER JOIN asignatura asig ON asig.id = n.asignatura_id
ORDER BY apellido;

SELECT a.nombre, a.apellido
FROM alumno a
WHERE a.nombre LIKE 'Ma%' OR a.apellido LIKE '%rie%';


select * from alumno a
left join labor_extra l  on l.alumno_id=a.id;



SELECT a.nombre, a.apellido, avg(n.calificacion) as media
FROM alumno a
INNER JOIN nota n ON a.id = n.alumno_id
INNER JOIN asignatura asig ON asig.id = n.asignatura_id
WHERE 1=1
GROUP BY a.nombre, a.apellido
ORDER BY media DESC;


SELECT a.nombre, a.apellido, avg(n.calificacion) as media
FROM alumno a
INNER JOIN nota n ON a.id = n.alumno_id
INNER JOIN asignatura asig ON asig.id = n.asignatura_id
GROUP BY a.nombre, a.apellido
HAVING media >= 6
ORDER BY media desc;

delete from labor_extra where puesto="Director";

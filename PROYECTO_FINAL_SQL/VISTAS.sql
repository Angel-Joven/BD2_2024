-- -----------------------------------------------------------------------------------------------------------------------

-- JOVEN JIMENEZ ANGEL CRISTIAN | BASES DE DATOS 2 - 2861
-- PROYECTO FINAL - Sistema de Gestión de Pacientes para una Clínica.

-- VISTAS A USAR

-- -----------------------------------------------------------------------------------------------------------------------

-- VISTA 'Mostrar_Citas_Dia'
-- Esta vista se encarga de generar un reporte sobre las citas 
-- que se tienen generadas dependiendo del dia que ingrese el personal.

DROP VIEW IF EXISTS Mostrar_Citas_Dia;
CREATE VIEW Mostrar_Citas_Dia AS
SELECT rpad('idCita_paciente',15,' '), rpad('idPaciente',10,' '), rpad('idDoctor',8,' '), rpad('Fecha_cita',10,' '), rpad('Hora_cita',10,' '), rpad('Costo',10,' '), rpad('Especialidad',50,' '), rpad('Numero_consultorio',18,' '), rpad('Nota_cita',50,' '), rpad('Usuario_Movimiento',50,' '), rpad('Fecha_Movimiento',20,' ') UNION ALL
SELECT rpad(c.idCita_paciente,15,' '), rpad(c.idPaciente,10,' '), rpad(c.idDoctor,8,' '), rpad(c.Fecha_cita,10,' '), rpad(c.Hora_cita,10,' '), rpad(c.Costo,10,' '), rpad(c.Especialidad,50,' '), rpad(c.Numero_consultorio,18,' '), rpad(c.Nota_cita,50,' '), rpad(c.Usuario_Movimiento,50,' '), rpad(c.Fecha_Movimiento,20,' ')
FROM cita_paciente c WHERE c.Fecha_cita = '2023-01-02'; -- Modificar este valor para asignar una fecha en especifico

SHOW CREATE VIEW Mostrar_Citas_Dia;

SET @contador_vista_citas_dia := @contador_vista_citas_dia + 1;
SET @nombre_archivo := CONCAT('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/reporte_citas_dia_reporte', @contador_vista_citas_dia, '.txt');
SET @sql1 := CONCAT('SELECT * FROM Mostrar_Citas_Dia INTO OUTFILE ', QUOTE(@nombre_archivo));
PREPARE stmt1 FROM @sql1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

-- -----------------------------------------------------------------------------------------------------------------------

-- VISTA 'Mostrar_Pacientes_Masculinos_o_Femeninos'
-- Esta vista se encarga de generar un reporte sobre los pacientes
-- que existen en nuestra clinica en donde estaran diferenciados
-- por su genero ya sea 'Masculino' o 'Femenino'

DROP VIEW IF EXISTS Mostrar_Pacientes_Masculinos_o_Femeninos;
CREATE VIEW Mostrar_Pacientes_Masculinos_o_Femeninos AS
SELECT rpad('idPaciente',10,' '), rpad('Nombre',30,' '), rpad('AP_Paterno',30,' '), rpad('AP_Materno',30,' '), rpad('CURP',18,' '), rpad('Sexo',10,' '), rpad('Edad',4,' '), rpad('Fecha_Nacimiento',16,' '), rpad('idDireccion_paciente',20,' '), rpad('Telefono_paciente',20,' '), rpad('Correo_paciente',40,' '), rpad('NSS',11,' '), rpad('idExpediente_paciente',21,' '), rpad('idTratamiento_paciente',22,' '), rpad('Usuario_Movimiento',50,' '), rpad('Fecha_Movimiento',20,' ') UNION ALL
SELECT rpad(p.idPaciente,10,' '), rpad(p.Nombre,30,' '), rpad(p.AP_Paterno,30,' '), rpad(p.AP_Materno,30,' '), rpad(p.CURP,18,' '), rpad(p.Sexo,10,' '), rpad(p.Edad,4,' '), rpad(p.Fecha_Nacimiento,16,' '), rpad(p.idDireccion_paciente,20,' '), rpad(p.Telefono_paciente,20,' '), rpad(p.Correo_paciente,40,' '), rpad(p.NSS,11,' '), rpad(p.idExpediente_paciente,21,' '), rpad(p.idTratamiento_paciente,22,' '), rpad(p.Usuario_Movimiento,50,' '), rpad(p.Fecha_Movimiento,20,' ')
FROM pacientes p WHERE Sexo = 'Femenino'; -- Modificar este valor para asignar un genero ya sea 'Masculino' o 'Femenino'.

SHOW CREATE VIEW Mostrar_Pacientes_Masculinos_o_Femeninos;

SET @contador_vista_pacientes_masculinos_o_femeninos := @contador_vista_pacientes_masculinos_o_femeninos + 1;
SET @nombre_archivo := CONCAT('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/reporte_pacientes_masculinos_o_femeninos_reporte', @contador_vista_pacientes_masculinos_o_femeninos, '.txt');
SET @sql1 := CONCAT('SELECT * FROM Mostrar_Pacientes_Masculinos_o_Femeninos INTO OUTFILE ', QUOTE(@nombre_archivo));
PREPARE stmt1 FROM @sql1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

-- -----------------------------------------------------------------------------------------------------------------------

-- VISTA 'Mostrar_Doctores_Especialidad'
-- Esta vista se encarga de generar un reporte sobre los doctores
-- que existen en nuestra clinica en donde estaran diferenciados
-- por su especialidad ya sea 'Cardiología', 'Dermatología', 
-- 'Ginecología', 'Pediatría' o 'Oftalmología'

DROP VIEW IF EXISTS Mostrar_Doctores_Especialidad;
CREATE VIEW Mostrar_Doctores_Especialidad AS
SELECT rpad('idDoctor',8,' '), rpad('Nombre',30,' '), rpad('AP_Paterno',30,' '), rpad('AP_Materno',30,' '), rpad('CURP',18,' '), rpad('RFC',13,' '), rpad('Sexo',10,' '), rpad('Edad',4,' '), rpad('Fecha_Nacimiento',16,' '), rpad('idDireccion_doctor',18,' '), rpad('Telefono_doctor',20,' '), rpad('Correo_doctor',40,' '), rpad('Especialidad',25,' '), rpad('NSS',11,' '), rpad('Usuario_Movimiento',50,' '), rpad('Fecha_Movimiento',20,' ') UNION ALL
SELECT rpad(d.idDoctor,8,' '), rpad(d.Nombre,30,' '), rpad(d.AP_Paterno,30,' '), rpad(d.AP_Materno,30,' '), rpad(d.CURP,18,' '), rpad(d.RFC,13,' '), rpad(d.Sexo,10,' '), rpad(d.Edad,4,' '), rpad(d.Fecha_Nacimiento,16,' '), rpad(d.idDireccion_doctor,18,' '), rpad(d.Telefono_doctor,20,' '), rpad(d.Correo_doctor,40,' '), rpad(d.Especialidad,25,' '), rpad(d.NSS,11,' '), rpad(d.Usuario_Movimiento,50,' '), rpad(d.Fecha_Movimiento,20,' ')
FROM doctores d WHERE Especialidad = 'Cardiología'; -- Modificar este valor para asignar una especialidad ya sea 'Cardiología', 'Dermatología', 'Ginecología', 'Pediatría', 'Oftalmología'.

SHOW CREATE VIEW Mostrar_Doctores_Especialidad;

SET @contador_vista_doctores_especialidad := @contador_vista_doctores_especialidad + 1;
SET @nombre_archivo := CONCAT('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/reporte_doctores_especialidad_reporte', @contador_vista_doctores_especialidad, '.txt');
SET @sql1 := CONCAT('SELECT * FROM Mostrar_Doctores_Especialidad INTO OUTFILE ', QUOTE(@nombre_archivo));
PREPARE stmt1 FROM @sql1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

-- -----------------------------------------------------------------------------------------------------------------------

-- VISTA 'Mostrar_Historial_Enfermedad_Paciente'
-- Esta vista se encarga de generar un reporte sobre las enfermedades
-- que han tenido los pacientes que existen en nuestra clinica 
-- en donde estaran diferenciados por el campo 'Lista_historial_enfermedades'
-- ya sea 'Gripe', 'Bronquitis', 'Neumonía', 'Varicela', 'COVID-19'
-- o alguna otra enfermedad registrada en la tabla.

-- NOTA: Importante usar este formato para que pueda generar correctamente
-- el reporte: '%enfermedad%'

DROP VIEW IF EXISTS Mostrar_Historial_Enfermedad_Paciente;
CREATE VIEW Mostrar_Historial_Enfermedad_Paciente AS
SELECT rpad('idExpediente_paciente',21,' '), rpad('idPaciente',10,' '), rpad('Lista_habitos_salud',100,' '), rpad('Lista_vacunas_puestas',100,' '), rpad('Lista_enfermedades_hereditarias',100,' '), rpad('Lista_historial_enfermedades',100,' '), rpad('Usuario_Movimiento',50,' '), rpad('Fecha_Movimiento',20,' ') UNION ALL
SELECT rpad(e.idExpediente_paciente,21,' '), rpad(e.idPaciente,10,' '), rpad(e.Lista_habitos_salud,100,' '), rpad(e.Lista_vacunas_puestas,100,' '), rpad(e.Lista_enfermedades_hereditarias,100,' '), rpad(e.Lista_historial_enfermedades,100,' '), rpad(e.Usuario_Movimiento,50,' '), rpad(e.Fecha_Movimiento,20,' ')
FROM expediente_paciente e WHERE Lista_historial_enfermedades LIKE '%COVID-19%'; -- Modificar este valor para asignar una enfermedad que ya tuvo un paciente ya sea 'Gripe', 'Bronquitis', 'Neumonía', 'Varicela', 'COVID-19' o alguna otra enfermedad registrada en la tabla.

SHOW CREATE VIEW Mostrar_Historial_Enfermedad_Paciente;

SET @contador_vista_historial_enfermedad_paciente := @contador_vista_historial_enfermedad_paciente + 1;
SET @nombre_archivo := CONCAT('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/reporte_historial_enfermedad_paciente_reporte', @contador_vista_historial_enfermedad_paciente, '.txt');
SET @sql1 := CONCAT('SELECT * FROM Mostrar_Historial_Enfermedad_Paciente INTO OUTFILE ', QUOTE(@nombre_archivo));
PREPARE stmt1 FROM @sql1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

-- -----------------------------------------------------------------------------------------------------------------------

-- VISTA 'Mostrar_Paciente_En_Tratamiento'
-- Esta vista se encarga de generar un reporte sobre los pacientes 
-- que existen en nuestra clinica en donde estaran diferenciados 
-- gracias a que si estan en tratamiento o no ya sea 'SI' o 'NO'.

DROP VIEW IF EXISTS Mostrar_Paciente_En_Tratamiento;
CREATE VIEW Mostrar_Paciente_En_Tratamiento AS
SELECT rpad('idTratamiento_paciente',22,' '), rpad('idPaciente',10,' '), rpad('En_Tratamiento',14,' '), rpad('Lista_tratamientos_actual',100,' '), rpad('Lista_tratamientos_anteriores',100,' '), rpad('Usuario_Movimiento',50,' '), rpad('Fecha_Movimiento',20,' ') UNION ALL
SELECT rpad(t.idTratamiento_paciente,22,' '), rpad(t.idPaciente,10,' '), rpad(t.En_Tratamiento,14,' '), rpad(t.Lista_tratamientos_actual,100,' '), rpad(t.Lista_tratamientos_anteriores,100,' '), rpad(t.Usuario_Movimiento,50,' '), rpad(t.Fecha_Movimiento,20,' ')
FROM tratamiento_paciente t WHERE En_Tratamiento = 'SI'; -- Modificar este valor para asignar si esta en tratamiento o no ya sea 'SI' o 'NO'.

SHOW CREATE VIEW Mostrar_Paciente_En_Tratamiento;

SET @contador_vista_paciente_en_tratamiento := @contador_vista_paciente_en_tratamiento + 1;
SET @nombre_archivo := CONCAT('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/reporte_paciente_en_tratamiento_reporte', @contador_vista_paciente_en_tratamiento, '.txt');
SET @sql1 := CONCAT('SELECT * FROM Mostrar_Paciente_En_Tratamiento INTO OUTFILE ', QUOTE(@nombre_archivo));
PREPARE stmt1 FROM @sql1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

-- -----------------------------------------------------------------------------------------------------------------------

-- VISTA 'Mostrar_Administradores_Rango_Activo'
-- Esta vista se encarga de generar un reporte sobre los usuarios 
-- o personal que existen en nuestra clinica y que tienen permisos
-- para poder trabajar en la base de datos en donde estaran diferenciados 
-- gracias a que si su rango (etiqueta) esta activo o no ya sea 'Si' o 'No'.

DROP VIEW IF EXISTS Mostrar_Administradores_Rango_Activo;
CREATE VIEW Mostrar_Administradores_Rango_Activo AS
SELECT rpad('idAdministrador',15,' '), rpad('Nombre',30,' '), rpad('Contraseña',10,' '), rpad('Etiqueta',20,' '), rpad('Esta_Activo',11,' '), rpad('Usuario_Movimiento',50,' '), rpad('Fecha_Movimiento',20,' ') UNION ALL
SELECT rpad(a.idAdministrador,15,' '), rpad(a.Nombre,30,' '), rpad(a.Contraseña,10,' '), rpad(a.Etiqueta,20,' '), rpad(a.Esta_Activo,11,' '), rpad(a.Usuario_Movimiento,50,' '), rpad(a.Fecha_Movimiento,20,' ')
FROM administradores a WHERE Esta_Activo = 'Si'; -- Modificar este valor para asignar si el rango de algun registro esta activo o no ya sea 'Si' o 'No'.

SHOW CREATE VIEW Mostrar_Administradores_Rango_Activo;

SET @contador_vista_admin_rango_activo := @contador_vista_admin_rango_activo + 1;
SET @nombre_archivo := CONCAT('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/reporte_admin_rango_activo_reporte', @contador_vista_admin_rango_activo, '.txt');
SET @sql1 := CONCAT('SELECT * FROM Mostrar_Administradores_Rango_Activo INTO OUTFILE ', QUOTE(@nombre_archivo));
PREPARE stmt1 FROM @sql1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

-- -----------------------------------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------------------------------

-- JOVEN JIMENEZ ANGEL CRISTIAN | BASES DE DATOS 2 - 2861
-- PROYECTO FINAL - Sistema de Gestión de Pacientes para una Clínica.

-- CONSULTAS GENERALES A USAR

-- -----------------------------------------------------------------------------------------------------------------------

-- Esta consulta servira para poder crear la base de datos de nuestra clinica.

CREATE DATABASE SGPC;

-- -----------------------------------------------------------------------------------------------------------------------

-- Esta consulta servira para poder usar la base de datos de nuestra clinica.
-- IMPORTANTE EJECUTAR ESTO PARA QUE PODAMOS TRABAJAR CON NUESTRA BASE DE DATOS.

USE SGPC;

-- -----------------------------------------------------------------------------------------------------------------------

-- Esta consulta servira para poder eliminar la base de datos de nuestra clinica.

DROP DATABASE SGPC;

-- -----------------------------------------------------------------------------------------------------------------------

-- Esta consulta servira para poder desactivar la verificacion de
-- llaves foraneas en la base de datos de nuestra clinica.

SET FOREIGN_KEY_CHECKS = 0;

-- -----------------------------------------------------------------------------------------------------------------------

-- Estas consultas serviran para poder activar o desactivar los autocommit y ver el estatus
-- del autocommit. Es importante desactivar al momento de que un usuario / personal
-- use algun procedimiento almacenado o se hagan nuevos cambios en la base de datos.

SET autocommit = 0; -- Hacer que autocommit = 0 (Desactivar)
SET autocommit = 1; -- Hacer que autocommit = 1 (Activar)
SELECT @@autocommit; -- Ver si estan habilitados los autocommits - Si = 1 -> Encendido ; Si = 0 -> Apagado.

-- -----------------------------------------------------------------------------------------------------------------------

-- Estas consultas serviran para crear variables que interactuan con la numeracion
-- en la creacion de los reportes de las vistas que tenemos creadas.

SET @contador_vista_citas_dia := 0;
SET @contador_vista_pacientes_masculinos_o_femeninos := 0;
SET @contador_vista_doctores_especialidad := 0;
SET @contador_vista_historial_enfermedad_paciente := 0;
SET @contador_vista_paciente_en_tratamiento := 0;
SET @contador_vista_admin_rango_activo := 0;

-- -----------------------------------------------------------------------------------------------------------------------

-- Esta consulta servira para poder visualizar la carpeta donde
-- se van a guardar los reportes de las vistas que hemos creado.

SHOW VARIABLES LIKE "secure_file_priv";

-- -----------------------------------------------------------------------------------------------------------------------

-- Estas consultas serviran para poder usar y ver la base de datos creada por default
-- en donde contienen la informacion de configuracion, asi como ver los usuarios
-- que tienen acceso a ciertas tablas, activar los 'logs' de nuestra base de datos, etc.

USE mysql;
SELECT * FROM user;
SET GLOBAL general_log = 'on'; -- Activar Logs.
SET GLOBAL general_log = 'off'; -- Desactivar Logs.
SET GLOBAL log_output = 'table'; -- En donde se van a escribir los 'logs'.
SELECT * from general_log; -- Ver listado completo de todos los registros almacenados en los logs.
SELECT COUNT(*) from general_log; -- Ver cuantos registros tenemos almacenados en los logs.

-- -----------------------------------------------------------------------------------------------------------------------

-- Estas consultas serviran para poder ver y eliminar el contenido
-- de la tabla 'pacientes'. Asimismo, podemos resetar las IDs de
-- los registros de dicha tabla para evitar problemas con la
-- asignacion de IDs.

SELECT * FROM pacientes;
DELETE FROM pacientes;
ALTER TABLE pacientes AUTO_INCREMENT = 1;

-- -----------------------------------------------------------------------------------------------------------------------

-- Estas consultas serviran para poder ver y eliminar el contenido
-- de la tabla 'direccion_paciente'. Asimismo, podemos resetar las IDs de
-- los registros de dicha tabla para evitar problemas con la
-- asignacion de IDs.

SELECT * FROM direccion_paciente;
DELETE FROM direccion_paciente;
ALTER TABLE direccion_paciente AUTO_INCREMENT = 1;

-- -----------------------------------------------------------------------------------------------------------------------

-- Estas consultas serviran para poder ver y eliminar el contenido
-- de la tabla 'doctores'. Asimismo, podemos resetar las IDs de
-- los registros de dicha tabla para evitar problemas con la
-- asignacion de IDs.

SELECT * FROM doctores;
DELETE FROM doctores;
ALTER TABLE doctores AUTO_INCREMENT = 1;

-- -----------------------------------------------------------------------------------------------------------------------

-- Estas consultas serviran para poder ver y eliminar el contenido
-- de la tabla 'direccion_doctor'. Asimismo, podemos resetar las IDs de
-- los registros de dicha tabla para evitar problemas con la
-- asignacion de IDs.

SELECT * FROM direccion_doctor;
DELETE FROM direccion_doctor;
ALTER TABLE direccion_doctor AUTO_INCREMENT = 1;

-- -----------------------------------------------------------------------------------------------------------------------

-- Estas consultas serviran para poder ver y eliminar el contenido
-- de la tabla 'expediente_paciente'. Asimismo, podemos resetar las IDs de
-- los registros de dicha tabla para evitar problemas con la
-- asignacion de IDs.

SELECT * FROM expediente_paciente;
DELETE FROM expediente_paciente;
ALTER TABLE expediente_paciente AUTO_INCREMENT = 1;

-- -----------------------------------------------------------------------------------------------------------------------

-- Estas consultas serviran para poder ver y eliminar el contenido
-- de la tabla 'tratamiento_paciente'. Asimismo, podemos resetar las IDs de
-- los registros de dicha tabla para evitar problemas con la
-- asignacion de IDs.

SELECT * FROM tratamiento_paciente;
DELETE FROM tratamiento_paciente;
ALTER TABLE tratamiento_paciente AUTO_INCREMENT = 1;

-- -----------------------------------------------------------------------------------------------------------------------

-- Estas consultas serviran para poder ver y eliminar el contenido
-- de la tabla 'cita_paciente'. Asimismo, podemos resetar las IDs de
-- los registros de dicha tabla para evitar problemas con la
-- asignacion de IDs.

SELECT * FROM cita_paciente;
DELETE FROM cita_paciente;
ALTER TABLE cita_paciente AUTO_INCREMENT = 1;

-- -----------------------------------------------------------------------------------------------------------------------

-- Estas consultas serviran para poder ver y eliminar el contenido
-- de la tabla 'citas_eliminadas'. Asimismo, podemos resetar las IDs de
-- los registros de dicha tabla para evitar problemas con la
-- asignacion de IDs.

SELECT * FROM citas_eliminadas;
DELETE FROM citas_eliminadas;
ALTER TABLE citas_eliminadas AUTO_INCREMENT = 1;

-- -----------------------------------------------------------------------------------------------------------------------

-- Estas consultas serviran para poder ver y eliminar el contenido
-- de la tabla 'administradores'. Asimismo, podemos resetar las IDs de
-- los registros de dicha tabla para evitar problemas con la
-- asignacion de IDs.

SELECT * FROM administradores;
DELETE FROM administradores;
ALTER TABLE administradores AUTO_INCREMENT = 1;

-- -----------------------------------------------------------------------------------------------------------------------

-- Estas consultas serviran para eliminar los TRIGGERS que tenemos creados.

DROP TRIGGER checarPacientesDuplicados;
DROP TRIGGER checarDireccionPacientesDuplicados;
DROP TRIGGER checarDoctoresDuplicados;
DROP TRIGGER checarDireccionDoctoresDuplicados;
DROP TRIGGER checarExpedientePacienteDuplicados;
DROP TRIGGER checarTratamientoPacienteDuplicados;
DROP TRIGGER checarCitasDuplicadasINSERT;
DROP TRIGGER insertarCitasEliminadas;

-- -----------------------------------------------------------------------------------------------------------------------

-- Estas consultas serviran para mandar a llamar los Procedimientos Almacenados que tenemos creados.

-- EJEMPLOS PARA LLAMAR AL PROCEDIMIENTO ALMACENADO 'GestionarCita()'
CALL GestionarCita('PROGRAMAR', NULL, 1, 2, '2024-09-17', '09:00:00', 50.00, 'Cardiología', 4, 'Consulta de seguimiento');
CALL GestionarCita('MODIFICAR', 501, 1, 2, '2024-09-18', '10:00:00', 50.00, 'Cardiología', 4, 'Cambio de horario');
CALL GestionarCita('CANCELAR', 501, 1, 2, NULL, NULL, NULL, NULL, NULL, 'Doctor no disponible');

-- EJEMPLOS PARA LLAMAR AL PROCEDIMIENTO ALMACENADO 'GestionarExpediente()'
CALL GestionarExpediente('CREAR', NULL, 500, 'TEST 1', 'TEST 2', 'TEST 3', 'TEST 4');
CALL GestionarExpediente('MODIFICAR', 500, 499, 'TEST 1.1.0', 'TEST 2', 'TEST 3', 'TEST 4');

-- EJEMPLOS PARA LLAMAR AL PROCEDIMIENTO ALMACENADO 'GestionarTratamiento()'
CALL GestionarTratamiento('CREAR', NULL, 500, 'SI', 'TEST 1', 'TEST 2');
CALL GestionarTratamiento('MODIFICAR', 500, 499, 'SI', 'TEST 1.1.0', 'TEST 2');

-- PARA LLAMAR AL PROCEDIMIENTO ALMACENADO 'actualizarEstadoCita()'
CALL actualizarEstadoCita();

-- EJEMPLOS PARA LLAMAR AL PROCEDIMIENTO ALMACENADO 'CrearUsuarios()'
CALL CrearUsuarios('AngelJovenADMIN', '1234', 'ADMINISTRADOR');
CALL CrearUsuarios('AngelJovenADMIN', '1234', 'EXPEDIENTES');
CALL CrearUsuarios('AngelJovenADMIN', '1234', 'NADA');
CALL CrearUsuarios('AngelJovenCitas', '1234', 'ADMINISTRADOR');
CALL CrearUsuarios('AngelJovenCitas', '1234', 'CITAS');
CALL CrearUsuarios('AngelJovenCitas', '1234', 'EXPEDIENTES');
CALL CrearUsuarios('AngelJovenCitas', '1234', 'TRATAMIENTO');
CALL CrearUsuarios('AngelJovenCitas', '1234', 'NADA');

-- PARA LLAMAR AL PROCEDIMIENTO ALMACENADO 'ActualizarEstadoRangoUsuariosDuplicados()'
CALL ActualizarEstadoRangoUsuariosDuplicados();

-- -----------------------------------------------------------------------------------------------------------------------

-- Estas consultas serviran para eliminar los Procedimientos Almacenados que tenemos creados.

DROP PROCEDURE GestionarCita;
DROP PROCEDURE GestionarExpediente;
DROP PROCEDURE GestionarTratamiento;
DROP PROCEDURE actualizarEstadoCita;
DROP PROCEDURE CrearUsuarios;
DROP PROCEDURE ActualizarEstadoRangoUsuariosDuplicados;

-- -----------------------------------------------------------------------------------------------------------------------

-- Estas consultas serviran para eliminar las vistas que tenemos creados.

DROP VIEW Mostrar_Citas_Dia; 
DROP VIEW Mostrar_Pacientes_Masculinos_o_Femeninos; 
DROP VIEW Mostrar_Doctores_Especialidad; 
DROP VIEW Mostrar_Historial_Enfermedad_Paciente; 
DROP VIEW Mostrar_Paciente_En_Tratamiento; 
DROP VIEW Mostrar_Administradores_Rango_Activo; 

-- -----------------------------------------------------------------------------------------------------------------------

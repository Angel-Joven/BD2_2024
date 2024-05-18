-- -----------------------------------------------------------------------------------------------------------------------

-- JOVEN JIMENEZ ANGEL CRISTIAN | BASES DE DATOS 2 - 2861
-- PROYECTO FINAL - Sistema de Gestión de Pacientes para una Clínica.

-- TABLAS A USAR

-- -----------------------------------------------------------------------------------------------------------------------

-- Esta tabla llamada 'pacientes' servira para poder almacenar los datos personales
-- de los pacientes registrados en nuestra clinica.

CREATE TABLE `pacientes` (
	`idPaciente` int NOT NULL AUTO_INCREMENT,
    `Nombre` varchar(100) DEFAULT NULL,
	`AP_Paterno` varchar(100) DEFAULT NULL,
	`AP_Materno` varchar(100) DEFAULT NULL,
    `CURP` varchar(18) DEFAULT NULL,
    `Sexo` varchar(9) DEFAULT NULL,
    `Edad` int(3) DEFAULT NULL,
    `Fecha_Nacimiento` date DEFAULT NULL,
    `Telefono_paciente` varchar(50) DEFAULT NULL,
    `Correo_paciente` varchar(100) DEFAULT NULL,
    `NSS` varchar(11) DEFAULT NULL,
    `Usuario_Movimiento` varchar(100) DEFAULT 'Administrador',
	`Fecha_Movimiento` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`idPaciente`)
);

-- -----------------------------------------------------------------------------------------------------------------------

-- Esta tabla llamada 'direccion_paciente' servira para poder almacenar la direccion
-- (lugar donde viven) de los pacientes registrados en nuestra clinica.

CREATE TABLE `direccion_paciente` (
  `idDireccion_paciente` int NOT NULL AUTO_INCREMENT,
  `Calle` varchar(100) DEFAULT NULL,
  `Numero_Interior` int DEFAULT NULL,
  `Numero_Exterior` int DEFAULT NULL,
  `Colonia` varchar(100) DEFAULT NULL,
  `Codigo_Postal` varchar(10) DEFAULT NULL,
  `Municipio` varchar(100) DEFAULT NULL,
  `Estado_Lugar` varchar(100) DEFAULT NULL,
  `Usuario_Movimiento` varchar(100) DEFAULT 'Administrador',
  `Fecha_Movimiento` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDireccion_paciente`)
);

-- -----------------------------------------------------------------------------------------------------------------------

-- Esta tabla llamada 'doctores' servira para poder almacenar los datos personales
-- de los doctores registrados en nuestra clinica.

CREATE TABLE `doctores` (
	`idDoctor` int NOT NULL AUTO_INCREMENT,
    `Nombre` varchar(100) DEFAULT NULL,
	`AP_Paterno` varchar(100) DEFAULT NULL,
	`AP_Materno` varchar(100) DEFAULT NULL,
    `CURP` varchar(18) DEFAULT NULL,
    `RFC` varchar(13) DEFAULT NULL,
    `Sexo` varchar(9) DEFAULT NULL,
    `Edad` int(3) DEFAULT NULL,
    `Fecha_Nacimiento` date DEFAULT NULL,
    `Telefono_doctor` varchar(50) DEFAULT NULL,
    `Correo_doctor` varchar(100) DEFAULT NULL,
    `Especialidad` varchar(100) DEFAULT NULL,
    `NSS` varchar(11) DEFAULT NULL,
    `Usuario_Movimiento` varchar(100) DEFAULT 'Administrador',
	`Fecha_Movimiento` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`idDoctor`)
);

-- -----------------------------------------------------------------------------------------------------------------------

-- Esta tabla llamada 'direccion_doctor' servira para poder almacenar la direccion
-- (lugar donde viven) de los doctores registrados en nuestra clinica.

CREATE TABLE `direccion_doctor` (
  `idDireccion_doctor` int NOT NULL AUTO_INCREMENT,
  `Calle` varchar(100) DEFAULT NULL,
  `Numero_Interior` int DEFAULT NULL,
  `Numero_Exterior` int DEFAULT NULL,
  `Colonia` varchar(100) DEFAULT NULL,
  `Codigo_Postal` varchar(10) DEFAULT NULL,
  `Municipio` varchar(100) DEFAULT NULL,
  `Estado_Lugar` varchar(100) DEFAULT NULL,
  `Usuario_Movimiento` varchar(100) DEFAULT 'Administrador',
  `Fecha_Movimiento` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDireccion_doctor`)
);

-- -----------------------------------------------------------------------------------------------------------------------

-- Esta tabla llamada 'expediente_paciente' servira para poder almacenar los
-- expedientes medicos de los pacientes registrados en nuestra clinica.

CREATE TABLE `expediente_paciente` (
  `idExpediente_paciente` int NOT NULL AUTO_INCREMENT,
  `Lista_habitos_salud` varchar(1000) DEFAULT NULL,
  `Lista_vacunas_puestas` varchar(1000) DEFAULT NULL,
  `Lista_enfermedades_hereditarias` varchar(1000) DEFAULT NULL,
  `Lista_historial_enfermedades` varchar(1000) DEFAULT NULL,
  `Usuario_Movimiento` varchar(100) DEFAULT 'Administrador',
  `Fecha_Movimiento` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idExpediente_paciente`)
);

-- -----------------------------------------------------------------------------------------------------------------------

-- Esta tabla llamada 'tratamiento_paciente' servira para poder almacenar los 
-- tratamientos y llevar seguimiento de estos de los pacientes registrados en nuestra clinica.

CREATE TABLE `tratamiento_paciente` (
  `idTratamiento_paciente` int NOT NULL AUTO_INCREMENT,
  `En_Tratamiento` varchar(2) DEFAULT NULL,
  `Lista_tratamientos_actual` varchar(1000) DEFAULT NULL,
  `Lista_tratamientos_anteriores` varchar(1000) DEFAULT NULL,
  `Usuario_Movimiento` varchar(100) DEFAULT 'Administrador',
  `Fecha_Movimiento` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTratamiento_paciente`)
);

-- -----------------------------------------------------------------------------------------------------------------------

-- Esta tabla llamada 'cita_paciente' servira para poder almacenar las citas medicas
-- de los pacientes registrados en nuestra clinica. Aqui se podran programar,
-- modificar o cancelar citas medicas.

CREATE TABLE `cita_paciente` (
  `idCita_paciente` int NOT NULL AUTO_INCREMENT,
  `Fecha_cita` date DEFAULT NULL,
  `Hora_cita` TIME DEFAULT NULL,
  `Costo` decimal(6,2) DEFAULT NULL,
  `Especialidad` varchar(100) DEFAULT NULL,
  `Numero_consultorio` int(3) DEFAULT NULL,
  `Nota_cita` varchar(1000) DEFAULT NULL,
  `Estado_cita` varchar(50) DEFAULT NULL,
  `Usuario_Movimiento` varchar(100) DEFAULT 'Administrador',
  `Fecha_Movimiento` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCita_paciente`)
);

-- -----------------------------------------------------------------------------------------------------------------------

-- Esta tabla llamada 'citas_eliminadas' servira para poder almacenar 
-- las citas que fueron modificadas o eliminadas de la tabla 'cita_paciente'.

CREATE TABLE `citas_eliminadas` (
  `idCita_eliminada` int NOT NULL AUTO_INCREMENT,
  `idCita_paciente` int NOT NULL,
  `Fecha_cita` date DEFAULT NULL,
  `Hora_cita` TIME DEFAULT NULL,
  `Costo` decimal(6,2) DEFAULT NULL,
  `Especialidad` varchar(100) DEFAULT NULL,
  `Numero_consultorio` int(3) DEFAULT NULL,
  `Nota_cita` varchar(1000) DEFAULT NULL,
  `Estado_cita` varchar(50) DEFAULT NULL,
  `Usuario_Movimiento` varchar(100) DEFAULT 'Administrador',
  `Fecha_Movimiento` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCita_eliminada`)
);

-- -----------------------------------------------------------------------------------------------------------------------

-- Esta tabla llamada 'administradores' servira para poder almacenar 
-- los usuarios que podran administrar la base de datos. Cada usuario estara
-- identificado con su nombre, contraseña, una etiqueta para saber que rango tiene
-- y si el rango que tiene dicho usuario esta activo actualmente o no.

CREATE TABLE `administradores` (
	`idAdministrador` int NOT NULL AUTO_INCREMENT,
    `Nombre` varchar(50) DEFAULT NULL,
    `Contraseña` varchar(8) DEFAULT NULL,
    `Etiqueta` varchar(50) DEFAULT NULL,
    `Esta_Activo` varchar(2) DEFAULT NULL,
    `Usuario_Movimiento` varchar(100) DEFAULT 'Administrador',
	`Fecha_Movimiento` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`idAdministrador`)
);

-- -----------------------------------------------------------------------------------------------------------------------

-- Estos ALTER TABLE serviaran para añadir nuevas columnas a nuestras tablas existentes con el 
-- fin de poder relacionar nuestras tablas.

ALTER TABLE pacientes ADD COLUMN idDireccion_paciente INT NOT NULL DEFAULT 0 AFTER `Fecha_Nacimiento`;
ALTER TABLE pacientes ADD CONSTRAINT `fk_Pacientes_direccion_paciente` FOREIGN KEY (`idDireccion_paciente`) REFERENCES `direccion_paciente` (`idDireccion_paciente`);

ALTER TABLE doctores ADD COLUMN idDireccion_doctor INT NOT NULL DEFAULT 0 AFTER `Fecha_Nacimiento`;
ALTER TABLE doctores ADD CONSTRAINT `fk_Doctores_direccion_doctor` FOREIGN KEY (`idDireccion_doctor`) REFERENCES `direccion_doctor` (`idDireccion_doctor`);

ALTER TABLE pacientes ADD COLUMN idExpediente_paciente INT NOT NULL DEFAULT 0 AFTER `NSS`;
ALTER TABLE pacientes ADD CONSTRAINT `fk_Pacientes_Expediente_paciente` FOREIGN KEY (`idExpediente_paciente`) REFERENCES `expediente_paciente` (`idExpediente_paciente`);

ALTER TABLE expediente_paciente ADD COLUMN idPaciente INT NOT NULL DEFAULT 0 AFTER `idExpediente_paciente`;
ALTER TABLE expediente_paciente ADD CONSTRAINT `fk_Expediente_paciente_Pacientes` FOREIGN KEY (`idPaciente`) REFERENCES `pacientes` (`idPaciente`);

ALTER TABLE pacientes ADD COLUMN idTratamiento_paciente INT NOT NULL DEFAULT 0 AFTER `idExpediente_paciente`;
ALTER TABLE pacientes ADD CONSTRAINT `fk_Pacientes_Tratamiento_paciente` FOREIGN KEY (`idTratamiento_paciente`) REFERENCES `tratamiento_paciente` (`idTratamiento_paciente`);

ALTER TABLE tratamiento_paciente ADD COLUMN idPaciente INT NOT NULL DEFAULT 0 AFTER `idTratamiento_paciente`;
ALTER TABLE tratamiento_paciente ADD CONSTRAINT `fk_Tratamiento_paciente_Pacientes` FOREIGN KEY (`idPaciente`) REFERENCES `pacientes` (`idPaciente`);

ALTER TABLE cita_paciente ADD COLUMN idPaciente INT NOT NULL DEFAULT 0 AFTER `idCita_paciente`;
ALTER TABLE cita_paciente ADD CONSTRAINT `fk_Cita_paciente_Pacientes` FOREIGN KEY (`idPaciente`) REFERENCES `pacientes` (`idPaciente`);

ALTER TABLE cita_paciente ADD COLUMN idDoctor INT NOT NULL DEFAULT 0 AFTER `idPaciente`;
ALTER TABLE cita_paciente ADD CONSTRAINT `fk_Cita_paciente_Doctores` FOREIGN KEY (`idDoctor`) REFERENCES `doctores` (`idDoctor`);

ALTER TABLE citas_eliminadas ADD COLUMN idPaciente INT NOT NULL DEFAULT 0 AFTER `idCita_paciente`;
ALTER TABLE citas_eliminadas ADD CONSTRAINT `fk_Citas_eliminadas_Pacientes` FOREIGN KEY (`idPaciente`) REFERENCES `pacientes` (`idPaciente`);

ALTER TABLE citas_eliminadas ADD COLUMN idDoctor INT NOT NULL DEFAULT 0 AFTER `idPaciente`;
ALTER TABLE citas_eliminadas ADD CONSTRAINT `fk_Citas_eliminadas_Doctores` FOREIGN KEY (`idDoctor`) REFERENCES `doctores` (`idDoctor`);

ALTER TABLE administradores ADD COLUMN idPaciente INT NOT NULL DEFAULT 0 AFTER `idAdministrador`;
ALTER TABLE administradores ADD CONSTRAINT `fk_Administrador_Pacientes` FOREIGN KEY (`idPaciente`) REFERENCES `pacientes` (`idPaciente`);

-- -----------------------------------------------------------------------------------------------------------------------

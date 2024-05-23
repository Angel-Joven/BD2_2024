-- -----------------------------------------------------------------------------------------------------------------------

-- JOVEN JIMENEZ ANGEL CRISTIAN | BASES DE DATOS 2 - 2861
-- PROYECTO FINAL - Sistema de Gestión de Pacientes para una Clínica.

-- SCRIPT SQL

-- -----------------------------------------------------------------------------------------------------------------------

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema sgpc
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sgpc
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sgpc` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `sgpc` ;

-- -----------------------------------------------------
-- Table `sgpc`.`direccion_paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgpc`.`direccion_paciente` (
  `idDireccion_paciente` INT NOT NULL AUTO_INCREMENT,
  `Calle` VARCHAR(100) NULL DEFAULT NULL,
  `Numero_Interior` INT NULL DEFAULT NULL,
  `Numero_Exterior` INT NULL DEFAULT NULL,
  `Colonia` VARCHAR(100) NULL DEFAULT NULL,
  `Codigo_Postal` VARCHAR(10) NULL DEFAULT NULL,
  `Municipio` VARCHAR(100) NULL DEFAULT NULL,
  `Estado_Lugar` VARCHAR(100) NULL DEFAULT NULL,
  `Usuario_Movimiento` VARCHAR(100) NULL DEFAULT 'Administrador',
  `Fecha_Movimiento` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDireccion_paciente`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sgpc`.`expediente_paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgpc`.`expediente_paciente` (
  `idExpediente_paciente` INT NOT NULL AUTO_INCREMENT,
  `idPaciente` INT NOT NULL DEFAULT '0',
  `Lista_habitos_salud` VARCHAR(1000) NULL DEFAULT NULL,
  `Lista_vacunas_puestas` VARCHAR(1000) NULL DEFAULT NULL,
  `Lista_enfermedades_hereditarias` VARCHAR(1000) NULL DEFAULT NULL,
  `Lista_historial_enfermedades` VARCHAR(1000) NULL DEFAULT NULL,
  `Usuario_Movimiento` VARCHAR(100) NULL DEFAULT 'Administrador',
  `Fecha_Movimiento` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idExpediente_paciente`),
  INDEX `fk_Expediente_paciente_Pacientes` (`idPaciente` ASC) VISIBLE,
  CONSTRAINT `fk_Expediente_paciente_Pacientes`
    FOREIGN KEY (`idPaciente`)
    REFERENCES `sgpc`.`pacientes` (`idPaciente`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sgpc`.`tratamiento_paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgpc`.`tratamiento_paciente` (
  `idTratamiento_paciente` INT NOT NULL AUTO_INCREMENT,
  `idPaciente` INT NOT NULL DEFAULT '0',
  `En_Tratamiento` VARCHAR(2) NULL DEFAULT NULL,
  `Lista_tratamientos_actual` VARCHAR(1000) NULL DEFAULT NULL,
  `Lista_tratamientos_anteriores` VARCHAR(1000) NULL DEFAULT NULL,
  `Usuario_Movimiento` VARCHAR(100) NULL DEFAULT 'Administrador',
  `Fecha_Movimiento` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTratamiento_paciente`),
  INDEX `fk_Tratamiento_paciente_Pacientes` (`idPaciente` ASC) VISIBLE,
  CONSTRAINT `fk_Tratamiento_paciente_Pacientes`
    FOREIGN KEY (`idPaciente`)
    REFERENCES `sgpc`.`pacientes` (`idPaciente`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sgpc`.`pacientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgpc`.`pacientes` (
  `idPaciente` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) NULL DEFAULT NULL,
  `AP_Paterno` VARCHAR(100) NULL DEFAULT NULL,
  `AP_Materno` VARCHAR(100) NULL DEFAULT NULL,
  `CURP` VARCHAR(18) NULL DEFAULT NULL,
  `Sexo` VARCHAR(9) NULL DEFAULT NULL,
  `Edad` INT NULL DEFAULT NULL,
  `Fecha_Nacimiento` DATE NULL DEFAULT NULL,
  `idDireccion_paciente` INT NOT NULL DEFAULT '0',
  `Telefono_paciente` VARCHAR(50) NULL DEFAULT NULL,
  `Correo_paciente` VARCHAR(100) NULL DEFAULT NULL,
  `NSS` VARCHAR(11) NULL DEFAULT NULL,
  `idExpediente_paciente` INT NOT NULL DEFAULT '0',
  `idTratamiento_paciente` INT NOT NULL DEFAULT '0',
  `Usuario_Movimiento` VARCHAR(100) NULL DEFAULT 'Administrador',
  `Fecha_Movimiento` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPaciente`),
  INDEX `fk_Pacientes_direccion_paciente` (`idDireccion_paciente` ASC) VISIBLE,
  INDEX `fk_Pacientes_Expediente_paciente` (`idExpediente_paciente` ASC) VISIBLE,
  INDEX `fk_Pacientes_Tratamiento_paciente` (`idTratamiento_paciente` ASC) VISIBLE,
  CONSTRAINT `fk_Pacientes_direccion_paciente`
    FOREIGN KEY (`idDireccion_paciente`)
    REFERENCES `sgpc`.`direccion_paciente` (`idDireccion_paciente`),
  CONSTRAINT `fk_Pacientes_Expediente_paciente`
    FOREIGN KEY (`idExpediente_paciente`)
    REFERENCES `sgpc`.`expediente_paciente` (`idExpediente_paciente`),
  CONSTRAINT `fk_Pacientes_Tratamiento_paciente`
    FOREIGN KEY (`idTratamiento_paciente`)
    REFERENCES `sgpc`.`tratamiento_paciente` (`idTratamiento_paciente`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sgpc`.`administradores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgpc`.`administradores` (
  `idAdministrador` INT NOT NULL AUTO_INCREMENT,
  `idPaciente` INT NOT NULL DEFAULT '0',
  `Nombre` VARCHAR(50) NULL DEFAULT NULL,
  `Contraseña` VARCHAR(8) NULL DEFAULT NULL,
  `Etiqueta` VARCHAR(50) NULL DEFAULT NULL,
  `Esta_Activo` VARCHAR(2) NULL DEFAULT NULL,
  `Usuario_Movimiento` VARCHAR(100) NULL DEFAULT 'Administrador',
  `Fecha_Movimiento` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idAdministrador`),
  INDEX `fk_Administrador_Pacientes` (`idPaciente` ASC) VISIBLE,
  CONSTRAINT `fk_Administrador_Pacientes`
    FOREIGN KEY (`idPaciente`)
    REFERENCES `sgpc`.`pacientes` (`idPaciente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sgpc`.`direccion_doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgpc`.`direccion_doctor` (
  `idDireccion_doctor` INT NOT NULL AUTO_INCREMENT,
  `Calle` VARCHAR(100) NULL DEFAULT NULL,
  `Numero_Interior` INT NULL DEFAULT NULL,
  `Numero_Exterior` INT NULL DEFAULT NULL,
  `Colonia` VARCHAR(100) NULL DEFAULT NULL,
  `Codigo_Postal` VARCHAR(10) NULL DEFAULT NULL,
  `Municipio` VARCHAR(100) NULL DEFAULT NULL,
  `Estado_Lugar` VARCHAR(100) NULL DEFAULT NULL,
  `Usuario_Movimiento` VARCHAR(100) NULL DEFAULT 'Administrador',
  `Fecha_Movimiento` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDireccion_doctor`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sgpc`.`doctores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgpc`.`doctores` (
  `idDoctor` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) NULL DEFAULT NULL,
  `AP_Paterno` VARCHAR(100) NULL DEFAULT NULL,
  `AP_Materno` VARCHAR(100) NULL DEFAULT NULL,
  `CURP` VARCHAR(18) NULL DEFAULT NULL,
  `RFC` VARCHAR(13) NULL DEFAULT NULL,
  `Sexo` VARCHAR(9) NULL DEFAULT NULL,
  `Edad` INT NULL DEFAULT NULL,
  `Fecha_Nacimiento` DATE NULL DEFAULT NULL,
  `idDireccion_doctor` INT NOT NULL DEFAULT '0',
  `Telefono_doctor` VARCHAR(50) NULL DEFAULT NULL,
  `Correo_doctor` VARCHAR(100) NULL DEFAULT NULL,
  `Especialidad` VARCHAR(100) NULL DEFAULT NULL,
  `NSS` VARCHAR(11) NULL DEFAULT NULL,
  `Usuario_Movimiento` VARCHAR(100) NULL DEFAULT 'Administrador',
  `Fecha_Movimiento` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDoctor`),
  INDEX `fk_Doctores_direccion_doctor` (`idDireccion_doctor` ASC) VISIBLE,
  CONSTRAINT `fk_Doctores_direccion_doctor`
    FOREIGN KEY (`idDireccion_doctor`)
    REFERENCES `sgpc`.`direccion_doctor` (`idDireccion_doctor`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sgpc`.`cita_paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgpc`.`cita_paciente` (
  `idCita_paciente` INT NOT NULL AUTO_INCREMENT,
  `idPaciente` INT NOT NULL DEFAULT '0',
  `idDoctor` INT NOT NULL DEFAULT '0',
  `Fecha_cita` DATE NULL DEFAULT NULL,
  `Hora_cita` TIME NULL DEFAULT NULL,
  `Costo` DECIMAL(6,2) NULL DEFAULT NULL,
  `Especialidad` VARCHAR(100) NULL DEFAULT NULL,
  `Numero_consultorio` INT NULL DEFAULT NULL,
  `Nota_cita` VARCHAR(1000) NULL DEFAULT NULL,
  `Estado_cita` VARCHAR(50) NULL DEFAULT NULL,
  `Usuario_Movimiento` VARCHAR(100) NULL DEFAULT 'Administrador',
  `Fecha_Movimiento` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCita_paciente`),
  INDEX `fk_Cita_paciente_Pacientes` (`idPaciente` ASC) VISIBLE,
  INDEX `fk_Cita_paciente_Doctores` (`idDoctor` ASC) VISIBLE,
  CONSTRAINT `fk_Cita_paciente_Doctores`
    FOREIGN KEY (`idDoctor`)
    REFERENCES `sgpc`.`doctores` (`idDoctor`),
  CONSTRAINT `fk_Cita_paciente_Pacientes`
    FOREIGN KEY (`idPaciente`)
    REFERENCES `sgpc`.`pacientes` (`idPaciente`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sgpc`.`citas_eliminadas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgpc`.`citas_eliminadas` (
  `idCita_eliminada` INT NOT NULL AUTO_INCREMENT,
  `idCita_paciente` INT NOT NULL,
  `idPaciente` INT NOT NULL DEFAULT '0',
  `idDoctor` INT NOT NULL DEFAULT '0',
  `Fecha_cita` DATE NULL DEFAULT NULL,
  `Hora_cita` TIME NULL DEFAULT NULL,
  `Costo` DECIMAL(6,2) NULL DEFAULT NULL,
  `Especialidad` VARCHAR(100) NULL DEFAULT NULL,
  `Numero_consultorio` INT NULL DEFAULT NULL,
  `Nota_cita` VARCHAR(1000) NULL DEFAULT NULL,
  `Estado_cita` VARCHAR(50) NULL DEFAULT NULL,
  `Usuario_Movimiento` VARCHAR(100) NULL DEFAULT 'Administrador',
  `Fecha_Movimiento` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCita_eliminada`),
  INDEX `fk_Citas_eliminadas_Pacientes` (`idPaciente` ASC) VISIBLE,
  INDEX `fk_Citas_eliminadas_Doctores` (`idDoctor` ASC) VISIBLE,
  CONSTRAINT `fk_Citas_eliminadas_Doctores`
    FOREIGN KEY (`idDoctor`)
    REFERENCES `sgpc`.`doctores` (`idDoctor`),
  CONSTRAINT `fk_Citas_eliminadas_Pacientes`
    FOREIGN KEY (`idPaciente`)
    REFERENCES `sgpc`.`pacientes` (`idPaciente`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `sgpc` ;

-- -----------------------------------------------------
-- Placeholder table for view `sgpc`.`mostrar_administradores_rango_activo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgpc`.`mostrar_administradores_rango_activo` (`rpad('idAdministrador',15,' ')` INT, `rpad('Nombre',30,' ')` INT, `rpad('Contraseña',10,' ')` INT, `rpad('Etiqueta',20,' ')` INT, `rpad('Esta_Activo',11,' ')` INT, `rpad('Usuario_Movimiento',50,' ')` INT, `rpad('Fecha_Movimiento',20,' ')` INT);

-- -----------------------------------------------------
-- Placeholder table for view `sgpc`.`mostrar_citas_dia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgpc`.`mostrar_citas_dia` (`rpad('idCita_paciente',15,' ')` INT, `rpad('idPaciente',10,' ')` INT, `rpad('idDoctor',8,' ')` INT, `rpad('Fecha_cita',10,' ')` INT, `rpad('Hora_cita',10,' ')` INT, `rpad('Costo',10,' ')` INT, `rpad('Especialidad',50,' ')` INT, `rpad('Numero_consultorio',18,' ')` INT, `rpad('Nota_cita',50,' ')` INT, `rpad('Usuario_Movimiento',50,' ')` INT, `rpad('Fecha_Movimiento',20,' ')` INT);

-- -----------------------------------------------------
-- Placeholder table for view `sgpc`.`mostrar_doctores_especialidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgpc`.`mostrar_doctores_especialidad` (`rpad('idDoctor',8,' ')` INT, `rpad('Nombre',30,' ')` INT, `rpad('AP_Paterno',30,' ')` INT, `rpad('AP_Materno',30,' ')` INT, `rpad('CURP',18,' ')` INT, `rpad('RFC',13,' ')` INT, `rpad('Sexo',10,' ')` INT, `rpad('Edad',4,' ')` INT, `rpad('Fecha_Nacimiento',16,' ')` INT, `rpad('idDireccion_doctor',18,' ')` INT, `rpad('Telefono_doctor',20,' ')` INT, `rpad('Correo_doctor',40,' ')` INT, `rpad('Especialidad',25,' ')` INT, `rpad('NSS',11,' ')` INT, `rpad('Usuario_Movimiento',50,' ')` INT, `rpad('Fecha_Movimiento',20,' ')` INT);

-- -----------------------------------------------------
-- Placeholder table for view `sgpc`.`mostrar_historial_enfermedad_paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgpc`.`mostrar_historial_enfermedad_paciente` (`rpad('idExpediente_paciente',21,' ')` INT, `rpad('idPaciente',10,' ')` INT, `rpad('Lista_habitos_salud',100,' ')` INT, `rpad('Lista_vacunas_puestas',100,' ')` INT, `rpad('Lista_enfermedades_hereditarias',100,' ')` INT, `rpad('Lista_historial_enfermedades',100,' ')` INT, `rpad('Usuario_Movimiento',50,' ')` INT, `rpad('Fecha_Movimiento',20,' ')` INT);

-- -----------------------------------------------------
-- Placeholder table for view `sgpc`.`mostrar_paciente_en_tratamiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgpc`.`mostrar_paciente_en_tratamiento` (`rpad('idTratamiento_paciente',22,' ')` INT, `rpad('idPaciente',10,' ')` INT, `rpad('En_Tratamiento',14,' ')` INT, `rpad('Lista_tratamientos_actual',100,' ')` INT, `rpad('Lista_tratamientos_anteriores',100,' ')` INT, `rpad('Usuario_Movimiento',50,' ')` INT, `rpad('Fecha_Movimiento',20,' ')` INT);

-- -----------------------------------------------------
-- Placeholder table for view `sgpc`.`mostrar_pacientes_masculinos_o_femeninos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgpc`.`mostrar_pacientes_masculinos_o_femeninos` (`rpad('idPaciente',10,' ')` INT, `rpad('Nombre',30,' ')` INT, `rpad('AP_Paterno',30,' ')` INT, `rpad('AP_Materno',30,' ')` INT, `rpad('CURP',18,' ')` INT, `rpad('Sexo',10,' ')` INT, `rpad('Edad',4,' ')` INT, `rpad('Fecha_Nacimiento',16,' ')` INT, `rpad('idDireccion_paciente',20,' ')` INT, `rpad('Telefono_paciente',20,' ')` INT, `rpad('Correo_paciente',40,' ')` INT, `rpad('NSS',11,' ')` INT, `rpad('idExpediente_paciente',21,' ')` INT, `rpad('idTratamiento_paciente',22,' ')` INT, `rpad('Usuario_Movimiento',50,' ')` INT, `rpad('Fecha_Movimiento',20,' ')` INT);

-- -----------------------------------------------------
-- procedure ActualizarEstadoRangoUsuariosDuplicados
-- -----------------------------------------------------

DELIMITER $$
USE `sgpc`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarEstadoRangoUsuariosDuplicados`()
BEGIN
    DECLARE listo INT DEFAULT FALSE;
    DECLARE nombre_usuario_duplicado VARCHAR(50);
    DECLARE id_admin_ultimo INT;
    
    DECLARE BuscarNombreUsuariosDuplicadosCursor CURSOR FOR SELECT Nombre FROM administradores GROUP BY Nombre HAVING COUNT(*) > 1;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET listo = TRUE;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Capturamos cualquier error SQL y mostramos un mensaje
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ocurrio un error al actualizar duplicados.';
    END;

    START TRANSACTION;

    OPEN BuscarNombreUsuariosDuplicadosCursor;
    
    read_loop: LOOP
        FETCH BuscarNombreUsuariosDuplicadosCursor INTO nombre_usuario_duplicado;
        IF listo THEN
            LEAVE read_loop;
        END IF;
		
        SET FOREIGN_KEY_CHECKS = 0;
        
        -- Obtenemos el ID del ultimo registro
        SELECT idAdministrador INTO id_admin_ultimo FROM administradores WHERE Nombre = nombre_usuario_duplicado ORDER BY idAdministrador DESC LIMIT 1;

        -- Actualizamos todos los registros duplicados a 'Estado_Activo' = 'No' menos el ultimo
        UPDATE administradores SET Esta_Activo = 'No', Usuario_Movimiento = 'Administrador', Fecha_Movimiento = CURRENT_TIMESTAMP WHERE Nombre = nombre_usuario_duplicado AND idAdministrador <> id_admin_ultimo;
          
    END LOOP;
    CLOSE BuscarNombreUsuariosDuplicadosCursor;
    
    COMMIT;
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CrearUsuarios
-- -----------------------------------------------------

DELIMITER $$
USE `sgpc`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CrearUsuarios`(
	IN nombre VARCHAR(50),
	IN pass VARCHAR(4),
    IN etiqueta VARCHAR(50)
)
BEGIN
	DECLARE sql0 VARCHAR(255);
    DECLARE sql1 VARCHAR(255);
    DECLARE sql2 VARCHAR(255);
    DECLARE sql3 VARCHAR(255);
    DECLARE sql4 VARCHAR(255);
    DECLARE sql5 VARCHAR(255);
    DECLARE sql6 VARCHAR(255);
    DECLARE sql7 VARCHAR(255);
    DECLARE sql8 VARCHAR(255);
    DECLARE sql9 VARCHAR(255);
    DECLARE sql10 VARCHAR(255);
    DECLARE sql11 VARCHAR(255);
    DECLARE sql12 VARCHAR(255);
    DECLARE sql13 VARCHAR(255);
    DECLARE sql14 VARCHAR(255);
    DECLARE sql15 VARCHAR(255);
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Capturamos cualquier error SQL y mostramos un mensaje
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ocurrio un error al crear o modificar el usuario.';
    END;

    START TRANSACTION;

	-- Para crear usuarios
    SET @sql1 = CONCAT('CREATE USER IF NOT EXISTS ', "'", nombre, "'", "@'localhost'", ' IDENTIFIED BY ', "'" , pass , "'" );
    PREPARE stmt1 FROM @sql1;
    EXECUTE stmt1;
    DEALLOCATE PREPARE stmt1;

	-- Para asignar etiqueta 'ADMINISTRADOR'
    IF etiqueta = 'ADMINISTRADOR' THEN
        SET @sql2 = CONCAT('GRANT all privileges ON sgpc.* TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt2 FROM @sql2;
        EXECUTE stmt2;
        DEALLOCATE PREPARE stmt2;
        FLUSH PRIVILEGES;
        SET @sql3 = CONCAT('SHOW GRANTS FOR ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt3 FROM @sql3;
        EXECUTE stmt3;
        DEALLOCATE PREPARE stmt3;
	
	-- Para asignar etiqueta 'CITAS'
    ELSEIF etiqueta = 'CITAS' THEN
        SET @sql2 = CONCAT('GRANT select ON sgpc.cita_paciente TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt2 FROM @sql2;
        EXECUTE stmt2;
        DEALLOCATE PREPARE stmt2;
        SET @sql3 = CONCAT('GRANT insert ON sgpc.cita_paciente TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt3 FROM @sql3;
        EXECUTE stmt3;
        DEALLOCATE PREPARE stmt3;
        SET @sql4 = CONCAT('GRANT update ON sgpc.cita_paciente TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt4 FROM @sql4;
        EXECUTE stmt4;
        DEALLOCATE PREPARE stmt4;
        SET @sql5 = CONCAT('GRANT delete ON sgpc.cita_paciente TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt5 FROM @sql5;
        EXECUTE stmt5;
        DEALLOCATE PREPARE stmt5;
        SET @sql6 = CONCAT('GRANT alter ON sgpc.cita_paciente TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt6 FROM @sql6;
        EXECUTE stmt6;
        DEALLOCATE PREPARE stmt6;
        SET @sql7 = CONCAT('GRANT select ON sgpc.citas_eliminadas TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt7 FROM @sql7;
        EXECUTE stmt7;
        DEALLOCATE PREPARE stmt7;
        SET @sql8 = CONCAT('GRANT insert ON sgpc.citas_eliminadas TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt8 FROM @sql8;
        EXECUTE stmt8;
        DEALLOCATE PREPARE stmt8;
        SET @sql9 = CONCAT('GRANT update ON sgpc.citas_eliminadas TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt9 FROM @sql9;
        EXECUTE stmt9;
        DEALLOCATE PREPARE stmt9;
        SET @sql10 = CONCAT('GRANT delete ON sgpc.citas_eliminadas TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt10 FROM @sql10;
        EXECUTE stmt10;
        DEALLOCATE PREPARE stmt10;
        SET @sql11 = CONCAT('GRANT alter ON sgpc.citas_eliminadas TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt11 FROM @sql11;
        EXECUTE stmt11;
        DEALLOCATE PREPARE stmt11;
        SET @sql12 = CONCAT('GRANT EXECUTE ON PROCEDURE sgpc.GestionarCita TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt12 FROM @sql12;
        EXECUTE stmt12;
        DEALLOCATE PREPARE stmt12;
        SET @sql13 = CONCAT('GRANT EXECUTE ON PROCEDURE sgpc.actualizarEstadoCita TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt13 FROM @sql13;
        EXECUTE stmt13;
        DEALLOCATE PREPARE stmt13;
        SET @sql14 = CONCAT('GRANT TRIGGER ON sgpc.cita_paciente TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt14 FROM @sql14;
        EXECUTE stmt14;
        DEALLOCATE PREPARE stmt14;
        FLUSH PRIVILEGES;
        SET @sql15 = CONCAT('SHOW GRANTS FOR ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt15 FROM @sql15;
        EXECUTE stmt15;
        DEALLOCATE PREPARE stmt15;

	-- Para asignar etiqueta 'EXPEDIENTES'
    ELSEIF etiqueta = 'EXPEDIENTES' THEN
        SET @sql2 = CONCAT('GRANT select ON sgpc.expediente_paciente TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt2 FROM @sql2;
        EXECUTE stmt2;
        DEALLOCATE PREPARE stmt2;
        SET @sql3 = CONCAT('GRANT insert ON sgpc.expediente_paciente TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt3 FROM @sql3;
        EXECUTE stmt3;
        DEALLOCATE PREPARE stmt3;
        SET @sql4 = CONCAT('GRANT update ON sgpc.expediente_paciente TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt4 FROM @sql4;
        EXECUTE stmt4;
        DEALLOCATE PREPARE stmt4;
        SET @sql5 = CONCAT('GRANT alter ON sgpc.expediente_paciente TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt5 FROM @sql5;
        EXECUTE stmt5;
        DEALLOCATE PREPARE stmt5;
        SET @sql6 = CONCAT('GRANT EXECUTE ON PROCEDURE sgpc.GestionarExpediente TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt6 FROM @sql6;
        EXECUTE stmt6;
        DEALLOCATE PREPARE stmt6;
        SET @sql7 = CONCAT('GRANT TRIGGER ON sgpc.expediente_paciente TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt7 FROM @sql7;
        EXECUTE stmt7;
        DEALLOCATE PREPARE stmt7;
        FLUSH PRIVILEGES;
        SET @sql8 = CONCAT('SHOW GRANTS FOR ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt8 FROM @sql8;
        EXECUTE stmt8;
        DEALLOCATE PREPARE stmt8;

	-- Para asignar etiqueta 'TRATAMIENTO'
    ELSEIF etiqueta = 'TRATAMIENTO' THEN
        SET @sql2 = CONCAT('GRANT select ON sgpc.tratamiento_paciente TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt2 FROM @sql2;
        EXECUTE stmt2;
        DEALLOCATE PREPARE stmt2;
        SET @sql3 = CONCAT('GRANT insert ON sgpc.tratamiento_paciente TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt3 FROM @sql3;
        EXECUTE stmt3;
        DEALLOCATE PREPARE stmt3;
        SET @sql4 = CONCAT('GRANT update ON sgpc.tratamiento_paciente TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt4 FROM @sql4;
        EXECUTE stmt4;
        DEALLOCATE PREPARE stmt4;
        SET @sql5 = CONCAT('GRANT alter ON sgpc.tratamiento_paciente TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt5 FROM @sql5;
        EXECUTE stmt5;
        DEALLOCATE PREPARE stmt5;
        SET @sql6 = CONCAT('GRANT EXECUTE ON PROCEDURE sgpc.GestionarTratamiento TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt6 FROM @sql6;
        EXECUTE stmt6;
        DEALLOCATE PREPARE stmt6;
        SET @sql7 = CONCAT('GRANT TRIGGER ON sgpc.tratamiento_paciente TO ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt7 FROM @sql7;
        EXECUTE stmt7;
        DEALLOCATE PREPARE stmt7;
        FLUSH PRIVILEGES;
        SET @sql8 = CONCAT('SHOW GRANTS FOR ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt8 FROM @sql8;
        EXECUTE stmt8;
        DEALLOCATE PREPARE stmt8;
	
    -- Para asignar etiqueta 'NADA' (NO PRIVILEGIOS)
    ELSEIF etiqueta = 'NADA' THEN
		SET @sql0 = CONCAT('REVOKE ALL PRIVILEGES, GRANT OPTION FROM ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt0 FROM @sql0;
        EXECUTE stmt0;
        DEALLOCATE PREPARE stmt0;
        FLUSH PRIVILEGES;
        SET @sql6 = CONCAT('SHOW GRANTS FOR ', "'", nombre, "'", "@'localhost'");
        PREPARE stmt6 FROM @sql6;
        EXECUTE stmt6;
        DEALLOCATE PREPARE stmt6;
    END IF;
    
    SET FOREIGN_KEY_CHECKS = 0;
    
    -- Insertamos o actualizamos el registro en la tabla 'administradores' en base
    -- a la informacion ingresada en el Procedimiento Almacenado.
    INSERT INTO `sgpc`.`administradores` (idPaciente, Nombre, Contraseña, Etiqueta, Esta_Activo, Usuario_Movimiento, Fecha_Movimiento)
    VALUES ('501', nombre, pass, etiqueta, 'Si', 'Administrador', CURRENT_TIMESTAMP)
    ON DUPLICATE KEY UPDATE
        Etiqueta = VALUES(Etiqueta);
    
    -- Llamamos a este Procedimiento Almacenado para actualizar los registros que estaran
    -- activos en base a la informacion ingresada de este Procedimiento Almacenado.
    CALL ActualizarEstadoRangoUsuariosDuplicados();
    
    COMMIT;
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GestionarCita
-- -----------------------------------------------------

DELIMITER $$
USE `sgpc`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GestionarCita`(
    IN p_Opcion VARCHAR(10),
    IN p_idCita_paciente INT,
    IN p_idPaciente INT,
    IN p_idDoctor INT,
    IN p_Fecha_cita DATE,
    IN p_Hora_cita TIME,
    IN p_Costo DECIMAL(6,2),
    IN p_Especialidad VARCHAR(100),
    IN p_Numero_consultorio INT,
    IN p_Nota_cita VARCHAR(1000)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Capturamos cualquier error SQL y mostramos un mensaje
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Ya existe una cita en este horario, no modifico nada en la cita o no existe el paciente o doctor ingresado.';
    END;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        -- Capturamos los errores para los datos no encontrados
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No se encontro la cita especificada.';
    END;

	-- Verificamos la existencia de idPaciente
    IF (SELECT COUNT(*) FROM pacientes WHERE idPaciente = p_idPaciente) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El idPaciente que ingreso no existe.';
    END IF;

    -- Verificamos la existencia de idDoctor
    IF (SELECT COUNT(*) FROM doctores WHERE idDoctor = p_idDoctor) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El idDoctor que ingreso no existe.';
    END IF;

    START TRANSACTION;

	-- Programar una nueva cita
    IF p_Opcion = 'PROGRAMAR' THEN
		SET FOREIGN_KEY_CHECKS = 0;
        ALTER TABLE cita_paciente AUTO_INCREMENT = 1;
        INSERT INTO cita_paciente (idPaciente, idDoctor, Fecha_cita, Hora_cita, Costo, Especialidad, Numero_consultorio, Nota_cita, Estado_cita, Usuario_Movimiento, Fecha_Movimiento)
        VALUES (p_idPaciente, p_idDoctor, p_Fecha_cita, p_Hora_cita, p_Costo, p_Especialidad, p_Numero_consultorio, p_Nota_cita, 'Programada', 'ADMIN CITAS', CURRENT_TIMESTAMP);
        SELECT * FROM cita_paciente WHERE idCita_paciente = last_insert_id();
    
    -- Modificar una cita existente
    ELSEIF p_Opcion = 'MODIFICAR' THEN
		SET FOREIGN_KEY_CHECKS = 0;
        ALTER TABLE citas_eliminadas AUTO_INCREMENT = 1;
        DELETE FROM cita_paciente WHERE idCita_paciente = p_idCita_paciente;
        ALTER TABLE cita_paciente AUTO_INCREMENT = 1;
        INSERT INTO cita_paciente (idPaciente, idDoctor, Fecha_cita, Hora_cita, Costo, Especialidad, Numero_consultorio, Nota_cita, Estado_cita, Usuario_Movimiento, Fecha_Movimiento)
        VALUES (p_idPaciente, p_idDoctor, p_Fecha_cita, p_Hora_cita, p_Costo, p_Especialidad, p_Numero_consultorio, p_Nota_cita, 'Programada', 'ADMIN CITAS', CURRENT_TIMESTAMP);
        SELECT * FROM cita_paciente WHERE idCita_paciente = last_insert_id();
    
		-- Si no se encontro la cita a modificar entonces muestra un mensaje de error.
        IF ROW_COUNT() = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No se encontro la cita para modificar.';
        END IF;
        
        SELECT * FROM cita_paciente WHERE idCita_paciente = p_idCita_paciente;
    
    -- Cancelar una cita existente
    ELSEIF p_Opcion = 'CANCELAR' THEN
		SET FOREIGN_KEY_CHECKS = 0;
        ALTER TABLE citas_eliminadas AUTO_INCREMENT = 1;
        DELETE FROM cita_paciente WHERE idCita_paciente = p_idCita_paciente;
        ALTER TABLE cita_paciente AUTO_INCREMENT = 1;
        SELECT * FROM citas_eliminadas WHERE idCita_paciente = p_idCita_paciente;
        
        -- Si no se encontro la cita a cancelar entonces muestra un mensaje de error.
        IF ROW_COUNT() = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No se encontro la cita para cancelar.';
        END IF;
    
    ELSE
        -- Cuando el usuario ingreso una opcion que no es valida
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Opcion no valida. Lista de opciones: "PROGRAMAR", "MODIFICAR", "CANCELAR"';
    END IF;
    
    COMMIT;
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GestionarExpediente
-- -----------------------------------------------------

DELIMITER $$
USE `sgpc`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GestionarExpediente`(
    IN p_Opcion VARCHAR(10),
    IN p_idExpediente_paciente INT,
    IN p_idPaciente INT,
    IN p_Lista_habitos_salud VARCHAR(1000),
    IN p_Lista_vacunas_puestas VARCHAR(1000),
    IN p_Lista_enfermedades_hereditarias VARCHAR(1000),
    IN p_Lista_historial_enfermedades VARCHAR(1000)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Capturamos cualquier error SQL y mostramos un mensaje
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Ya existe el expediente de este paciente, no modifico nada del expediente o no existe el paciente o doctor ingresado.';
    END;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        -- Capturamos los errores para los datos no eencontrados
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No se encontro el expediente especificado.';
    END;

	-- Verificamos la existencia de idPaciente
    IF (SELECT COUNT(*) FROM pacientes WHERE idPaciente = p_idPaciente) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El idPaciente que ingreso no existe.';
    END IF;

    START TRANSACTION;

	-- Crear un nuevo expediente
    IF p_Opcion = 'CREAR' THEN
		SET FOREIGN_KEY_CHECKS = 0;
        ALTER TABLE expediente_paciente AUTO_INCREMENT = 1;
        INSERT INTO expediente_paciente (idPaciente, Lista_habitos_salud, Lista_vacunas_puestas, Lista_enfermedades_hereditarias, Lista_historial_enfermedades, Usuario_Movimiento, Fecha_Movimiento)
        VALUES (p_idPaciente, p_Lista_habitos_salud, p_Lista_vacunas_puestas, p_Lista_enfermedades_hereditarias, p_Lista_historial_enfermedades, 'ADMIN EXPEDIENTES', CURRENT_TIMESTAMP);
        SELECT * FROM expediente_paciente WHERE idExpediente_paciente = last_insert_id();
    
    -- Modificar un expediente existente
    ELSEIF p_Opcion = 'MODIFICAR' THEN
		SET FOREIGN_KEY_CHECKS = 0;
        UPDATE expediente_paciente
        SET idPaciente = p_idPaciente,
            Lista_habitos_salud = p_Lista_habitos_salud,
            Lista_vacunas_puestas = p_Lista_vacunas_puestas,
            Lista_enfermedades_hereditarias = p_Lista_enfermedades_hereditarias,
            Lista_historial_enfermedades = p_Lista_historial_enfermedades,
			Usuario_Movimiento = 'ADMIN EXPEDIENTES',
            Fecha_Movimiento = CURRENT_TIMESTAMP
        WHERE idExpediente_paciente = p_idExpediente_paciente;
    
		-- Si no se encontro el expediente a modificar entonces muestra un mensaje de error.
        IF ROW_COUNT() = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No se encontro el expediente para modificar.';
        END IF;
        
        SELECT * FROM expediente_paciente WHERE idExpediente_paciente = p_idExpediente_paciente;
    
    ELSE
        -- Cuando el usuario ingreso una opcion que no es valida
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Opcion no valida. Lista de opciones: "CREAR", "MODIFICAR".';
    END IF;

    COMMIT;
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GestionarTratamiento
-- -----------------------------------------------------

DELIMITER $$
USE `sgpc`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GestionarTratamiento`(
    IN p_Opcion VARCHAR(10),
    IN p_idTratamiento_paciente INT,
    IN p_idPaciente INT,
    IN p_En_Tratamiento VARCHAR(2),
    IN p_Lista_tratamientos_actual VARCHAR(1000),
    IN p_Lista_tratamientos_anteriores VARCHAR(1000)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Capturamos cualquier error SQL y mostramos un mensaje
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Ya existe este registro para este paciente, no modifico nada en el registro o no existe el paciente o doctor ingresado.';
    END;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        -- Capturamos los errores para los datos no encontrados
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No se encontro el registro del tratamiento especificado.';
    END;

	-- Verificamos la existencia de idPaciente
    IF (SELECT COUNT(*) FROM pacientes WHERE idPaciente = p_idPaciente) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El idPaciente que ingreso no existe.';
    END IF;

    START TRANSACTION;
	
    -- Crear un nuevo registro para el tratamiento
    IF p_Opcion = 'CREAR' THEN
		SET FOREIGN_KEY_CHECKS = 0;
        ALTER TABLE tratamiento_paciente AUTO_INCREMENT = 1;
        INSERT INTO tratamiento_paciente (idPaciente, En_Tratamiento, Lista_tratamientos_actual, Lista_tratamientos_anteriores, Usuario_Movimiento, Fecha_Movimiento)
        VALUES (p_idPaciente, p_En_Tratamiento, p_Lista_tratamientos_actual, p_Lista_tratamientos_anteriores, 'ADMIN TRATAMIENTOS', CURRENT_TIMESTAMP);
        SELECT * FROM tratamiento_paciente WHERE idTratamiento_paciente = last_insert_id();
    
    -- Modificar un registro de un tratamiento existente
    ELSEIF p_Opcion = 'MODIFICAR' THEN
		SET FOREIGN_KEY_CHECKS = 0;
        UPDATE tratamiento_paciente
        SET idPaciente = p_idPaciente,
            En_Tratamiento = p_En_Tratamiento,
            Lista_tratamientos_actual = p_Lista_tratamientos_actual,
            Lista_tratamientos_anteriores = p_Lista_tratamientos_anteriores,
			Usuario_Movimiento = 'ADMIN TRATAMIENTOS',
            Fecha_Movimiento = CURRENT_TIMESTAMP
        WHERE idTratamiento_paciente = p_idTratamiento_paciente;
    
		-- Si no se encontro el registro del tratamiento a modificar entonces muestra un mensaje de error.
        IF ROW_COUNT() = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No se encontro el registro para modificar el tratamiento.';
        END IF;
        
        SELECT * FROM tratamiento_paciente WHERE idTratamiento_paciente = p_idTratamiento_paciente;
    
    ELSE
        -- Cuando el usuario ingreso una opcion que no es valida
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Opcion no valida. Lista de opciones: "CREAR", "MODIFICAR".';
    END IF;
    
    COMMIT;
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure actualizarEstadoCita
-- -----------------------------------------------------

DELIMITER $$
USE `sgpc`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarEstadoCita`()
BEGIN
    DECLARE listo INT DEFAULT FALSE;
    DECLARE idCita INT;
	DECLARE fecha_cita DATE;
    DECLARE hora_cita TIME;
    DECLARE fecha_actual DATETIME;
    
    DECLARE LeerRegistrosCitascursor CURSOR FOR SELECT ci.idCita_paciente, ci.Fecha_cita, ci.Hora_cita FROM cita_paciente ci;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET listo = TRUE;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Capturamos cualquier error SQL y mostramos un mensaje
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ocurrio un error al actualizar el estado de las citas.';
    END;
    
    START TRANSACTION;
    
    OPEN LeerRegistrosCitascursor;
    
    SET fecha_actual = NOW();
    
    read_loop: LOOP
	FETCH NEXT FROM LeerRegistrosCitascursor
	INTO idCita,
		fecha_cita,
		hora_cita;
        
	IF TIMESTAMP(fecha_cita, hora_cita) <= fecha_actual THEN
		SET FOREIGN_KEY_CHECKS = 0;
		-- Si la fecha de la cita ha pasado, actualizamos el estado de la cita a 'COMPLETADA'
		UPDATE cita_paciente SET Estado_cita = 'Completada' WHERE idCita_paciente = idCita;
        UPDATE cita_paciente SET Fecha_Movimiento = CURRENT_TIMESTAMP WHERE idCita_paciente = idCita;
        UPDATE cita_paciente SET Usuario_Movimiento = 'ADMIN CITAS' WHERE idCita_paciente = idCita;
	else
		SET FOREIGN_KEY_CHECKS = 0;
		-- Si la fecha de la cita no ha pasado, actualizamos el estado de la cita a 'PROGRAMADA'
		UPDATE cita_paciente SET Estado_cita = 'Programada' WHERE idCita_paciente = idCita;
        UPDATE cita_paciente SET Fecha_Movimiento = CURRENT_TIMESTAMP WHERE idCita_paciente = idCita;
        UPDATE cita_paciente SET Usuario_Movimiento = 'ADMIN CITAS' WHERE idCita_paciente = idCita;
	END IF;
    
	IF listo THEN
		LEAVE read_loop;
	END IF;
    END LOOP;
    
    CLOSE LeerRegistrosCitascursor;

    COMMIT;
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `sgpc`.`mostrar_administradores_rango_activo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sgpc`.`mostrar_administradores_rango_activo`;
USE `sgpc`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sgpc`.`mostrar_administradores_rango_activo` AS select rpad('idAdministrador',15,' ') AS `rpad('idAdministrador',15,' ')`,rpad('Nombre',30,' ') AS `rpad('Nombre',30,' ')`,rpad('Contraseña',10,' ') AS `rpad('Contraseña',10,' ')`,rpad('Etiqueta',20,' ') AS `rpad('Etiqueta',20,' ')`,rpad('Esta_Activo',11,' ') AS `rpad('Esta_Activo',11,' ')`,rpad('Usuario_Movimiento',50,' ') AS `rpad('Usuario_Movimiento',50,' ')`,rpad('Fecha_Movimiento',20,' ') AS `rpad('Fecha_Movimiento',20,' ')` union all select rpad(`a`.`idAdministrador`,15,' ') AS `rpad(a.idAdministrador,15,' ')`,rpad(`a`.`Nombre`,30,' ') AS `rpad(a.Nombre,30,' ')`,rpad(`a`.`Contraseña`,10,' ') AS `rpad(a.Contraseña,10,' ')`,rpad(`a`.`Etiqueta`,20,' ') AS `rpad(a.Etiqueta,20,' ')`,rpad(`a`.`Esta_Activo`,11,' ') AS `rpad(a.Esta_Activo,11,' ')`,rpad(`a`.`Usuario_Movimiento`,50,' ') AS `rpad(a.Usuario_Movimiento,50,' ')`,rpad(`a`.`Fecha_Movimiento`,20,' ') AS `rpad(a.Fecha_Movimiento,20,' ')` from `sgpc`.`administradores` `a` where (`a`.`Esta_Activo` = 'Si');

-- -----------------------------------------------------
-- View `sgpc`.`mostrar_citas_dia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sgpc`.`mostrar_citas_dia`;
USE `sgpc`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sgpc`.`mostrar_citas_dia` AS select rpad('idCita_paciente',15,' ') AS `rpad('idCita_paciente',15,' ')`,rpad('idPaciente',10,' ') AS `rpad('idPaciente',10,' ')`,rpad('idDoctor',8,' ') AS `rpad('idDoctor',8,' ')`,rpad('Fecha_cita',10,' ') AS `rpad('Fecha_cita',10,' ')`,rpad('Hora_cita',10,' ') AS `rpad('Hora_cita',10,' ')`,rpad('Costo',10,' ') AS `rpad('Costo',10,' ')`,rpad('Especialidad',50,' ') AS `rpad('Especialidad',50,' ')`,rpad('Numero_consultorio',18,' ') AS `rpad('Numero_consultorio',18,' ')`,rpad('Nota_cita',50,' ') AS `rpad('Nota_cita',50,' ')`,rpad('Usuario_Movimiento',50,' ') AS `rpad('Usuario_Movimiento',50,' ')`,rpad('Fecha_Movimiento',20,' ') AS `rpad('Fecha_Movimiento',20,' ')` union all select rpad(`c`.`idCita_paciente`,15,' ') AS `rpad(c.idCita_paciente,15,' ')`,rpad(`c`.`idPaciente`,10,' ') AS `rpad(c.idPaciente,10,' ')`,rpad(`c`.`idDoctor`,8,' ') AS `rpad(c.idDoctor,8,' ')`,rpad(`c`.`Fecha_cita`,10,' ') AS `rpad(c.Fecha_cita,10,' ')`,rpad(`c`.`Hora_cita`,10,' ') AS `rpad(c.Hora_cita,10,' ')`,rpad(`c`.`Costo`,10,' ') AS `rpad(c.Costo,10,' ')`,rpad(`c`.`Especialidad`,50,' ') AS `rpad(c.Especialidad,50,' ')`,rpad(`c`.`Numero_consultorio`,18,' ') AS `rpad(c.Numero_consultorio,18,' ')`,rpad(`c`.`Nota_cita`,50,' ') AS `rpad(c.Nota_cita,50,' ')`,rpad(`c`.`Usuario_Movimiento`,50,' ') AS `rpad(c.Usuario_Movimiento,50,' ')`,rpad(`c`.`Fecha_Movimiento`,20,' ') AS `rpad(c.Fecha_Movimiento,20,' ')` from `sgpc`.`cita_paciente` `c` where (`c`.`Fecha_cita` = '2023-01-02');

-- -----------------------------------------------------
-- View `sgpc`.`mostrar_doctores_especialidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sgpc`.`mostrar_doctores_especialidad`;
USE `sgpc`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sgpc`.`mostrar_doctores_especialidad` AS select rpad('idDoctor',8,' ') AS `rpad('idDoctor',8,' ')`,rpad('Nombre',30,' ') AS `rpad('Nombre',30,' ')`,rpad('AP_Paterno',30,' ') AS `rpad('AP_Paterno',30,' ')`,rpad('AP_Materno',30,' ') AS `rpad('AP_Materno',30,' ')`,rpad('CURP',18,' ') AS `rpad('CURP',18,' ')`,rpad('RFC',13,' ') AS `rpad('RFC',13,' ')`,rpad('Sexo',10,' ') AS `rpad('Sexo',10,' ')`,rpad('Edad',4,' ') AS `rpad('Edad',4,' ')`,rpad('Fecha_Nacimiento',16,' ') AS `rpad('Fecha_Nacimiento',16,' ')`,rpad('idDireccion_doctor',18,' ') AS `rpad('idDireccion_doctor',18,' ')`,rpad('Telefono_doctor',20,' ') AS `rpad('Telefono_doctor',20,' ')`,rpad('Correo_doctor',40,' ') AS `rpad('Correo_doctor',40,' ')`,rpad('Especialidad',25,' ') AS `rpad('Especialidad',25,' ')`,rpad('NSS',11,' ') AS `rpad('NSS',11,' ')`,rpad('Usuario_Movimiento',50,' ') AS `rpad('Usuario_Movimiento',50,' ')`,rpad('Fecha_Movimiento',20,' ') AS `rpad('Fecha_Movimiento',20,' ')` union all select rpad(`d`.`idDoctor`,8,' ') AS `rpad(d.idDoctor,8,' ')`,rpad(`d`.`Nombre`,30,' ') AS `rpad(d.Nombre,30,' ')`,rpad(`d`.`AP_Paterno`,30,' ') AS `rpad(d.AP_Paterno,30,' ')`,rpad(`d`.`AP_Materno`,30,' ') AS `rpad(d.AP_Materno,30,' ')`,rpad(`d`.`CURP`,18,' ') AS `rpad(d.CURP,18,' ')`,rpad(`d`.`RFC`,13,' ') AS `rpad(d.RFC,13,' ')`,rpad(`d`.`Sexo`,10,' ') AS `rpad(d.Sexo,10,' ')`,rpad(`d`.`Edad`,4,' ') AS `rpad(d.Edad,4,' ')`,rpad(`d`.`Fecha_Nacimiento`,16,' ') AS `rpad(d.Fecha_Nacimiento,16,' ')`,rpad(`d`.`idDireccion_doctor`,18,' ') AS `rpad(d.idDireccion_doctor,18,' ')`,rpad(`d`.`Telefono_doctor`,20,' ') AS `rpad(d.Telefono_doctor,20,' ')`,rpad(`d`.`Correo_doctor`,40,' ') AS `rpad(d.Correo_doctor,40,' ')`,rpad(`d`.`Especialidad`,25,' ') AS `rpad(d.Especialidad,25,' ')`,rpad(`d`.`NSS`,11,' ') AS `rpad(d.NSS,11,' ')`,rpad(`d`.`Usuario_Movimiento`,50,' ') AS `rpad(d.Usuario_Movimiento,50,' ')`,rpad(`d`.`Fecha_Movimiento`,20,' ') AS `rpad(d.Fecha_Movimiento,20,' ')` from `sgpc`.`doctores` `d` where (`d`.`Especialidad` = 'Cardiología');

-- -----------------------------------------------------
-- View `sgpc`.`mostrar_historial_enfermedad_paciente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sgpc`.`mostrar_historial_enfermedad_paciente`;
USE `sgpc`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sgpc`.`mostrar_historial_enfermedad_paciente` AS select rpad('idExpediente_paciente',21,' ') AS `rpad('idExpediente_paciente',21,' ')`,rpad('idPaciente',10,' ') AS `rpad('idPaciente',10,' ')`,rpad('Lista_habitos_salud',100,' ') AS `rpad('Lista_habitos_salud',100,' ')`,rpad('Lista_vacunas_puestas',100,' ') AS `rpad('Lista_vacunas_puestas',100,' ')`,rpad('Lista_enfermedades_hereditarias',100,' ') AS `rpad('Lista_enfermedades_hereditarias',100,' ')`,rpad('Lista_historial_enfermedades',100,' ') AS `rpad('Lista_historial_enfermedades',100,' ')`,rpad('Usuario_Movimiento',50,' ') AS `rpad('Usuario_Movimiento',50,' ')`,rpad('Fecha_Movimiento',20,' ') AS `rpad('Fecha_Movimiento',20,' ')` union all select rpad(`e`.`idExpediente_paciente`,21,' ') AS `rpad(e.idExpediente_paciente,21,' ')`,rpad(`e`.`idPaciente`,10,' ') AS `rpad(e.idPaciente,10,' ')`,rpad(`e`.`Lista_habitos_salud`,100,' ') AS `rpad(e.Lista_habitos_salud,100,' ')`,rpad(`e`.`Lista_vacunas_puestas`,100,' ') AS `rpad(e.Lista_vacunas_puestas,100,' ')`,rpad(`e`.`Lista_enfermedades_hereditarias`,100,' ') AS `rpad(e.Lista_enfermedades_hereditarias,100,' ')`,rpad(`e`.`Lista_historial_enfermedades`,100,' ') AS `rpad(e.Lista_historial_enfermedades,100,' ')`,rpad(`e`.`Usuario_Movimiento`,50,' ') AS `rpad(e.Usuario_Movimiento,50,' ')`,rpad(`e`.`Fecha_Movimiento`,20,' ') AS `rpad(e.Fecha_Movimiento,20,' ')` from `sgpc`.`expediente_paciente` `e` where (`e`.`Lista_historial_enfermedades` like '%COVID-19%');

-- -----------------------------------------------------
-- View `sgpc`.`mostrar_paciente_en_tratamiento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sgpc`.`mostrar_paciente_en_tratamiento`;
USE `sgpc`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sgpc`.`mostrar_paciente_en_tratamiento` AS select rpad('idTratamiento_paciente',22,' ') AS `rpad('idTratamiento_paciente',22,' ')`,rpad('idPaciente',10,' ') AS `rpad('idPaciente',10,' ')`,rpad('En_Tratamiento',14,' ') AS `rpad('En_Tratamiento',14,' ')`,rpad('Lista_tratamientos_actual',100,' ') AS `rpad('Lista_tratamientos_actual',100,' ')`,rpad('Lista_tratamientos_anteriores',100,' ') AS `rpad('Lista_tratamientos_anteriores',100,' ')`,rpad('Usuario_Movimiento',50,' ') AS `rpad('Usuario_Movimiento',50,' ')`,rpad('Fecha_Movimiento',20,' ') AS `rpad('Fecha_Movimiento',20,' ')` union all select rpad(`t`.`idTratamiento_paciente`,22,' ') AS `rpad(t.idTratamiento_paciente,22,' ')`,rpad(`t`.`idPaciente`,10,' ') AS `rpad(t.idPaciente,10,' ')`,rpad(`t`.`En_Tratamiento`,14,' ') AS `rpad(t.En_Tratamiento,14,' ')`,rpad(`t`.`Lista_tratamientos_actual`,100,' ') AS `rpad(t.Lista_tratamientos_actual,100,' ')`,rpad(`t`.`Lista_tratamientos_anteriores`,100,' ') AS `rpad(t.Lista_tratamientos_anteriores,100,' ')`,rpad(`t`.`Usuario_Movimiento`,50,' ') AS `rpad(t.Usuario_Movimiento,50,' ')`,rpad(`t`.`Fecha_Movimiento`,20,' ') AS `rpad(t.Fecha_Movimiento,20,' ')` from `sgpc`.`tratamiento_paciente` `t` where (`t`.`En_Tratamiento` = 'SI');

-- -----------------------------------------------------
-- View `sgpc`.`mostrar_pacientes_masculinos_o_femeninos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sgpc`.`mostrar_pacientes_masculinos_o_femeninos`;
USE `sgpc`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sgpc`.`mostrar_pacientes_masculinos_o_femeninos` AS select rpad('idPaciente',10,' ') AS `rpad('idPaciente',10,' ')`,rpad('Nombre',30,' ') AS `rpad('Nombre',30,' ')`,rpad('AP_Paterno',30,' ') AS `rpad('AP_Paterno',30,' ')`,rpad('AP_Materno',30,' ') AS `rpad('AP_Materno',30,' ')`,rpad('CURP',18,' ') AS `rpad('CURP',18,' ')`,rpad('Sexo',10,' ') AS `rpad('Sexo',10,' ')`,rpad('Edad',4,' ') AS `rpad('Edad',4,' ')`,rpad('Fecha_Nacimiento',16,' ') AS `rpad('Fecha_Nacimiento',16,' ')`,rpad('idDireccion_paciente',20,' ') AS `rpad('idDireccion_paciente',20,' ')`,rpad('Telefono_paciente',20,' ') AS `rpad('Telefono_paciente',20,' ')`,rpad('Correo_paciente',40,' ') AS `rpad('Correo_paciente',40,' ')`,rpad('NSS',11,' ') AS `rpad('NSS',11,' ')`,rpad('idExpediente_paciente',21,' ') AS `rpad('idExpediente_paciente',21,' ')`,rpad('idTratamiento_paciente',22,' ') AS `rpad('idTratamiento_paciente',22,' ')`,rpad('Usuario_Movimiento',50,' ') AS `rpad('Usuario_Movimiento',50,' ')`,rpad('Fecha_Movimiento',20,' ') AS `rpad('Fecha_Movimiento',20,' ')` union all select rpad(`p`.`idPaciente`,10,' ') AS `rpad(p.idPaciente,10,' ')`,rpad(`p`.`Nombre`,30,' ') AS `rpad(p.Nombre,30,' ')`,rpad(`p`.`AP_Paterno`,30,' ') AS `rpad(p.AP_Paterno,30,' ')`,rpad(`p`.`AP_Materno`,30,' ') AS `rpad(p.AP_Materno,30,' ')`,rpad(`p`.`CURP`,18,' ') AS `rpad(p.CURP,18,' ')`,rpad(`p`.`Sexo`,10,' ') AS `rpad(p.Sexo,10,' ')`,rpad(`p`.`Edad`,4,' ') AS `rpad(p.Edad,4,' ')`,rpad(`p`.`Fecha_Nacimiento`,16,' ') AS `rpad(p.Fecha_Nacimiento,16,' ')`,rpad(`p`.`idDireccion_paciente`,20,' ') AS `rpad(p.idDireccion_paciente,20,' ')`,rpad(`p`.`Telefono_paciente`,20,' ') AS `rpad(p.Telefono_paciente,20,' ')`,rpad(`p`.`Correo_paciente`,40,' ') AS `rpad(p.Correo_paciente,40,' ')`,rpad(`p`.`NSS`,11,' ') AS `rpad(p.NSS,11,' ')`,rpad(`p`.`idExpediente_paciente`,21,' ') AS `rpad(p.idExpediente_paciente,21,' ')`,rpad(`p`.`idTratamiento_paciente`,22,' ') AS `rpad(p.idTratamiento_paciente,22,' ')`,rpad(`p`.`Usuario_Movimiento`,50,' ') AS `rpad(p.Usuario_Movimiento,50,' ')`,rpad(`p`.`Fecha_Movimiento`,20,' ') AS `rpad(p.Fecha_Movimiento,20,' ')` from `sgpc`.`pacientes` `p` where (`p`.`Sexo` = 'Femenino');
USE `sgpc`;

DELIMITER $$
USE `sgpc`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `sgpc`.`checarDireccionPacientesDuplicados`
BEFORE INSERT ON `sgpc`.`direccion_paciente`
FOR EACH ROW
BEGIN
		DECLARE error_msg1 VARCHAR(255);
		IF EXISTS (SELECT * FROM direccion_paciente WHERE Calle = NEW.Calle AND Numero_Interior = NEW.Numero_Interior AND Colonia = NEW.Colonia AND Codigo_Postal = NEW.Codigo_Postal) THEN
			SET error_msg1 = 'Esta direccion del paciente ya esta registrada en la base de datos.';
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg1;
		END IF;
    END$$

USE `sgpc`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `sgpc`.`checarExpedientePacienteDuplicados`
BEFORE INSERT ON `sgpc`.`expediente_paciente`
FOR EACH ROW
BEGIN
		DECLARE error_msg4 VARCHAR(255);
		IF EXISTS (SELECT * FROM expediente_paciente WHERE idPaciente = NEW.idPaciente) THEN
			SET error_msg4 = 'Este expediente del paciente ya existe en la base de datos.';
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg4;
		END IF;
    END$$

USE `sgpc`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `sgpc`.`checarTratamientoPacienteDuplicados`
BEFORE INSERT ON `sgpc`.`tratamiento_paciente`
FOR EACH ROW
BEGIN
		DECLARE error_msg5 VARCHAR(255);
		IF EXISTS (SELECT * FROM tratamiento_paciente WHERE idPaciente = NEW.idPaciente) THEN
			SET error_msg5 = 'Este paciente ya se encuentra en tratamiento.';
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg5;
		END IF;
    END$$

USE `sgpc`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `sgpc`.`checarPacientesDuplicados`
BEFORE INSERT ON `sgpc`.`pacientes`
FOR EACH ROW
BEGIN
		DECLARE error_msg0 VARCHAR(255);
		IF EXISTS (SELECT * FROM pacientes WHERE Nombre = NEW.Nombre AND AP_Paterno = NEW.AP_Paterno AND AP_Materno = NEW.AP_Materno) OR EXISTS (SELECT * FROM pacientes WHERE CURP = NEW.CURP) THEN
			SET error_msg0 = 'Este paciente ya esta registrado en la base de datos.';
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg0;
		END IF;
    END$$

USE `sgpc`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `sgpc`.`checarDireccionDoctoresDuplicados`
BEFORE INSERT ON `sgpc`.`direccion_doctor`
FOR EACH ROW
BEGIN
		DECLARE error_msg3 VARCHAR(255);
		IF EXISTS (SELECT * FROM direccion_doctor WHERE Calle = NEW.Calle AND Numero_Interior = NEW.Numero_Interior AND Colonia = NEW.Colonia AND Codigo_Postal = NEW.Codigo_Postal) THEN
			SET error_msg3 = 'Esta direccion del doctor ya esta registrada en la base de datos.';
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg3;
		END IF;
    END$$

USE `sgpc`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `sgpc`.`checarDoctoresDuplicados`
BEFORE INSERT ON `sgpc`.`doctores`
FOR EACH ROW
BEGIN
		DECLARE error_msg2 VARCHAR(255);
		IF EXISTS (SELECT * FROM doctores WHERE Nombre = NEW.Nombre AND AP_Paterno = NEW.AP_Paterno AND AP_Materno = NEW.AP_Materno) OR EXISTS (SELECT * FROM doctores WHERE CURP = NEW.CURP) OR EXISTS (SELECT * FROM doctores WHERE RFC = NEW.RFC) THEN
			SET error_msg2 = 'Este doctor ya esta registrado en la base de datos.';
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg2;
		END IF;
    END$$

USE `sgpc`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `sgpc`.`checarCitasDuplicadasINSERT`
BEFORE INSERT ON `sgpc`.`cita_paciente`
FOR EACH ROW
BEGIN
        DECLARE error_msg6 VARCHAR(255);
        IF EXISTS (SELECT * FROM cita_paciente WHERE Fecha_cita = NEW.Fecha_cita AND HOUR(Hora_cita) = HOUR(NEW.Hora_cita) AND Numero_consultorio = NEW.Numero_consultorio) THEN
            SET error_msg6 = 'No se puede agendar esta cita debido a que ya ese horario y ese consultorio ya esta ocupado por un doctor (empalme de citas).';
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg6;
        END IF;
    END$$

USE `sgpc`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `sgpc`.`insertarCitasEliminadas`
BEFORE DELETE ON `sgpc`.`cita_paciente`
FOR EACH ROW
BEGIN
        INSERT INTO citas_eliminadas (idCita_paciente, idPaciente, idDoctor, Fecha_cita, Hora_cita, Costo, Especialidad, Numero_consultorio, Nota_cita, Estado_cita, Usuario_Movimiento, Fecha_Movimiento)
        VALUES (OLD.idCita_paciente, OLD.idPaciente, OLD.idDoctor, OLD.Fecha_cita, OLD.Hora_cita, OLD.Costo, OLD.Especialidad, OLD.Numero_consultorio, 'Cita Cancelada', 'Cancelada', 'ADMIN CITAS', CURRENT_TIMESTAMP);
    END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET FOREIGN_KEY_CHECKS = 0;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

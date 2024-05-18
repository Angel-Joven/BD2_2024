-- -----------------------------------------------------------------------------------------------------------------------

-- JOVEN JIMENEZ ANGEL CRISTIAN | BASES DE DATOS 2 - 2861
-- PROYECTO FINAL - Sistema de Gestión de Pacientes para una Clínica.

-- TRIGGERS A USAR

-- -----------------------------------------------------------------------------------------------------------------------

-- TRIGGER 'checarPacientesDuplicados'
-- Este trigger verifica que antes de hacer un INSERT en la tabla 'pacientes'
-- no haya un registro igual al que se va a ingresar.
-- Si lo hay, entonces no lo inserta y en cambio le retorna un mensaje de error.
-- Si no lo hay, entonces insertara el registro normalmente.

DELIMITER //
CREATE TRIGGER checarPacientesDuplicados
	BEFORE INSERT ON pacientes FOR EACH ROW
    BEGIN
		DECLARE error_msg0 VARCHAR(255);
		IF EXISTS (SELECT * FROM pacientes WHERE Nombre = NEW.Nombre AND AP_Paterno = NEW.AP_Paterno AND AP_Materno = NEW.AP_Materno) OR EXISTS (SELECT * FROM pacientes WHERE CURP = NEW.CURP) THEN
			SET error_msg0 = 'Este paciente ya esta registrado en la base de datos.';
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg0;
		END IF;
    END//
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------

-- TRIGGER 'checarDireccionPacientesDuplicados'
-- Este trigger verifica que antes de hacer un INSERT en la tabla 'direccion_paciente'
-- no haya un registro igual al que se va a ingresar.
-- Si lo hay, entonces no lo inserta y en cambio le retorna un mensaje de error.
-- Si no lo hay, entonces insertara el registro normalmente.

DELIMITER //
CREATE TRIGGER checarDireccionPacientesDuplicados
	BEFORE INSERT ON direccion_paciente FOR EACH ROW
    BEGIN
		DECLARE error_msg1 VARCHAR(255);
		IF EXISTS (SELECT * FROM direccion_paciente WHERE Calle = NEW.Calle AND Numero_Interior = NEW.Numero_Interior AND Colonia = NEW.Colonia AND Codigo_Postal = NEW.Codigo_Postal) THEN
			SET error_msg1 = 'Esta direccion del paciente ya esta registrada en la base de datos.';
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg1;
		END IF;
    END//
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------

-- TRIGGER 'checarDoctoresDuplicados'
-- Este trigger verifica que antes de hacer un INSERT en la tabla 'doctores'
-- no haya un registro igual al que se va a ingresar.
-- Si lo hay, entonces no lo inserta y en cambio le retorna un mensaje de error.
-- Si no lo hay, entonces insertara el registro normalmente.

DELIMITER //
CREATE TRIGGER checarDoctoresDuplicados
	BEFORE INSERT ON doctores FOR EACH ROW
    BEGIN
		DECLARE error_msg2 VARCHAR(255);
		IF EXISTS (SELECT * FROM doctores WHERE Nombre = NEW.Nombre AND AP_Paterno = NEW.AP_Paterno AND AP_Materno = NEW.AP_Materno) OR EXISTS (SELECT * FROM doctores WHERE CURP = NEW.CURP) OR EXISTS (SELECT * FROM doctores WHERE RFC = NEW.RFC) THEN
			SET error_msg2 = 'Este doctor ya esta registrado en la base de datos.';
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg2;
		END IF;
    END//
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------

-- TRIGGER 'checarDireccionDoctoresDuplicados'
-- Este trigger verifica que antes de hacer un INSERT en la tabla 'direccion_doctor'
-- no haya un registro igual al que se va a ingresar.
-- Si lo hay, entonces no lo inserta y en cambio le retorna un mensaje de error.
-- Si no lo hay, entonces insertara el registro normalmente.

DELIMITER //
CREATE TRIGGER checarDireccionDoctoresDuplicados
	BEFORE INSERT ON direccion_doctor FOR EACH ROW
    BEGIN
		DECLARE error_msg3 VARCHAR(255);
		IF EXISTS (SELECT * FROM direccion_doctor WHERE Calle = NEW.Calle AND Numero_Interior = NEW.Numero_Interior AND Colonia = NEW.Colonia AND Codigo_Postal = NEW.Codigo_Postal) THEN
			SET error_msg3 = 'Esta direccion del doctor ya esta registrada en la base de datos.';
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg3;
		END IF;
    END//
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------

-- TRIGGER 'checarExpedientePacienteDuplicados'
-- Este trigger verifica que antes de hacer un INSERT en la tabla 'expediente_paciente'
-- no haya un registro igual al que se va a ingresar.
-- Si lo hay, entonces no lo inserta y en cambio le retorna un mensaje de error.
-- Si no lo hay, entonces insertara el registro normalmente.

DELIMITER //
CREATE TRIGGER checarExpedientePacienteDuplicados
	BEFORE INSERT ON expediente_paciente FOR EACH ROW
    BEGIN
		DECLARE error_msg4 VARCHAR(255);
		IF EXISTS (SELECT * FROM expediente_paciente WHERE idPaciente = NEW.idPaciente) THEN
			SET error_msg4 = 'Este expediente del paciente ya existe en la base de datos.';
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg4;
		END IF;
    END//
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------

-- TRIGGER 'checarTratamientoPacienteDuplicados'
-- Este trigger verifica que antes de hacer un INSERT en la tabla 'tratamiento_paciente'
-- no haya un registro igual al que se va a ingresar.
-- Si lo hay, entonces no lo inserta y en cambio le retorna un mensaje de error.
-- Si no lo hay, entonces insertara el registro normalmente.

DELIMITER //
CREATE TRIGGER checarTratamientoPacienteDuplicados
	BEFORE INSERT ON tratamiento_paciente FOR EACH ROW
    BEGIN
		DECLARE error_msg5 VARCHAR(255);
		IF EXISTS (SELECT * FROM tratamiento_paciente WHERE idPaciente = NEW.idPaciente) THEN
			SET error_msg5 = 'Este paciente ya se encuentra en tratamiento.';
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg5;
		END IF;
    END//
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------

-- TRIGGER 'checarTratamientoPacienteDuplicados'
-- Este trigger verifica que antes de hacer un INSERT en la tabla 'cita_paciente'
-- no haya un registro igual al que se va a ingresar.
-- Si lo hay, entonces no lo inserta y en cambio le retorna un mensaje de error.
-- Si no lo hay, entonces insertara el registro normalmente.

-- Esto evitara que haya empalme en las citas en base a la fecha, hora y consultorio.
-- Las citas se asignaran cada hora en donde la duracion de cada cita sera de 1 hora.

DELIMITER //
CREATE TRIGGER checarCitasDuplicadasINSERT
    BEFORE INSERT ON cita_paciente FOR EACH ROW
    BEGIN
        DECLARE error_msg6 VARCHAR(255);
        IF EXISTS (SELECT * FROM cita_paciente WHERE Fecha_cita = NEW.Fecha_cita AND HOUR(Hora_cita) = HOUR(NEW.Hora_cita) AND Numero_consultorio = NEW.Numero_consultorio) THEN
            SET error_msg6 = 'No se puede agendar esta cita debido a que ya ese horario y ese consultorio ya esta ocupado por un doctor (empalme de citas).';
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg6;
        END IF;
    END//
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------

-- TRIGGER 'insertarCitasEliminadas'
-- Este trigger se ejecutara antes de hacer un DELETE en la tabla 'cita_paciente'
-- Antes de que se haga un DELETE, ese registro que sera eliminado se insertara
-- en la tabla 'citas_eliminadas' con el fin de tener un respaldo de todas las
-- citas generadas para posteriormente usarlas para alguna documentacion o reporte.

DELIMITER //
CREATE TRIGGER insertarCitasEliminadas
    BEFORE DELETE ON cita_paciente FOR EACH ROW
    BEGIN
        INSERT INTO citas_eliminadas (idCita_paciente, idPaciente, idDoctor, Fecha_cita, Hora_cita, Costo, Especialidad, Numero_consultorio, Nota_cita, Estado_cita, Usuario_Movimiento, Fecha_Movimiento)
        VALUES (OLD.idCita_paciente, OLD.idPaciente, OLD.idDoctor, OLD.Fecha_cita, OLD.Hora_cita, OLD.Costo, OLD.Especialidad, OLD.Numero_consultorio, 'Cita Cancelada', 'Cancelada', 'ADMIN CITAS', CURRENT_TIMESTAMP);
    END//
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------

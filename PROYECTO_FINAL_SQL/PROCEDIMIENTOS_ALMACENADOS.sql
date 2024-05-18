-- -----------------------------------------------------------------------------------------------------------------------

-- JOVEN JIMENEZ ANGEL CRISTIAN | BASES DE DATOS 2 - 2861
-- PROYECTO FINAL - Sistema de Gestión de Pacientes para una Clínica.

-- PROCEDIMIENTOS ALMACENADOS A USAR

-- -----------------------------------------------------------------------------------------------------------------------

-- Procedimiento Almacenado 'GestionarCita()'
-- Este procedimiento almacenado se encarga de PROGRAMAR, MODIFICAR o CANCELAR
-- citas medicas.

-- Recibe datos de entrada en donde:
-- p_Opcion = Seleccionar una opcion: 'PROGRAMAR', 'MODIFICAR', 'CANCELAR' en formato TEXTO (Entre comillas simples '')
-- p_idCita_paciente = ID de la cita a MODIFICAR o CANCELAR en formato NUMERO. Omitir con un 'NULL' cuando se va a PROGRAMAR una cita.
-- p_idPaciente = ID del paciente en formato NUMERO
-- p_idDoctor = ID del doctor en formato NUMERO
-- p_Fecha_cita = Fecha de la cita en formato ('YYYY-MM-DD') es decir 'AÑO-MES-DIA' (Entre comillas simples '')
-- p_Hora_cita = Hora de la cita en formato ('HH:MM:SS') es decir 'HORA-MINUTO-SEGUNDO' (Entre comillas simples '')
-- p_Costo = Costo de la cita en formato (0.00) es decir UNIDADES.DECIMAS/CENTISIMAS
-- p_Especialidad = Especialidad que estara enfoncada la consulta en formato TEXTO (Entre comillas simples '').
-- p_Numero_consultorio = Consultorio a usar en la cita en formato NUMERO
-- p_Nota_cita = Nota o informacion adicional a la cita en formato TEXTO (Entre comillas simples '').

-- Usuarios que pueden ejecutar este Procedimiento Almacenado:
-- Los que poseean la etiqueta 'ADMINISTRADOR' o 'CITAS'.

DELIMITER //
CREATE PROCEDURE GestionarCita(
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
    
END //
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------

-- Procedimiento Almacenado 'GestionarExpediente()'
-- Este procedimiento almacenado se encarga de CREAR o MODIFICAR expedientes medicos de los pacientes.

-- Recibe datos de entrada en donde:
-- p_Opcion = Seleccionar una opcion: 'CREAR', 'MODIFICAR' en formato TEXTO (Entre comillas simples '')
-- p_idExpediente_paciente = ID del expediente a MODIFICAR en formato NUMERO. Omitir con un 'NULL' cuando se va a CREAR un expediente medico.
-- p_idPaciente = ID del paciente en formato NUMERO
-- p_Lista_habitos_salud = Lista de los habitos de salud que tiene el paciente (ejemplo. Es o no es fumador, Hace o no hace ejercicio, Come o no come saludable, etc.) en formato TEXTO. (Entre comillas simples ''  y separadas por comas cada habito (ejemplo. 'Hace ejercicio, Es Fumador')
-- p_Lista_vacunas_puestas = Lista de vacunas puestas que tiene el paciente actualmente (ejemplo. Sarampion, COVID-19, Influenza, etc.) en formato TEXTO. (Entre comillas simples '') y separadas por comas cada vacuna (ejemplo. 'Polio, Influenza, Sarampion')
-- p_Lista_enfermedades_hereditarias = Lista de las enfermedades hereditarias que tiene el paciente (ejemplo. Hepatitis B, Problemas de Corazon, etc.) en formato TEXTO. (Entre comillas simples '') y separadas por comas cada enfermedad hereditaria (ejemplo. 'Problemas del corazon, Hepatitis B, Cancer')
-- p_Lista_historial_enfermedades = Lista de enfermedades que ha tenido el paciente (ejemplo. Cancer, COVID-19, Asma, etc.) en formato TEXTO. (Entre comillas simples '') y separadas por comas cada enfermedad que ha tenido (ejemplo. 'COVID-19, Cancer, Asma')

-- Usuarios que pueden ejecutar este Procedimiento Almacenado:
-- Los que poseean la etiqueta 'ADMINISTRADOR' o 'EXPEDIENTES'.

DELIMITER //
CREATE PROCEDURE GestionarExpediente(
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
    
END //
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------

-- Procedimiento Almacenado 'GestionarTratamiento()'
-- Este procedimiento almacenado se encarga de CREAR o MODIFICAR tratamientos medicos a los pacientes.

-- Recibe datos de entrada en donde:
-- p_Opcion = Seleccionar una opcion: 'CREAR', 'MODIFICAR' en formato TEXTO (Entre comillas simples '')
-- p_idTratamiento_paciente = ID del tratamiento a MODIFICAR en formato NUMERO. Omitir con un 'NULL' cuando se va a CREAR un tratamiento medico.
-- p_idPaciente = ID del paciente en formato NUMERO
-- p_En_Tratamiento = Seleccionar una opcion: 'SI', 'NO' en formato TEXTO (Entre comillas simples '')
-- p_Lista_tratamientos_actual = Lista de los tratamientos medicos que tiene el paciente actualmente (ejemplo. Quimioterapia, Radioterapia, Hormonas, Terapia, Medicina, Vitaminas etc.) en formato TEXTO. (Entre comillas simples ''  y separadas por comas cada tratamiento actual (ejemplo. 'Vitamina A, Terapia para caminar, Vacuna contra el Tetanos')
-- p_Lista_tratamientos_anteriores = Lista de tratamientos medicos que ha tenido el paciente (ejemplo. Cirugia, Antibioticos, Penicilina, Antiinflamatorios etc.) en formato TEXTO. (Entre comillas simples '') y separadas por comas cada tratamiento anterior (ejemplo. 'AntiInflamatorios, Vitamina A y B, Cirugia')

-- Usuarios que pueden ejecutar este Procedimiento Almacenado:
-- Los que poseean la etiqueta 'ADMINISTRADOR' o 'TRATAMIENTO'.

DELIMITER //
CREATE PROCEDURE GestionarTratamiento(
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
    
END //
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------

-- Procedimiento Almacenado 'actualizarEstadoCita()'
-- Este procedimiento almacenado se encarga de actualizar las citas medicas
-- que ya pasaron asignandoles el estatus 'Completada'
-- de acuerdo a la fecha actual que se ejecute dicho proceso.

-- No recibe datos de entrada.

-- Usuarios que pueden ejecutar este Procedimiento Almacenado:
-- Los que poseean la etiqueta 'ADMINISTRADOR' o 'CITAS'.

DELIMITER //
CREATE PROCEDURE actualizarEstadoCita()
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
    
END //
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------

-- Procedimiento Almacenado 'CrearUsuarios()'
-- Este procedimiento almacenado se encarga de crear usuarios con el fin de poder
-- asignarles privilegios para que puedan realizar ciertas acciones que nosotros necesitemos.

-- Recibe datos de entrada en donde:
-- nombre = Nombre del usuario en formato TEXTO (Entre comillas simples '').
-- pass = Contraseña de 4 digitos para que pueda ingresar el usuario en formato TEXTO (Entre comillas simples '').
-- etiqueta = Seleccionar una etiqueta: 'ADMINISTRADOR', 'CITAS', 'EXPEDIENTES', 'TRATAMIENTO', 'NADA' en formato TEXTO (Entre comillas simples '')

-- Usuarios que pueden ejecutar este Procedimiento Almacenado:
-- Los que poseean la etiqueta 'ADMINISTRADOR'.

DELIMITER //
CREATE PROCEDURE CrearUsuarios (
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
    
END //
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------

-- Procedimiento Almacenado 'ActualizarEstadoRangoUsuariosDuplicados()'
-- Este procedimiento almacenado se encarga de actualizar los registros de la tabla
-- 'administradores' en donde los usuarios cuyo ultimo rango esta activo o no.

-- Por ejemplo, si un usuario tiene el rango 'ADMINISTRADOR' en un registro y este esta activo
-- y despues se actualiza su rango a 'CITAS' generando un nuevo registro, el ultimo registro
-- tendra el campo 'Esta_Activo' = SI, mientras que los anteriores registros que pertenezcan
-- a ese usuario su campo 'Esta_Activo' = NO

-- No recibe datos de entrada.

-- Usuarios que pueden ejecutar este Procedimiento Almacenado:
-- Los que poseean la etiqueta 'ADMINISTRADOR'.

DELIMITER //
CREATE PROCEDURE ActualizarEstadoRangoUsuariosDuplicados()
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
    
END //
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------

-- Crear la base de datos si no existe
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'question_db')
BEGIN
    CREATE DATABASE question_db;
END
GO

-- Cambiar al nuevo esquema de la base de datos
USE question_db;
GO

-- Crear el esquema si no existe
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'question_db')
BEGIN
    EXEC('CREATE SCHEMA question_db');
END
GO

-- -----------------------------------------------------
-- Crear tabla question_db.question
-- -----------------------------------------------------
IF OBJECT_ID('question_db.question', 'U') IS NULL
BEGIN
    CREATE TABLE question_db.question (
        id INT IDENTITY(1,1) NOT NULL, -- id auto incremental
        pregunta TEXT NOT NULL,         -- columna para la pregunta
        respuesta TEXT NULL,            -- columna para la respuesta
        CONSTRAINT PK_question PRIMARY KEY (id) -- clave primaria en el id
    );
END
GO

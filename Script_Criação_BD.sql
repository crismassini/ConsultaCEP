/******************************************************************************/
/***         Generated by IBExpert 2020.4.21.2 09/07/2024 21:00:19          ***/
/******************************************************************************/

SET SQL DIALECT 3;

SET NAMES WIN1252;

CREATE DATABASE 'C:\SoftplanConsultaCep\Database\ConsultaCepDB.fdb'
USER 'SYSDBA' PASSWORD 'masterkeyu'
PAGE_SIZE 16384
DEFAULT CHARACTER SET WIN1252 COLLATION WIN1252;



/******************************************************************************/
/***                               Generators                               ***/
/******************************************************************************/

CREATE GENERATOR GEN_CEP_ID;
SET GENERATOR GEN_CEP_ID TO 9;



/******************************************************************************/
/***                                 Tables                                 ***/
/******************************************************************************/



CREATE TABLE CEP (
    CODIGO             INTEGER NOT NULL,
    CEP                VARCHAR(8),
    LOGRADOURO         VARCHAR(200),
    COMPLEMENTO        VARCHAR(50),
    BAIRRO             VARCHAR(100),
    LOCALIDADE         VARCHAR(100),
    UF                 VARCHAR(2),
    USUARIOALTERACAO   INTEGER,
    DATAHORAALTERACAO  TIMESTAMP
);

/******************************************************************************/
/***                              Primary keys                              ***/
/******************************************************************************/

ALTER TABLE CEP ADD CONSTRAINT PK_CEP PRIMARY KEY (CODIGO);
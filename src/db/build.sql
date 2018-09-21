--***************************************************************
--******************  DROP TABLES *************************
--**************************************************************
DROP TABLE error_log; 
DROP TABLE users 
DROP TABLE roles;
DROP TABLE users_roles;
DROP TABLE clubs;


--****************************************************************
--***************************************************************
--******************  POSTGRESQL SETTINGS *************************
--**************************************************************
--**************************************************************

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--****************************************************************
--***************************************************************
--******************  CREATE TABLES *************************
--**************************************************************
--**************************************************************

--==================================================================
--==================== users  ========================
--==================================================================

--==================================================================
--=========================== HELPER  ========================
--==================================================================

--ERROR_LOG
CREATE TABLE error_log
(
	id SERIAL,
    	error text,
    	error_time timestamp,
    	username text,
	PRIMARY KEY (id) 	
);

-- a free agent user should have a school and teacher automagically create for them with same username and passwod they must put in an email though even if not valid.
-- if you create a school then you can add teachers and students and change passwords etc.

--SCHOOL
CREATE TABLE clubs (
        id SERIAL,
        username text NOT NULL UNIQUE,
        name text NOT NULL,
        city text NOT NULL,
        state text NOT NULL,
        zip text NOT NULL,
        password text NOT NULL,
        email text NOT NULL,
        student_code text NOT NULL,
        UNIQUE (name,city,state,zip),
	PRIMARY KEY (id)
);

--TEACHER
CREATE TABLE teachers (
        id SERIAL,
        name text,
        password text,
        school_id integer,
        UNIQUE (name,school_id),
        PRIMARY KEY (id),
        FOREIGN KEY(school_id) REFERENCES schools(id)
);

--ROOM
CREATE TABLE pitches (
        id SERIAL,
        name text NOT NULL,
        club_id integer NOT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY(club_id) REFERENCES clubs(id)
);

--TEAM
CREATE TABLE teams (
        id SERIAL,
	name text UNIQUE,
        PRIMARY KEY (id)
);

CREATE TABLE gender (
        id SERIAL,
	name text UNIQUE,
        PRIMARY KEY (id)
);

CREATE TABLE training (
        id SERIAL,
        start_time timestamp,
        end_time timestamp,
        PRIMARY KEY (id)
);

CREATE TABLE sessions (
        id SERIAL,
        start_time timestamp,
        end_time timestamp,
        PRIMARY KEY (id)
);

CREATE TABLE training_sessions (
        id SERIAL,
        training_id integer NOT NULL,
        sessions_id integer NOT NULL,
        PRIMARY KEY (id),
	FOREIGN KEY (training_id) REFERENCES training(id),
	FOREIGN KEY (sessions_id) REFERENCES sessions(id)
);


CREATE TABLE matches (
        id SERIAL,
        start_time timestamp,
        end_time timestamp,
        PRIMARY KEY (id)
);


--TEAM_MATCH
CREATE TABLE teams_matches (
        id SERIAL,
        matches_id integer NOT NULL,
        score integer NOT NULL,
        PRIMARY KEY (id),
	FOREIGN KEY (matches_id) REFERENCES matches(id),
	FOREIGN KEY (team_id) REFERENCES teams(id)
);


--USERS
CREATE TABLE users (
	id SERIAL,
    	username text UNIQUE, 
    	password text,
    	first_name text,
    	middle_name text,
    	last_name text,
    	club_id integer DEFAULT 1, 
     	last_activity timestamp,
        banned_id integer NOT NULL default 0,
	PRIMARY KEY (id),	
	FOREIGN KEY (club_id) REFERENCES clubs(id)
);

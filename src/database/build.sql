--warmup ,global integraged, global structure, return to calmness
--***************************************************************
--******************  DROP TABLES *************************
--**************************************************************

DROP TABLE error_log CASCADE; 

--DROP TABLE training CASCADE;
--DROP TABLE training_sessions CASCADE;
DROP TABLE users_trainings_availability CASCADE;
DROP TABLE availability CASCADE;
DROP TABLE trainings_sessions CASCADE;
DROP TABLE sessions CASCADE;
DROP TABLE trainings CASCADE;

DROP TABLE gender CASCADE;
DROP TABLE age CASCADE;
DROP TABLE level CASCADE;
DROP TABLE possession CASCADE;
DROP TABLE zone CASCADE;


DROP TABLE matches_teams CASCADE;
DROP TABLE matches CASCADE;

DROP TABLE pitches CASCADE;

DROP TABLE users_roles CASCADE;
DROP TABLE clubs_users CASCADE;
DROP TABLE users CASCADE;
DROP TABLE roles CASCADE;

DROP TABLE teams CASCADE;

DROP TABLE clubs CASCADE;

DROP TABLE states CASCADE;
DROP TABLE home_away CASCADE;

DROP TABLE formations CASCADE;


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

CREATE TABLE states (
	id SERIAL,
	name text,
	PRIMARY KEY (id)	
);

-- a club should have admins in roles table
CREATE TABLE clubs (
        id SERIAL,
        name text NOT NULL,
        street_address text NOT NULL,
        city text NOT NULL,
        state_id integer NOT NULL,
        zip text NOT NULL,
	PRIMARY KEY (id),
        FOREIGN KEY(state_id) REFERENCES states(id)
);


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
        club_id integer NOT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY(club_id) REFERENCES clubs(id)
);

CREATE TABLE gender (
        id SERIAL,
	name text UNIQUE,
        PRIMARY KEY (id)
);

--TRAINING

--442 433 451
CREATE TABLE formations (
	id SERIAL,
    	name text UNIQUE, 
	PRIMARY KEY (id)
);

--u3 u4 u19  
CREATE TABLE age (
	id SERIAL,
    	name text UNIQUE, 
	PRIMARY KEY (id)
);

--a b c  
CREATE TABLE level (
	id SERIAL,
    	name text UNIQUE, 
	PRIMARY KEY (id)
);

-- possession 
CREATE TABLE possession (
	id SERIAL,
    	name text UNIQUE, 
	PRIMARY KEY (id)
);

--  zone
CREATE TABLE zone (
	id SERIAL,
    	name text UNIQUE, 
	PRIMARY KEY (id)
);





CREATE TABLE trainings (
        id SERIAL,
        start_time timestamp,
        end_time timestamp,
	team_id integer,
	pitch_id integer,
        PRIMARY KEY (id),
	FOREIGN KEY (team_id) REFERENCES teams(id),
	FOREIGN KEY (pitch_id) REFERENCES pitches(id)
);

CREATE TABLE sessions (
        id SERIAL,
	gender_id integer,
	age_id integer,
	level_id integer,
	possession_id integer,
	zone_id integer,
        PRIMARY KEY (id),
	FOREIGN KEY (gender_id) REFERENCES gender(id),
	FOREIGN KEY (age_id) REFERENCES age(id),
	FOREIGN KEY (level_id) REFERENCES level(id),
	FOREIGN KEY (possession_id) REFERENCES possession(id),
	FOREIGN KEY (zone_id) REFERENCES zone(id)
);
	--formation_id integer,
	--FOREIGN KEY (formation_id) REFERENCES formations(id)

CREATE TABLE trainings_sessions (
        id SERIAL,
        trainings_id integer NOT NULL,
        sessions_id integer NOT NULL,
        start_time timestamp,
        end_time timestamp,
        PRIMARY KEY (id),
	FOREIGN KEY (trainings_id) REFERENCES trainings(id),
	FOREIGN KEY (sessions_id) REFERENCES sessions(id)
);

CREATE TABLE availability (
	id SERIAL,
	name text,
        PRIMARY KEY (id)
);




--MATCHES
-- home,away,nuetral
CREATE TABLE home_away (
	id SERIAL,
	name text,
        PRIMARY KEY (id)
);

CREATE TABLE matches (
        id SERIAL,
        start_time timestamp,
        end_time timestamp,
	street_address text, 	
	city text, 	
	state_id integer, 	
	zip text, 	
	pitch_id integer, 	
	home_away_id integer, 	
        PRIMARY KEY (id),
	FOREIGN KEY (state_id) REFERENCES states(id),
	FOREIGN KEY (home_away_id) REFERENCES home_away(id),
	FOREIGN KEY (pitch_id) REFERENCES pitches(id)
);

CREATE TABLE matches_teams (
        id SERIAL,
        matches_id integer NOT NULL,
        team_id integer NOT NULL,
        score integer NOT NULL,
        PRIMARY KEY (id),
	FOREIGN KEY (matches_id) REFERENCES matches(id),
	FOREIGN KEY (team_id) REFERENCES teams(id)
);

-- we are going with a single user table so we do not need multiple logins instead you just need one and choose what role you want to view. 
CREATE TABLE users (
	id SERIAL,
    	username text NOT NULL UNIQUE, 
    	password text,
    	first_name text,
    	middle_name text,
    	last_name text,
    	email text,
    	phone text,
    	street_address text,
    	city text,
    	state_id integer,
    	zip text,
	PRIMARY KEY (id),	
	FOREIGN KEY (state_id) REFERENCES states(id)
);

CREATE TABLE clubs_users (
	club_id integer NOT NULL,
	user_id integer NOT NULL,
	PRIMARY KEY (club_id,user_id),	
	FOREIGN KEY (club_id) REFERENCES clubs(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);
	
	

	 


-- roles are director, coach, player, parent, manager, liason
CREATE TABLE roles (
	id SERIAL,
    	name text UNIQUE, 
	PRIMARY KEY (id)
);
-- you choose what role you want to be at any time and that redoes gui
CREATE TABLE users_roles (
        users_id integer NOT NULL,
        roles_id integer NOT NULL,
	PRIMARY KEY (users_id,roles_id),
	FOREIGN KEY (users_id) REFERENCES users(id),
	FOREIGN KEY (roles_id) REFERENCES roles(id)
);

CREATE TABLE users_trainings_availability (
        id SERIAL,
       	users_id integer NOT NULL,
        trainings_id integer NOT NULL,
	availability_id integer NOT NULL,
        PRIMARY KEY (id),
	FOREIGN KEY (availability_id) REFERENCES availability(id),
	FOREIGN KEY (users_id) REFERENCES users(id),
	FOREIGN KEY (trainings_id) REFERENCES trainings(id)
);

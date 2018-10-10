--warmup ,global integraged, global structure, return to calmness
--***************************************************************
--******************  DROP TABLES *************************
--**************************************************************

DROP TABLE error_log CASCADE; 

DROP TABLE sessions_media CASCADE; 
DROP TABLE media CASCADE; 

DROP TABLE genders_sessions CASCADE;

DROP TABLE genders CASCADE;
DROP TABLE age CASCADE;
DROP TABLE level CASCADE;
DROP TABLE possession CASCADE;
DROP TABLE zone CASCADE;

DROP TABLE practices_users_attendance CASCADE;
DROP TABLE practices_users_availability CASCADE;
DROP TABLE games_users_attendance CASCADE;
DROP TABLE games_users_availability CASCADE;

DROP TABLE practices_sessions CASCADE;
DROP TABLE sessions CASCADE;

DROP TABLE uniforms_games CASCADE;
DROP TABLE uniforms_order CASCADE;
DROP TABLE uniforms CASCADE;


DROP TABLE users_system_roles CASCADE; --admin, data-entry
DROP TABLE users_clubs_roles CASCADE; -- techninal director, cfo, coordinator, cms-admin, board member, president, ceo 
DROP TABLE users_teams_roles CASCADE; --player, coach, manager, liason, parent

DROP TABLE roles CASCADE;

DROP TABLE system_users CASCADE;
DROP TABLE clubs_users CASCADE;
DROP TABLE teams_users CASCADE;
DROP TABLE users CASCADE;

DROP TABLE formations CASCADE;
DROP TABLE availability CASCADE;
DROP TABLE attendance CASCADE;

DROP TABLE practices CASCADE;
DROP TABLE games CASCADE;

DROP TABLE teams CASCADE;
DROP TABLE pitches CASCADE;
DROP TABLE clubs CASCADE;
DROP TABLE states CASCADE;
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

--FOR SESSIONS LATER
CREATE TABLE genders (
        id SERIAL,
	name text UNIQUE,
        PRIMARY KEY (id)
);


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

CREATE TABLE uniforms (
	id SERIAL,
    	name text UNIQUE, 
	PRIMARY KEY (id)
);


CREATE TABLE practices (
        id SERIAL,

	--time
        arrival_time timestamp, --only 1 arrival time leave it
        start_time timestamp, --only 1 start time leave it
        end_time timestamp,

	--place for place just use what manager wants string, url, full field address or simply pitch id
	address text, --this could be link or string 	
	street_address text, 	
	city text, 	
	state_id integer, 	
	zip text, 	
	pitch_id integer, --all you need for a practice	
	field_name text, --field 3, field A, 9v9 field etc if nothing in db
       
	team_id integer,

	--details

	FOREIGN KEY (team_id) REFERENCES teams(id),
	FOREIGN KEY (pitch_id) REFERENCES pitches(id),
	FOREIGN KEY (state_id) REFERENCES states(id),
	PRIMARY KEY (id)
);

CREATE TABLE games (
        id SERIAL,
	
	--time
        arrival_time timestamp, --only 1 arrival time leave it
        start_time timestamp, --only 1 start time leave it
        end_time timestamp,
	
	--place for place just use what manager wants string, url, full field address or simply pitch id
	address text, --this could be link or string 	
	street_address text, 	
	city text, 	
	state_id integer, 	
	zip text, 	
	pitch_id integer, --all you need for a practice, is this needed for games or just field name below?	
	field_name text, --field 3, field A, 9v9 field etc
	
	team_id integer, --the team who has the game for join. for a more global system??? we need another table and this one would draw from that as this is for scheduling. that is why it has arrival time. an official game from a league db would not have arrival time.
	
	FOREIGN KEY (team_id) REFERENCES teams(id),
	FOREIGN KEY (pitch_id) REFERENCES pitches(id),
	FOREIGN KEY (state_id) REFERENCES states(id),

        PRIMARY KEY (id)
);
	


CREATE TABLE uniforms_order (
	id SERIAL,
	name text, --primary, secondary, tertiary
        PRIMARY KEY (id)
);

CREATE TABLE uniforms_games (
	id SERIAL,
	uniform_id integer,
	uniforms_order_id integer,
	game_id integer,
        PRIMARY KEY (id),
	FOREIGN KEY (game_id) REFERENCES games(id),
	FOREIGN KEY (uniforms_order_id) REFERENCES uniforms_order(id)
);


CREATE TABLE sessions (
        id SERIAL,
	url text UNIQUE, --link
        PRIMARY KEY (id)
);

CREATE TABLE media (
	id SERIAL,
	name text, --pic, text, video, link
        PRIMARY KEY (id)
);


CREATE TABLE sessions_media (
	id SERIAL,
	sessions_id integer,
	media_id integer, --picture, text, video, link
	url text, 
	FOREIGN KEY (media_id) REFERENCES media(id),
	FOREIGN KEY (sessions_id) REFERENCES sessions(id),
        PRIMARY KEY (id)
);

CREATE TABLE practices_sessions (
        id SERIAL,
        practice_id integer NOT NULL,
        session_id integer NOT NULL,
        start_time timestamp, --if you want for each session
        end_time timestamp, --if you want for efficiency
        PRIMARY KEY (id),
	FOREIGN KEY (practice_id) REFERENCES practices(id),
	FOREIGN KEY (session_id) REFERENCES sessions(id)
);

CREATE TABLE availability (
	id SERIAL,
	name text,
        PRIMARY KEY (id)
);

CREATE TABLE attendance (
	id SERIAL,
	name text,
        PRIMARY KEY (id)
);

--search fields for sessions

CREATE TABLE genders_sessions (
        id SERIAL,
	gender_id integer,
	session_id integer,
        PRIMARY KEY (id),
        FOREIGN KEY(gender_id) REFERENCES genders(id),
        FOREIGN KEY(session_id) REFERENCES sessions(id)
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
	id SERIAL,
	user_id integer NOT NULL,
	club_id integer NOT NULL,
	UNIQUE (user_id, club_id),	
	FOREIGN KEY (club_id) REFERENCES clubs(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE teams_users (
	user_id integer NOT NULL,
	team_id integer NOT NULL,
	PRIMARY KEY (user_id, team_id),	
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE system_users (
	id SERIAL,
	user_id integer NOT NULL,
	PRIMARY KEY (id),	
	FOREIGN KEY (user_id) REFERENCES users(id)
);
	
	
	
	
CREATE TABLE roles (
	id SERIAL,
	name text,
	PRIMARY KEY (id)
);

-- you choose what role you want to be at any time and that redoes gui
CREATE TABLE users_system_roles (
        id SERIAL,
        user_id integer NOT NULL,
        role_id integer NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (role_id) REFERENCES roles(id)
);

CREATE TABLE users_clubs_roles (
        id SERIAL,
        users_id integer NOT NULL,
       	club_id integer NOT NULL,
        roles_id integer NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (users_id) REFERENCES users(id),
	FOREIGN KEY (club_id) REFERENCES clubs(id),
	FOREIGN KEY (roles_id) REFERENCES roles(id)
);

CREATE TABLE users_teams_roles (
        id SERIAL,
        user_id integer NOT NULL,
        team_id integer NOT NULL,
        role_id integer NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (team_id) REFERENCES teams(id),
	FOREIGN KEY (role_id) REFERENCES roles(id)
);



CREATE TABLE practices_users_availability (
        id SERIAL,
        practice_id integer NOT NULL,
       	users_id integer NOT NULL,
	availability_id integer NOT NULL,
        PRIMARY KEY (id),
	FOREIGN KEY (practice_id) REFERENCES practices(id),
	FOREIGN KEY (users_id) REFERENCES users(id),
	FOREIGN KEY (availability_id) REFERENCES availability(id)
);

CREATE TABLE practices_users_attendance (
        id SERIAL,
        practice_id integer NOT NULL,
       	users_id integer NOT NULL,
	attendance_id integer NOT NULL,
        PRIMARY KEY (id),
	FOREIGN KEY (practice_id) REFERENCES practices(id),
	FOREIGN KEY (users_id) REFERENCES users(id),
	FOREIGN KEY (attendance_id) REFERENCES attendance(id)
);

CREATE TABLE games_users_availability (
        id SERIAL,
        game_id integer NOT NULL,
       	users_id integer NOT NULL,
	availability_id integer NOT NULL,
        PRIMARY KEY (id),
	FOREIGN KEY (game_id) REFERENCES games(id),
	FOREIGN KEY (users_id) REFERENCES users(id),
	FOREIGN KEY (availability_id) REFERENCES availability(id)
);

CREATE TABLE games_users_attendance (
        id SERIAL,
        game_id integer NOT NULL,
       	users_id integer NOT NULL,
	attendance_id integer NOT NULL,
        PRIMARY KEY (id),
	FOREIGN KEY (game_id) REFERENCES games(id),
	FOREIGN KEY (users_id) REFERENCES users(id),
	FOREIGN KEY (attendance_id) REFERENCES attendance(id)
);


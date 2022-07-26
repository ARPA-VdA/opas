--
-- PostgreSQL database dump
--

-- Dumped from database version 13.7 (Ubuntu 13.7-1.pgdg22.04+1)
-- Dumped by pg_dump version 14.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 15 (class 2615 OID 16388)
-- Name: calibrations; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA calibrations;


ALTER SCHEMA calibrations OWNER TO postgres;

--
-- TOC entry 16 (class 2615 OID 16391)
-- Name: journal; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA journal;


ALTER SCHEMA journal OWNER TO postgres;

--
-- TOC entry 5707 (class 0 OID 0)
-- Dependencies: 16
-- Name: SCHEMA journal; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA journal IS 'Schema used for manage network reports';


--
-- TOC entry 17 (class 2615 OID 16392)
-- Name: labanalysis; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA labanalysis;


ALTER SCHEMA labanalysis OWNER TO postgres;

--
-- TOC entry 5708 (class 0 OID 0)
-- Dependencies: 17
-- Name: SCHEMA labanalysis; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA labanalysis IS 'Laboratory analysis schema';


--
-- TOC entry 18 (class 2615 OID 16393)
-- Name: main; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA main;


ALTER SCHEMA main OWNER TO postgres;

--
-- TOC entry 5709 (class 0 OID 0)
-- Dependencies: 18
-- Name: SCHEMA main; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA main IS 'Main schema for Bobo project';


--
-- TOC entry 19 (class 2615 OID 16394)
-- Name: metadata; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA metadata;


ALTER SCHEMA metadata OWNER TO postgres;

--
-- TOC entry 5710 (class 0 OID 0)
-- Dependencies: 19
-- Name: SCHEMA metadata; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA metadata IS 'Schema use for metadata';


--
-- TOC entry 20 (class 2615 OID 16395)
-- Name: operations; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA operations;


ALTER SCHEMA operations OWNER TO postgres;

--
-- TOC entry 21 (class 2615 OID 16405)
-- Name: tables_ar; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tables_ar;


ALTER SCHEMA tables_ar OWNER TO postgres;

--
-- TOC entry 5711 (class 0 OID 0)
-- Dependencies: 21
-- Name: SCHEMA tables_ar; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA tables_ar IS 'Schema used for storing ARPA network data';


--
-- TOC entry 25 (class 2615 OID 27223)
-- Name: tool_builder; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tool_builder;


ALTER SCHEMA tool_builder OWNER TO postgres;

--
-- TOC entry 5712 (class 0 OID 0)
-- Dependencies: 25
-- Name: SCHEMA tool_builder; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA tool_builder IS 'Schema use for import data from remote stations';


--
-- TOC entry 22 (class 2615 OID 16423)
-- Name: tool_netcom; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tool_netcom;


ALTER SCHEMA tool_netcom OWNER TO postgres;

--
-- TOC entry 5713 (class 0 OID 0)
-- Dependencies: 22
-- Name: SCHEMA tool_netcom; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA tool_netcom IS 'Schema for storing calibrations, operations as maintenances';


--
-- TOC entry 23 (class 2615 OID 16429)
-- Name: tool_visualizer_lily; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tool_visualizer_lily;


ALTER SCHEMA tool_visualizer_lily OWNER TO postgres;

--
-- TOC entry 5714 (class 0 OID 0)
-- Dependencies: 23
-- Name: SCHEMA tool_visualizer_lily; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA tool_visualizer_lily IS 'Schema use for Visualizer tool';


--
-- TOC entry 24 (class 2615 OID 16433)
-- Name: tool_web_lily; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tool_web_lily;


ALTER SCHEMA tool_web_lily OWNER TO postgres;

--
-- TOC entry 5715 (class 0 OID 0)
-- Dependencies: 24
-- Name: SCHEMA tool_web_lily; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA tool_web_lily IS 'Main schema for Arpa web application';


--
-- TOC entry 26 (class 2615 OID 27253)
-- Name: warnings; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA warnings;


ALTER SCHEMA warnings OWNER TO postgres;

--
-- TOC entry 5716 (class 0 OID 0)
-- Dependencies: 26
-- Name: SCHEMA warnings; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA warnings IS 'Schema use for warnings management';


--
-- TOC entry 2 (class 3079 OID 16440)
-- Name: plperl; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plperl WITH SCHEMA pg_catalog;


--
-- TOC entry 5717 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION plperl; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plperl IS 'PL/Perl procedural language';


--
-- TOC entry 1 (class 3079 OID 16445)
-- Name: plperlu; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plperlu WITH SCHEMA pg_catalog;


--
-- TOC entry 5718 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plperlu; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plperlu IS 'PL/PerlU untrusted procedural language';


--
-- TOC entry 10 (class 3079 OID 16450)
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- TOC entry 5719 (class 0 OID 0)
-- Dependencies: 10
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- TOC entry 9 (class 3079 OID 16555)
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;


--
-- TOC entry 5720 (class 0 OID 0)
-- Dependencies: 9
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';


--
-- TOC entry 8 (class 3079 OID 16601)
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- TOC entry 5721 (class 0 OID 0)
-- Dependencies: 8
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- TOC entry 7 (class 3079 OID 16728)
-- Name: ltree; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS ltree WITH SCHEMA public;


--
-- TOC entry 5722 (class 0 OID 0)
-- Dependencies: 7
-- Name: EXTENSION ltree; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION ltree IS 'data type for hierarchical tree-like structures';


--
-- TOC entry 6 (class 3079 OID 16913)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 5723 (class 0 OID 0)
-- Dependencies: 6
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 5 (class 3079 OID 16950)
-- Name: postgres_fdw; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgres_fdw WITH SCHEMA public;


--
-- TOC entry 5724 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION postgres_fdw; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgres_fdw IS 'foreign-data wrapper for remote PostgreSQL servers';


--
-- TOC entry 4 (class 3079 OID 16954)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- TOC entry 5725 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- TOC entry 1362 (class 1247 OID 16966)
-- Name: scripta_analysis; Type: TYPE; Schema: labanalysis; Owner: postgres
--

CREATE TYPE labanalysis.scripta_analysis AS ENUM (
    'metalli',
    'an_ca',
    'ecoc',
    'levo',
    'ipa',
    'mdt',
    'gravimetriche'
);


ALTER TYPE labanalysis.scripta_analysis OWNER TO postgres;

--
-- TOC entry 1365 (class 1247 OID 16983)
-- Name: scripta_data; Type: TYPE; Schema: labanalysis; Owner: postgres
--

CREATE TYPE labanalysis.scripta_data AS (
	idcampione numeric(22,0),
	id_analitico numeric,
	id_accettazione numeric(22,0),
	codicecampione character varying(50),
	idtipianalisi numeric(22,0),
	tipoanalisi character varying(255),
	idtipianalisisottotipo numeric,
	sottotipoanalisi character varying(255),
	idparametro numeric(22,0),
	codiceparametro character varying(255),
	esame character varying(255),
	valorenum character varying(255),
	valoreinstampa character varying(255),
	incertezza character varying(1000),
	datafine timestamp(6) without time zone,
	id_um numeric(22,0),
	unitamisura character varying(255),
	loq character varying(255),
	salvato character(1),
	certificato character(1),
	validato character(1),
	aria_id_esame numeric,
	aria_id_analisi_aria numeric,
	aria_dt_inizio_camp date,
	aria_dt_fine_camp date,
	aria_numero_giorni_camp integer,
	aria_volume double precision,
	numero_interno_sezione character varying(20),
	lottofiltri character varying(20),
	aria_stazione numeric,
	aria_note character varying(1000),
	idluogo integer,
	sito character varying(255),
	localita character varying(255),
	comune character varying(255),
	importato boolean,
	gruppo character varying(255)
);


ALTER TYPE labanalysis.scripta_data OWNER TO postgres;

--
-- TOC entry 1368 (class 1247 OID 16986)
-- Name: scripta_sample; Type: TYPE; Schema: labanalysis; Owner: postgres
--

CREATE TYPE labanalysis.scripta_sample AS (
	id numeric(22,0),
	codice character varying(50),
	tipo text,
	dsc character varying(2000),
	sito character varying(255),
	idluogo integer,
	idmacroattivita numeric,
	idtipianalisi numeric(22,0),
	idtipianalisisottotipo numeric,
	dataaccettazione timestamp without time zone,
	idtipianalisicmcip integer,
	idtipianalisicmcsa integer,
	dataprelievo timestamp without time zone,
	note character varying(2000),
	idanagcom character varying(6),
	idanagprel numeric(22,0),
	idanagdist numeric,
	protesternoric character varying(255),
	dataric character varying(255),
	varichiesto boolean,
	vadtdata timestamp(6) without time zone,
	vadtora character varying(5),
	vadtorastampato timestamp without time zone,
	protinterno character varying(255),
	numlotto character varying(255),
	fase character varying(255),
	codicerp character varying(255),
	idanagfatt character varying(255),
	imptotnetto double precision,
	datainizioprova date,
	datafineprova date,
	dataconsegna date,
	analisiesterne integer,
	dtstampa timestamp without time zone,
	codannopoa character varying(255),
	xdtimeins timestamp without time zone,
	xdtime timestamp with time zone,
	lockidutente integer,
	lockdt text,
	dtharrivocampione timestamp without time zone,
	aria_id_esame numeric,
	aria_id_analisi_aria numeric,
	aria_dt_inizio_camp date,
	aria_dt_fine_camp date,
	aria_numero_giorni_camp integer,
	aria_volume double precision,
	numero_interno_sezione character varying(20),
	lottofiltri character varying(20),
	aria_stazione numeric,
	aria_note character varying(1000),
	importato boolean,
	gruppo character varying(255)
);


ALTER TYPE labanalysis.scripta_sample OWNER TO postgres;

--
-- TOC entry 1371 (class 1247 OID 16988)
-- Name: email; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.email AS public.citext
	CONSTRAINT email_check CHECK ((VALUE OPERATOR(public.~) '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'::public.citext));


ALTER DOMAIN public.email OWNER TO postgres;

--
-- TOC entry 1346 (class 1247 OID 16992)
-- Name: plr_environ_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.plr_environ_type AS (
	name text,
	value text
);


ALTER TYPE public.plr_environ_type OWNER TO postgres;

--
-- TOC entry 1353 (class 1247 OID 16995)
-- Name: r_typename; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.r_typename AS (
	typename text,
	typeoid oid
);


ALTER TYPE public.r_typename OWNER TO postgres;

--
-- TOC entry 1377 (class 1247 OID 16998)
-- Name: r_version_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.r_version_type AS (
	name text,
	value text
);


ALTER TYPE public.r_version_type OWNER TO postgres;

--
-- TOC entry 1380 (class 1247 OID 17001)
-- Name: tablefunc_crosstab_2; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tablefunc_crosstab_2 AS (
	row_name text,
	category_1 text,
	category_2 text
);


ALTER TYPE public.tablefunc_crosstab_2 OWNER TO postgres;

--
-- TOC entry 1383 (class 1247 OID 17004)
-- Name: tablefunc_crosstab_3; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tablefunc_crosstab_3 AS (
	row_name text,
	category_1 text,
	category_2 text,
	category_3 text
);


ALTER TYPE public.tablefunc_crosstab_3 OWNER TO postgres;

--
-- TOC entry 1386 (class 1247 OID 17007)
-- Name: tablefunc_crosstab_4; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tablefunc_crosstab_4 AS (
	row_name text,
	category_1 text,
	category_2 text,
	category_3 text,
	category_4 text
);


ALTER TYPE public.tablefunc_crosstab_4 OWNER TO postgres;

--
-- TOC entry 1389 (class 1247 OID 17010)
-- Name: cf_data_type; Type: TYPE; Schema: tables_ar; Owner: postgres
--

CREATE TYPE tables_ar.cf_data_type AS (
	fulldate timestamp without time zone,
	id smallint,
	meanvalue real,
	code smallint,
	stationalarm smallint,
	readings smallint,
	min double precision,
	mintime time without time zone,
	max double precision,
	maxtime time without time zone,
	stddev real,
	calccode smallint
);


ALTER TYPE tables_ar.cf_data_type OWNER TO postgres;

--
-- TOC entry 1392 (class 1247 OID 17021)
-- Name: enum_task_assignee; Type: TYPE; Schema: tool_web_lily; Owner: postgres
--

CREATE TYPE tool_web_lily.enum_task_assignee AS ENUM (
    'Arpa',
    'Ecometer'
);


ALTER TYPE tool_web_lily.enum_task_assignee OWNER TO postgres;

--
-- TOC entry 802 (class 1255 OID 17064)
-- Name: get_next_daily_report_id(character varying); Type: FUNCTION; Schema: journal; Owner: postgres
--

CREATE FUNCTION journal.get_next_daily_report_id(character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
declare
    my_year VARCHAR;
    next_id INTEGER;
BEGIN

    /* get the year */
    my_year := $1;

    /* query */
    SELECT rp_id INTO next_id FROM journal.daily_reports
        WHERE year = my_year ORDER BY rp_id DESC LIMIT 1;

    IF FOUND THEN
      -- RAISE NOTICE 'FOUND !';
      /* return value */
      RETURN next_id + 1;
    ELSE
      -- RAISE NOTICE 'NOT FOUND !!';
      RETURN 1;
    END IF;

/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in journal.get_next_daily_report_id() : %', SQLERRM ;
END;
$_$;


ALTER FUNCTION journal.get_next_daily_report_id(character varying) OWNER TO postgres;

--
-- TOC entry 5726 (class 0 OID 0)
-- Dependencies: 802
-- Name: FUNCTION get_next_daily_report_id(character varying); Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON FUNCTION journal.get_next_daily_report_id(character varying) IS 'Get the next daily report progressive id per year';


--
-- TOC entry 803 (class 1255 OID 17065)
-- Name: get_next_report_id(character varying); Type: FUNCTION; Schema: journal; Owner: postgres
--

CREATE FUNCTION journal.get_next_report_id(character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
declare
    my_year VARCHAR;
    next_id INTEGER;
BEGIN

    /* get the year */
    my_year := $1;

    /* query */
    SELECT rp_id INTO next_id FROM journal.reports
        WHERE year = my_year ORDER BY rp_id DESC LIMIT 1;

    IF FOUND THEN
      -- RAISE NOTICE 'FOUND !';
      /* return value */
      RETURN next_id + 1;
    ELSE
      -- RAISE NOTICE 'NOT FOUND !!';
      RETURN 1;
    END IF;

/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in journal.get_next_report_id() : %', SQLERRM ;
END;
$_$;


ALTER FUNCTION journal.get_next_report_id(character varying) OWNER TO postgres;

--
-- TOC entry 5727 (class 0 OID 0)
-- Dependencies: 803
-- Name: FUNCTION get_next_report_id(character varying); Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON FUNCTION journal.get_next_report_id(character varying) IS 'Get the next report progressive id per year';


--
-- TOC entry 804 (class 1255 OID 17066)
-- Name: check_sample_exists(integer, integer, integer, timestamp without time zone, integer); Type: FUNCTION; Schema: labanalysis; Owner: postgres
--

CREATE FUNCTION labanalysis.check_sample_exists(integer, integer, integer, timestamp without time zone, integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
  stid      ALIAS FOR $1;
  fiid      ALIAS FOR $2;
  anid      ALIAS FOR $3;
  datestart ALIAS FOR $4;
  nodays    ALIAS FOR $5;
  myrec     record;
  myquery   text;
BEGIN

    SELECT INTO myrec
        laboratory_samples.sp_id,
        laboratory_samples.st_id,
        laboratory_samples.date_start,
        laboratory_samples.no_days,
        laboratory_samples.fi_id,
        laboratory_samples.an_id
    FROM
        labanalysis.laboratory_samples
    WHERE
        laboratory_samples.st_id = stid
        AND laboratory_samples.an_id = anid
        AND laboratory_samples.date_start = datestart
        AND laboratory_samples.no_days = nodays
        --AND datestart BETWEEN laboratory_samples.date_start
        --    AND laboratory_samples.date_start +
        --    (interval '1 day' * (laboratory_samples.no_days - 1))
        ;

    IF FOUND THEN
      --RAISE NOTICE 'Sample ID: %', myrec.sp_id;
      RETURN true;
    ELSE
      RETURN false; /* ok to insert sample */
    END IF;

    /* errors check */
    EXCEPTION
        /* in case of duplicate key error we update */
      WHEN OTHERS THEN RAISE NOTICE 'check_sample_exists() ERROR : %', SQLERRM;
        /* return value */
        RETURN true;
END;
$_$;


ALTER FUNCTION labanalysis.check_sample_exists(integer, integer, integer, timestamp without time zone, integer) OWNER TO postgres;

--
-- TOC entry 805 (class 1255 OID 17067)
-- Name: check_sample_exists_by_spid(integer); Type: FUNCTION; Schema: labanalysis; Owner: postgres
--

CREATE FUNCTION labanalysis.check_sample_exists_by_spid(integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
  spid      ALIAS FOR $1;
  myrec     record;
  myquery   text;
BEGIN

    SELECT INTO myrec
        laboratory_samples.sp_id
    FROM
        labanalysis.laboratory_samples
    WHERE
        laboratory_samples.sp_id = spid;

    IF FOUND THEN
      RETURN true;
    ELSE
      RETURN false; /* ok to insert sample */
    END IF;

    /* errors check */
    EXCEPTION
        /* in case of duplicate key error we update */
      WHEN OTHERS THEN RAISE NOTICE 'check_sample_exists_by_spid() ERROR : %', SQLERRM;
        /* return value */
        RETURN true;
END;
$_$;


ALTER FUNCTION labanalysis.check_sample_exists_by_spid(integer) OWNER TO postgres;

--
-- TOC entry 806 (class 1255 OID 17068)
-- Name: check_sample_exists_ret_spid(integer, integer, integer, timestamp without time zone, integer); Type: FUNCTION; Schema: labanalysis; Owner: postgres
--

CREATE FUNCTION labanalysis.check_sample_exists_ret_spid(integer, integer, integer, timestamp without time zone, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
  stid      ALIAS FOR $1;
  fiid      ALIAS FOR $2;
  anid      ALIAS FOR $3;
  datestart ALIAS FOR $4;
  nodays    ALIAS FOR $5;
  myrec     record;
  myquery   text;
BEGIN

    SELECT INTO myrec
        laboratory_samples.sp_id,
        laboratory_samples.st_id,
        laboratory_samples.date_start,
        laboratory_samples.no_days,
        laboratory_samples.fi_id,
        laboratory_samples.an_id
    FROM
        labanalysis.laboratory_samples
    WHERE
        laboratory_samples.st_id = stid
        AND laboratory_samples.an_id = anid
        AND laboratory_samples.date_start = datestart
        AND laboratory_samples.no_days = nodays
        --AND datestart BETWEEN laboratory_samples.date_start
        --    AND laboratory_samples.date_start +
        --    (interval '1 day' * (laboratory_samples.no_days - 1))
        ;

    IF FOUND THEN
      RETURN myrec.sp_id;
    ELSE
      RETURN 0; /* ok to insert sample */
    END IF;

    /* errors check */
    EXCEPTION
        /* in case of duplicate key error we update */
      WHEN OTHERS THEN RAISE NOTICE 'check_sample_exists_ret_spid() ERROR : %', SQLERRM;
        /* return value */
        RETURN true;
END;
$_$;


ALTER FUNCTION labanalysis.check_sample_exists_ret_spid(integer, integer, integer, timestamp without time zone, integer) OWNER TO postgres;

--
-- TOC entry 807 (class 1255 OID 17069)
-- Name: check_sample_white_exists_by_spid(integer); Type: FUNCTION; Schema: labanalysis; Owner: postgres
--

CREATE FUNCTION labanalysis.check_sample_white_exists_by_spid(integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
  spid      ALIAS FOR $1;
  myrec     record;
  myquery   text;
BEGIN

    /*
      SELECT labanalysis.check_sample_white_exists_by_spid(201709999);
    */

    SELECT INTO myrec
        sp_id
    FROM
        labanalysis.laboratory_samples_white
    WHERE
        sp_id = spid;

    IF FOUND THEN
      RETURN true;
    ELSE
      RETURN false; /* ok to insert sample */
    END IF;

    /* errors check */
    EXCEPTION
        /* in case of duplicate key error we update */
      WHEN OTHERS THEN RAISE NOTICE 'check_sample_white_exists_by_spid() ERROR : %', SQLERRM;
        /* return value */
        RETURN true;
END;
$_$;


ALTER FUNCTION labanalysis.check_sample_white_exists_by_spid(integer) OWNER TO postgres;

--
-- TOC entry 808 (class 1255 OID 17070)
-- Name: check_sample_white_exists_ret_spid(integer, integer, integer, timestamp without time zone, integer); Type: FUNCTION; Schema: labanalysis; Owner: postgres
--

CREATE FUNCTION labanalysis.check_sample_white_exists_ret_spid(integer, integer, integer, timestamp without time zone, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
  stid      ALIAS FOR $1;
  fiid      ALIAS FOR $2;
  anid      ALIAS FOR $3;
  datestart ALIAS FOR $4;
  nodays    ALIAS FOR $5;
  myrec     record;
  myquery   text;
BEGIN

    SELECT INTO myrec
        sp_id,
        st_id,
        date_start,
        no_days,
        fi_id,
        an_id
    FROM
        labanalysis.laboratory_samples_white
    WHERE
        st_id = stid
        AND an_id = anid
        AND date_start = datestart
        AND no_days = nodays
        --AND datestart BETWEEN laboratory_samples.date_start
        --    AND laboratory_samples.date_start +
        --    (interval '1 day' * (laboratory_samples.no_days - 1))
        ;

    IF FOUND THEN
      RETURN myrec.sp_id;
    ELSE
      RETURN 0; /* ok to insert sample */
    END IF;

    /* errors check */
    EXCEPTION
        /* in case of duplicate key error we update */
      WHEN OTHERS THEN RAISE NOTICE 'check_sample_white_exists_ret_spid() ERROR : %', SQLERRM;
        /* return value */
        RETURN true;
END;
$_$;


ALTER FUNCTION labanalysis.check_sample_white_exists_ret_spid(integer, integer, integer, timestamp without time zone, integer) OWNER TO postgres;

--
-- TOC entry 809 (class 1255 OID 17071)
-- Name: delete_sample(integer); Type: FUNCTION; Schema: labanalysis; Owner: postgres
--

CREATE FUNCTION labanalysis.delete_sample(integer) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
declare
  sp_id   integer;
  st_id   integer;
  date    timestamp;
  days    integer;
  v       integer;
  myquery varchar;
  myrec   record;
  schema  varchar;
  tblid   varchar;
  id      integer;
BEGIN

  /* get the sample id */
  sp_id := $1;

  /* collect the needed data station id, date start and date lenght */
  myquery := 'SELECT laboratory_samples.sp_id,laboratory_samples.st_id, '
  || 'laboratory_samples.date_start, laboratory_samples.no_days AS no_days, '
  || '_stations.schema, _stations.tableid '
        || 'FROM labanalysis.laboratory_samples '
        || 'JOIN _stations USING (st_id) '
        || 'WHERE laboratory_samples.sp_id=' || sp_id; --20000366

  --RAISE NOTICE 'delete_sample() SQL: %', myquery;

  /* get the destination tableid if not null */
  FOR myrec IN EXECUTE myquery LOOP
     schema := myrec.schema;
     tblid  := myrec.tableid;
     st_id  := myrec.st_id;
     date   := myrec.date_start;
     days   := myrec.no_days;
  END LOOP;

  --RAISE NOTICE 'delete_sample() st_id: %, tblid %, date: %, days: %, ', st_id, tblid, date, days;
  --RETURN true;

  /* insert new data */
  v := 0;
  WHILE v < days loop
    v := v + 1;

    --RAISE NOTICE 'delete_sample() date: %', date;

    myquery := 'SELECT laboratory_data.lab_pr_id, '
    || '_laboratory_analysis_parameters.pr_id, _stations_parameters.id '
        || 'FROM labanalysis.laboratory_samples '
        || 'JOIN labanalysis.laboratory_data USING (sp_id) '
        || 'JOIN labanalysis._laboratory_analysis_parameters USING (lab_pr_id) '
        || 'JOIN _stations_parameters ON _stations_parameters.st_id=laboratory_samples.st_id '
        || 'AND _stations_parameters.pr_id=_laboratory_analysis_parameters.pr_id '
        || 'WHERE laboratory_samples.sp_id=' || sp_id; --20000366

    --RAISE NOTICE 'delete_sample() SQL 2: %', myquery;

    /* get the destination tableid if not null */
    FOR myrec IN EXECUTE myquery LOOP

      id := myrec.id;
      --RAISE NOTICE 'delete_sample() id: %', id;

      BEGIN
        /* execute the update query against the horizontal db */
        myquery := 'UPDATE ' || schema || '.tbl_' || tblid || ' SET id_' || id
                || '=null WHERE fulldate='''|| date || '''';
        --RAISE NOTICE 'delete_sample() SQL 3: %', myquery;
        EXECUTE myquery;

        /* execute the delete query against the vertical db */
        myquery := 'DELETE FROM ' || schema || '.data_' || tblid || ' '
                || 'WHERE fulldate='''|| date || ''' AND id=' || id;
        --RAISE NOTICE 'delete_sample() SQL 4: %', myquery;
        EXECUTE myquery;

      /* errors check */
      EXCEPTION
          /* in case of duplicate key error we update */
        WHEN OTHERS THEN RAISE NOTICE 'delete_sample() ERROR: %', myquery;
          /* return value */
          RETURN false;
      END;

    END LOOP;

    /* next day */
    date := date + '1 DAY'::INTERVAL;
  END loop;

  /* delete the data from deposimeters_input_data */
  myquery := 'DELETE FROM labanalysis.deposimeters_input_data WHERE sp_id=' || sp_id;
  --RAISE NOTICE 'SQL 4: %', myquery;
  EXECUTE myquery;

  /* delete the data from laboratory_data */
  myquery := 'DELETE FROM labanalysis.laboratory_data WHERE sp_id=' || sp_id;
  --RAISE NOTICE 'SQL 4: %', myquery;
  EXECUTE myquery;

  /* delete the data from laboratory_samples */
  myquery := 'DELETE FROM labanalysis.laboratory_samples WHERE sp_id=' || sp_id;
  --RAISE NOTICE 'SQL 5: %', myquery;
  EXECUTE myquery;

  RETURN true;

/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'delete_sample() ERROR: %', myquery;
   RETURN false;
END;
$_$;


ALTER FUNCTION labanalysis.delete_sample(integer) OWNER TO postgres;

--
-- TOC entry 810 (class 1255 OID 17072)
-- Name: delete_sample_data(integer); Type: FUNCTION; Schema: labanalysis; Owner: postgres
--

CREATE FUNCTION labanalysis.delete_sample_data(integer) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
declare
  sp_id   integer;
  st_id   integer;
  date    timestamp;
  days    integer;
  v       integer;
  myquery varchar;
  myrec   record;
  schema  varchar;
  tblid   varchar;
  id      integer;
BEGIN

  /* get the sample id */
  sp_id := $1;

  /* collect the needed data station id, date start and date lenght */
  myquery := 'SELECT laboratory_samples.sp_id,laboratory_samples.st_id, '
  || 'laboratory_samples.date_start, laboratory_samples.no_days AS no_days, '
  || '_stations.schema, _stations.tableid '
        || 'FROM labanalysis.laboratory_samples '
        || 'JOIN _stations USING (st_id) '
        || 'WHERE laboratory_samples.sp_id=' || sp_id; --20000366

  --RAISE NOTICE 'delete_sample_data() SQL: %', myquery;

  /* get the destination tableid if not null */
  FOR myrec IN EXECUTE myquery LOOP
     schema := myrec.schema;
     tblid  := myrec.tableid;
     st_id  := myrec.st_id;
     date   := myrec.date_start;
     days   := myrec.no_days;
  END LOOP;

  --RAISE NOTICE 'delete_sample_data() st_id: %, tblid %, date: %, days: %, ', st_id, tblid, date, days;
  --RETURN true;

  /* insert new data */
  v := 0;
  WHILE v < days loop
    v := v + 1;

    --RAISE NOTICE 'delete_sample_data() date: %', date;

    myquery := 'SELECT laboratory_data.lab_pr_id, '
    || '_laboratory_analysis_parameters.pr_id, _stations_parameters.id '
        || 'FROM labanalysis.laboratory_samples '
        || 'JOIN labanalysis.laboratory_data USING (sp_id) '
        || 'JOIN labanalysis._laboratory_analysis_parameters USING (lab_pr_id) '
        || 'JOIN _stations_parameters ON _stations_parameters.st_id=laboratory_samples.st_id '
        || 'AND _stations_parameters.pr_id=_laboratory_analysis_parameters.pr_id '
        || 'WHERE laboratory_samples.sp_id=' || sp_id; --20000366

    --RAISE NOTICE 'delete_sample_data() SQL 2: %', myquery;

    /* get the destination tableid if not null */
    FOR myrec IN EXECUTE myquery LOOP

      id := myrec.id;
      --RAISE NOTICE 'delete_sample_data() id: %', id;

      BEGIN
        /* execute the update query against the horizontal db */
        myquery := 'UPDATE ' || schema || '.tbl_' || tblid || ' SET id_' || id
                || '=null WHERE fulldate='''|| date || '''';
        --RAISE NOTICE 'delete_sample_data() SQL 3: %', myquery;
        EXECUTE myquery;

        /* execute the delete query against the vertical db */
        myquery := 'DELETE FROM ' || schema || '.data_' || tblid || ' '
                || 'WHERE fulldate='''|| date || ''' AND id=' || id;
        --RAISE NOTICE 'delete_sample_data() SQL 4: %', myquery;
        EXECUTE myquery;

      /* errors check */
      EXCEPTION
          /* in case of duplicate key error we update */
        WHEN OTHERS THEN RAISE NOTICE 'delete_sample_data() ERROR: %', myquery;
          /* return value */
          RETURN false;
      END;

    END LOOP;

    /* next day */
    date := date + '1 DAY'::INTERVAL;
  END loop;

  /* delete the data from laboratory_data */
  myquery := 'DELETE FROM labanalysis.laboratory_data WHERE sp_id=' || sp_id;
  --RAISE NOTICE 'SQL 4: %', myquery;
  EXECUTE myquery;

  RETURN true;

/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'delete_sample_data() ERROR: %', myquery;
   RETURN false;
END;
$_$;


ALTER FUNCTION labanalysis.delete_sample_data(integer) OWNER TO postgres;

--
-- TOC entry 811 (class 1255 OID 17073)
-- Name: delete_sample_data_only(integer); Type: FUNCTION; Schema: labanalysis; Owner: postgres
--

CREATE FUNCTION labanalysis.delete_sample_data_only(integer) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
declare
  sp_id   integer;
  st_id   integer;
  date    timestamp;
  days    integer;
  v       integer;
  myquery varchar;
  myrec   record;
  schema  varchar;
  tblid   varchar;
  id      integer;
BEGIN

  /* get the sample id */
  sp_id := $1;

  /* collect the needed data station id, date start and date lenght */
  myquery := 'SELECT laboratory_samples.sp_id,laboratory_samples.st_id, '
  || 'laboratory_samples.date_start, laboratory_samples.no_days AS no_days, '
  || '_stations.schema, _stations.tableid '
        || 'FROM labanalysis.laboratory_samples '
        || 'JOIN _stations USING (st_id) '
        || 'WHERE laboratory_samples.sp_id=' || sp_id; --20000366

  --RAISE NOTICE 'delete_sample_data() SQL: %', myquery;

  /* get the destination tableid if not null */
  FOR myrec IN EXECUTE myquery LOOP
     schema := myrec.schema;
     tblid  := myrec.tableid;
     st_id  := myrec.st_id;
     date   := myrec.date_start;
     days   := myrec.no_days;
  END LOOP;

  --RAISE NOTICE 'delete_sample_data() st_id: %, tblid %, date: %, days: %, ', st_id, tblid, date, days;
  --RETURN true;

  /* insert new data */
  v := 0;
  WHILE v < days loop
    v := v + 1;

    --RAISE NOTICE 'delete_sample_data() date: %', date;

    myquery := 'SELECT laboratory_data.lab_pr_id, '
    || '_laboratory_analysis_parameters.pr_id, _stations_parameters.id '
        || 'FROM labanalysis.laboratory_samples '
        || 'JOIN labanalysis.laboratory_data USING (sp_id) '
        || 'JOIN labanalysis._laboratory_analysis_parameters USING (lab_pr_id) '
        || 'JOIN _stations_parameters ON _stations_parameters.st_id=laboratory_samples.st_id '
        || 'AND _stations_parameters.pr_id=_laboratory_analysis_parameters.pr_id '
        || 'WHERE laboratory_samples.sp_id=' || sp_id; --20000366

    --RAISE NOTICE 'delete_sample_data() SQL 2: %', myquery;

    /* get the destination tableid if not null */
    FOR myrec IN EXECUTE myquery LOOP

      id := myrec.id;
      --RAISE NOTICE 'delete_sample_data() id: %', id;

      BEGIN
        /* execute the update query against the horizontal db */
        myquery := 'UPDATE ' || schema || '.tbl_' || tblid || ' SET id_' || id
                || '=null WHERE fulldate='''|| date || '''';
        RAISE NOTICE 'delete_sample_data() SQL 3: %', myquery;
        EXECUTE myquery;

        /* execute the delete query against the vertical db */
        myquery := 'DELETE FROM ' || schema || '.data_' || tblid || ' '
                || 'WHERE fulldate='''|| date || ''' AND id=' || id;
        RAISE NOTICE 'delete_sample_data() SQL 4: %', myquery;
        EXECUTE myquery;

      /* errors check */
      EXCEPTION
          /* in case of duplicate key error we update */
        WHEN OTHERS THEN RAISE NOTICE 'delete_sample_data() ERROR: %', myquery;
          /* return value */
          RETURN false;
      END;

    END LOOP;

    /* next day */
    date := date + '1 DAY'::INTERVAL;
  END loop;

  /* delete the data from laboratory_data */
  myquery := 'DELETE FROM labanalysis.laboratory_data WHERE sp_id=' || sp_id;
  RAISE NOTICE 'SQL 4: %', myquery;
  --EXECUTE myquery;

  RETURN true;

/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'delete_sample_data_only() ERROR: %', myquery;
   RETURN false;
END;
$_$;


ALTER FUNCTION labanalysis.delete_sample_data_only(integer) OWNER TO postgres;

--
-- TOC entry 812 (class 1255 OID 17074)
-- Name: delete_white_sample(integer); Type: FUNCTION; Schema: labanalysis; Owner: postgres
--

CREATE FUNCTION labanalysis.delete_white_sample(integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
  spid      ALIAS FOR $1;
  myrec     record;
  myquery   text;
BEGIN

    /*
      SELECT labanalysis.delete_white_sample(201709999);
    */

    /* delete the data from laboratory_data_white */
    myquery := 'DELETE FROM labanalysis.laboratory_data_white WHERE sp_id=' || spid;
    --RAISE NOTICE 'SQL 4: %', myquery;
    EXECUTE myquery;

    /* delete the data from laboratory_samples */
    myquery := 'DELETE FROM labanalysis.laboratory_samples_white WHERE sp_id=' || spid;
    --RAISE NOTICE 'SQL 5: %', myquery;
    EXECUTE myquery;

    -- return
    RETURN true;

    /* errors check */
    EXCEPTION
        /* in case of duplicate key error we update */
      WHEN OTHERS THEN RAISE NOTICE 'delete_white_sample() ERROR : %', SQLERRM;
        /* return value */
        RETURN false;
END;
$_$;


ALTER FUNCTION labanalysis.delete_white_sample(integer) OWNER TO postgres;

--
-- TOC entry 814 (class 1255 OID 17075)
-- Name: laboratory_calc(); Type: FUNCTION; Schema: labanalysis; Owner: postgres
--

CREATE FUNCTION labanalysis.laboratory_calc() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  days     integer;
  mytbl    varchar;
  myhtbl   varchar;
  myquery  varchar;
  myrec    record;
  id       integer;
  v        integer;
  date     timestamp;
  conc     float;
  conc_min float;
  conc_max float;
  q_del    varchar;
BEGIN

  /* collect the needed data */
  myquery := 'select labanalysis.laboratory_samples.date_start, labanalysis.laboratory_samples.no_days, '
    || '_stations.schema, _stations.tableid, _stations_parameters.id '
    || 'from '
    || 'labanalysis.laboratory_samples join _stations on labanalysis.laboratory_samples.st_id = _stations.st_id '
    || 'join _stations_parameters on _stations_parameters.st_id=labanalysis.laboratory_samples.st_id '
    || 'where '
    || 'labanalysis.laboratory_samples.sp_id=' || NEW.sp_id || ' '
    || 'and _stations_parameters.pr_id=(select labanalysis._laboratory_analysis_parameters.pr_id '
    || 'from labanalysis._laboratory_analysis_parameters '
    || 'where labanalysis._laboratory_analysis_parameters.lab_pr_id=' || NEW.lab_pr_id || ')';

  -- RAISE NOTICE 'laboratory_calc() SQL : %', myquery;

  /* get the destination tableid if not null */
  FOR myrec IN EXECUTE myquery LOOP
     mytbl  := myrec.schema || '.data_' || myrec.tableid;
     myhtbl := myrec.schema || '.tbl_'  || myrec.tableid;
     id     := myrec.id;
     date   := myrec.date_start;
     days   := myrec.no_days;
     conc   := NEW.conc;
  END LOOP;
  -- RAISE NOTICE 'insert new data days %, %', days, date;

  /* calculate the min & max */
  IF ( conc >= 0 ) THEN
    conc_min := conc;
    conc_max := conc;
  ELSE
    conc_min := 0;
    conc_max := abs(conc);
    conc     := abs(conc / 2);
  END IF;

  /* insert new data */
  v := 0;
  WHILE v < days LOOP
    -- RAISE NOTICE 'laboratory_calc() Day: % of %', v, days;
    -- RAISE NOTICE 'laboratory_calc() conc: % ', conc;
    v := v + 1;

    /* we try to insert the row if fails we perform un update */
    myquery := 'INSERT INTO ' || mytbl || ' (fulldate,id,meanvalue,min,max) VALUES ( '''
       || date || ''', ' || id || ', ' || conc || ', ' || conc_min || ', ' || conc_max || ')';

    --RAISE NOTICE 'laboratory_calc() SQL 2: %', myquery;

    /* remove any existing row data */
    IF conc IS null THEN

      BEGIN
          --RAISE NOTICE 'laboratory_calc() conc is NULL Only remove';
          q_del := 'DELETE FROM ' || mytbl || ' WHERE fulldate = ' ||
                   quote_literal(date) || ' AND id = ' || id;
          EXECUTE q_del;
      --update the horizontal table as well ( no min & max )
          q_del := 'UPDATE ' || myhtbl || ' SET id_' || id || '=null, '
                || ' id_' || id || '_cod=null '
                || 'WHERE fulldate = ' || quote_literal(date);
          EXECUTE q_del;

        /* errors check */
        EXCEPTION
        WHEN OTHERS THEN RAISE NOTICE 'laboratory_calc() ERROR! %', q_del;
          /* return value */
          RETURN NEW;
      END;

    ELSE /* conc is not null */

      BEGIN

        /* execute the insert query */
        EXECUTE myquery;

        /* errors check */
        EXCEPTION

        /* in case of duplicate key error we update */
        WHEN UNIQUE_VIOLATION THEN NULL;
              q_del := 'DELETE FROM ' || mytbl || ' WHERE fulldate = ' ||
              quote_literal(date) || ' AND id = ' || id;
      /* delete the old row */
          EXECUTE q_del;
          /* insert the new one */
          EXECUTE myquery;

        /* other errors */
        WHEN OTHERS THEN RAISE NOTICE 'laboratory_calc() ERROR! % | %', q_del, myquery;
          /* return value */
          RETURN NEW;
      END;
    END IF;

    /* next day */
    date := date + '1 DAY'::INTERVAL;
    --RETURN NEW;

  END LOOP;

  /* return value */
  RETURN NEW;

END;
$$;


ALTER FUNCTION labanalysis.laboratory_calc() OWNER TO postgres;

--
-- TOC entry 815 (class 1255 OID 17076)
-- Name: replace_lab(character varying); Type: FUNCTION; Schema: labanalysis; Owner: postgres
--

CREATE FUNCTION labanalysis.replace_lab(character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
declare
    query varchar;
    q_del varchar;
    q_bak varchar;
    tspid varchar;
    tprid varchar;
    pos   smallint;
BEGIN
    query := $1;
    /* execute the insert query */
    /* INSERT INTO labanalysis.laboratory_data VALUES (DEFAULT, 20000367, 1, 0.2 ) */
    --RAISE NOTICE 'replace_lab() TEST % - %', mytbl, query;
    EXECUTE query;
    return true;

/* errors check */
EXCEPTION
    /* in case of duplicate key error we update */
    WHEN UNIQUE_VIOLATION THEN NULL;

      /* get the start position */
      pos := position('VALUES (' in query );
      q_bak := substring( query from 1 for pos -1 );
      q_bak := trim(both ' ' from q_bak);
      /* get the table name
      table := split_part(q_bak,' ',3); */
      q_bak := substring( query from pos + 1 for char_length(query)-pos-1 );
      /* get the date */
      tspid := split_part(q_bak,',',2);
      /* get the code */
      tprid := split_part(q_bak,',',3);
      /* get the delete query */
      q_del := 'DELETE FROM labanalysis.laboratory_data WHERE sp_id = '
          || tspid || ' AND lab_pr_id = ' || tprid;

    --RAISE NOTICE 'replace_lab() TEST: %', q_del;
    --return true;

      BEGIN
        /* execute the delete query */
        EXECUTE q_del;

        BEGIN
          /* re-execute the insert query */
          --RAISE NOTICE 'replace_lab() TEST % - %', mytbl, query;
          EXECUTE query;
          return true;

        /* errors check */
        EXCEPTION
          /* still errors */
          WHEN OTHERS THEN RAISE NOTICE 'replace_lab() ERROR: %', query;
            return false;
        END;

      /* errors check */
      EXCEPTION
        /* still errors */
        WHEN OTHERS THEN RAISE NOTICE 'replace_lab() ERROR: %', query;
          return false;
      END;

END;
$_$;


ALTER FUNCTION labanalysis.replace_lab(character varying) OWNER TO postgres;

--
-- TOC entry 816 (class 1255 OID 17077)
-- Name: scripta_get_sample_data(integer); Type: FUNCTION; Schema: labanalysis; Owner: postgres
--


--
-- TOC entry 819 (class 1255 OID 17083)
-- Name: scripta_import_station_samples(smallint, labanalysis.scripta_analysis, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: labanalysis; Owner: postgres
--

CREATE FUNCTION labanalysis.scripta_import_station_samples(st_id smallint, an_type labanalysis.scripta_analysis, date_start timestamp without time zone, date_end timestamp without time zone) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    query       text;
    inner_query text;
    group_filter text;
    rec         record;
BEGIN

    /*
    * https://www.postgresql.org/docs/current/contrib-dblink-connect.html
    * TEST
    * SELECT * FROM labanalysis.scripta_import_station_samples(4000::smallint, 'metalli', '2019-01-01'::timestamp, '2019-06-01 23:59:59'::timestamp);
    */
    RAISE NOTICE 'scripta_import_station_samples() >> Stazione: %, Tipo; %, Periodo: % - % ', st_id, an_type, date_start, date_end;
    RAISE NOTICE '--';

    CASE
        WHEN an_type = 'metalli' THEN group_filter:= 'gruppo IN (''001'', ''002'', ''016'', ''017'') ';
        WHEN an_type = 'an_ca'   THEN group_filter:= 'gruppo = ''003'' ';
        WHEN an_type = 'ecoc'    THEN group_filter:= 'gruppo = ''012'' ';
        WHEN an_type = 'levo'    THEN group_filter:= 'gruppo = ''011'' ';
        WHEN an_type = 'ipa'     THEN group_filter:= 'gruppo = ''011'' ';
        WHEN an_type = 'gravimetriche'   THEN group_filter:= 'gruppo = ''gravimetriche'' ';
        ELSE group_filter:='gruppo = ''004'' ';
    END CASE;

    -- get records
    query := 'SELECT '||E'\n'
        || '    scripta.id         AS idcampione, '||E'\n'
        || '    scripta.codice                  , '||E'\n'
        || '    scripta.dsc                     , '||E'\n'
        || '    scripta.sito                    , '||E'\n'
        || '    scripta.idluogo                 , '||E'\n'
        || '    s.st_id                 AS st_id, '||E'\n'
        || '    scripta.aria_dt_inizio_camp     , '||E'\n'
        || '    scripta.aria_dt_fine_camp         '||E'\n'
        || 'FROM '||E'\n'
        || '    labanalysis.scripta_get_samples() scripta '||E'\n'
        || '    LEFT JOIN _stations s ON s.st_id_scripta = scripta.idluogo '||E'\n'
        || 'WHERE '||E'\n'
        || '    s.st_id = '||st_id||' '||E'\n'
        || '--AND scripta.importato IS NOT TRUE '||E'\n'
        || 'AND scripta.aria_dt_inizio_camp BETWEEN '|| quote_literal(date_start)||'::timestamp AND '||quote_literal(date_end)||'::timestamp '||E'\n'
        || 'AND scripta.aria_volume IS NOT NULL '||E'\n'
        || 'AND scripta.numero_interno_sezione !~* ''bianco'' '||E'\n'
        || 'AND scripta.dsc !~* ''bianco'' '||E'\n'
        || 'AND '||group_filter||' '||E'\n'
        || 'ORDER BY scripta.aria_dt_inizio_camp;';

    RAISE NOTICE 'query: %', query;

    FOR rec IN EXECUTE query
    LOOP

        RAISE NOTICE '-----------------------------------------------------------------';
        RAISE NOTICE 'ID campione: % / CODICE: % ', rec.idcampione, rec.codice;
        RAISE NOTICE 'Stazione: % e st_id: % => IDLUOGO: %',  rec.sito, rec.st_id, rec.idluogo;
        RAISE NOTICE 'Data inizio: % ', rec.aria_dt_inizio_camp;

        inner_query := 'SELECT * FROM labanalysis.scripta_import_sample('|| rec.idcampione ||'::integer);';
        RAISE NOTICE 'Inner query: %', inner_query;
        EXECUTE inner_query;

    END LOOP;

    RETURN true;

/* errors check */
EXCEPTION WHEN OTHERS THEN /* in case of any error */
    RAISE NOTICE 'ERROR IN labanalysis.scripta_import_station_samples() : %', SQLERRM ;

    RETURN false;
END;
$$;


ALTER FUNCTION labanalysis.scripta_import_station_samples(st_id smallint, an_type labanalysis.scripta_analysis, date_start timestamp without time zone, date_end timestamp without time zone) OWNER TO postgres;






--
-- TOC entry 821 (class 1255 OID 17085)
-- Name: bitmask_greater(integer, integer); Type: FUNCTION; Schema: main; Owner: postgres
--

CREATE FUNCTION main.bitmask_greater(integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$

DECLARE
    original_num ALIAS FOR $1;
    max_code     ALIAS FOR $2;
    greater_res  INTEGER;
BEGIN
    -- Test
    -- SELECT test.bitmask_greater(5, 1024);
    greater_res := 0;

    LOOP
        IF max_code = 0 THEN
            EXIT;
        END IF;


        IF (original_num / max_code) = 1 THEN
            greater_res := max_code;
            EXIT;
        END IF;

        max_code := max_code / 2;

    END LOOP;

    RETURN greater_res;

    /* errors check */
    EXCEPTION
    WHEN OTHERS THEN
      RAISE NOTICE 'ERROR IN main.bitmask_greater() : %', SQLERRM ;
      RETURN false;
END;

$_$;


ALTER FUNCTION main.bitmask_greater(integer, integer) OWNER TO postgres;

--
-- TOC entry 813 (class 1255 OID 17086)
-- Name: bitmask_toarray(integer, integer); Type: FUNCTION; Schema: main; Owner: postgres
--

CREATE FUNCTION main.bitmask_toarray(integer, integer) RETURNS integer[]
    LANGUAGE plpgsql
    AS $_$

DECLARE
    original_num ALIAS FOR $1;
    counter      ALIAS FOR $2;
    bin_power    INTEGER;
    array_res    INTEGER[];
BEGIN
    -- Test
    -- SELECT test.bitmask_toarray(735, 10);
    LOOP
        IF counter = -1 THEN
            EXIT;  -- exit loop
        END IF;

        bin_power := POWER(2, counter);
        --RAISE NOTICE 'Potenza di 2: %', bin_power;

        IF (original_num / bin_power) = 1 THEN

            array_res := array_append(array_res, bin_power);
            original_num := original_num % bin_power ;
            --RAISE NOTICE 'Array: %', array_res;
        END IF;

        counter := counter - 1;
    END LOOP;

    RETURN array_res;

  /* errors check */
  EXCEPTION
    WHEN OTHERS THEN
      RAISE NOTICE 'ERROR IN main.bitmask_toarray() : %', SQLERRM ;
      RETURN false;
END;

$_$;


ALTER FUNCTION main.bitmask_toarray(integer, integer) OWNER TO postgres;

--
-- TOC entry 822 (class 1255 OID 17087)
-- Name: code2calccode(integer); Type: FUNCTION; Schema: main; Owner: postgres
--

CREATE FUNCTION main.code2calccode(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$

DECLARE
    code       ALIAS FOR $1;
    calc_code  integer;
BEGIN
    -- Test
    -- SELECT main.code2calccode(1235, '2019-09-10 16:00:00'::timestamp, 4::smallintw;

    /*default value*/
    calc_code := 0;

    /*calculate the final calc code
      based on OPAS-DL EnumChannelCode Enum (ModuleData.vb)
    */
    IF code & 1    = 1    THEN calc_code := calc_code | 128; END IF; -- SPAN_LOW = 1
    IF code & 2    = 2    THEN calc_code := calc_code | 256; END IF; -- SPAN_HIGH = 2
    IF code & 4    = 4    THEN calc_code := calc_code | 32;  END IF; -- ZERO_LOW = 4
    IF code & 8    = 8    THEN calc_code := calc_code | 64;  END IF; -- ZERO_HIGH = 8
    IF code & 16   = 16   THEN calc_code := calc_code | 8;   END IF; -- CALIBRATION = 16
    IF code & 32   = 32   THEN calc_code := calc_code | 0;   END IF; -- ' 32
    IF code & 64   = 64   THEN calc_code := calc_code | 0;   END IF; -- ' 64
    IF code & 128  = 128  THEN calc_code := calc_code | 16;  END IF; -- MIN_READING_PERC = 128
    IF code & 256  = 256  THEN calc_code := calc_code | 512; END IF; -- INTRUMENT_ERROR = 256
    IF code & 512  = 512  THEN calc_code := calc_code | 2;   END IF; -- DETECTION_LIMIT = 512
    IF code & 1024 = 1024 THEN calc_code := calc_code | 512; END IF; -- MIN_DETECTION_LIMIT = 1024
    IF code & 2048 = 2048 THEN calc_code := calc_code | 4;   END IF; -- MIN_THERSHOLD = 2048
    IF code & 4096 = 4096 THEN calc_code := calc_code | 4;   END IF; -- MAX_THERSHOLD = 4096
    IF code & 8192 = 8192 THEN calc_code := calc_code | 4;   END IF; -- MAX_VARIANCE = 8192

    /*return value*/
    RETURN calc_code;

    /* errors check */
    EXCEPTION
    WHEN OTHERS THEN
      RAISE NOTICE 'ERROR IN main.code2calccode() : %', SQLERRM ;
      RETURN null;
END;

$_$;


ALTER FUNCTION main.code2calccode(integer) OWNER TO postgres;

--
-- TOC entry 5733 (class 0 OID 0)
-- Dependencies: 822
-- Name: FUNCTION code2calccode(integer); Type: COMMENT; Schema: main; Owner: postgres
--

COMMENT ON FUNCTION main.code2calccode(integer) IS 'Calculate the calccode from code';


--
-- TOC entry 823 (class 1255 OID 17088)
-- Name: check_st_id_pr_id_fl_utilizzo(); Type: FUNCTION; Schema: operations; Owner: postgres
--

CREATE FUNCTION operations.check_st_id_pr_id_fl_utilizzo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN
   IF EXISTS (SELECT 1 FROM operations.v_instruments_stations vis WHERE vis.pr_id = NEW.pr_id AND vis.st_id = NEW.st_id  AND vis.fl_utilizzo = NEW.fl_utilizzo ) THEN
     RETURN NEW;
   --ELSE 
    -- RETURN NULL ;
  END IF;
END;
$$;


ALTER FUNCTION operations.check_st_id_pr_id_fl_utilizzo() OWNER TO postgres;

--
-- TOC entry 824 (class 1255 OID 17089)
-- Name: aera_export_daily(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.aera_export_daily() RETURNS boolean
    LANGUAGE plperlu
    AS $_$
	$id_partner="03";
	$tempo="H";
	@stations = (4000,4030,4010,4020,4060,4110,4080,4050,4040);
	%tables = ( "4000" ,	"data_plouves",
			"4030" ,    "data_dora",
			"4010" ,    "data_teatro",
			"4020" ,    "data_mt_fleury",
			"4060" ,    "data_morgex",
			"4110" ,    "data_donnas",
			"4080" ,    "data_etroubles",
			"4050" ,    "data_la_thuile",
			"4040",    	"data_tunnel_mb" );
	%table_id = ( "4000" ,	"IT0983A",
			"4030" ,    "IT1725A",
			"4010" ,    "IT0982A",
			"4020" ,    "IT0980A",
			"4060" ,    "IT0978A",
			"4110" ,    "IT0988A",
			"4080" ,    "IT0979A",
			"4050" ,    "IT0977A",
			"4040",    "IT1747A" );
	# parametro id generale, id misura
	%id_misure = ("1110",24,
			"1140",24,
			"1145",39,
			"2000",V4,
			"1020",2,
			"1030",3,
			"1010",12,
			"1040",4,
			"1060",8,
			"1000",1,
			"3210",P6,
			"3060",19,
			"3000",82,
			"3040",87,
			"3080",88);
	%id_metodo = ("1110",PMH4,
			"1140",PMJ1,
			"1145",PM2J1,
			"2000",BZA,
			"1020",NOA,
			"1030",NOA,
			"1010",OXA,
			"1040",COA,
			"1060",OA,
			"1000",SO2A,
			"3210",BPP,
			"3060",PBP,
			"3000",CDP,
			"3040",NIP,
			"3080",ZNP);
	########## open the export file ##########
	@timeData = gmtime(time);
	$mese=sprintf("%02d",@timeData[4]+1);
	$giorno=sprintf("%02d",@timeData[3]);
	$anno=(@timeData[5]+1900);
	$h=@timeData[2];
	$minuti=@timeData[1];
	$datafinequeryoraria=$anno.'-'.$mese.'-'.$giorno.' 00:00:00';
	$ora=$giorno.$mese.$anno."_".$h.$minuti;
	$nomefile=">/home/aera/daily/03data_".$ora.".csv";
    open(EXPFILE, $nomefile);
	$datainizioqueryoraria=$anno.'-'.$mese.'-'.$giorno.' 01:00:00';
	$oggi=$anno.'-'.$mese.'-'.$giorno.' '.$h.':'.$minuti.':00';
	foreach $station(@stations) {
		#recupero gli id della singola stazione associati ai parametri orari
		$sqlv  = "select pr_id,id from public._stations_parameters_master where st_id=$station and pr_id in (1110,2000,1020,1030,1010,1040,1060,1000)";
		$station_id = spi_query($sqlv);
		$id_list = "";
		%id_to_id_misura=();
		while (defined ($row = spi_fetchrow($station_id))) {
			if ($id_list eq ''){ $id_list=$row->{id};}
			else {$id_list=$id_list.",".$row->{id};}
			$id_to_id_misura{$row->{id}}=$row->{pr_id};
		}
		
		
		#recupero gli id della singola stazione associati ai parametri giornalieri
		#parametri relativi al pm10 e pm2.5 SM200
		$sqlv  = "select pr_id,id from public._stations_parameters_master where st_id=$station and pr_id in (1140,1145)";
		$station_id = spi_query($sqlv);
		$id_listgg = "";
		while (defined ($row = spi_fetchrow($station_id))) {
			if ($id_listgg eq ''){ $id_listgg=$row->{id};}
			else {$id_listgg=$id_listgg.",".$row->{id};}
			$id_to_id_misura{$row->{id}}=$row->{pr_id};
		}
		
		
		#recupero i dati dei parametri orari
		#sottraggo 1 ora per avere l''ora UTC ma aggiungo 1 ora per conformarmi alla convenzione: 2012-02-02 00:00:00 correspond à la valeur horaire du 01 février à 23h au 2 février à 00h.
		# (fulldate - interval '1 hour') as 
		$sqlv  = "select fulldate,meanvalue,id from tables_ar.$tables{$station} where fulldate between (timestamp '$datainizioqueryoraria' - interval '8 day') and '$datafinequeryoraria' and id in ($id_list)";
		$dati  = spi_query($sqlv);
		$dati_list="";
		while (defined ($row = spi_fetchrow($dati))) {
			if ($dati_list eq ''){ $dati_list=$id_partner.";".$table_id{$station}.";".$id_misure{$id_to_id_misura{$row->{id}}}.";".$tempo.";".$row->{fulldate}.";".$row->{meanvalue}.";A".$id_metodo{$id_to_id_misura{$row->{id}}};}
			else {$dati_list=$dati_list."\n".$id_partner.";".$table_id{$station}.";".$id_misure{$id_to_id_misura{$row->{id}}}.";".$tempo.";".$row->{fulldate}.";".$row->{meanvalue}.";A;".$id_metodo{$id_to_id_misura{$row->{id}}};}
		}
		
		if ($id_listgg ne ''){
			#recupero i dati dei parametri giornalieri (se esistono) non tutte le stazioni rilevano il pm10 e pm2.5
			$sql  = "select fulldate,meanvalue,id from tables_ar.$tables{$station} where fulldate between (timestamp '$datainizioqueryoraria' - interval '8 day') and '$datafinequeryoraria' and id in ($id_listgg) and extract('hour' from fulldate) = 7 ";
			$dati1  = spi_query($sql);
			while (defined ($row = spi_fetchrow($dati1))) {
				if ($dati_list eq ''){ $dati_list=$id_partner.";".$table_id{$station}.";".$id_misure{$id_to_id_misura{$row->{id}}}.";J;".$row->{fulldate}.";".$row->{meanvalue}.";A".$id_metodo{$id_to_id_misura{$row->{id}}};}
				else {$dati_list=$dati_list."\n".$id_partner.";".$table_id{$station}.";".$id_misure{$id_to_id_misura{$row->{id}}}.";J;".$row->{fulldate}.";".$row->{meanvalue}.";A;".$id_metodo{$id_to_id_misura{$row->{id}}};}
			}
		}
		$dati_list=$dati_list."\n";
		# print out to file
		print EXPFILE "$dati_list";

	}
	########## close the export file ##########
    close EXPFILE;
	return true;
$_$;


ALTER FUNCTION public.aera_export_daily() OWNER TO postgres;

--
-- TOC entry 825 (class 1255 OID 17091)
-- Name: calc_sliding_mean(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calc_sliding_mean() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  /* passed variables */
  mystid smallint;
  /* static values set user */
  slide_no     smallint := 8;    -- height hours
  slide_no_min smallint := 6;    -- minimum values to validate the result
  /* static values */
  o3_prid         smallint := 1060; -- ozone pr_id
  o3_slide_prid   smallint := 1400; -- ozone sliding mean pr_id
  co_prid         smallint := 1040; -- carbon monoxide pr_id
  co_slide_prid   smallint := 1410; -- carbon monoxide sliding mean pr_id
  /* main variables */
  myprid    smallint;
  myid      smallint;
  myid_calc smallint;
  myquery   varchar;
  mydate_start timestamp;
  mydate_end   timestamp;
  mydate_loop_start timestamp; -- we must update (or insert) 8 foreward rows
  mydate_loop_end   timestamp; -- we must update (or insert) 8 foreward rows
  sl_mean   real;
  sl_cod    smallint; -- sliding mean code
  cc_cod    smallint; -- calccode code
  /* dbh */
  myrec    record;
  get_diag smallint;
BEGIN

  /* If all the fields are equals to old skip */
  /* added @ 2009-03-17 */
  IF (TG_OP = 'UPDATE') THEN
    IF  NEW.meanvalue != OLD.meanvalue OR
        NEW.code      != OLD.code OR
        NEW.min       != OLD.min OR
        NEW.mintime   != OLD.mintime OR
        NEW.max       != OLD.max OR
        NEW.maxtime   != OLD.maxtime OR
        NEW.readings  != OLD.readings OR
        NEW.stddev    != OLD.stddev OR
        NEW.calccode  != OLD.calccode THEN
	-- continue
    ELSE
        -- skip
	--RAISE NOTICE 'replicator.exportdata() : RETURN NEW';
	--RAISE NOTICE '% % ', NEW.fulldate, NEW.id;
	RETURN NEW;
    END IF;
  END IF;
  
  /* get the values passed by the caller */
  mystid  := TG_ARGV[0];

  /* get the pr_id */
  SELECT INTO myprid pr_id FROM _stations_parameters WHERE st_id = mystid AND id = NEW.id;
  ---- RAISE NOTICE 'calc_sliding_mean() myprid: % ', myprid;

  /* ***********************************************
  * get the right vertical table ids
  * ************************************************/
  IF myprid = o3_prid THEN /* Ozone */

    SELECT INTO myid id      FROM _stations_parameters WHERE st_id = mystid AND pr_id = o3_prid;
    SELECT INTO myid_calc id FROM _stations_parameters WHERE st_id = mystid AND pr_id = o3_slide_prid;

  ELSIF myprid = co_prid THEN /* Carbon monoxide */

    SELECT INTO myid id      FROM _stations_parameters WHERE st_id = mystid AND pr_id = co_prid;
    SELECT INTO myid_calc id FROM _stations_parameters WHERE st_id = mystid AND pr_id = co_slide_prid;

  ELSE /* return */
      RETURN NEW;
  END IF;
  --RAISE NOTICE 'myid: %, myid: %', myid, myid_calc;


  /* ***********************************************
  * sliding mean calculation
  * ************************************************/

  /* LOOP stuff cache the start loop date */
  mydate_loop_start := NEW.fulldate;
  myquery := 'select ' || quote_literal(mydate_loop_start)
     || '::timestamp + interval ''' || slide_no || ' hour''';
  EXECUTE myquery INTO mydate_loop_end;
  ---- RAISE NOTICE 'mydate_loop_start %,  mydate_loop_end: % ', mydate_loop_start, mydate_loop_end;

  /* loop through record datetime up to 8 hours ahead */
  WHILE mydate_loop_start < mydate_loop_end loop

      /* get the record date time */
      mydate_end = mydate_loop_start;
      /* get the - n hours date time */
      myquery := 'select ' || quote_literal(mydate_end)
         || '::timestamp - interval ''' || slide_no - 1 || ' hour''';
      EXECUTE myquery INTO mydate_start;
      ---- RAISE NOTICE 'mydate_start %,  mydate_end: % ', mydate_start, mydate_end;

      /* build the query to get the mean value and code */
      myquery := 'SELECT round(cast(avg(meanvalue) as numeric), 3) as slmean, '
        || 'case when count(meanvalue) >= ' || slide_no_min
        || ' then 0 else 64 end as slcod '
        || 'FROM ' || TG_TABLE_SCHEMA || '.' || TG_RELNAME || ' WHERE fulldate BETWEEN '
        || quote_literal(mydate_start) || ' AND ' || quote_literal(mydate_end)
        || ' AND id = ' || myid || ' AND calccode <= 4'; -- only valid data !!

      BEGIN
          ---- RAISE NOTICE '[ SL MEAN ] query : % ', myquery;
          /* retieve values */
          FOR myrec IN EXECUTE myquery LOOP
              sl_mean := myrec.slmean;
              sl_cod  := myrec.slcod;
              /* value */
              IF myrec.slmean IS NULL THEN
                -- RAISE NOTICE 'NULL sl_mean !';
                sl_mean := -1000000;
              ELSE
                sl_mean := myrec.slmean;
              END IF;
              /* code & calccode */
              IF myrec.slcod  IS NULL THEN
                sl_cod := 'null';
                cc_cod := 8;
              ELSE
                sl_cod := myrec.slcod;
                IF sl_cod = 0 THEN
                  cc_cod := 0;
                ELSE -- slcod => 64
                  cc_cod := 8;
                END IF;
              END IF;

          END LOOP;
          /* null check */
          --IF sl_mean IS NULL THEN sl_mean := 'null'; END IF;
          --IF sl_cod  IS NULL THEN sl_cod  := 'null'; END IF;
          ---- RAISE NOTICE 'sl_mean: % sl_cod: %', sl_mean, sl_cod;

          /* NULL check */
          IF sl_mean <> -1000000 THEN

            /* we update the row and if fails we perform an insert */
            myquery := 'UPDATE ' || TG_TABLE_SCHEMA || '.' || TG_RELNAME || ' SET '
            || 'meanvalue = ' || sl_mean || ', '
            || 'code = '      || sl_cod || ', '
            || 'calccode = '  || cc_cod || ' ' /* set the calccode as well as the trigger is fired BEFORE INSERT only ! */
            || 'WHERE fulldate = ' || quote_literal(mydate_end) || ' '
            || 'AND id = ' || myid_calc;
            -- RAISE NOTICE '[ SL MEAN ] update query : %', myquery;

            /* execute the update query */
            EXECUTE myquery;

            GET DIAGNOSTICS get_diag = ROW_COUNT;
            ---- RAISE NOTICE 'GET DIAGNOSTICS get_diag [%]', get_diag;

            /* check if no rows have been updated */
            IF get_diag = 0 THEN

              /* we try to insert the row if fails we perform un update */
              myquery := 'INSERT INTO ' || TG_TABLE_SCHEMA || '.' || TG_RELNAME || ' ('
              || ' fulldate, id, meanvalue, code '
              || ' ) VALUES ( '
              || quote_literal(mydate_end) || ', ' || myid_calc || ', '
              || sl_mean  || ', ' || sl_cod || ')';

              /* execute the insert query */
              ---- RAISE NOTICE '[ SL MEAN ] insert query : %', myquery;
              EXECUTE myquery;

            END IF; -- get_diag = 0

          END IF; -- sl_mean <> NULL

      /* errors check */
      EXCEPTION WHEN OTHERS THEN /* in case of any error */
          RAISE NOTICE 'ERROR calc_sliding_mean : %', myquery;
          RETURN NEW; /* return value */
      END;

    /* add one hour */
    mydate_loop_start := mydate_loop_start + '1 HOUR'::INTERVAL;

  END loop; /* from date loop start -> date loop end */

  /* Final value */
  RETURN NEW;

END;
$$;


ALTER FUNCTION public.calc_sliding_mean() OWNER TO postgres;

--
-- TOC entry 5734 (class 0 OID 0)
-- Dependencies: 825
-- Name: FUNCTION calc_sliding_mean(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.calc_sliding_mean() IS 'Calculate the sliding means';


--
-- TOC entry 826 (class 1255 OID 17093)
-- Name: calccode(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calccode() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  calc_code INTEGER;
BEGIN
  /* Default value */
  calc_code := 0;

  /* Station Alarm */
    /* Alert
    IF NEW.StationAlarm & 16 = 16 OR NEW.StationAlarm & 32 = 32
      OR NEW.StationAlarm & 64 = 64 THEN
        calc_code := calc_code | 2;
    END IF;
	 */
    /* Alert power supply
    IF NEW.StationAlarm & 128 = 128 THEN
      calc_code := calc_code | 2;
    END IF;
	 */
    /* Alert severe
    IF NEW.StationAlarm & 256 = 256 OR NEW.StationAlarm & 512 = 512 
        OR NEW.StationAlarm & 1024 = 1024 OR NEW.StationAlarm & 2048 = 2048 THEN
      calc_code := calc_code | 8;
    END IF;
	 */
    /* Not valid data
    IF NEW.StationAlarm & 4096 = 4096 THEN
        calc_code := calc_code | 32;
    END IF;
	 */

    /* Value Code */
    /* Alert */
    IF NEW.Code & 4 = 4 OR NEW.Code & 8 = 8
        OR NEW.Code & 16 = 16 THEN
      calc_code := calc_code | 2;
    END IF;

    /* Alert severe */
    IF NEW.Code & 32 = 32 THEN
      calc_code := calc_code | 2;
    END IF;

    /* Alert severe */
    IF NEW.Code &  64 = 64 THEN
      calc_code := calc_code | 8;
    END IF;

  /* Final value */
  NEW.calccode := calc_code;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.calccode() OWNER TO postgres;

--
-- TOC entry 5735 (class 0 OID 0)
-- Dependencies: 826
-- Name: FUNCTION calccode(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.calccode() IS 'Calculate the final code';


--
-- TOC entry 827 (class 1255 OID 17094)
-- Name: calccode_fs(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calccode_fs() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  calc_code INTEGER;
BEGIN
  -- TRIGGER BEFORE INSERT

  /* Final value */
  NEW.calccode := 0;
  RETURN NEW;

--   /* TO BE IMPLEMENTED */
--
--   /* Default value */
--   calc_code := 0;
--
--   /* Alert */
--   IF NEW.Code & 4 = 4 OR NEW.Code & 8 = 8 THEN
--     calc_code := calc_code | 2;
--   END IF;
--
--   /* Alert severe */
--   IF NEW.Code & 16 = 16 OR NEW.Code & 32 = 32 OR NEW.Code & 64 = 64 THEN
--     calc_code := calc_code | 8;
--   END IF;
--
--   /* Final value */
--   NEW.calccode_fs := calc_code;
--   RETURN NEW;

END;
$$;


ALTER FUNCTION public.calccode_fs() OWNER TO postgres;

--
-- TOC entry 5736 (class 0 OID 0)
-- Dependencies: 827
-- Name: FUNCTION calccode_fs(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.calccode_fs() IS 'Calculate the final code';


--
-- TOC entry 828 (class 1255 OID 17095)
-- Name: change_id_donnas(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.change_id_donnas() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN
    IF NEW.id = 3 THEN -- temp pt100 2
      NEW.id = 1997; -- temp ext test 1
    END IF;
    IF NEW.id = 1995 THEN -- temp pt100 1
      NEW.id = 3; -- temp ext
    END IF;
    --IF NEW.id = 1996 THEN -- temp 0-2V
    --  NEW.id = 1996; -- temp ext test 2
    --END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.change_id_donnas() OWNER TO postgres;

--
-- TOC entry 829 (class 1255 OID 17096)
-- Name: check_pr_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_pr_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN
   IF EXISTS (SELECT 1 FROM _parameters_list pl WHERE pl.pr_id = NEW.pr_id) THEN
     RETURN NEW;
   --ELSE 
    -- RETURN NULL ;
  END IF;
END;
$$;


ALTER FUNCTION public.check_pr_id() OWNER TO postgres;

--
-- TOC entry 830 (class 1255 OID 17097)
-- Name: check_st_pr_id(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_st_pr_id(integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
	stprid alias for $1;
	counter integer;
BEGIN
    SELECT count(*) into counter from _stations_parameters where st_pr_id=stprid;
    IF counter = 1 THEN
	RETURN true;
    ELSE
        RAISE NOTICE 'CONSTRAINT : st_pr_id % does not exists', stprid;
	RETURN false;
    END IF;
    
  /* errors check */
  EXCEPTION
    WHEN OTHERS THEN
      RAISE NOTICE 'ERROR IN tool_analyser.check_st_pr_id() : %', SQLERRM ;
      RETURN false;
END;
$_$;


ALTER FUNCTION public.check_st_pr_id(integer) OWNER TO postgres;

--
-- TOC entry 831 (class 1255 OID 17098)
-- Name: check_station_islate(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_station_islate(integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
declare
    stid         integer;
    ref_fulldate timestamp;
    tablename    varchar;
    minutes_gap  integer;
    query        varchar;
    myrec        record;
BEGIN

    /* test : select check_station_islate(4000) */
    stid         := $1;
    ref_fulldate := TIMEZONE('UTC',CURRENT_TIMESTAMP);

    SELECT schema || '.data_' || tableid INTO tablename FROM _stations WHERE st_id = stid;
    --RAISE NOTICE 'table name : %', tablename;
    
    query = 'SELECT extract(HOUR FROM ' || quote_literal(ref_fulldate);
    query := query || '::timestamp - foo.fulldate::timestamp)';
    query := query || ' * 60 + extract(MINUTE FROM ' || quote_literal(ref_fulldate);
    query := query || '::timestamp - foo.fulldate::timestamp)';
    query := query || 'AS gap ';
    query := query || 'FROM ';
    query := query || '(SELECT fulldate FROM ' || tablename;
    query := query || ' WHERE id < 1999 AND id NOT IN (1400, 1410) '; -- medie mobili
    query := query || ' ORDER BY fulldate DESC LIMIT 1) as foo';
    --RAISE NOTICE 'query : %', query;

    /* get resulr */
    FOR myrec IN EXECUTE query LOOP
        minutes_gap := myrec.gap;
    END LOOP;
    --RAISE NOTICE 'minutes_gap : %', minutes_gap;

    IF minutes_gap <= 0 THEN
      RETURN false;
    ELSE
      RETURN true;
    END IF;
    
/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in check_station_islate : %', SQLERRM;
END;
$_$;


ALTER FUNCTION public.check_station_islate(integer) OWNER TO postgres;

--
-- TOC entry 5737 (class 0 OID 0)
-- Dependencies: 831
-- Name: FUNCTION check_station_islate(integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.check_station_islate(integer) IS 'Check if a station is late';


--
-- TOC entry 832 (class 1255 OID 17099)
-- Name: check_station_islate(integer, integer, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_station_islate(integer, integer, timestamp without time zone) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
declare
    stid         integer;
    id           integer;
    ref_fulldate timestamp;
    tablename    varchar;
    minutes_gap  integer;
    query        varchar;
    myrec        record;
BEGIN

    stid         := $1;
    id           := $2;
    ref_fulldate := $3;

    SELECT schema || '.data_' || tableid INTO tablename FROM _stations WHERE st_id = stid;
    RAISE NOTICE 'table name : %', tablename;
    
    query = 'SELECT extract(HOUR FROM ' || quote_literal(ref_fulldate);
    query := query || '::timestamp - foo.fulldate::timestamp)';
    query := query || ' * 60 + extract(MINUTE FROM ' || quote_literal(ref_fulldate);
    query := query || '::timestamp - foo.fulldate::timestamp)';
    query := query || 'AS gap ';
    query := query || 'FROM ';
    query := query || '(SELECT fulldate FROM ' || tablename;
    query := query || ' WHERE id = ' || id;
    query := query || ' ORDER BY fulldate DESC LIMIT 1) as foo';
    RAISE NOTICE 'query : %', query;

    /* get resulr */
    FOR myrec IN EXECUTE query LOOP
        minutes_gap := myrec.gap;
    END LOOP;
    RAISE NOTICE 'minutes_gap : %', minutes_gap;

    IF minutes_gap <= 0 THEN
		RETURN false;
    ELSE
		RETURN true;
    END IF;
    
/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in check_station_islate : %', SQLERRM;
END;
$_$;


ALTER FUNCTION public.check_station_islate(integer, integer, timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 5738 (class 0 OID 0)
-- Dependencies: 832
-- Name: FUNCTION check_station_islate(integer, integer, timestamp without time zone); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.check_station_islate(integer, integer, timestamp without time zone) IS 'Check if a station is late';


--
-- TOC entry 833 (class 1255 OID 17100)
-- Name: clear_vert_and_hor_data(integer, integer, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.clear_vert_and_hor_data(integer, integer, timestamp without time zone, timestamp without time zone) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
declare
    stid     integer;   -- station st_id
    id       integer;   -- parameter id
    datefrom timestamp; -- date from
    dateto   timestamp; -- date to
    --
    vtable   text;  -- vertical data table
    htable   text;  -- horizontal table
    --
    myquery  text;
    myres    integer;
BEGIN
    stid := $1;
    id   := $2;
    datefrom := $3;
    dateto   := $4;

    /*
    test SELECT clear_vert_and_hor_data( 1000, 1, '2008-01-01', '2008-01-01' );
    */

    /* get the tablenames */
    SELECT schema || '.data_'    || tableid INTO vtable  FROM _stations WHERE st_id=stid;
    SELECT schema || '.tbl_'     || tableid INTO htable  FROM _stations WHERE st_id=stid;
    /*  */
    RAISE NOTICE 'vtable: %, htable: %', vtable, htable;

    /* delete from vertical table */
    myquery := 'DELETE FROM ' || vtable || ' WHERE id = ' || id || ' ';
    myquery := myquery || ' AND fulldate BETWEEN ''' || datefrom || ''' AND ''' || dateto || ''' ';
    RAISE NOTICE 'Query % ...', myquery;
    /* execute query */
    EXECUTE myquery;

    /* update horizontal table */
    myquery := 'UPDATE ' || htable || ' SET id_' || id || ' = null, id_' || id || '_cod = null ';
    myquery := myquery || ' WHERE fulldate BETWEEN ''' || datefrom || ''' AND ''' || dateto || ''' ';
    RAISE NOTICE 'Query % ...', myquery;
    /* execute query */
    EXECUTE myquery;

    RETURN true;

/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR IN clear_vert_and_hor_data() : %', SQLERRM ;
END;
$_$;


ALTER FUNCTION public.clear_vert_and_hor_data(integer, integer, timestamp without time zone, timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 5739 (class 0 OID 0)
-- Dependencies: 833
-- Name: FUNCTION clear_vert_and_hor_data(integer, integer, timestamp without time zone, timestamp without time zone); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.clear_vert_and_hor_data(integer, integer, timestamp without time zone, timestamp without time zone) IS 'Delete a parameter values from all data tables';


--
-- TOC entry 834 (class 1255 OID 17101)
-- Name: clone_user_grants(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.clone_user_grants(user_id integer, new_user_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
  rec_stations   RECORD;
  rec_parameters RECORD;
BEGIN

    /* testing
			SELECT tool_analyser.clone_user_grants(1, 2);
    */

    /* _users_stations */
    BEGIN
        RAISE NOTICE 'Deleting from table _users_stations ...';
        DELETE FROM _users_stations WHERE us_id = new_user_id;
    EXCEPTION WHEN OTHERS THEN
    		RAISE NOTICE 'ERROR in _users_stations : %', SQLERRM;
    END;

    /* clone stations grants */
    FOR rec_stations IN SELECT * FROM _users_stations WHERE us_id = user_id ORDER BY st_id LOOP

            /* notice */
            --RAISE NOTICE 'Station ID %', rec_stations.st_id;

	    /* add the new user stations grants */
	    INSERT INTO _users_stations(us_id, st_id) VALUES (new_user_id, rec_stations.st_id);

    END LOOP;


    /* _users_parameters */
    BEGIN
        RAISE NOTICE 'Deleting from table _users_parameters ...';
        DELETE FROM _users_parameters WHERE us_id = new_user_id;
    EXCEPTION WHEN OTHERS THEN
    		RAISE NOTICE 'ERROR in _users_parameters : %', SQLERRM;
    END;

    /* clone parameters grants */
    FOR rec_parameters IN SELECT * FROM _users_parameters WHERE us_id = user_id ORDER BY pr_id LOOP

        /* notice */
        --RAISE NOTICE 'Parameter ID %', rec_parameters.pr_id;

	    /* add the new user stations grants */
	    INSERT INTO _users_parameters(us_id, pr_id) VALUES (new_user_id, rec_parameters.pr_id);

    END LOOP;

    RETURN true;

/* errors check */
EXCEPTION
  /* still errors */
  WHEN OTHERS THEN
    RAISE NOTICE 'ERROR IN tool_analyser.clone_user_grants : %', SQLERRM ;
    RETURN false;
END;
$$;


ALTER FUNCTION public.clone_user_grants(user_id integer, new_user_id integer) OWNER TO postgres;

--
-- TOC entry 5740 (class 0 OID 0)
-- Dependencies: 834
-- Name: FUNCTION clone_user_grants(user_id integer, new_user_id integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.clone_user_grants(user_id integer, new_user_id integer) IS 'Clone a Analyser user tree';


--
-- TOC entry 835 (class 1255 OID 17102)
-- Name: clone_user_macros(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.clone_user_macros(user_id integer, new_user_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
  view_macros       RECORD;
  rec_macros_groups RECORD;
  rec_macros_parameters RECORD;
  mygrid            INTEGER;
  mymcid            INTEGER;
BEGIN

    /* testing
		  SELECT tool_analyser.clone_user_macros(1, 2);
    */

	/* notice */
	--RAISE NOTICE 'Deleting macros and windows ...';
	BEGIN

    --RAISE NOTICE 'Deleting from table tool_analyser.macros_parameters ...';
		DELETE FROM tool_analyser.macros_parameters WHERE mc_id in (
			SELECT mc_id FROM tool_analyser.macros
			LEFT JOIN tool_analyser.macros_groups_users USING(gr_id)
			WHERE tool_analyser.macros_groups_users.us_id = new_user_id
		); -- select * from tool_analyser.macros_groups_users where us_id = 14;

		--RAISE NOTICE 'Deleting from table tool_analyser.macros ...';
		DELETE FROM tool_analyser.macros WHERE mc_id in (
			SELECT mc_id FROM tool_analyser.macros
			LEFT JOIN tool_analyser.macros_groups_users USING(gr_id)
			WHERE tool_analyser.macros_groups_users.us_id = new_user_id
		);

    --RAISE NOTICE 'Deleting from table tool_analyser.macros_groups ...';
		DELETE FROM tool_analyser.macros_groups WHERE gr_id in (
			SELECT gr_id FROM tool_analyser.macros_groups
			LEFT JOIN tool_analyser.macros_groups_users USING(gr_id)
			WHERE tool_analyser.macros_groups_users.us_id = new_user_id
		);

		--RAISE NOTICE 'Deleting from table tool_analyser.macros_groups_users ...';
		DELETE FROM tool_analyser.macros_groups_users WHERE us_id = new_user_id;

	EXCEPTION WHEN OTHERS THEN
		RAISE NOTICE 'ERROR in tool_analyser : %', SQLERRM;
	END;

	/* insert new macros */
    FOR view_macros IN SELECT * FROM tool_analyser.macros_groups_users
			JOIN tool_analyser.macros_groups USING(gr_id) WHERE us_id = user_id ORDER BY gr_id LOOP

        /* notice */
        --RAISE NOTICE 'Group ID %, Name %', view_macros.gr_id, view_macros.name;

	    /* add the new groups returning gr_id */
	    INSERT INTO tool_analyser.macros_groups(name, po_id)
		    VALUES (view_macros.name, view_macros.po_id) RETURNING gr_id INTO mygrid;

        /* notice */
        --RAISE NOTICE 'New group ID %', mygrid;

        /* add the new group into groups_users */
        INSERT INTO tool_analyser.macros_groups_users(us_id, gr_id) VALUES (new_user_id, mygrid);

            /* macros */
	    FOR rec_macros_groups IN SELECT * FROM tool_analyser.macros WHERE gr_id = view_macros.gr_id ORDER BY po_id LOOP

	        /* notice */
	        --RAISE NOTICE 'Macro McId %', rec_macros_groups.mc_id;

            /* add the new macro into macros */
		    INSERT INTO tool_analyser.macros(gr_id, name, description, int_time, po_id)
    			VALUES (mygrid, rec_macros_groups.name, rec_macros_groups.description,
    			rec_macros_groups.int_time, rec_macros_groups.po_id) RETURNING mc_id INTO mymcid;

            /* macros parameters */
		    FOR rec_macros_parameters IN SELECT *
		    		FROM tool_analyser.macros_parameters
		    		WHERE mc_id = rec_macros_groups.mc_id ORDER BY id LOOP

			        /* notice */
			        --RAISE NOTICE 'Parameter StPrId %', rec_macros_parameters.st_pr_id;

			        /* add the new macro into macros */
					INSERT INTO tool_analyser.macros_parameters(
			            mc_id, st_pr_id, name, legend, treatment, decimals, decimals_ba, formule,
			            lowerlimit, upperlimit, chartstyle, color, thick, marks, custom_axis, po_id)
				    VALUES (mymcid, rec_macros_parameters.st_pr_id, rec_macros_parameters.name,
    				rec_macros_parameters.legend, rec_macros_parameters.treatment,
    				rec_macros_parameters.decimals, rec_macros_parameters.decimals_ba,
    				rec_macros_parameters.formule, rec_macros_parameters.lowerlimit,
    				rec_macros_parameters.upperlimit, rec_macros_parameters.chartstyle,
    				rec_macros_parameters.color, rec_macros_parameters.thick,
    				rec_macros_parameters.marks, rec_macros_parameters.custom_axis,
    				rec_macros_parameters.po_id);

		    END LOOP;

	    END LOOP;

    END LOOP;

    RETURN true;

/* errors check */
EXCEPTION
	/* still errors */
	WHEN OTHERS THEN
		RAISE NOTICE 'ERROR IN tool_analyser.clone_user_macros : %', SQLERRM ;
		RETURN false;
END;
$$;


ALTER FUNCTION public.clone_user_macros(user_id integer, new_user_id integer) OWNER TO postgres;

--
-- TOC entry 5741 (class 0 OID 0)
-- Dependencies: 835
-- Name: FUNCTION clone_user_macros(user_id integer, new_user_id integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.clone_user_macros(user_id integer, new_user_id integer) IS 'Clone a Analyser user tree';


--
-- TOC entry 837 (class 1255 OID 17103)
-- Name: clone_user_settings(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.clone_user_settings(user_id integer, new_user_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
  rec_us	RECORD;
BEGIN

    /* testing
		  SELECT tool_analyser.clone_user_settings(1, 2);
    */

    /* tool_analyser.users_settings */
    BEGIN
        RAISE NOTICE 'Deleting from table tool_analyser.users_settings ...';
        DELETE FROM tool_analyser.users_settings WHERE us_id = new_user_id;
    EXCEPTION WHEN OTHERS THEN
      	RAISE NOTICE 'ERROR in tool_analyser.users_settings : %', SQLERRM;
    END;

    /* clone user settings */
    FOR rec_us IN SELECT * FROM tool_analyser.users_settings WHERE us_id = user_id LOOP
        -- actually one record
        /* add the new user stations grants */
        INSERT INTO tool_analyser.users_settings( us_id,
			theme_01, theme_02, theme_03, theme_04, theme_05,
			usechartsrollbar, useshortnames, appendaltitude,
			legendmaxrows, usemacrointtime, fontheadersize,
			fontheaderbold, fontsize, fontbold, showdateintitle)
        VALUES (new_user_id,
			rec_us.theme_01, rec_us.theme_02, rec_us.theme_03, rec_us.theme_04, rec_us.theme_05,
			rec_us.usechartsrollbar, rec_us.useshortnames, rec_us.appendaltitude,
			rec_us.legendmaxrows, rec_us.usemacrointtime, rec_us.fontheadersize,
			rec_us.fontheaderbold, rec_us.fontsize, rec_us.fontbold, rec_us.showdateintitle
        );

    END LOOP;

    RETURN true;

/* errors check */
EXCEPTION
	/* still errors */
	WHEN OTHERS THEN
		RAISE NOTICE 'ERROR IN tool_analyser.clone_user_settings : %', SQLERRM ;
		RETURN false;
END;
$$;


ALTER FUNCTION public.clone_user_settings(user_id integer, new_user_id integer) OWNER TO postgres;

--
-- TOC entry 5742 (class 0 OID 0)
-- Dependencies: 837
-- Name: FUNCTION clone_user_settings(user_id integer, new_user_id integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.clone_user_settings(user_id integer, new_user_id integer) IS 'Clone user sttings';


--
-- TOC entry 838 (class 1255 OID 17104)
-- Name: clone_user_settings_colors(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.clone_user_settings_colors(user_id integer, new_user_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
  rec_usc	RECORD;
BEGIN

    /* testing
		  SELECT tool_analyser.clone_user_settings_colors(1, 2);
    */

    /* tool_analyser.users_settings_colors */
    BEGIN
        RAISE NOTICE 'Deleting from table tool_analyser.users_settings_colors ...';
        DELETE FROM tool_analyser.users_settings_colors WHERE us_id = new_user_id;
    EXCEPTION WHEN OTHERS THEN
    	RAISE NOTICE 'ERROR in tool_analyser.users_settings_colors : %', SQLERRM;
    END;

    /* clone user settings */
    FOR rec_usc IN SELECT * FROM tool_analyser.users_settings_colors WHERE us_id = user_id LOOP
        -- actually one record

        /* add the new user stations grants */
		INSERT INTO tool_analyser.users_settings_colors(us_id,
			color_01, color_02, color_03, color_04, color_05, color_06,
			color_07, color_08, color_09, color_10, color_11, color_12,
			color_13, color_14, color_15, color_16, color_17, color_18,
			color_19, color_20, color_21, color_22, color_23, color_24,
			color_25, color_26, color_27, color_28, color_29, color_30)
		VALUES (new_user_id,
			rec_usc.color_01, rec_usc.color_02, rec_usc.color_03, rec_usc.color_04, rec_usc.color_05, rec_usc.color_06,
			rec_usc.color_07, rec_usc.color_08, rec_usc.color_09, rec_usc.color_10, rec_usc.color_11, rec_usc.color_12,
			rec_usc.color_13, rec_usc.color_14, rec_usc.color_15, rec_usc.color_16, rec_usc.color_17, rec_usc.color_18,
			rec_usc.color_19, rec_usc.color_20, rec_usc.color_21, rec_usc.color_22, rec_usc.color_23, rec_usc.color_24,
			rec_usc.color_25, rec_usc.color_26, rec_usc.color_27, rec_usc.color_28, rec_usc.color_29, rec_usc.color_30
			);

    END LOOP;

    RETURN true;

/* errors check */
EXCEPTION
	/* still errors */
	WHEN OTHERS THEN
		RAISE NOTICE 'ERROR IN tool_analyser.clone_user_settings_colors : %', SQLERRM ;
		RETURN false;
END;
$$;


ALTER FUNCTION public.clone_user_settings_colors(user_id integer, new_user_id integer) OWNER TO postgres;

--
-- TOC entry 5743 (class 0 OID 0)
-- Dependencies: 838
-- Name: FUNCTION clone_user_settings_colors(user_id integer, new_user_id integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.clone_user_settings_colors(user_id integer, new_user_id integer) IS 'Clone user sttings colors';


--
-- TOC entry 839 (class 1255 OID 17105)
-- Name: clone_user_tree(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.clone_user_tree(user_id integer, new_user_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
  view_groups         RECORD;
  rec_groups_stations RECORD;
  mygrid              INTEGER;
BEGIN

    /* testing
      SELECT tool_analyser.clone_user_tree(1, 2);
    */

    /* tool_analyser.analyser_groups_stations (tree) */
    BEGIN
        RAISE NOTICE 'Deleting from table tool_analyser.analyser_groups_stations ...';
        DELETE FROM tool_analyser.analyser_groups_stations WHERE gr_id IN (
        	SELECT gr_id FROM tool_analyser.analyser_groups_stations WHERE us_id = user_id
        );
    EXCEPTION WHEN OTHERS THEN
      	RAISE NOTICE 'ERROR in tool_visualizer.analyser_groups_stations : %', SQLERRM;
    END;

    /* tool_analyser.analyser_groups (tree) */
    BEGIN
        RAISE NOTICE 'Deleting from table tool_analyser.analyser_groups ...';
        DELETE FROM tool_analyser.analyser_groups WHERE gr_id IN (
        	SELECT gr_id FROM tool_analyser.analyser_groups_users WHERE us_id = new_user_id
        );
    EXCEPTION WHEN OTHERS THEN
      	RAISE NOTICE 'ERROR in tool_visualizer.analyser_groups : %', SQLERRM;
    END;

    /* tool_analyser.analyser_groups_users (tree) */
    BEGIN
        RAISE NOTICE 'Deleting from table tool_analyser.analyser_groups_users ...';
        DELETE FROM tool_analyser.analyser_groups_users WHERE us_id = new_user_id;
    EXCEPTION WHEN OTHERS THEN
      	RAISE NOTICE 'ERROR in tool_visualizer.analyser_groups_users : %', SQLERRM;
    END;

    FOR view_groups IN SELECT * FROM tool_analyser.analyser_groups_users JOIN tool_analyser.analyser_groups USING(gr_id)
    	WHERE us_id = user_id ORDER BY gr_id LOOP
        /* notice */
        --RAISE NOTICE 'Group ID %, Name %', view_groups.gr_id, view_groups.name;

		    /* add the new groups returning gr_ig */
		    INSERT INTO tool_analyser.analyser_groups(name, icon, po_id)
						VALUES (view_groups.name, view_groups.icon, view_groups.po_id) RETURNING gr_id INTO mygrid;

        /* notice */
        --RAISE NOTICE 'New group ID %', mygrid;

        /* add the new group into groups_users */
        INSERT INTO tool_analyser.analyser_groups_users(us_id, gr_id) VALUES (new_user_id, mygrid);


        /* stations */
	    	FOR rec_groups_stations IN SELECT * FROM tool_analyser.analyser_groups_stations WHERE gr_id = view_groups.gr_id ORDER BY po_id LOOP

	        /* notice */
	        --RAISE NOTICE 'Station StId %', rec_groups_stations.st_id;

          /* add the new stations into groups_users */
			    INSERT INTO tool_analyser.analyser_groups_stations(gr_id, st_id, po_id)
							VALUES (mygrid, rec_groups_stations.st_id, rec_groups_stations.po_id);

	    	END LOOP;

    END LOOP;

    RETURN true;

/* errors check */
EXCEPTION
  /* still errors */
  WHEN OTHERS THEN
    RAISE NOTICE 'ERROR IN tool_analyser.clone_user_tree : %', SQLERRM ;
    RETURN false;
END;
$$;


ALTER FUNCTION public.clone_user_tree(user_id integer, new_user_id integer) OWNER TO postgres;

--
-- TOC entry 5744 (class 0 OID 0)
-- Dependencies: 839
-- Name: FUNCTION clone_user_tree(user_id integer, new_user_id integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.clone_user_tree(user_id integer, new_user_id integer) IS 'Clone a Analyser user tree';


--
-- TOC entry 840 (class 1255 OID 17106)
-- Name: connectby(text, text, text, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.connectby(text, text, text, text, integer) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'connectby_text';


ALTER FUNCTION public.connectby(text, text, text, text, integer) OWNER TO postgres;

--
-- TOC entry 841 (class 1255 OID 17107)
-- Name: connectby(text, text, text, text, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.connectby(text, text, text, text, integer, text) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'connectby_text';


ALTER FUNCTION public.connectby(text, text, text, text, integer, text) OWNER TO postgres;

--
-- TOC entry 842 (class 1255 OID 17108)
-- Name: connectby(text, text, text, text, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.connectby(text, text, text, text, text, integer) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'connectby_text_serial';


ALTER FUNCTION public.connectby(text, text, text, text, text, integer) OWNER TO postgres;

--
-- TOC entry 843 (class 1255 OID 17109)
-- Name: connectby(text, text, text, text, text, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.connectby(text, text, text, text, text, integer, text) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'connectby_text_serial';


ALTER FUNCTION public.connectby(text, text, text, text, text, integer, text) OWNER TO postgres;

--
-- TOC entry 844 (class 1255 OID 17110)
-- Name: counter(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.counter(integer) RETURNS integer
    LANGUAGE plperl
    AS $_X$
return $_[0] + $_SHARED{counter}++; $_X$;


ALTER FUNCTION public.counter(integer) OWNER TO postgres;

--
-- TOC entry 845 (class 1255 OID 17111)
-- Name: crosstab(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.crosstab(text) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


ALTER FUNCTION public.crosstab(text) OWNER TO postgres;

--
-- TOC entry 846 (class 1255 OID 17112)
-- Name: crosstab(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.crosstab(text, integer) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


ALTER FUNCTION public.crosstab(text, integer) OWNER TO postgres;

--
-- TOC entry 847 (class 1255 OID 17113)
-- Name: crosstab(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.crosstab(text, text) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab_hash';


ALTER FUNCTION public.crosstab(text, text) OWNER TO postgres;

--
-- TOC entry 848 (class 1255 OID 17114)
-- Name: crosstab2(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.crosstab2(text) RETURNS SETOF public.tablefunc_crosstab_2
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


ALTER FUNCTION public.crosstab2(text) OWNER TO postgres;

--
-- TOC entry 849 (class 1255 OID 17115)
-- Name: crosstab3(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.crosstab3(text) RETURNS SETOF public.tablefunc_crosstab_3
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


ALTER FUNCTION public.crosstab3(text) OWNER TO postgres;

--
-- TOC entry 850 (class 1255 OID 17116)
-- Name: crosstab4(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.crosstab4(text) RETURNS SETOF public.tablefunc_crosstab_4
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


ALTER FUNCTION public.crosstab4(text) OWNER TO postgres;

--
-- TOC entry 851 (class 1255 OID 17117)
-- Name: fill_data_table(timestamp without time zone, timestamp without time zone, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fill_data_table(timestamp without time zone, timestamp without time zone, integer, integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
declare
    /* passed variables */
    date_from  timestamp;
    date_to    timestamp;
    station_id integer;
    table_id   integer;
    /* main variables */
    mytbl      text;
    mysql      text;
BEGIN 

    /* get the year */
    date_from  := $1;
    date_to    := $2;
    station_id := $3;
    table_id   := $4;

    /* sample
      SELECT fill_data_table('2008-07-01', '2008-07-01 23:59:59', 4000, 1);
    */

    /* notice */
    RAISE NOTICE 'date_from %, date_to %', date_from ,date_to ;
    RAISE NOTICE 'station_id %, table_id %', station_id ,table_id ;

    /* get the vertical table name taking into account the schema */
    SELECT schema || '.data_' || tableid INTO mytbl FROM _stations WHERE st_id = station_id;
    
    /* notice */
    RAISE NOTICE 'mytbl %', mytbl;
    
    /* loop theough all the hours */
    WHILE date_from < date_to loop

      mysql := 'INSERT INTO ' || mytbl || ' (fulldate, id, meanvalue, code) VALUES ('
	|| quote_literal(date_from) || ', ' || table_id || ', null, 0)';

      /* notice */
      RAISE NOTICE 'SQL : [%]', mysql;

      BEGIN 
        /* execute the update query */
        EXECUTE mysql;
      /* errors check */
      EXCEPTION WHEN UNIQUE_VIOLATION THEN NULL;
        /* notice */
        RAISE NOTICE 'RECORD EXISTS for date %, id %]', date_from, table_id;
      END;
      
      date_from := date_from + '1 HOUR'::INTERVAL;

      /* execute query */
      BEGIN
      
      /* errors check */
      EXCEPTION
        /* in case of any error */
        WHEN OTHERS THEN RAISE NOTICE 'ERROR fill_data_table() : %', SQLERRM ;
      END;

    END loop;
    return true;
END;
$_$;


ALTER FUNCTION public.fill_data_table(timestamp without time zone, timestamp without time zone, integer, integer) OWNER TO postgres;

--
-- TOC entry 5745 (class 0 OID 0)
-- Dependencies: 851
-- Name: FUNCTION fill_data_table(timestamp without time zone, timestamp without time zone, integer, integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.fill_data_table(timestamp without time zone, timestamp without time zone, integer, integer) IS 'Fill a table with null values data';


--
-- TOC entry 836 (class 1255 OID 17118)
-- Name: fillmastertable(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fillmastertable() RETURNS timestamp without time zone
    LANGUAGE plpgsql
    AS $$
declare
    dt_now timestamp;
    dt_last timestamp;
    max_loops INTEGER;
    v INTEGER;
BEGIN
    -- gets the last update
    SELECT fulldate INTO dt_last FROM _master ORDER BY Fulldate DESC LIMIT 1;
    -- gets the gmt - 1 hour date time
    -- http://www.postgresql.org/docs/8.0/static/datetime-keywords.html
    --dt_now := TIMEZONE('utc', CURRENT_TIMESTAMP);
    dt_now := date_trunc('hour',timezone('utc', current_timestamp));
    --RAISE NOTICE 'dt_last %, dt_now %',dt_last ,dt_now ;
    --return dt_now;
    max_loops := 1000;
    v := 0;
    WHILE dt_last < dt_now AND v < max_loops loop
      v := v + 1;
      dt_last := dt_last + '1 HOUR'::INTERVAL;

      /* execute query */
      BEGIN
        insert into _master VALUES (dt_last);
      /* errors check */
      EXCEPTION
      /* in case of any error */
        WHEN OTHERS THEN RAISE NOTICE 'ERROR in fillmastertable';
      END;

    END loop;
    return dt_last;
END;
$$;


ALTER FUNCTION public.fillmastertable() OWNER TO postgres;

--
-- TOC entry 5746 (class 0 OID 0)
-- Dependencies: 836
-- Name: FUNCTION fillmastertable(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.fillmastertable() IS 'Fill the _master table';


--
-- TOC entry 852 (class 1255 OID 17119)
-- Name: fillmastertable_1(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fillmastertable_1() RETURNS timestamp without time zone
    LANGUAGE plpgsql
    AS $$
declare
    dt_now    timestamp;
    dt_last   timestamp;
    max_loops integer;
    v         integer;
BEGIN
    --
    -- select fillmastertable_1();
    --

    -- gets the last update
    SELECT fulldate INTO dt_last FROM _master_1 ORDER BY Fulldate DESC LIMIT 1;
    -- gets the gmt - 1 hour date time
    -- http://www.postgresql.org/docs/8.0/static/datetime-keywords.html
    --dt_now := TIMEZONE('utc', CURRENT_TIMESTAMP);
    dt_now := date_trunc('minute',timezone('utc-1', current_timestamp));
    --RAISE NOTICE 'dt_last %, dt_now %',dt_last ,dt_now ;
    --return dt_now;
    max_loops := 10000;
    v := 0;
    WHILE dt_last < dt_now AND v < max_loops loop
        v := v + 1;
        dt_last := dt_last + '1 MINUTE'::INTERVAL;

        /* execute query */
        BEGIN
            insert into _master_1 VALUES (dt_last);
        /* errors check */
        EXCEPTION
            /* in case of any error */
            WHEN OTHERS THEN RAISE NOTICE 'ERROR in fillmastertable_1 : %', SQLERRM;
        END;

    END loop;
    return dt_last;
END;
$$;


ALTER FUNCTION public.fillmastertable_1() OWNER TO postgres;

--
-- TOC entry 5747 (class 0 OID 0)
-- Dependencies: 852
-- Name: FUNCTION fillmastertable_1(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.fillmastertable_1() IS 'Fill the _master_1 table';


--
-- TOC entry 853 (class 1255 OID 17120)
-- Name: fillmastertable_30(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fillmastertable_30() RETURNS timestamp without time zone
    LANGUAGE plpgsql
    AS $$
declare
    dt_now timestamp;
    dt_last timestamp;
    max_loops INTEGER;
    v INTEGER;
BEGIN
    -- gets the last update
    SELECT fulldate INTO dt_last FROM _master_30 ORDER BY Fulldate DESC LIMIT 1;
    -- gets the gmt - 1 hour date time
    dt_now := TIMEZONE('UTC',CURRENT_TIMESTAMP);
    --dt_now := date_trunc('hour',timezone('utc', current_timestamp));
    --RAISE NOTICE 'dt_now %', dt_now;
    max_loops := 1000;
    v := 0;
    WHILE dt_last < dt_now AND v < max_loops loop
      v := v + 1;
      dt_last := dt_last + '30 MINUTE'::INTERVAL;

      /* execute query */
      BEGIN
        insert into _master_30 VALUES (dt_last);
      /* errors check */
      EXCEPTION
      /* in case of any error */
        WHEN OTHERS THEN RAISE NOTICE 'ERROR in fillmastertable';
      END;

    END loop;
    return dt_last;
END;
$$;


ALTER FUNCTION public.fillmastertable_30() OWNER TO postgres;

--
-- TOC entry 5748 (class 0 OID 0)
-- Dependencies: 853
-- Name: FUNCTION fillmastertable_30(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.fillmastertable_30() IS 'Fill the _master_30 table';


--
-- TOC entry 854 (class 1255 OID 17121)
-- Name: get_counter(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_counter() RETURNS integer
    LANGUAGE plperl IMMUTABLE
    AS $_X$
return $_SHARED{counter}++;
$_X$;


ALTER FUNCTION public.get_counter() OWNER TO postgres;

--
-- TOC entry 855 (class 1255 OID 17122)
-- Name: get_horizontal_tablename(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_horizontal_tablename(integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
declare
    tblid text;
    stprid INTEGER;
BEGIN
    stprid := $1;
    SELECT schema || '.tbl_' || tableid INTO tblid FROM _stations JOIN _stations_parameters USING (st_id) WHERE st_pr_id=stprid;
    RETURN tblid;
/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in get_horizontal_tablename';
END;
$_$;


ALTER FUNCTION public.get_horizontal_tablename(integer) OWNER TO postgres;

--
-- TOC entry 5749 (class 0 OID 0)
-- Dependencies: 855
-- Name: FUNCTION get_horizontal_tablename(integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.get_horizontal_tablename(integer) IS 'Get the horizontal table name upon st_pr_id';


--
-- TOC entry 856 (class 1255 OID 17123)
-- Name: get_horizontal_tablename_by_st_id(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_horizontal_tablename_by_st_id(integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
declare
    tblid text;
    stid INTEGER;
BEGIN
    stid := $1;
    SELECT schema || '.tbl_' || tableid INTO tblid FROM _stations WHERE st_id=stid;
    RETURN tblid;
/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in get_horizontal_tablename_by_st_id : %', SQLERRM;
END;
$_$;


ALTER FUNCTION public.get_horizontal_tablename_by_st_id(integer) OWNER TO postgres;

--
-- TOC entry 5750 (class 0 OID 0)
-- Dependencies: 856
-- Name: FUNCTION get_horizontal_tablename_by_st_id(integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.get_horizontal_tablename_by_st_id(integer) IS 'Get the horizontal table name upon st_id';


--
-- TOC entry 857 (class 1255 OID 17124)
-- Name: get_id_vtable(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_id_vtable(integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
declare
    id_vt  text;
    stprid INTEGER;
BEGIN
    stprid := $1;
    SELECT id INTO id_vt FROM _stations_parameters WHERE st_pr_id = stprid;
    RETURN id_vt;
/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in get_id_vtable';
END;
$_$;


ALTER FUNCTION public.get_id_vtable(integer) OWNER TO postgres;

--
-- TOC entry 5751 (class 0 OID 0)
-- Dependencies: 857
-- Name: FUNCTION get_id_vtable(integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.get_id_vtable(integer) IS 'Get the parameter id upon st_pr_id';


--
-- TOC entry 858 (class 1255 OID 17125)
-- Name: get_id_vtable_by_pr_id(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_id_vtable_by_pr_id(integer, integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
declare
    id_vt  text;
    stid INTEGER;
    prid INTEGER;
BEGIN
    stid := $1;
    prid := $2;
    SELECT id INTO id_vt FROM _stations_parameters WHERE pr_id = prid and st_id = stid;
    RETURN id_vt;
/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in get_id_vtable_by_pr_id';
END;
$_$;


ALTER FUNCTION public.get_id_vtable_by_pr_id(integer, integer) OWNER TO postgres;

--
-- TOC entry 5752 (class 0 OID 0)
-- Dependencies: 858
-- Name: FUNCTION get_id_vtable_by_pr_id(integer, integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.get_id_vtable_by_pr_id(integer, integer) IS 'Get the parameter id upon pr_id';


--
-- TOC entry 859 (class 1255 OID 17126)
-- Name: get_minutes_per_month(date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_minutes_per_month(date) RETURNS numeric
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
declare
    mydate1 date;
    mydate2 timestamp;
    minutes integer;
BEGIN
    /* get passed value */
    mydate1 := $1;
    /*
      SELECT last_day_of_month('2012-02-01'::date); -- http://wiki.postgresql.org/wiki/Date_LastDay
      SELECT get_minutes_per_month('2012-02-01'::date);
    */
    SELECT INTO mydate2 last_day_of_month(mydate1);
    mydate2 := mydate2 + interval '23 hour' + interval '59 minute' + interval '59 second';
    --RAISE NOTICE 'mydate1 : %', mydate1 ;
    --RAISE NOTICE 'mydate2 : %', mydate2 ;

    /* get diff minutes */
    SELECT INTO minutes (EXTRACT(epoch FROM (select mydate2::timestamp - mydate1::timestamp))+1)/60;

    RETURN minutes;

/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR IN get_minutes_per_month() : %', SQLERRM ;
END;
$_$;


ALTER FUNCTION public.get_minutes_per_month(date) OWNER TO postgres;

--
-- TOC entry 5753 (class 0 OID 0)
-- Dependencies: 859
-- Name: FUNCTION get_minutes_per_month(date); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.get_minutes_per_month(date) IS 'Get the number of minutes for the passing year-month';


--
-- TOC entry 860 (class 1255 OID 17127)
-- Name: get_minutes_per_quarter(date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_minutes_per_quarter(date) RETURNS numeric
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
declare
    mydate  date;
    mydate1 date;
    mydate2 timestamp;
    minutes integer;
    quart   integer;
BEGIN
    /* get passed value */
    mydate1 := $1;
    /*
      SELECT last_day_of_month('2012-02-01'::date); -- http://wiki.postgresql.org/wiki/Date_LastDay
      SELECT get_minutes_per_quarter('2012-10-01'::date);
    */
    SELECT INTO quart EXTRACT(QUARTER FROM mydate1);
    --RAISE NOTICE 'quarter : %', quart ;

    IF quart = 1 THEN
        SELECT INTO mydate  (EXTRACT(YEAR FROM mydate1) || '-01-01')::date; -- january
        SELECT INTO mydate2 (EXTRACT(YEAR FROM mydate1) || '-03-31')::date; -- march
    ELSIF quart = 2 THEN
        SELECT INTO mydate  (EXTRACT(YEAR FROM mydate1) || '-04-01')::date; -- april
        SELECT INTO mydate2 (EXTRACT(YEAR FROM mydate1) || '-06-30')::date; -- june
    ELSIF quart = 3 THEN
        SELECT INTO mydate  (EXTRACT(YEAR FROM mydate1) || '-07-01')::date; -- july
        SELECT INTO mydate2 (EXTRACT(YEAR FROM mydate1) || '-09-30')::date; -- september
    ELSIF quart = 4 THEN
        SELECT INTO mydate  (EXTRACT(YEAR FROM mydate1) || '-10-01')::date; -- october
        SELECT INTO mydate2 (EXTRACT(YEAR FROM mydate1) || '-12-31')::date; -- december
    END IF;

    /* adjust */
    mydate1 := mydate;
    mydate2 := mydate2 + interval '23 hour' + interval '59 minute' + interval '59 second';

    /* notice */
    --RAISE NOTICE 'mydate1 : %', mydate1 ;
    --RAISE NOTICE 'mydate2 : %', mydate2 ;

    /* get diff minutes */
    SELECT INTO minutes (EXTRACT(epoch FROM (select mydate2::timestamp - mydate1::timestamp))+1)/60;

    RETURN minutes;

/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR IN get_minutes_per_quarter() : %', SQLERRM ;
END;
$_$;


ALTER FUNCTION public.get_minutes_per_quarter(date) OWNER TO postgres;

--
-- TOC entry 5754 (class 0 OID 0)
-- Dependencies: 860
-- Name: FUNCTION get_minutes_per_quarter(date); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.get_minutes_per_quarter(date) IS 'Get the number of minutes for the passing year-quarter';


--
-- TOC entry 861 (class 1255 OID 17128)
-- Name: get_minutes_per_year(date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_minutes_per_year(date) RETURNS numeric
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
declare
    mydate1 date;
    mydate2 timestamp;
    minutes integer;
BEGIN
    /* get passed value */
    mydate1 := $1;
    /*
      SELECT last_day_of_year('2012-02-01'::date); -- http://wiki.postgresql.org/wiki/Date_LastDay
      SELECT get_minutes_per_year('2012-01-01'::date); select 527040 - 525600
    */
    SELECT INTO mydate2 last_day_of_year(mydate1);
    mydate2 := mydate2 + interval '23 hour' + interval '59 minute' + interval '59 second';
    --RAISE NOTICE 'mydate1 : %', mydate1 ;
    --RAISE NOTICE 'mydate2 : %', mydate2 ;

    /* get diff minutes */
    SELECT INTO minutes (EXTRACT(epoch FROM (select mydate2::timestamp - mydate1::timestamp))+1)/60;

    RETURN minutes;

/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR IN get_minutes_per_year() : %', SQLERRM ;
END;
$_$;


ALTER FUNCTION public.get_minutes_per_year(date) OWNER TO postgres;

--
-- TOC entry 5755 (class 0 OID 0)
-- Dependencies: 861
-- Name: FUNCTION get_minutes_per_year(date); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.get_minutes_per_year(date) IS 'Get the number of minutes for the passing year';


--
-- TOC entry 862 (class 1255 OID 17129)
-- Name: get_parameter_name(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_parameter_name(integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
declare
    prname text;
    stprid INTEGER;
BEGIN
    stprid := $1;
    SELECT name INTO prname FROM _parameters_list JOIN
           _stations_parameters USING (pr_id) WHERE st_pr_id=stprid;
    RETURN prname;
/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in get_station_name';
END;
$_$;


ALTER FUNCTION public.get_parameter_name(integer) OWNER TO postgres;

--
-- TOC entry 5756 (class 0 OID 0)
-- Dependencies: 862
-- Name: FUNCTION get_parameter_name(integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.get_parameter_name(integer) IS 'Get the parameter name based upon st_pr_id';


--
-- TOC entry 863 (class 1255 OID 17130)
-- Name: get_parameter_name_by_pr_id(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_parameter_name_by_pr_id(integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
declare
    prname text;
   prid INTEGER;
BEGIN
    prid := $1;
    SELECT name INTO prname FROM _parameters_list 
           WHERE pr_id=prid;
    RETURN prname;
/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in get_parameter_name_by_pr_id';
END;
$_$;


ALTER FUNCTION public.get_parameter_name_by_pr_id(integer) OWNER TO postgres;

--
-- TOC entry 5757 (class 0 OID 0)
-- Dependencies: 863
-- Name: FUNCTION get_parameter_name_by_pr_id(integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.get_parameter_name_by_pr_id(integer) IS 'Get the parameter name based upon pr_id';


--
-- TOC entry 864 (class 1255 OID 17131)
-- Name: get_pr_id_by_id_vtable(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_pr_id_by_id_vtable(integer, integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
declare
    stid INTEGER;
    vtid INTEGER;
    prid INTEGER;
BEGIN
    stid := $1;
    vtid := $2;
    SELECT pr_id INTO prid FROM _stations_parameters WHERE id = vtid and st_id = stid;
    RETURN prid;
/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in get_pr_id_by_id_vtable';
END;
$_$;


ALTER FUNCTION public.get_pr_id_by_id_vtable(integer, integer) OWNER TO postgres;

--
-- TOC entry 5758 (class 0 OID 0)
-- Dependencies: 864
-- Name: FUNCTION get_pr_id_by_id_vtable(integer, integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.get_pr_id_by_id_vtable(integer, integer) IS 'Get the parameter pr_id upon vtable id';


--
-- TOC entry 865 (class 1255 OID 17132)
-- Name: get_station_id(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_station_id(integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
declare
    stid text;
    stprid INTEGER;
BEGIN
    stprid := $1;
    SELECT st_id INTO stid FROM _stations JOIN _stations_parameters USING (st_id) WHERE st_pr_id=stprid;
    RETURN stid;
/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in get_table_id';
END;
$_$;


ALTER FUNCTION public.get_station_id(integer) OWNER TO postgres;

--
-- TOC entry 5759 (class 0 OID 0)
-- Dependencies: 865
-- Name: FUNCTION get_station_id(integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.get_station_id(integer) IS 'Get the station id upon st_pr_id';


--
-- TOC entry 866 (class 1255 OID 17133)
-- Name: get_station_name(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_station_name(integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
declare
    name text;
    stprid INTEGER;
BEGIN
    stprid := $1;
    SELECT stationname INTO name FROM _stations JOIN _stations_parameters USING (st_id) WHERE st_pr_id=stprid;
    RETURN name;
/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in get_station_name';
END;
$_$;


ALTER FUNCTION public.get_station_name(integer) OWNER TO postgres;

--
-- TOC entry 5760 (class 0 OID 0)
-- Dependencies: 866
-- Name: FUNCTION get_station_name(integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.get_station_name(integer) IS 'Get the station name based upon st_pr_id';


--
-- TOC entry 867 (class 1255 OID 17134)
-- Name: get_stprid(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_stprid(integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
declare
    stid INTEGER;
    prid INTEGER;
    stprid INTEGER;
BEGIN
    stid := $1;
    prid := $2;
    SELECT st_pr_id INTO stprid FROM _stations_parameters WHERE st_id=stid AND pr_id=prid;
    RETURN stprid;
/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in get_stprid';
END;
$_$;


ALTER FUNCTION public.get_stprid(integer, integer) OWNER TO postgres;

--
-- TOC entry 5761 (class 0 OID 0)
-- Dependencies: 867
-- Name: FUNCTION get_stprid(integer, integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.get_stprid(integer, integer) IS 'Get the st_pr_id';


--
-- TOC entry 868 (class 1255 OID 17135)
-- Name: get_tablename_by_st_pr_id(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_tablename_by_st_pr_id(integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
declare
    tblid text;
    stprid INTEGER;
BEGIN
    stprid := $1;
    SELECT tableid INTO tblid FROM _stations JOIN _stations_parameters USING (st_id) WHERE st_pr_id=stprid;
    RETURN tblid;
/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in get_station_name';
END;
$_$;


ALTER FUNCTION public.get_tablename_by_st_pr_id(integer) OWNER TO postgres;

--
-- TOC entry 5762 (class 0 OID 0)
-- Dependencies: 868
-- Name: FUNCTION get_tablename_by_st_pr_id(integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.get_tablename_by_st_pr_id(integer) IS 'Get the table id upon st_pr_id';


--
-- TOC entry 869 (class 1255 OID 17136)
-- Name: get_vertical_tablename(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_vertical_tablename(integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
declare
    tblid text;
    stprid INTEGER;
BEGIN
    stprid := $1;
    SELECT schema || '.data_' || tableid INTO tblid FROM _stations JOIN _stations_parameters USING (st_id) WHERE st_pr_id=stprid;
    RETURN tblid;
/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in get_vertical_tablename';
END;
$_$;


ALTER FUNCTION public.get_vertical_tablename(integer) OWNER TO postgres;

--
-- TOC entry 5763 (class 0 OID 0)
-- Dependencies: 869
-- Name: FUNCTION get_vertical_tablename(integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.get_vertical_tablename(integer) IS 'Get the vertical table name upon st_pr_id';


--
-- TOC entry 870 (class 1255 OID 17137)
-- Name: get_vertical_tablename_by_st_id(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_vertical_tablename_by_st_id(integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
declare
    tblid text;
    stid  INTEGER;
BEGIN
    stid := $1;
    SELECT schema || '.data_' || tableid INTO tblid FROM _stations WHERE st_id=stid;
    RETURN tblid;
/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in get_vertical_tablename_by_st_id : %', SQLERRM;
END;
$_$;


ALTER FUNCTION public.get_vertical_tablename_by_st_id(integer) OWNER TO postgres;

--
-- TOC entry 5764 (class 0 OID 0)
-- Dependencies: 870
-- Name: FUNCTION get_vertical_tablename_by_st_id(integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.get_vertical_tablename_by_st_id(integer) IS 'Get the vertical table name upon st_pr_id';


--
-- TOC entry 871 (class 1255 OID 17138)
-- Name: get_wind_rose_dir_stprid(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_wind_rose_dir_stprid(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
declare
    stprid_speed INTEGER;
    stprid_dir   INTEGER;
BEGIN
    stprid_speed := $1;
    select st_pr_id INTO stprid_dir from _stations_parameters where st_id=(select st_id
     from _stations_parameters where st_pr_id = stprid_speed ) and pr_id=11; -- fixed
    --SELECT st_pr_id INTO stprid FROM _stations_parameters WHERE st_id=stid AND pr_id=prid;
    RETURN stprid_dir;
/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in get_stprid';
END;
$_$;


ALTER FUNCTION public.get_wind_rose_dir_stprid(integer) OWNER TO postgres;

--
-- TOC entry 5765 (class 0 OID 0)
-- Dependencies: 871
-- Name: FUNCTION get_wind_rose_dir_stprid(integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.get_wind_rose_dir_stprid(integer) IS 'Get the wind direction st_pr_id';


--
-- TOC entry 872 (class 1255 OID 17139)
-- Name: granttablesofschema(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.granttablesofschema(username character varying, permissions character varying, schema character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
  regActual   RECORD;
  numTables   INTEGER;
BEGIN

   numTables := 0;

   FOR regActual IN
      SELECT tablename FROM pg_tables WHERE schemaname = schema
   LOOP
      numTables := numTables + 1;

      EXECUTE 'GRANT ' || permissions || ' ON ' || schema || '.' || regActual.tablename || ' TO ' || user;
   END LOOP;

   RETURN 'Tables: ' || numTables::VARCHAR;
END;
$$;


ALTER FUNCTION public.granttablesofschema(username character varying, permissions character varying, schema character varying) OWNER TO postgres;

--
-- TOC entry 873 (class 1255 OID 17140)
-- Name: history(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.history() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  stid smallint;
BEGIN

  /* station id passed by caller */
  stid  := TG_ARGV[0];

  /* Alert */
  /* If all the fields are equals to old skip */
  /* added @ 2009-03-17 */
    IF  NEW.meanvalue != OLD.meanvalue OR
        NEW.code      != OLD.code OR
        NEW.min       != OLD.min OR
        NEW.mintime   != OLD.mintime OR
        NEW.max       != OLD.max OR
        NEW.maxtime   != OLD.maxtime OR
        NEW.readings  != OLD.readings OR
        NEW.stddev    != OLD.stddev OR
        NEW.calccode  != OLD.calccode THEN
	-- continue
--  ELSE
--        ---- skip
--	--RAISE NOTICE 'replicator.exportdata() : RETURN NEW';
--	--RAISE NOTICE '% % ', NEW.fulldate, NEW.id;
--	RETURN NEW;
--  END IF;  
--  IF OLD.meanvalue <> NEW.meanvalue
--  OR  OLD.code     <> NEW.code
--  OR  OLD.min      <> NEW.min
--  OR  OLD.max      <> NEW.max
--  OR  OLD.calccode <> NEW.calccode THEN
  
    --   date_update timestamp without time zone DEFAULT now(),
    --   st_id smallint,
    --   fulldate timestamp without time zone NOT NULL,
    --   id smallint NOT NULL,
    --   meanvalue_old real,
    --   meanvalue_new real,
    --   code_old integer DEFAULT 0,
    --   code_new integer DEFAULT 0,
    --   min_old real,
    --   min_new real,
    --   max_old real,
    --   max_new real,
    --   calccode_old smallint DEFAULT 0,
    --   calccode_new smallint DEFAULT 0
    /* Default value */
    INSERT INTO history_changes VALUES ( default, stid,
           OLD.fulldate,  OLD.id, -- does not change
           OLD.meanvalue, NEW.meanvalue,
           OLD.code, NEW.code,
           OLD.min, NEW.min,
           OLD.max, NEW.max,
           OLD.calccode, NEW.calccode );
  END IF;

  /* Final value */
  RETURN NEW;

  /* errors check */
  EXCEPTION

  /* in case of any error */
  WHEN OTHERS THEN RAISE NOTICE 'ERROR in history';

  /* Final value */
  RETURN NEW;

END;
$$;


ALTER FUNCTION public.history() OWNER TO postgres;

--
-- TOC entry 874 (class 1255 OID 17141)
-- Name: insert(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert(character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
    q_ins   varchar;
    q_del   varchar;
    q_upd   varchar;
    q_bak   varchar;
    tname   varchar; -- table raw_ | data_
    tcame   varchar; -- code table data_
    tshna   varchar; -- needed to find station st_id
    tdate   varchar;
    ttbid   varchar;
    pos     smallint;
    cm_cc   smallint;
BEGIN

    /* get the query */
    q_ins := $1;

    /* get the start position */
    pos := position('(''' in q_ins );
    q_bak := substring( q_ins from 1 for pos -1 );
    q_bak := trim(both ' ' from q_bak);

    /* get the full table name */
    tname := split_part(q_bak, ' ', 3);
    RAISE NOTICE 'tname : %', tname;
    q_bak := substring( q_ins from pos + 1 for char_length(q_ins)-pos-1 );

    /* get the full table name - vertical format */
    tcame := regexp_replace(tname, 'raw\w{0,5}_', 'data_');
    RAISE NOTICE 'tcame : %', tcame;

    /* get the table name without header - vertical format */
    --tshna := substring(tcame FROM '\.(?:data|raw\w{0,5})_(.*)');
    tshna := substring(tcame FROM '\.data_(.*)');
    RAISE NOTICE 'tshna : %', tshna;

    /* get the date */
    tdate := split_part(q_bak, ',', 1);
    RAISE NOTICE 'tdate : %', tdate;

    /* get the table id */
    ttbid := split_part(q_bak, ',', 2);
    RAISE NOTICE 'ttbid : %', ttbid;

    BEGIN

        /* execute the insert query */
        RAISE NOTICE 'QUERY q_ins : %', q_ins;
        EXECUTE q_ins;

    /* errors check */
    EXCEPTION

        WHEN OTHERS THEN
        RAISE NOTICE 'ERROR IN replace : %', SQLERRM ;
        RAISE NOTICE 'QUERY q_del : %', q_del;
        RETURN false;

    END;


    /* if we need to manage calccode */

    /* check for code manager */
    SELECT INTO cm_cc code FROM codemanager c LEFT JOIN _stations s USING(st_id)
        WHERE s.tableid = tshna AND table_id = ttbid::smallint
        AND tdate::timestamp BETWEEN c.date_from AND c.date_to;

    IF FOUND THEN

        /* format dates */
        IF extract('minute' FROM tdate::timestamp) < 30 THEN
            tdate := date_trunc('hour', tdate::timestamp);
        ELSE
            tdate := date_trunc('hour', tdate::timestamp) + interval '30 minute';
        END IF;

        /* get the update query to data_xxxx tables */
        q_upd := 'UPDATE ' || tcame || ' SET calccode = ' || cm_cc ||
            ' WHERE fulldate BETWEEN ' || quote_literal(tdate) || '::timestamp - interval ''30 minutes'' AND ' ||
            quote_literal(tdate) || ' AND id = ' || ttbid;
        RAISE NOTICE 'q_upd : %', q_upd;

        BEGIN

            /* re-execute the insert query */
            EXECUTE q_upd;

        /* errors check */
        EXCEPTION
            /* still errors */
            WHEN OTHERS THEN
                RAISE NOTICE 'ERROR IN replace : %', SQLERRM ;
                RAISE NOTICE 'QUERY q_upd : %', q_upd;
                RETURN false;
        END;

    END IF;

    /* end */
    return true;

END;

$_$;


ALTER FUNCTION public.insert(character varying) OWNER TO postgres;

--
-- TOC entry 5766 (class 0 OID 0)
-- Dependencies: 874
-- Name: FUNCTION insert(character varying); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.insert(character varying) IS 'Insert value taking into account code validation';


--
-- TOC entry 875 (class 1255 OID 17142)
-- Name: insert_ifnotexists(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_ifnotexists(character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
declare
    query varchar;
    q_tst varchar;
    q_bak varchar;
    table varchar;
    tdate varchar;
    tcode varchar;
    pos   smallint;
    c     integer;
BEGIN

	/* get the query */
	query := $1;

	/* get the start position */
	pos := position('(''' in query );
	q_bak := substring( query from 1 for pos -1 );
	q_bak := trim(both ' ' from q_bak);
		
	/* get the table name */
	table := split_part(q_bak,' ',3);
	q_bak := substring( query from pos + 1 for char_length(query)-pos-1 );
		
	/* get the date */
	tdate := split_part(q_bak,',',1);
		
	/* get the code */
	tcode := split_part(q_bak,',',2);
		
	/* get the delete query */
	q_tst := 'SELECT count(*) FROM ' || table || ' WHERE fulldate = ' || tdate || ' AND id = ' || tcode;
	-- RAISE NOTICE 'q_tst : %', q_tst;

	/* execute the test query */
	EXECUTE q_tst INTO c;
	IF c = 1 THEN
		/* do nothing */
		--RAISE NOTICE 'Record found, skipping ...';
		/* return */
		return true;
	ELSE
		/* execute the insert query */
		--RAISE NOTICE 'Inserting record ...';
		EXECUTE query;
		/* return */
		return true;
	END IF;	
    
/* errors check */
EXCEPTION
	/* still errors */
	WHEN OTHERS THEN
		RAISE NOTICE 'ERROR IN insert_ifnotexists : %', SQLERRM ;
		RAISE NOTICE 'QUERY : %', query;
		RETURN false;

END;
$_$;


ALTER FUNCTION public.insert_ifnotexists(character varying) OWNER TO postgres;

--
-- TOC entry 876 (class 1255 OID 17143)
-- Name: isleapyear(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.isleapyear(year integer) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
  SELECT ($1 % 4 = 0) AND (($1 % 100 <> 0) or ($1 % 400 = 0))
$_$;


ALTER FUNCTION public.isleapyear(year integer) OWNER TO postgres;

--
-- TOC entry 877 (class 1255 OID 17144)
-- Name: last_day(date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.last_day(date) RETURNS date
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
  SELECT (date_trunc('MONTH', $1) + INTERVAL '1 MONTH - 1 day')::date;
$_$;


ALTER FUNCTION public.last_day(date) OWNER TO postgres;

--
-- TOC entry 878 (class 1255 OID 17145)
-- Name: last_day(timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.last_day(timestamp without time zone) RETURNS date
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
  SELECT (date_trunc('MONTH', $1) + INTERVAL '1 MONTH - 1 day')::date;
$_$;


ALTER FUNCTION public.last_day(timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 879 (class 1255 OID 17146)
-- Name: last_day_of_month(date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.last_day_of_month(date) RETURNS date
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
  SELECT (date_trunc('MONTH', $1) + INTERVAL '1 MONTH - 1 day')::date;
$_$;


ALTER FUNCTION public.last_day_of_month(date) OWNER TO postgres;

--
-- TOC entry 880 (class 1255 OID 17147)
-- Name: last_day_of_year(date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.last_day_of_year(date) RETURNS date
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
  SELECT (date_trunc('YEAR', $1) + INTERVAL '1 YEAR - 1 day')::date;
$_$;


ALTER FUNCTION public.last_day_of_year(date) OWNER TO postgres;

--
-- TOC entry 881 (class 1255 OID 17148)
-- Name: lastdateofmonth(date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.lastdateofmonth(date) RETURNS date
    LANGUAGE sql
    AS $_$
SELECT CAST(date_trunc('month', $1) + interval '1 month'
- interval '1 day' as date);
$_$;


ALTER FUNCTION public.lastdateofmonth(date) OWNER TO postgres;

--
-- TOC entry 882 (class 1255 OID 17149)
-- Name: normal_rand(integer, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.normal_rand(integer, double precision, double precision) RETURNS SETOF double precision
    LANGUAGE c STRICT
    AS '$libdir/tablefunc', 'normal_rand';


ALTER FUNCTION public.normal_rand(integer, double precision, double precision) OWNER TO postgres;

--
-- TOC entry 883 (class 1255 OID 17150)
-- Name: perl_conter(integer, real, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.perl_conter(integer, real, character) RETURNS real
    LANGUAGE plperlu
    AS $_$
  $myidx = shift;
  $myval = shift;
  $myreset = shift;
  # reset the arry if requested
  if ( $myreset eq 't' ) { @stored_val=(''); }
  # increment the value
  $stored_val[$myidx]  = $stored_val[$myidx] + $myval;
  # return it
  return $stored_val[$myidx];
$_$;


ALTER FUNCTION public.perl_conter(integer, real, character) OWNER TO postgres;

--
-- TOC entry 884 (class 1255 OID 17151)
-- Name: perl_flush(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.perl_flush() RETURNS integer
    LANGUAGE plperlu
    AS $$
  @stored_sl_val=(''); 
  @stored_sl_cnt=('');
  return 1;
$$;


ALTER FUNCTION public.perl_flush() OWNER TO postgres;

--
-- TOC entry 885 (class 1255 OID 17152)
-- Name: perl_running_total(integer, real, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.perl_running_total(integer, real, character) RETURNS real
    LANGUAGE plperlu
    AS $_$
#BEGIN { strict->import(); }
  # perl_running_total( array_id, value, reset/cumulate )
  # reset
  # select perl_running_total(0,0,'t'); -- reset
  #

  # get values
  my ($myidx, $myval, $myreset) = @_;

  # reset the arry if requested
  if ( $myreset eq 't' ) {
    @stored_val=();
    return 0;
  }

  # increment the value
  $stored_val[$myidx]  = $stored_val[$myidx] + $myval;

  # return it
  return $stored_val[$myidx];

$_$;


ALTER FUNCTION public.perl_running_total(integer, real, character) OWNER TO postgres;

--
-- TOC entry 5767 (class 0 OID 0)
-- Dependencies: 885
-- Name: FUNCTION perl_running_total(integer, real, character); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.perl_running_total(integer, real, character) IS 'Calculate cumulative values';


--
-- TOC entry 886 (class 1255 OID 17153)
-- Name: perl_sliding_mean(integer, real, integer, integer, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.perl_sliding_mean(integer, real, integer, integer, character) RETURNS real
    LANGUAGE plperlu
    AS $_X$
#BEGIN { strict->import(); }
  # perl_sliding_mean( array_id, value, slid_count, slid_min_no, reset/sliding )
  # reset
  # select perl_sliding_mean(0,0,0,0,'t'); -- reset
  #
  # references
  # http://www.linuxjournal.com/article/6540

  #elog(NOTICE, "perl_sliding_mean => ENTER ROUTINE");

  # get values
  my ($myid, $myval, $mycount, $myvalid, $myreset) = @_;
  #my @stored_arr; # cannot be declared as my otherwise reset the array

  # reset the arry if requested
  if ( $myreset eq 't' ) {
    # log log log log log log
    #elog(NOTICE, "perl_sliding_mean => reset" );
    @stored_sl_val=();
    @stored_arr=();
    #elog(NOTICE, "perl_sliding_mean => scalar stored_sl_val " . scalar @stored_sl_val );
    #elog(NOTICE, "perl_sliding_mean => scalar stored_arr " . scalar @stored_arr );
    return 0;
  }

  # restore the array of array
  @temp_sl_val = $stored_arr[$myid];
  @stored_sl_val = @{$temp_sl_val[0]};
  #elog(NOTICE, "perl_sliding_mean => scalar stored_sl_val " . scalar @stored_sl_val );

  # check if the value is null
  if ( ! $myval ) {
    # log log log log log log
    #elog(NOTICE, "perl_sliding_mean => push null value 0" );
    # sum does not change
    push(@stored_sl_val, 0);
  } else {
    # log log log log log log
    #elog(NOTICE, "perl_sliding_mean => push value $myval" );
    # assign the new value
    push(@stored_sl_val, $myval);
  }

  # log log log log log log
  #elog(NOTICE, "perl_sliding_mean => scalar array " . scalar @stored_sl_val );
  if ( ( scalar @stored_sl_val ) > $mycount ) {
	# log log log log log log
	#elog(NOTICE, "perl_sliding_mean => pop element" );
	# Remove one element from the beginning of the array.
	shift(@stored_sl_val);
  }

  # getting mean
  # log log log log log log
  #elog(NOTICE, "perl_sliding_mean => getting mean" );
  my $good_values;
  my $result;
  foreach (@stored_sl_val) {
	# log log log log log log
	#elog(NOTICE, "arr : " . $_ );
	$result += $_;
	if ( $_ != 0 ) { $good_values ++ }
  }

  # log log log log log log
  #elog(NOTICE, "perl_sliding_mean => sum : $result, good values : $good_values" );
  my $mean;
  if ( $good_values >= $myvalid ) {
    $mean = $result / $good_values;
  } else {
    # log log log log log log
    #elog(NOTICE, "perl_sliding_mean => good_values < myvalid" );
    $mean = -99999999; # skip later and return null
  }

  # save back the array of array
  #elog(NOTICE, "perl_sliding_mean => scalar stored_sl_val " . scalar @stored_sl_val );
  $stored_arr[$myid] = [ @stored_sl_val ];

  # return calculated sliding mean or null
  if ( $mean == -99999999 ) { return; }
  return $mean;

$_X$;


ALTER FUNCTION public.perl_sliding_mean(integer, real, integer, integer, character) OWNER TO postgres;

--
-- TOC entry 5768 (class 0 OID 0)
-- Dependencies: 886
-- Name: FUNCTION perl_sliding_mean(integer, real, integer, integer, character); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.perl_sliding_mean(integer, real, integer, integer, character) IS 'Calculate sliding means';


--
-- TOC entry 887 (class 1255 OID 17154)
-- Name: perl_sliding_mean(integer, real, integer, integer, character, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.perl_sliding_mean(integer, real, integer, integer, character, character) RETURNS real
    LANGUAGE plperlu
    AS $_X$
#BEGIN { strict->import(); }
  # perl_sliding_mean( array_id, value, slid_count, slid_min_no, avg/sum, reset/sliding )
  # reset
  # select perl_sliding_mean(0,0,0,0,'f','t'); -- reset
  #
  # references
  # http://www.linuxjournal.com/article/6540

  #elog(NOTICE, "perl_sliding_mean => ENTER ROUTINE");

  # get values
  my ($myid, $myval, $mycount, $myvalid, $myslidesum, $myreset) = @_;
  #my @stored_arr; # cannot be declared as my otherwise reset the array

  # reset the arry if requested
  if ( $myreset eq 't' ) {
    # log log log log log log
    #elog(NOTICE, "perl_sliding_mean => reset" );
    @stored_sl_val=();
    @stored_arr=();
    #elog(NOTICE, "perl_sliding_mean => scalar stored_sl_val " . scalar @stored_sl_val );
    #elog(NOTICE, "perl_sliding_mean => scalar stored_arr " . scalar @stored_arr );
    return 0;
  }

  # restore the array of array
  @temp_sl_val = $stored_arr[$myid];
  @stored_sl_val = @{$temp_sl_val[0]};
  #elog(NOTICE, "perl_sliding_mean => scalar stored_sl_val " . scalar @stored_sl_val );

  # check if the value is null
  if ( ! defined $myval ) {
    # log log log log log log
    #elog(NOTICE, "perl_sliding_mean => push null value [undef]" );
    # sum does not change
    push(@stored_sl_val, undef);
  } else {
    # log log log log log log
    #elog(NOTICE, "perl_sliding_mean => push value $myval" );
    # assign the new value
    push(@stored_sl_val, $myval);
  }

  # log log log log log log
  #elog(NOTICE, "perl_sliding_mean => scalar array " . scalar @stored_sl_val );
  if ( ( scalar @stored_sl_val ) > $mycount ) {
  # log log log log log log
  #elog(NOTICE, "perl_sliding_mean => pop element" );
  # Remove one element from the beginning of the array.
  shift(@stored_sl_val);
  }

  # getting mean
  # log log log log log log
  #elog(NOTICE, "perl_sliding_mean => getting mean" );
  my $good_values;
  my $result;
  foreach (@stored_sl_val) {
  # log log log log log log
  #elog(NOTICE, "arr : " . $_ );
  if ( defined $_ ) {
    $result += $_;
    $good_values ++;
  }
  }

  # log log log log log log
  #elog(NOTICE, "perl_sliding_mean => sum : $result, good values : $good_values" );
  my $mean;
  if ( $good_values >= $myvalid ) {
    # reset the arry if requested
    if ( $myslidesum eq 't' ) {
      $mean = $result; # sum
    } else {
      $mean = $result / $good_values; # average
    }
  } else {
    # log log log log log log
    #elog(NOTICE, "perl_sliding_mean => good_values < myvalid" );
    $mean = -99999999; # skip later and return null
  }

  # save back the array of array
  #elog(NOTICE, "perl_sliding_mean => scalar stored_sl_val " . scalar @stored_sl_val );
  $stored_arr[$myid] = [ @stored_sl_val ];

  # return calculated sliding mean or null
  if ( $mean == -99999999 ) { return; }
  return $mean;

$_X$;


ALTER FUNCTION public.perl_sliding_mean(integer, real, integer, integer, character, character) OWNER TO postgres;

--
-- TOC entry 5769 (class 0 OID 0)
-- Dependencies: 887
-- Name: FUNCTION perl_sliding_mean(integer, real, integer, integer, character, character); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.perl_sliding_mean(integer, real, integer, integer, character, character) IS 'Calculate sliding means/sums';


--
-- TOC entry 888 (class 1255 OID 17155)
-- Name: perl_sliding_mean3(real, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.perl_sliding_mean3(real, character) RETURNS real
    LANGUAGE plperlu
    AS $_$
  #$myidx = shift;
  $myval = shift;
  $myreset = shift;
  # reset the arry if requested
  # if ( $myreset eq 't' ) { @stored_sl_val=(''); @stored_sl_cnt=('');}
  # increment the counter
  $stored_sl_cnt[999]  = $stored_sl_cnt[999] + 1;
  # increment the value
  if ($stored_sl_cnt[999] eq 9) { @stored_sl_cnt[999]= 1;}
  $stored_sl_val[$stored_sl_cnt[999]]=$myval;
  #calcolo media
 $media = ($stored_sl_val[1]+$stored_sl_val[2]+$stored_sl_val[3]+$stored_sl_val[4]+$stored_sl_val[5]+$stored_sl_val[6]+$stored_sl_val[7]+$stored_sl_val[8])/8;
  return $media;
#return $stored_sl_cnt[999];
$_$;


ALTER FUNCTION public.perl_sliding_mean3(real, character) OWNER TO postgres;

--
-- TOC entry 889 (class 1255 OID 17156)
-- Name: pull_from_file(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.pull_from_file(text) RETURNS bytea
    LANGUAGE plperlu
    AS $_$
  my ($file)=@_; 
  return `cat $file`; 
$_$;


ALTER FUNCTION public.pull_from_file(text) OWNER TO postgres;

--
-- TOC entry 890 (class 1255 OID 17157)
-- Name: r2v_stations(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.r2v_stations() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    /* static values */
    phono_prid integer = 32;
    /* main variables */
    get_diag             integer;
    stid                 integer;
    myprid               integer;
    mytbl                varchar;
    myquery              varchar;
    hh                   integer;
    dt                   timestamp;
    myrec                record;
    myval                real;
    mycod                integer;
    myd1                 varchar;
    myd2                 varchar;
    bdone                boolean;
    --myminutes_char varchar;
    myminutes            integer;
    dt_ref               timestamp;
BEGIN

    /* station st_id passed by caller */
    stid  := TG_ARGV[0];

    /* get the pr_id */
    SELECT INTO myprid pr_id FROM _stations_parameters WHERE st_id = stid AND id = NEW.id;
    --RAISE NOTICE 'id % - prid % ', new.id, myprid;

    /* get the table name taking into account the schema */
    -- not , 'g' greedy
    SELECT INTO mytbl TG_TABLE_SCHEMA || '.' || regexp_replace(TG_TABLE_NAME, 'raw_', 'data_');

    /* get the minutes */
    SELECT INTO myminutes date_part('minute', NEW.fulldate);
    --RAISE NOTICE 'fulldate %, myminutes % ', NEW.fulldate, myminutes;

    /* choose the aggregation span time */
    myd1 = to_char(NEW.fulldate, 'YYYY-MM-DD HH24:00:00');
    myd2 = to_char(NEW.fulldate, 'YYYY-MM-DD HH24:59:59');

    /* store the flat hour for the insert */
    dt := myd1;
    -- RAISE NOTICE 'myd1: % myd2: %', myd1, myd2;

    /* query */
    myquery := 'SELECT CAST(ROUND(CAST(Avg(CASE WHEN ' || NEW.id
        || ' = Id THEN meanvalue END)AS NUMERIC), 2) AS REAL) AS val, '
        || 'Max(CASE WHEN ' || NEW.id || ' = Id THEN code  END) AS cod '
        || 'FROM ' || TG_TABLE_SCHEMA || '.' || TG_TABLE_NAME || ' '
        || 'WHERE fulldate >= ''' || myd1 || ''' AND fulldate < ''' || myd2 || ''' ';
    --RAISE NOTICE 'SELECT myquery : % ', myquery;

    /* parameter properties */
    EXECUTE myquery INTO myval, mycod;
    --RAISE NOTICE 'myval: % mycod: %', myval, mycod;

    /* check for null values */
    IF myval IS NULL THEN
        -- RAISE NOTICE 'SELECT myquery : % ', myquery;
        RAISE NOTICE 'The myval IS NULL @ %!', NEW.fulldate;
        RETURN NEW; /* return value */
    END IF;

    /* update the existing row */
    myquery := 'UPDATE ' || mytbl || ' SET meanvalue = '
        || myval || ', code = ' || mycod
        || ' WHERE fulldate = ' || quote_literal(dt)
        || ' AND id = ' || NEW.id;

    /* execute the update query */
    --RAISE NOTICE 'UPDATING raw TABLE [%]', myquery;
    EXECUTE myquery;

    GET DIAGNOSTICS get_diag = ROW_COUNT;
    --RAISE NOTICE 'GET DIAGNOSTICS get_diag [%]', get_diag;

    /* check if a row has benn updated */
    IF get_diag = 0 THEN

        /* we insert the new row in the vertical database */
        myquery := 'INSERT INTO ' || mytbl || ' '
            || '(fulldate, id, meanvalue, code ) VALUES ('
            || quote_literal(dt) || ', ' || NEW.id || ', ' || myval
            || ',  ' || mycod || ')';
        --RAISE NOTICE 'INSERTING data [%]', myquery;

        /* execute the insert query */
        EXECUTE myquery;

    END IF;

    /* return value */
    RETURN NEW;

    /* errors check */
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'OTHERS ERROR in r2v_stations: %', myquery;
        RAISE NOTICE 'ERROR GENERAL r2v_stations() : %', SQLERRM ;
        RETURN NEW; /* return value */
END;
$$;


ALTER FUNCTION public.r2v_stations() OWNER TO postgres;

--
-- TOC entry 891 (class 1255 OID 17158)
-- Name: replace(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.replace(character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
    q_ins   varchar;
    q_del   varchar;
    q_upd   varchar;
    q_bak   varchar;
    tname   varchar; -- table raw_ | data_
    tcame   varchar; -- code table data_
    tshna   varchar; -- needed to find station st_id
    tdate   varchar;
    ttbid   varchar;
    pos     smallint;
    cm_cc   smallint;
BEGIN

    /* get the query */
    q_ins := $1;

    /* get the start position */
    pos := position('(''' in q_ins );
    q_bak := substring( q_ins from 1 for pos -1 );
    q_bak := trim(both ' ' from q_bak);

    /* get the full table name */
    tname := split_part(q_bak, ' ', 3);
    --RAISE NOTICE 'tname : %', tname;
    q_bak := substring( q_ins from pos + 1 for char_length(q_ins)-pos-1 );

    /* get the full table name - vertical format */
    tcame := regexp_replace(tname, E'raw\w{0,5}_', 'data_');
    --RAISE NOTICE 'tcame : %', tcame;

    /* get the table name without header - vertical format */
    --tshna := substring(tcame FROM '\.(?:data|raw\w{0,5})_(.*)');
    tshna := substring(tcame FROM E'\.data_(.*)');
    --RAISE NOTICE 'tshna : %', tshna;

    /* get the date */
    tdate := split_part(q_bak, ',', 1);
    --RAISE NOTICE 'tdate : %', tdate;

    /* get the table id */
    ttbid := split_part(q_bak, ',', 2);
    --RAISE NOTICE 'ttbid : %', ttbid;

    BEGIN

        /* execute the insert query */
        --RAISE NOTICE 'QUERY q_ins : %', q_ins;
        EXECUTE q_ins;

    /* errors check */
    EXCEPTION

        /* in case of duplicate key error we update */
        WHEN UNIQUE_VIOLATION THEN NULL;

        /* get the delete query */
        q_del := 'DELETE FROM ' || tname || ' WHERE fulldate = ' || tdate || ' AND id = ' || ttbid;
        --RAISE NOTICE 'QUERY q_del : %', q_del;

        BEGIN
            /* execute the delete query */
            EXECUTE q_del;

            BEGIN
                /* re-execute the insert query */
                EXECUTE q_ins;

            /* errors check */
            EXCEPTION
                /* still errors */
                WHEN OTHERS THEN
                    RAISE NOTICE 'ERROR IN replace : %', SQLERRM ;
                    RAISE NOTICE 'QUERY q_ins : %', q_ins;
                    RETURN false;
            END;

        /* errors check */
        EXCEPTION
                /* still errors */
                WHEN OTHERS THEN
                RAISE NOTICE 'ERROR IN replace : %', SQLERRM ;
                RAISE NOTICE 'QUERY q_del : %', q_del;
                RETURN false;
        END;

    END;

    /* check for code manager */
    SELECT INTO cm_cc code FROM codemanager c LEFT JOIN _stations s USING(st_id)
        WHERE s.tableid = tshna AND table_id = ttbid::smallint AND
        tdate::timestamp BETWEEN c.date_from AND c.date_to;

    IF FOUND THEN

        /* format dates */
        IF extract('minute' FROM tdate::timestamp) < 30 THEN
            tdate := date_trunc('hour', tdate::timestamp);
        ELSE
            tdate := date_trunc('hour', tdate::timestamp) + interval '30 minute';
        END IF;

        /* get the update query for 1 hour inteval time to data_xxxx tables */
        q_upd := 'UPDATE ' || tcame || ' SET calccode = ' || cm_cc ||
            ' WHERE fulldate BETWEEN ' || quote_literal(tdate) || '::timestamp - interval ''30 minutes'' AND ' ||
            quote_literal(tdate) || ' AND id = ' || ttbid;
        --RAISE NOTICE 'q_upd : %', q_upd;

        BEGIN

            /* re-execute the insert query */
            EXECUTE q_upd;

        /* errors check */
        EXCEPTION
            /* still errors */
            WHEN OTHERS THEN
                RAISE NOTICE 'ERROR IN replace : %', SQLERRM ;
                RAISE NOTICE 'QUERY q_upd : %', q_upd;
                RETURN false;
        END;

    END IF;

    /* end */
    return true;

END;

$_$;


ALTER FUNCTION public.replace(character varying) OWNER TO postgres;

--
-- TOC entry 5770 (class 0 OID 0)
-- Dependencies: 891
-- Name: FUNCTION replace(character varying); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.replace(character varying) IS 'Replace an existing value taking into account code validation';


--
-- TOC entry 892 (class 1255 OID 17159)
-- Name: replace_old(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.replace_old(character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
declare
    query varchar;
    q_del varchar;
    q_bak varchar;
    table varchar;
    tdate varchar;
    tcode varchar;
    pos   smallint;
BEGIN
    query := $1;
    /* execute the insert query */
    EXECUTE query;
    return true;

/* errors check */
EXCEPTION
    /* in case of duplicate key error we update */
    WHEN UNIQUE_VIOLATION THEN NULL;

      /* get the start position */
      pos := position('(''' in query );
      q_bak := substring( query from 1 for pos -1 );
      q_bak := trim(both ' ' from q_bak);
      /* get the table name */
      table := split_part(q_bak,' ',3);
      q_bak := substring( query from pos + 1 for char_length(query)-pos-1 );
      /* get the date */
      tdate := split_part(q_bak,',',1);
      /* get the code */
      tcode := split_part(q_bak,',',2);
      /* get the delete query */
      q_del := 'DELETE FROM ' || table || ' WHERE fulldate = '
          || tdate || ' AND id = ' || tcode;

      BEGIN
        /* execute the delete query */
        EXECUTE q_del;

        BEGIN
          /* re-execute the insert query */
          EXECUTE query;
          return true;

        /* errors check */
        EXCEPTION
          /* still errors */
          WHEN OTHERS THEN RAISE NOTICE 'ERROR in replace %', q_del;
            return false;
        END;

      /* errors check */
      EXCEPTION
        /* still errors */
        WHEN OTHERS THEN RAISE NOTICE 'ERROR in replace %', query;
          return false;
      END;

END;
$_$;


ALTER FUNCTION public.replace_old(character varying) OWNER TO postgres;

--
-- TOC entry 893 (class 1255 OID 17160)
-- Name: test(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.test(integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
	stprid alias for $1;
	counter integer;
BEGIN
    SELECT count(*) into counter from _stations_parameters where st_pr_id=stprid;
    IF counter = 1 THEN
	RETURN true;
    ELSE
	RETURN false;
    END IF;
END;
$_$;


ALTER FUNCTION public.test(integer) OWNER TO postgres;

--
-- TOC entry 894 (class 1255 OID 17161)
-- Name: trg_handle_timestamp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trg_handle_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    --
    -- when updating calcode updated time_stamp field as well
    --

    --
    -- this allow to update time_stamp field
    --
    IF NEW.time_stamp = OLD.time_stamp THEN 
	NEW.time_stamp := now(); 
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.trg_handle_timestamp() OWNER TO postgres;

--
-- TOC entry 895 (class 1255 OID 17162)
-- Name: update_calccode_stprid_fulldate(smallint, timestamp without time zone, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_calccode_stprid_fulldate(smallint, timestamp without time zone, smallint) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
declare
    stprid  ALIAS FOR $1;
    refdate ALIAS FOR $2;
    code    ALIAS FOR $3;
    --
    stid      smallint;
    tblid     smallint;
    rowcount  integer;
    tablename text;
    query     text;
BEGIN

    -- TEST
    -- SELECT update_calccode_stprid_fulldate(894::smallint, '2016-01-17 00:00:00'::timestamp, 64::smallint);

    -- debug
    --RAISE NOTICE 'stprid : %', stprid;
    --RAISE NOTICE 'refdate : %', refdate;
    --RAISE NOTICE 'code : %', code;

    -- get st_id from stprid
    SELECT st_id, id INTO stid, tblid FROM _stations_parameters_master WHERE st_pr_id = stprid;
    IF NOT FOUND THEN
        RETURN null;
    END IF;
    RAISE NOTICE 'stid : %', stid;
    --RAISE NOTICE 'tblid : %', tblid;

    -- get the horizontal table name
    SELECT schema || '.data_' || tableid INTO tablename FROM _stations WHERE st_id = stid;
    IF NOT FOUND THEN
        RETURN null;
    END IF;
    --RAISE NOTICE 'tablename : %', tablename;

    -- update query
    query := 'UPDATE ' || tablename || ' SET '
        || ' calccode = ' || code
        || ' WHERE fulldate = ''' || refdate || ''''
        || ' AND id = ' || tblid;
    --RAISE NOTICE 'query : %', query;

    EXECUTE query;
    --EXECUTE format('UPDATE ' || quote_ident(tablename) || ' SET calccode = $1 WHERE fulldate = $2 AND id = $3') USING code, refdate, tblid;

    -- check
    GET DIAGNOSTICS rowcount = ROW_COUNT;
    --RAISE NOTICE 'rowcount : %', rowcount;

    -- return
    RETURN rowcount > 0;

/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in update_calccode_stprid_fulldate: %', SQLERRM;
   RETURN false;
END;
$_$;


ALTER FUNCTION public.update_calccode_stprid_fulldate(smallint, timestamp without time zone, smallint) OWNER TO postgres;

--
-- TOC entry 5771 (class 0 OID 0)
-- Dependencies: 895
-- Name: FUNCTION update_calccode_stprid_fulldate(smallint, timestamp without time zone, smallint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.update_calccode_stprid_fulldate(smallint, timestamp without time zone, smallint) IS 'Update calccode by st_pr_id and fulldate';


--
-- TOC entry 896 (class 1255 OID 17163)
-- Name: user_delete(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.user_delete(user_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
  user_name varchar;
BEGIN

    /* get the user name */
    SELECT INTO user_name username FROM _users WHERE us_id = user_id;
    IF FOUND THEN

     /* notice */
      RAISE NOTICE 'Deleting user %', user_name;

      /* _users_logins */
      BEGIN
        RAISE NOTICE 'Deleting from table _users_logins ...';
        DELETE FROM _users_logins WHERE us_id = user_id;
      EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE '_users_logins DOES NOT EXISTS';
      END;

      /* _users_parameters */
      BEGIN
          RAISE NOTICE 'Deleting from table _users_parameters ...';
          DELETE FROM _users_parameters WHERE us_id = user_id;
      EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE '_users_parameters DOES NOT EXISTS';
      END;

      /* _users_stations */
      BEGIN
          RAISE NOTICE 'Deleting from table _users_stations ...';
          DELETE FROM _users_stations WHERE us_id = user_id;
      EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE '_users_stations DOES NOT EXISTS';
      END;


      /* tool_analyser.users_settings */
      BEGIN
          RAISE NOTICE 'Deleting from table tool_analyser.users_settings ...';
          DELETE FROM tool_analyser.users_settings WHERE us_id = user_id;
      EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'tool_analyser.users_settings DOES NOT EXISTS';
      END;

      /* tool_analyser.users_settings_colors */
      BEGIN
          RAISE NOTICE 'Deleting from table tool_analyser.users_settings_colors ...';
          DELETE FROM tool_analyser.users_settings_colors WHERE us_id = user_id;
      EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'tool_analyser.users_settings_colors DOES NOT EXISTS';
      END;

      /* tool_analyser.macros_groups (macro) */
      BEGIN
          RAISE NOTICE 'Deleting from table tool_analyser.macros_groups ...';
          DELETE FROM tool_analyser.macros_groups WHERE gr_id IN (
          	SELECT gr_id FROM tool_analyser.macros_groups_users WHERE us_id = user_id
          );
      EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'tool_analyser.macros_groups DOES NOT EXISTS';
      END;

      /* tool_analyser.analyser_groups (tree) */
      BEGIN
          RAISE NOTICE 'Deleting from table tool_analyser.analyser_groups ...';
          DELETE FROM tool_analyser.analyser_groups WHERE gr_id IN (
          	SELECT gr_id FROM tool_analyser.analyser_groups_users WHERE us_id = user_id
          );
      EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'tool_analyser.analyser_groups DOES NOT EXISTS';
      END;

      /* tool_analyser.chart_quota_sets */
      BEGIN
          RAISE NOTICE 'Deleting from table tool_analyser.chart_quota_sets ...';
          DELETE FROM tool_analyser.chart_quota_sets WHERE se_id IN (
          	SELECT se_id FROM tool_analyser.chart_quota_users WHERE us_id = user_id
          );
      EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'tool_analyser.chart_quota_sets DOES NOT EXISTS';
      END;



      /* tool_visualizer.users_settings */
      BEGIN
          RAISE NOTICE 'Deleting from table tool_visualizer.users_settings ...';
          DELETE FROM tool_visualizer.users_settings WHERE us_id = user_id;
      EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'tool_visualizer.users_settings DOES NOT EXISTS';
      END;

      /* tool_visualizer.pages_groups */
      BEGIN
          RAISE NOTICE 'Deleting from table tool_visualizer.pages_groups ...';
          DELETE FROM tool_visualizer.pages_groups WHERE gr_id IN (
          	SELECT gr_id FROM tool_visualizer.pages_groups_users WHERE us_id = user_id
          );
      EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'tool_analyser.analyser_groups DOES NOT EXISTS';
      END;

      /* labanalysis.users_laboratory_analysis */
      BEGIN
          RAISE NOTICE 'Deleting from table users_laboratory_analysis ...';
          DELETE FROM labanalysis.users_laboratory_analysis WHERE us_id = user_id;
      EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'labanalysis.users_laboratory_analysis DOES NOT EXISTS';
      END;


      /* _users [last one] */
      BEGIN
          RAISE NOTICE 'Deleting from table _users ...';
          DELETE FROM _users WHERE us_id = user_id;
      EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE '_users DOES NOT EXISTS';
      END;

    ELSE
      RAISE NOTICE 'No user found !';
    END IF;

    RETURN true;

/* errors check */
EXCEPTION
  /* still errors */
  WHEN OTHERS THEN
    RAISE NOTICE 'ERROR IN user_delete : %', SQLERRM ;
    RAISE NOTICE 'QUERY : %', query;
    RETURN false;
END;
$$;


ALTER FUNCTION public.user_delete(user_id integer) OWNER TO postgres;

--
-- TOC entry 5772 (class 0 OID 0)
-- Dependencies: 896
-- Name: FUNCTION user_delete(user_id integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.user_delete(user_id integer) IS 'Delete a user from the database';


--
-- TOC entry 897 (class 1255 OID 17164)
-- Name: users_logins(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.users_logins() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

  /* Insert a new row */
  INSERT INTO _users_logins VALUES ( default, NEW.us_id, NEW.userlastlogin );

  /* Final value */
  RETURN NEW;

  /* errors check */
  EXCEPTION

  /* in case of any error */
  WHEN OTHERS THEN RAISE NOTICE 'ERROR in users_logins';

  /* Final value */
  RETURN NEW;

END;
$$;


ALTER FUNCTION public.users_logins() OWNER TO postgres;

--
-- TOC entry 5773 (class 0 OID 0)
-- Dependencies: 897
-- Name: FUNCTION users_logins(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.users_logins() IS 'Save user logins history';


--
-- TOC entry 898 (class 1255 OID 17165)
-- Name: v2h_30mins_stations_minmax(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.v2h_30mins_stations_minmax() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  /* static values */
  tamb_prid integer = 1;
  urel_prid integer = 2;
  pbar_prid integer = 3;
  inso_prid integer = 4;
  prec_prid integer = 7;
  radi_prid integer = 5;
  neve_prid integer = 8;
  idro_prid integer = 9;
  vvel_prid integer = 10;
  vdir_prid integer = 11;
  temp_snow_from_prid integer = 50;
  temp_snow_to_prid integer   = 70;
  /* main variables */
  myrec        record;
  stid         integer;
  mytbl        varchar;
  myprid       integer;
  myid_min     integer;
  myid_max     integer;
  myquery      varchar;
  get_diag     integer;
  my_cod       varchar;
  my_val       varchar;
  my_min       varchar;
  my_max       varchar;
  my_cod_min   varchar;
  my_cod_max   varchar;
  /* integration */
  mydt varchar;
  myd1 varchar;
  myd2 varchar;
BEGIN
  -- TRIGGER AFTER INSERT OR UPDATE
  --RAISE NOTICE 'ENTERING v2h_30mins_stations_minmax() ...';

  /* station id passed by caller */
  stid  := TG_ARGV[0];

  /* get the pr_id */
  SELECT INTO myprid pr_id FROM _stations_parameters WHERE st_id = stid AND id = NEW.id;
  IF NOT FOUND THEN
    --RAISE EXCEPTION 'id % not found', NEW.id;
    RETURN NEW;
  END IF;
  --RAISE NOTICE 'stid: % myprid: %', stid, myprid;

  /* get the table name taking into account the schema */
  SELECT INTO mytbl TG_TABLE_SCHEMA || '.' || regexp_replace(TG_TABLE_NAME, 'data_', 'tbl_'); -- not , 'g' greedy

  /* get the min and max ids
    500;"Temperatura min"
    501;"Temperatura max"
    502;"Umidità min"
    503;"Umidità max"
    504;"Pressione min"
    505;"Pressione max"
    506;"Velocità vento max"
    507;"Direzione vento max"
  */
  IF myprid = tamb_prid  THEN   /* temp */
    SELECT INTO myid_min id FROM _stations_parameters WHERE st_id = stid AND pr_id = 500;
    SELECT INTO myid_max id FROM _stations_parameters WHERE st_id = stid AND pr_id = 501;
  ELSIF myprid = urel_prid THEN  /* umid */
    SELECT INTO myid_min id FROM _stations_parameters WHERE st_id = stid AND pr_id = 502;
    SELECT INTO myid_max id FROM _stations_parameters WHERE st_id = stid AND pr_id = 503;
  ELSIF myprid = pbar_prid THEN  /* press */
    SELECT INTO myid_min id FROM _stations_parameters WHERE st_id = stid AND pr_id = 504;
    SELECT INTO myid_max id FROM _stations_parameters WHERE st_id = stid AND pr_id = 505;
  ELSIF myprid = vvel_prid THEN  /* velv */
    SELECT INTO myid_max id FROM _stations_parameters WHERE st_id = stid AND pr_id = 506;
  ELSIF myprid = vdir_prid THEN  /* dirv */
    SELECT INTO myid_max id FROM _stations_parameters WHERE st_id = stid AND pr_id = 507;
  END IF;

  /* build the dates */
  --myd1 = date_trunc('hour', NEW.fulldate);
  myd1 = to_char(NEW.fulldate, 'YYYY-MM-DD HH24:00:00'); -- || ':00:00';
  myd2 = to_char(NEW.fulldate, 'YYYY-MM-DD HH24:59:59'); -- || ':59:59';
  mydt := myd1; /* get the flat hour for the insert */
  --RAISE NOTICE 'myd1: % myd2: %', myd1, myd2;

  /* precipitations */
  IF myprid IN ( prec_prid, inso_prid ) THEN
    -- sum of all the available values
    myquery := 'SELECT '
      || 'CAST(ROUND(CAST(Sum(CASE WHEN ' || NEW.id || '=id THEN meanvalue END)AS NUMERIC),2) AS REAL) AS val, '
      || 'CAST(ROUND(CAST(Avg(CASE WHEN ' || NEW.id || '=id THEN min END)AS NUMERIC),2) AS REAL) AS min, '
      || 'CAST(ROUND(CAST(Avg(CASE WHEN ' || NEW.id || '=id THEN max END)AS NUMERIC),2) AS REAL) AS max, '
      || 'Max(CASE WHEN ' || NEW.id || ' = id THEN calccode  END) AS cod '
      || 'FROM ' || TG_TABLE_SCHEMA || '.' ||TG_RELNAME || ' '
      || 'WHERE fulldate BETWEEN ''' || myd1 || ''' AND ''' || myd2 || ''' ';

  /* wind speed and direction */
  ELSIF myprid = vvel_prid OR myprid = vdir_prid THEN
      -- get the last one ( 30:00:00 )
      myquery := 'SELECT '
        || 'CAST(meanvalue AS REAL) AS val, '
        || 'CAST(min AS REAL) AS min, '
        || 'CAST(max AS REAL) AS max, '
        || 'calccode AS cod '
        || 'FROM ' || TG_TABLE_SCHEMA || '.' || TG_RELNAME || ' '
        || 'WHERE fulldate BETWEEN ''' || myd1 || ''' AND ''' || myd2 || ''' '
        || 'AND id=' || NEW.id || ' ORDER BY fulldate DESC LIMIT 1';

  /* all other parameters */
  ELSE
    -- mean of all the available values
    myquery := 'SELECT '
      || 'CAST(ROUND(CAST(Avg(CASE WHEN ' || NEW.id || '=id THEN meanvalue END)AS NUMERIC),2) AS REAL) AS val, '
      || 'CAST(ROUND(CAST(Avg(CASE WHEN ' || NEW.id || '=id THEN min END)AS NUMERIC),2) AS REAL) AS min, '
      || 'CAST(ROUND(CAST(Avg(CASE WHEN ' || NEW.id || '=id THEN max END)AS NUMERIC),2) AS REAL) AS max, '
      || 'Max(CASE WHEN ' || NEW.id || ' = id THEN calccode  END) AS cod '
      || 'FROM ' || TG_TABLE_SCHEMA || '.' ||TG_RELNAME || ' '
      || 'WHERE fulldate BETWEEN ''' || myd1 || ''' AND ''' || myd2 || ''' ';
  END IF;
  --RAISE NOTICE 'SELECT myquery : % ', myquery;

  /* get the aggregate data values */
  FOR myrec IN EXECUTE myquery LOOP

      /* check for null values */
      IF myrec.val IS NULL THEN
        my_val := 'null';
        my_cod := 'null';
        --RAISE NOTICE 'meanvalue is NULL !!';
      ELSE
        my_val := myrec.val;
        my_cod := myrec.cod;
      END IF;

      /* check for null values */
      IF myrec.min IS NULL THEN
        my_min := 'null';
        my_cod_min := 'null';
      ELSE
        my_min := myrec.min;
        my_cod_min := myrec.cod;
      END IF;

      /* check for null values */
      IF myrec.max IS NULL THEN
        my_max := 'null';
        my_cod_max := 'null';
      ELSE
        my_max := myrec.max;
        my_cod_max := myrec.cod;
      END IF;

  END LOOP; /* there are limits */
  --RAISE NOTICE 'my_val: % my_cod: %', my_val, my_cod;
  --RAISE NOTICE 'myid_min %, myid_min %', myid_min, myid_max;
  --RETURN NEW; -- test

  /*
    vertical to horizontal
    try to update the existing row
  */
  /* temp umid press [ min & max ] */
  IF myprid = tamb_prid OR myprid = urel_prid OR myprid = pbar_prid THEN
      -- Create the update query
      myquery := 'UPDATE ' || mytbl || ' SET '
            || 'id_' || NEW.id   || ' = '     || my_val  || ', '
            || 'id_' || NEW.id   || '_cod = ' || my_cod;
      IF NOT myid_min IS NULL THEN
            myquery := myquery  || ', ' || 'id_' || myid_min || ' = ' || my_min
            || ', ' || 'id_' || myid_min || '_cod = ' || my_cod_min;
      END IF;
      IF NOT myid_max IS NULL THEN
            myquery := myquery  || ', ' || 'id_' || myid_max || ' = ' || my_max
            || ', ' || 'id_' || myid_max || '_cod = ' || my_cod_max;
      END IF;
      myquery := myquery  || '  ' || 'WHERE fulldate = ' || quote_literal(mydt);

  /* velv dirv [ only max ] */
  ELSIF myprid = vvel_prid OR myprid = vdir_prid THEN

      -- Create the update query
      myquery := 'UPDATE ' || mytbl || ' SET '
            || 'id_' || NEW.id   || ' = '     || my_val || ', '
            || 'id_' || NEW.id   || '_cod = ' || my_cod;
      IF NOT myid_max IS NULL THEN
            myquery := myquery  || ', ' || 'id_' || myid_max || ' = ' || my_max
            || ', ' || 'id_' || myid_max || '_cod = ' || my_cod_max;
      END IF;
    myquery := myquery  || '  ' || 'WHERE fulldate = ' || quote_literal(mydt);

  /* all others [ nothing ] */
  ELSE
      -- Create the update query
      myquery := 'UPDATE ' || mytbl || ' SET '
      || 'id_' || NEW.id   || ' = '     || my_val  || ', '
      || 'id_' || NEW.id   || '_cod = ' || my_cod        || '  '
      || 'WHERE fulldate = ' || quote_literal(mydt);

  END IF;

  /* execute the update query */
  --RAISE NOTICE 'UPDATING mytbl TABLE ... [%]', myquery;
  EXECUTE myquery;

  GET DIAGNOSTICS get_diag = ROW_COUNT;
  --RAISE NOTICE 'GET DIAGNOSTICS get_diag [%]', get_diag;

  /* check if a row has benn updated */
  IF get_diag = 0 THEN

      /* temp umid press [ min & max ] */
      IF myprid = tamb_prid OR myprid = urel_prid OR myprid = pbar_prid THEN

          -- Create the insert query
          myquery := 'INSERT INTO ' || mytbl  || ' ( fulldate '
          || ', id_' || NEW.id
          || ', id_' || NEW.id || '_cod ';
          IF NOT myid_min IS NULL THEN
            myquery := myquery || ', id_' || myid_min
            || ', id_' || myid_min || '_cod ';
          END IF;
          IF NOT myid_max IS NULL THEN
            myquery := myquery || ', id_' || myid_max
            || ', id_' || myid_max || '_cod ';
          END IF;
          myquery := myquery  || ' ) VALUES ( '
          || quote_literal(mydt) || ', '
          || my_val      || ', '
          || my_cod;
          IF NOT myid_min IS NULL THEN
            myquery := myquery  || ', ' || my_min
            || ',  ' || my_cod_min;
          END IF;
          IF NOT myid_max IS NULL THEN
            myquery := myquery  || ', ' || my_max
            || ',  ' || my_cod_max;
          END IF;
          myquery := myquery  || ')';

      /* velv dirv [ only max ] */
      ELSIF myprid = vvel_prid OR myprid = vdir_prid THEN

          -- Create the insert query
          myquery := 'INSERT INTO ' || mytbl  || ' ( fulldate '
          || ', id_' || NEW.id
          || ', id_' || NEW.id || '_cod ';
          IF NOT myid_max IS NULL THEN
        myquery := myquery  || ', id_' || myid_max
        || ', id_' || myid_max || '_cod ';
          END IF;
          myquery := myquery  || ' ) VALUES ( '
          || quote_literal(mydt) || ', '
          || my_val      || ',  '
          || my_cod;
          IF NOT myid_max IS NULL THEN
        myquery := myquery  || ',  ' || my_max
        || ',  ' || my_cod_max;
          END IF;
          myquery := myquery  || ')';

      /* all others [ nothing ] */
      ELSE
          -- Create the insert query
          myquery := 'INSERT INTO ' || mytbl  || ' ( fulldate '
          || ', id_' || NEW.id
          || ', id_' || NEW.id || '_cod '
          || ' ) VALUES ( '
          || quote_literal(mydt) || ', '
          || my_val      || ',  '
          || my_cod            || ')';

      END IF;
      --RAISE NOTICE 'myprid %, myquery : %', myprid, myquery;

      /* execute the insert query */
      --RAISE NOTICE 'INSERTING INTO mytbl TABLE ... [%]', myquery;
      EXECUTE myquery;

  END IF;

  /* return value */
  RETURN NEW;

  /* errors check */
  EXCEPTION
    WHEN OTHERS THEN
      RAISE NOTICE 'ERROR IN v2h_30mins_stations_minmax() : %', SQLERRM ;
      RAISE NOTICE 'QUERY : %', myquery;
      /* return value */
      RETURN NEW;

END;
$$;


ALTER FUNCTION public.v2h_30mins_stations_minmax() OWNER TO postgres;

--
-- TOC entry 5774 (class 0 OID 0)
-- Dependencies: 898
-- Name: FUNCTION v2h_30mins_stations_minmax(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.v2h_30mins_stations_minmax() IS 'Push data into the horizontal database aggregating values';


--
-- TOC entry 899 (class 1255 OID 17167)
-- Name: v2h_stations_minmax(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.v2h_stations_minmax() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE
  /* static values */
  tamb_prid integer := 1;
  urel_prid integer := 2;
  pbar_prid integer := 3;
  vvel_prid integer := 10;
  vdir_prid integer := 11;
  /* main variables */
  rec          record;
  stid         integer;
  mytbl        varchar;
  myprid       integer;
  myid_min     integer;
  myid_max     integer;
  myquery      varchar;
  get_diag     integer;
  my_meanvalue varchar;
  my_cod       varchar;
  my_min       varchar;
  my_max       varchar;
  my_cod_min   varchar;
  my_cod_max   varchar;
  /* SM200 */
  dt           timestamp;
  hh_sm200     integer;
BEGIN
  -- TRIGGER AFTER INSERT OR UPDATE
 -- RAISE NOTICE 'ENTERING v2h_stations_minmax() ...';

  /* If all the fields are equals to old skip */
  /* added @ 2009-03-17 */
  IF (TG_OP = 'UPDATE') THEN
    IF  NEW.meanvalue != OLD.meanvalue OR
        NEW.code      != OLD.code OR
        NEW.min       != OLD.min OR
        NEW.mintime   != OLD.mintime OR
        NEW.max       != OLD.max OR
        NEW.maxtime   != OLD.maxtime OR
        NEW.readings  != OLD.readings OR
        NEW.stddev    != OLD.stddev OR
        NEW.calccode  != OLD.calccode THEN
	-- continue
    ELSE
        -- skip
	--RAISE NOTICE 'replicator.exportdata() : RETURN NEW';
	--RAISE NOTICE '% % ', NEW.fulldate, NEW.id;
	RETURN NEW;
    END IF;
  END IF;
  
  /* station id passed by caller */
  stid  := TG_ARGV[0];

  /* get the pr_id */
  SELECT INTO myprid pr_id FROM _stations_parameters WHERE st_id = stid AND id = NEW.id;
  IF NOT FOUND THEN
    --RAISE EXCEPTION 'id % not found', NEW.id;
    RETURN NEW;
  END IF;
  --RAISE NOTICE 'stid: % myprid: %', stid, myprid;

  /* get the table name taking into account the schema */
  SELECT INTO mytbl TG_TABLE_SCHEMA || '.' || regexp_replace(TG_TABLE_NAME, 'data_', 'tbl_'); -- not , 'g' greedy

  /* store the fulldate */
  dt := NEW.fulldate;

  /* SM200 PM10 - SM200 PM2.5 CHECK */
  IF myprid IN (1140, 1145) OR ( myprid BETWEEN 2300 AND 2550 ) THEN
    SELECT INTO hh_sm200 date_part('hour', NEW.fulldate);
    /* data check */
    IF hh_sm200 >= 6 AND hh_sm200 <= 10 THEN -- 6 to 10
        /* substract one day */
        dt := NEW.fulldate - interval '1 day';
        /* set it to 00:00:00 */
        dt := date_trunc('day', dt); -- substring(dt from 1 for 10);
        -- RAISE NOTICE 'THIS IS SM200 @ % -> %', NEW.fulldate, dt;
    ELSE
        -- RAISE NOTICE 'THIS IS SM200 -> SKIP BECAUSE OF HOUR ...';
        RETURN NEW;
    END IF;
  END IF;

  /* get the min and max ids
    500;"Temperatura min"
    501;"Temperatura max"
    502;"Umidità min"
    503;"Umidità max"
    504;"Pressione min"
    505;"Pressione max"
    506;"Velocità vento max"
    507;"Direzione vento max"
  */
  IF myprid = tamb_prid  THEN   /* temp */
    SELECT INTO myid_min id FROM _stations_parameters WHERE st_id = stid AND pr_id = 500;
    SELECT INTO myid_max id FROM _stations_parameters WHERE st_id = stid AND pr_id = 501;
  ELSIF myprid = urel_prid THEN  /* umid */
    SELECT INTO myid_min id FROM _stations_parameters WHERE st_id = stid AND pr_id = 502;
    SELECT INTO myid_max id FROM _stations_parameters WHERE st_id = stid AND pr_id = 503;
  ELSIF myprid = pbar_prid THEN  /* press */
    SELECT INTO myid_min id FROM _stations_parameters WHERE st_id = stid AND pr_id = 504;
    SELECT INTO myid_max id FROM _stations_parameters WHERE st_id = stid AND pr_id = 505;
  ELSIF myprid = vvel_prid THEN  /* velv */
    SELECT INTO myid_max id FROM _stations_parameters WHERE st_id = stid AND pr_id = 506;
  ELSIF myprid = vdir_prid THEN  /* dirv */
    SELECT INTO myid_max id FROM _stations_parameters WHERE st_id = stid AND pr_id = 507;
  END IF;

  /* check for null values */
  IF NEW.MeanValue IS NULL THEN
    my_meanvalue := 'null';
    my_cod := NEW.CalcCode;
    --RAISE NOTICE 'meanvalue is NULL !!';
  ELSE
    my_meanvalue := NEW.Meanvalue;
    my_cod := NEW.CalcCode;
  END IF;

  /* check for null values */
  IF NEW.Min IS NULL THEN
    my_min := 'null';
    my_cod_min := 'null';
  ELSE
    my_min := NEW.Min;
    my_cod_min := NEW.CalcCode;
  END IF;

  /* check for null values */
  IF NEW.Max IS NULL THEN
    my_max := 'null';
    my_cod_max := 'null';
  ELSE
    my_max := NEW.Max;
    my_cod_max := NEW.CalcCode;
  END IF;
--  RAISE NOTICE 'myid_min %, myid_min %', myid_min, myid_max;

  /*
    vertical to horizontal
    try to update the existing row
  */
  /* temp umid press [ min & max ] */
  IF myprid = tamb_prid OR myprid = urel_prid OR myprid = pbar_prid THEN
      -- Create the update query
      myquery := 'UPDATE ' || mytbl || ' SET '
            || 'id_' || NEW.id   || ' = '     || my_meanvalue  || ', '
            || 'id_' || NEW.id   || '_cod = ' || my_cod;
      IF NOT myid_min IS NULL THEN
            myquery := myquery  || ', ' || 'id_' || myid_min || ' = ' || my_min
            || ', ' || 'id_' || myid_min || '_cod = ' || my_cod_min;
      END IF;
      IF NOT myid_max IS NULL THEN
            myquery := myquery  || ', ' || 'id_' || myid_max || ' = ' || my_max
            || ', ' || 'id_' || myid_max || '_cod = ' || my_cod_max;
      END IF;
      myquery := myquery  || '  ' || 'WHERE fulldate = ' || quote_literal(dt);

  /* velv dirv [ only max ] */
  ELSIF myprid = vvel_prid OR myprid = vdir_prid THEN

      -- Create the update query
      myquery := 'UPDATE ' || mytbl || ' SET '
            || 'id_' || NEW.id   || ' = '     || my_meanvalue || ', '
            || 'id_' || NEW.id   || '_cod = ' || my_cod;
      IF NOT myid_max IS NULL THEN
            myquery := myquery  || ', ' || 'id_' || myid_max || ' = ' || my_max
            || ', ' || 'id_' || myid_max || '_cod = ' || my_cod_max;
      END IF;
    myquery := myquery  || '  ' || 'WHERE fulldate = ' || quote_literal(dt);

  /* all others [ nothing ] */
  ELSE
      -- Create the update query
      myquery := 'UPDATE ' || mytbl || ' SET '
      || 'id_' || NEW.id   || ' = '     || my_meanvalue  || ', '
      || 'id_' || NEW.id   || '_cod = ' || my_cod        || '  '
      || 'WHERE fulldate = ' || quote_literal(dt);

  END IF;

  /* execute the update query */
--  RAISE NOTICE 'UPDATING mytbl TABLE ... [%]', myquery;
  EXECUTE myquery;

  GET DIAGNOSTICS get_diag = ROW_COUNT;
  --RAISE NOTICE 'GET DIAGNOSTICS get_diag [%]', get_diag;

  /* check if a row has been updated */
  IF get_diag = 0 THEN

      /* temp umid press [ min & max ] */
      IF myprid = tamb_prid OR myprid = urel_prid OR myprid = pbar_prid THEN

          -- Create the insert query
          myquery := 'INSERT INTO ' || mytbl  || ' ( fulldate '
          || ', id_' || NEW.id
          || ', id_' || NEW.id || '_cod ';
          IF NOT myid_min IS NULL THEN
            myquery := myquery || ', id_' || myid_min
            || ', id_' || myid_min || '_cod ';
          END IF;
          IF NOT myid_max IS NULL THEN
            myquery := myquery || ', id_' || myid_max
            || ', id_' || myid_max || '_cod ';
          END IF;
          myquery := myquery  || ' ) VALUES ( '
          || quote_literal(dt) || ', '
          || my_meanvalue      || ', '
          || my_cod;
          IF NOT myid_min IS NULL THEN
            myquery := myquery  || ', ' || my_min
            || ',  ' || my_cod_min;
          END IF;
          IF NOT myid_max IS NULL THEN
            myquery := myquery  || ', ' || my_max
            || ',  ' || my_cod_max;
          END IF;
          myquery := myquery  || ')';

      /* velv dirv [ only max ] */
      ELSIF myprid = vvel_prid OR myprid = vdir_prid THEN

          -- Create the insert query
          myquery := 'INSERT INTO ' || mytbl  || ' ( fulldate '
          || ', id_' || NEW.id
          || ', id_' || NEW.id || '_cod ';
          IF NOT myid_max IS NULL THEN
        myquery := myquery  || ', id_' || myid_max
        || ', id_' || myid_max || '_cod ';
          END IF;
          myquery := myquery  || ' ) VALUES ( '
          || quote_literal(dt) || ', '
          || my_meanvalue      || ',  '
          || my_cod;
          IF NOT myid_max IS NULL THEN
        myquery := myquery  || ',  ' || my_max
        || ',  ' || my_cod_max;
          END IF;
          myquery := myquery  || ')';

      /* all others [ nothing ] */
      ELSE
          -- Create the insert query
          myquery := 'INSERT INTO ' || mytbl  || ' ( fulldate '
          || ', id_' || NEW.id
          || ', id_' || NEW.id || '_cod '
          || ' ) VALUES ( '
          || quote_literal(dt) || ', '
          || my_meanvalue      || ',  '
          || my_cod            || ')';

      END IF;

      --RAISE NOTICE 'myprid %, myquery : %', myprid, myquery;

      /* execute the insert query */
      --RAISE NOTICE 'INSERTING INTO mytbl TABLE ... [%]', myquery;
      EXECUTE myquery;

  END IF;

  /* return value */
  RETURN NEW;

  /* errors check */
  EXCEPTION
    WHEN OTHERS THEN
      RAISE NOTICE 'ERROR IN v2h_stations_minmax() : %', SQLERRM ;
      RAISE NOTICE 'QUERY : %', myquery;
      /* return value */
      RETURN NEW;

END;
$$;


ALTER FUNCTION public.v2h_stations_minmax() OWNER TO postgres;

--
-- TOC entry 5775 (class 0 OID 0)
-- Dependencies: 899
-- Name: FUNCTION v2h_stations_minmax(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.v2h_stations_minmax() IS 'Push data into the horizontal database';


--
-- TOC entry 900 (class 1255 OID 17169)
-- Name: v2h_stations_minmax_v150(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.v2h_stations_minmax_v150() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  /* static values */
  tamb_prid integer := 1;
  urel_prid integer := 2;
  pbar_prid integer := 3;
  vvel_prid integer := 10;
  vdir_prid integer := 11;
  /* main variables */
  rec          record;
  stid         integer;
  mytbl        varchar;
  myprid       integer;
  myid_min     integer;
  myid_max     integer;
  myquery      varchar;
  get_diag     integer;
  my_meanvalue varchar;
  my_cod       varchar;
  my_min       varchar;
  my_max       varchar;
  my_cod_min   varchar;
  my_cod_max   varchar;
  dt           timestamp;
BEGIN
  -- TRIGGER AFTER INSERT OR UPDATE
 -- RAISE NOTICE 'ENTERING v2h_stations_minmax() ...';

  /* If all the fields are equals to old skip */
  /* added @ 2009-03-17 */
  IF (TG_OP = 'UPDATE') THEN
    IF  NEW.meanvalue != OLD.meanvalue OR
        NEW.code      != OLD.code OR
        NEW.min       != OLD.min OR
        NEW.mintime   != OLD.mintime OR
        NEW.max       != OLD.max OR
        NEW.maxtime   != OLD.maxtime OR
        NEW.readings  != OLD.readings OR
        NEW.stddev    != OLD.stddev OR
        NEW.calccode  != OLD.calccode THEN
	-- continue
    ELSE
        -- skip
	--RAISE NOTICE 'replicator.exportdata() : RETURN NEW';
	--RAISE NOTICE '% % ', NEW.fulldate, NEW.id;
	--RETURN NEW;
    END IF;
  END IF;
  
  /* station id passed by caller */
  stid  := TG_ARGV[0];

  /* get the pr_id */
  SELECT INTO myprid pr_id FROM _stations_parameters WHERE st_id = stid AND id = NEW.id;
  IF NOT FOUND THEN
    --RAISE EXCEPTION 'id % not found', NEW.id;
    RETURN NEW;
  END IF;
  --RAISE NOTICE 'stid: % myprid: %', stid, myprid;

  /* get the table name taking into account the schema */
  SELECT INTO mytbl TG_TABLE_SCHEMA || '.' || regexp_replace(TG_TABLE_NAME, 'data_', 'tbl_'); -- not , 'g' greedy

  /* store the fulldate */
  dt := NEW.fulldate;

  /* get the min and max ids
    500;"Temperatura min"
    501;"Temperatura max"
    502;"Umidità min"
    503;"Umidità max"
    504;"Pressione min"
    505;"Pressione max"
    506;"Velocità vento max"
    507;"Direzione vento max"
  */
  IF myprid = tamb_prid  THEN   /* temp */
    SELECT INTO myid_min id FROM _stations_parameters WHERE st_id = stid AND pr_id = 500;
    SELECT INTO myid_max id FROM _stations_parameters WHERE st_id = stid AND pr_id = 501;
  ELSIF myprid = urel_prid THEN  /* umid */
    SELECT INTO myid_min id FROM _stations_parameters WHERE st_id = stid AND pr_id = 502;
    SELECT INTO myid_max id FROM _stations_parameters WHERE st_id = stid AND pr_id = 503;
  ELSIF myprid = pbar_prid THEN  /* press */
    SELECT INTO myid_min id FROM _stations_parameters WHERE st_id = stid AND pr_id = 504;
    SELECT INTO myid_max id FROM _stations_parameters WHERE st_id = stid AND pr_id = 505;
  ELSIF myprid = vvel_prid THEN  /* velv */
    SELECT INTO myid_max id FROM _stations_parameters WHERE st_id = stid AND pr_id = 506;
  ELSIF myprid = vdir_prid THEN  /* dirv */
    SELECT INTO myid_max id FROM _stations_parameters WHERE st_id = stid AND pr_id = 507;
  END IF;

  /* check for null values */
  IF NEW.MeanValue IS NULL THEN
    my_meanvalue := 'null';
    my_cod := NEW.CalcCode;
    --RAISE NOTICE 'meanvalue is NULL !!';
  ELSE
    my_meanvalue := NEW.Meanvalue;
    my_cod := NEW.CalcCode;
  END IF;

  /* check for null values */
  IF NEW.Min IS NULL THEN
    my_min := 'null';
    my_cod_min := 'null';
  ELSE
    my_min := NEW.Min;
    my_cod_min := NEW.CalcCode;
  END IF;

  /* check for null values */
  IF NEW.Max IS NULL THEN
    my_max := 'null';
    my_cod_max := 'null';
  ELSE
    my_max := NEW.Max;
    my_cod_max := NEW.CalcCode;
  END IF;
--  RAISE NOTICE 'myid_min %, myid_min %', myid_min, myid_max;

  /*
    vertical to horizontal
    try to update the existing row
  */
  /* temp umid press [ min & max ] */
  IF myprid = tamb_prid OR myprid = urel_prid OR myprid = pbar_prid THEN
      -- Create the update query
      myquery := 'UPDATE ' || mytbl || ' SET '
            || 'id_' || NEW.id   || ' = '     || my_meanvalue  || ', '
            || 'id_' || NEW.id   || '_cod = ' || my_cod;
      IF NOT myid_min IS NULL THEN
            myquery := myquery  || ', ' || 'id_' || myid_min || ' = ' || my_min
            || ', ' || 'id_' || myid_min || '_cod = ' || my_cod_min;
      END IF;
      IF NOT myid_max IS NULL THEN
            myquery := myquery  || ', ' || 'id_' || myid_max || ' = ' || my_max
            || ', ' || 'id_' || myid_max || '_cod = ' || my_cod_max;
      END IF;
      myquery := myquery  || '  ' || 'WHERE fulldate = ' || quote_literal(dt);

  /* velv dirv [ only max ] */
  ELSIF myprid = vvel_prid OR myprid = vdir_prid THEN

      -- Create the update query
      myquery := 'UPDATE ' || mytbl || ' SET '
            || 'id_' || NEW.id   || ' = '     || my_meanvalue || ', '
            || 'id_' || NEW.id   || '_cod = ' || my_cod;
      IF NOT myid_max IS NULL THEN
            myquery := myquery  || ', ' || 'id_' || myid_max || ' = ' || my_max
            || ', ' || 'id_' || myid_max || '_cod = ' || my_cod_max;
      END IF;
    myquery := myquery  || '  ' || 'WHERE fulldate = ' || quote_literal(dt);

  /* all others [ nothing ] */
  ELSE
      -- Create the update query
      myquery := 'UPDATE ' || mytbl || ' SET '
      || 'id_' || NEW.id   || ' = '     || my_meanvalue  || ', '
      || 'id_' || NEW.id   || '_cod = ' || my_cod        || '  '
      || 'WHERE fulldate = ' || quote_literal(dt);

  END IF;

  /* execute the update query */
--  RAISE NOTICE 'UPDATING mytbl TABLE ... [%]', myquery;
  EXECUTE myquery;

  GET DIAGNOSTICS get_diag = ROW_COUNT;
  --RAISE NOTICE 'GET DIAGNOSTICS get_diag [%]', get_diag;

  /* check if a row has been updated */
  IF get_diag = 0 THEN

      /* temp umid press [ min & max ] */
      IF myprid = tamb_prid OR myprid = urel_prid OR myprid = pbar_prid THEN

          -- Create the insert query
          myquery := 'INSERT INTO ' || mytbl  || ' ( fulldate '
          || ', id_' || NEW.id
          || ', id_' || NEW.id || '_cod ';
          IF NOT myid_min IS NULL THEN
            myquery := myquery || ', id_' || myid_min
            || ', id_' || myid_min || '_cod ';
          END IF;
          IF NOT myid_max IS NULL THEN
            myquery := myquery || ', id_' || myid_max
            || ', id_' || myid_max || '_cod ';
          END IF;
          myquery := myquery  || ' ) VALUES ( '
          || quote_literal(dt) || ', '
          || my_meanvalue      || ', '
          || my_cod;
          IF NOT myid_min IS NULL THEN
            myquery := myquery  || ', ' || my_min
            || ',  ' || my_cod_min;
          END IF;
          IF NOT myid_max IS NULL THEN
            myquery := myquery  || ', ' || my_max
            || ',  ' || my_cod_max;
          END IF;
          myquery := myquery  || ')';

      /* velv dirv [ only max ] */
      ELSIF myprid = vvel_prid OR myprid = vdir_prid THEN

          -- Create the insert query
          myquery := 'INSERT INTO ' || mytbl  || ' ( fulldate '
          || ', id_' || NEW.id
          || ', id_' || NEW.id || '_cod ';
          IF NOT myid_max IS NULL THEN
        myquery := myquery  || ', id_' || myid_max
        || ', id_' || myid_max || '_cod ';
          END IF;
          myquery := myquery  || ' ) VALUES ( '
          || quote_literal(dt) || ', '
          || my_meanvalue      || ',  '
          || my_cod;
          IF NOT myid_max IS NULL THEN
        myquery := myquery  || ',  ' || my_max
        || ',  ' || my_cod_max;
          END IF;
          myquery := myquery  || ')';

      /* all others [ nothing ] */
      ELSE
          -- Create the insert query
          myquery := 'INSERT INTO ' || mytbl  || ' ( fulldate '
          || ', id_' || NEW.id
          || ', id_' || NEW.id || '_cod '
          || ' ) VALUES ( '
          || quote_literal(dt) || ', '
          || my_meanvalue      || ',  '
          || my_cod            || ')';

      END IF;

      --RAISE NOTICE 'myprid %, myquery : %', myprid, myquery;

      /* execute the insert query */
      --RAISE NOTICE 'INSERTING INTO mytbl TABLE ... [%]', myquery;
      EXECUTE myquery;

  END IF;

  /* return value */
  RETURN NEW;

  /* errors check */
  EXCEPTION
    WHEN OTHERS THEN
      RAISE NOTICE 'ERROR IN v2h_stations_minmax_v150() : %', SQLERRM ;
      RAISE NOTICE 'QUERY : %', myquery;
      /* return value */
      RETURN NEW;

END;
$$;


ALTER FUNCTION public.v2h_stations_minmax_v150() OWNER TO postgres;

--
-- TOC entry 5776 (class 0 OID 0)
-- Dependencies: 900
-- Name: FUNCTION v2h_stations_minmax_v150(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.v2h_stations_minmax_v150() IS 'Push data into the horizontal database';


--
-- TOC entry 901 (class 1255 OID 17251)
-- Name: get_cf_data_cogne(timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: tables_ar; Owner: postgres
--

--
-- TOC entry 907 (class 1255 OID 17257)
-- Name: raw_inst_palas_up_before(); Type: FUNCTION; Schema: tables_ar; Owner: postgres
--

CREATE FUNCTION tables_ar.raw_inst_palas_up_before() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    test boolean;
BEGIN

    /* execute quesry to check if a value exists */
    EXECUTE format('SELECT 1 FROM %I.%I WHERE (fulldate, id) = (%s, %s)',
        TG_TABLE_SCHEMA, TG_TABLE_NAME, quote_literal(NEW.fulldate), NEW.id
    ) INTO test;

    /* check */
    IF test THEN
        /*skip insert*/
        RETURN NULL;
    END IF;

    /*default*/
    RETURN NEW;
END
$$;


ALTER FUNCTION tables_ar.raw_inst_palas_up_before() OWNER TO postgres;

--
-- TOC entry 5782 (class 0 OID 0)
-- Dependencies: 907
-- Name: FUNCTION raw_inst_palas_up_before(); Type: COMMENT; Schema: tables_ar; Owner: postgres
--

COMMENT ON FUNCTION tables_ar.raw_inst_palas_up_before() IS 'Trigger to avoid duplicate key error';


--
-- TOC entry 908 (class 1255 OID 17258)
-- Name: update_anas_etroubles_palas_hourly_data(smallint); Type: FUNCTION; Schema: tables_ar; Owner: postgres
--

CREATE FUNCTION tables_ar.update_anas_etroubles_palas_hourly_data(smallint) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
declare
    hours ALIAS FOR $1;
    query text;
BEGIN

    /* test
        SELECT tables_ar.update_anas_etroubles_palas_hourly_data(-3::smallint);
    */
    RAISE NOTICE 'Hours gap: %', hours;

    -- delete data
    RAISE NOTICE 'Delete data';
    DELETE FROM tables_ar.data_anas_etroubles
        WHERE fulldate >= date_trunc('hour', CURRENT_TIMESTAMP + INTERVAL '1 hour' * hours)::timestamp
        AND id IN (39,41,43,45,47);

    -- insert data
    RAISE NOTICE 'Insert data';
    FOR counter_id IN 39..48 BY 2 LOOP
        RAISE NOTICE 'id: %', counter_id;

        INSERT INTO tables_ar.data_anas_etroubles (fulldate, id, meanvalue)
        SELECT
            date_trunc('hour'::text, fulldate) AS fulldate,
            counter_id::smallint as id,
            avg(CASE WHEN id = counter_id THEN (value * 1000)::real ELSE NULL::real END) as meanvalue
        FROM
            tables_ar.raw_inst_anas_etroubles_palas
        WHERE
            id = counter_id AND  fulldate >= date_trunc('hour', CURRENT_TIMESTAMP + INTERVAL '1 hour' * hours)::timestamp
        GROUP BY 1
        ORDER BY 1;

    END LOOP;

    -- return value
    RETURN TRUE;

/* errors check */
EXCEPTION
    /* in case of any error */
    WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred while executing tables_ar.update_anas_etroubles_palas_hourly_data % %', SQLERRM, SQLSTATE;
        -- return value
        RETURN FALSE;
END;
$_$;


ALTER FUNCTION tables_ar.update_anas_etroubles_palas_hourly_data(smallint) OWNER TO postgres;

--
-- TOC entry 5783 (class 0 OID 0)
-- Dependencies: 908
-- Name: FUNCTION update_anas_etroubles_palas_hourly_data(smallint); Type: COMMENT; Schema: tables_ar; Owner: postgres
--

COMMENT ON FUNCTION tables_ar.update_anas_etroubles_palas_hourly_data(smallint) IS 'Fill palas hourly data table';


--
-- TOC entry 909 (class 1255 OID 17259)
-- Name: update_grande_charriere_palas_hourly_data(smallint); Type: FUNCTION; Schema: tables_ar; Owner: postgres
--

CREATE FUNCTION tables_ar.update_grande_charriere_palas_hourly_data(smallint) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
declare
    hours ALIAS FOR $1;
    query text;
BEGIN

    /* test
        SELECT tables_ar.update_grande_charriere_palas_hourly_data(-3::smallint);
    */
    RAISE NOTICE 'Hours gap: %', hours;

    -- delete data
    RAISE NOTICE 'Delete data';
    DELETE FROM tables_ar.data_grande_charriere
        WHERE fulldate >= date_trunc('hour', CURRENT_TIMESTAMP + INTERVAL '1 hour' * hours)::timestamp
        AND id IN (1039,1041,1043,1045,1047);

    -- insert data
    RAISE NOTICE 'Insert data';
    FOR counter_id IN 39..48 BY 2 LOOP
        RAISE NOTICE 'id: %', counter_id;

        INSERT INTO tables_ar.data_grande_charriere (fulldate, id, meanvalue)
        SELECT
            date_trunc('hour'::text, fulldate) AS fulldate,
            (1000+counter_id)::smallint as id,
            avg(CASE WHEN id = counter_id THEN (value * 1000)::real ELSE NULL::real END) as meanvalue
        FROM
            tables_ar.raw_inst_palas
        WHERE
            id = counter_id AND  fulldate >= date_trunc('hour', CURRENT_TIMESTAMP + INTERVAL '1 hour' * hours)::timestamp
            AND value IS NOT NULL
        GROUP BY 1
        ORDER BY 1;

    END LOOP;

    -- return value
    RETURN TRUE;

/* errors check */
EXCEPTION
    /* in case of any error */
    WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred while executing tables_ar.update_grande_charriere_palas_hourly_data % %', SQLERRM, SQLSTATE;
        -- return value
        RETURN FALSE;
END;
$_$;


ALTER FUNCTION tables_ar.update_grande_charriere_palas_hourly_data(smallint) OWNER TO postgres;

--
-- TOC entry 5784 (class 0 OID 0)
-- Dependencies: 909
-- Name: FUNCTION update_grande_charriere_palas_hourly_data(smallint); Type: COMMENT; Schema: tables_ar; Owner: postgres
--

COMMENT ON FUNCTION tables_ar.update_grande_charriere_palas_hourly_data(smallint) IS 'Fill grande charriere palas hourly data table';


--
-- TOC entry 910 (class 1255 OID 17260)
-- Name: update_palas_hourly_data(smallint); Type: FUNCTION; Schema: tables_ar; Owner: postgres
--

CREATE FUNCTION tables_ar.update_palas_hourly_data(smallint) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
declare
    hours ALIAS FOR $1;
    query text;
BEGIN

    /* test
        SELECT tables_ar.update_palas_hourly_data(-3::smallint);
    */
    RAISE NOTICE 'Hours gap: %', hours;

    -- delete data
    RAISE NOTICE 'Delete data';
    DELETE FROM tables_ar.data_palas
        WHERE fulldate >= date_trunc('hour', CURRENT_TIMESTAMP + INTERVAL '1 hour' * hours)::timestamp
        AND id IN (39,41,43,45,47);

    -- insert data
    RAISE NOTICE 'Insert data';
    FOR counter_id IN 39..48 BY 2 LOOP
        RAISE NOTICE 'id: %', counter_id;

        INSERT INTO tables_ar.data_palas (fulldate, id, meanvalue)
        SELECT
            date_trunc('hour'::text, fulldate) AS fulldate,
            counter_id::smallint as id,
            avg(CASE WHEN id = counter_id THEN (value * 1000)::real ELSE NULL::real END) as meanvalue
        FROM
            tables_ar.raw_inst_palas
        WHERE
            id = counter_id AND  fulldate >= date_trunc('hour', CURRENT_TIMESTAMP + INTERVAL '1 hour' * hours)::timestamp
        GROUP BY 1
        ORDER BY 1;

    END LOOP;

    -- return value
    RETURN TRUE;

/* errors check */
EXCEPTION
    /* in case of any error */
    WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred while executing tables_ar.update_palas_hourly_data % %', SQLERRM, SQLSTATE;
        -- return value
        RETURN FALSE;
END;
$_$;


ALTER FUNCTION tables_ar.update_palas_hourly_data(smallint) OWNER TO postgres;

--
-- TOC entry 5785 (class 0 OID 0)
-- Dependencies: 910
-- Name: FUNCTION update_palas_hourly_data(smallint); Type: COMMENT; Schema: tables_ar; Owner: postgres
--

COMMENT ON FUNCTION tables_ar.update_palas_hourly_data(smallint) IS 'Fill palas hourly data table';


--
-- TOC entry 911 (class 1255 OID 17261)
-- Name: update_plouves_palas_hourly_data(smallint); Type: FUNCTION; Schema: tables_ar; Owner: postgres
--

CREATE FUNCTION tables_ar.update_plouves_palas_hourly_data(smallint) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
declare
    hours ALIAS FOR $1;
    query text;
BEGIN

    /* test
        SELECT tables_ar.update_plouves_palas_hourly_data(-3::smallint);
    */
    RAISE NOTICE 'Hours gap: %', hours;

    -- delete data
    RAISE NOTICE 'Delete data';
    DELETE FROM tables_ar.data_plouves
        WHERE fulldate >= date_trunc('hour', CURRENT_TIMESTAMP + INTERVAL '1 hour' * hours)::timestamp
        AND id IN (39,41,43,45,47);

    -- insert data
    RAISE NOTICE 'Insert data';
    FOR counter_id IN 39..48 BY 2 LOOP
        RAISE NOTICE 'id: %', counter_id;

        INSERT INTO tables_ar.data_plouves (fulldate, id, meanvalue)
        SELECT
            date_trunc('hour'::text, fulldate) AS fulldate,
            counter_id::smallint as id,
            avg(CASE WHEN id = counter_id THEN (value * 1000)::real ELSE NULL::real END) as meanvalue
        FROM
            tables_ar.raw_inst_plouves_palas
        WHERE
            id = counter_id AND  fulldate >= date_trunc('hour', CURRENT_TIMESTAMP + INTERVAL '1 hour' * hours)::timestamp
        GROUP BY 1
        ORDER BY 1;

    END LOOP;

    -- return value
    RETURN TRUE;

/* errors check */
EXCEPTION
    /* in case of any error */
    WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred while executing tables_ar.update_plouves_palas_hourly_data % %', SQLERRM, SQLSTATE;
        -- return value
        RETURN FALSE;
END;
$_$;


ALTER FUNCTION tables_ar.update_plouves_palas_hourly_data(smallint) OWNER TO postgres;

--
-- TOC entry 5786 (class 0 OID 0)
-- Dependencies: 911
-- Name: FUNCTION update_plouves_palas_hourly_data(smallint); Type: COMMENT; Schema: tables_ar; Owner: postgres
--

COMMENT ON FUNCTION tables_ar.update_plouves_palas_hourly_data(smallint) IS 'Fill palas hourly data table';


--
-- TOC entry 912 (class 1255 OID 17262)
-- Name: update_primo_maggio_palas_hourly_data(smallint); Type: FUNCTION; Schema: tables_ar; Owner: postgres
--

CREATE FUNCTION tables_ar.update_primo_maggio_palas_hourly_data(smallint) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
declare
    hours ALIAS FOR $1;
    query text;
BEGIN

    /* test
        SELECT tables_ar.update_primo_maggio_palas_hourly_data(-3::smallint);
    */
    RAISE NOTICE 'Hours gap: %', hours;

    -- delete data
    RAISE NOTICE 'Delete data';
    DELETE FROM tables_ar.data_primo_maggio
        WHERE fulldate >= date_trunc('hour', CURRENT_TIMESTAMP + INTERVAL '1 hour' * hours)::timestamp
        AND id IN (39,41,43,45,47);

    -- insert data
    RAISE NOTICE 'Insert data';
    FOR counter_id IN 39..48 BY 2 LOOP
        RAISE NOTICE 'id: %', counter_id;

        INSERT INTO tables_ar.data_primo_maggio (fulldate, id, meanvalue)
        SELECT
            date_trunc('hour'::text, fulldate) AS fulldate,
            counter_id::smallint as id,
            avg(CASE WHEN id = counter_id THEN (value * 1000)::real ELSE NULL::real END) as meanvalue
        FROM
            tables_ar.raw_inst_primo_maggio_palas
        WHERE
            id = counter_id AND  fulldate >= date_trunc('hour', CURRENT_TIMESTAMP + INTERVAL '1 hour' * hours)::timestamp
        GROUP BY 1
        ORDER BY 1;

    END LOOP;

    -- return value
    RETURN TRUE;

/* errors check */
EXCEPTION
    /* in case of any error */
    WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred while executing tables_ar.update_primo_maggio_palas_hourly_data % %', SQLERRM, SQLSTATE;
        -- return value
        RETURN FALSE;
END;
$_$;


ALTER FUNCTION tables_ar.update_primo_maggio_palas_hourly_data(smallint) OWNER TO postgres;

--
-- TOC entry 5787 (class 0 OID 0)
-- Dependencies: 912
-- Name: FUNCTION update_primo_maggio_palas_hourly_data(smallint); Type: COMMENT; Schema: tables_ar; Owner: postgres
--

COMMENT ON FUNCTION tables_ar.update_primo_maggio_palas_hourly_data(smallint) IS 'Fill palas hourly data table';


--
-- TOC entry 913 (class 1255 OID 17263)
-- Name: update_tunnel_mb_palas_hourly_data(smallint); Type: FUNCTION; Schema: tables_ar; Owner: postgres
--

CREATE FUNCTION tables_ar.update_tunnel_mb_palas_hourly_data(smallint) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
declare
    hours ALIAS FOR $1;
    query text;
BEGIN

    -- return value
    RETURN TRUE;

    /* test
        SELECT tables_ar.update_palas_hourly_data(-3::smallint);
    */
    RAISE NOTICE 'Hours gap: %', hours;

    -- delete data
    RAISE NOTICE 'Delete data';
    DELETE FROM tables_ar.data_tunnel_mb
        WHERE fulldate >= date_trunc('hour', CURRENT_TIMESTAMP + INTERVAL '1 hour' * hours)::timestamp
        AND id IN (39,41,43,45,47);

    -- insert data
    RAISE NOTICE 'Insert data';
    FOR counter_id IN 39..48 BY 2 LOOP
        RAISE NOTICE 'id: %', counter_id;

        INSERT INTO tables_ar.data_tunnel_mb (fulldate, id, meanvalue)
        SELECT
            date_trunc('hour'::text, fulldate) AS fulldate,
            counter_id::smallint as id,
            avg(CASE WHEN id = counter_id THEN (value * 1000)::real ELSE NULL::real END) as meanvalue
        FROM
            tables_ar.raw_inst_tunnel_mb_palas
        WHERE
            id = counter_id AND  fulldate >= date_trunc('hour', CURRENT_TIMESTAMP + INTERVAL '1 hour' * hours)::timestamp
        GROUP BY 1
        ORDER BY 1;

    END LOOP;

    -- return value
    RETURN TRUE;

/* errors check */
EXCEPTION
    /* in case of any error */
    WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred while executing tables_ar.update_tunnel_mb_palas_hourly_data % %', SQLERRM, SQLSTATE;
        -- return value
        RETURN FALSE;
END;
$_$;


ALTER FUNCTION tables_ar.update_tunnel_mb_palas_hourly_data(smallint) OWNER TO postgres;

--
-- TOC entry 5788 (class 0 OID 0)
-- Dependencies: 913
-- Name: FUNCTION update_tunnel_mb_palas_hourly_data(smallint); Type: COMMENT; Schema: tables_ar; Owner: postgres
--

COMMENT ON FUNCTION tables_ar.update_tunnel_mb_palas_hourly_data(smallint) IS 'Fill palas hourly data table';


--
-- TOC entry 914 (class 1255 OID 17264)
-- Name: v2v_raw(); Type: FUNCTION; Schema: tables_ar; Owner: postgres
--

CREATE FUNCTION tables_ar.v2v_raw() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  /* main variables */
  get_diag            integer;
  stid                integer;
  myprid              integer;
  mytbl               varchar;
  myquery             varchar;
  myval               real;
  myd1                varchar;
  myd2                varchar;
  myminutes           integer;
  dt                  timestamp;
  dt_ref              timestamp;
BEGIN
  -- TRIGGER BEFORE INSERT OR UPDATE

  /* station st_id passed by caller */
  stid  := TG_ARGV[0];

  /* get the pr_id */
  SELECT INTO myprid pr_id FROM _stations_parameters WHERE st_id = stid AND id = NEW.id;
  --RAISE NOTICE 'id % - myprid % ', new.id, myprid;

  /* get the table name taking into account the schema (not , 'g' greedy) */
  SELECT INTO mytbl TG_TABLE_SCHEMA || '.' || regexp_replace(TG_TABLE_NAME, 'raw_', 'data_');
  --RAISE NOTICE 'mytbl %', mytbl;

  /* get the minutes */
  SELECT INTO myminutes date_part('minute', NEW.fulldate);
  --RAISE NOTICE 'fulldate %, myminutes % ', NEW.fulldate, myminutes;

  /* choose the aggregation span time */
  myd1 = to_char(NEW.fulldate, 'YYYY-MM-DD HH24:00:00');
  myd2 = to_char(NEW.fulldate, 'YYYY-MM-DD HH24:59:59');
  /* store the flat hour for the insert */
  dt := myd1;
  --RAISE NOTICE 'myd1: % myd2: %', myd1, myd2;
  --RAISE NOTICE 'NEW.id: %, TG_TABLE_SCHEMA: %, TG_TABLE_NAME: %', NEW.id, TG_TABLE_SCHEMA, TG_TABLE_NAME;

  /* means */
  myquery := 'SELECT CAST(ROUND(CAST(Avg(CASE WHEN ' || NEW.id
      || ' = Id THEN meanvalue END)AS NUMERIC), 3) AS REAL) AS val '
      || 'FROM ' || TG_TABLE_SCHEMA || '.' || TG_TABLE_NAME || ' '
      || 'WHERE fulldate BETWEEN ''' || myd1 || ''' AND ''' || myd2 || ''' ';
  --RAISE NOTICE 'SELECT myquery : % ', myquery;

  /* parameter properties */
  EXECUTE myquery INTO myval;
  --RAISE NOTICE 'myval: %', myval;

  /* check for null values */
  IF myval IS NULL THEN
    -- RAISE NOTICE 'SELECT myquery : % ', myquery;
    -- RAISE NOTICE 'The myval IS NULL @ %!', NEW.fulldate;
    RETURN NEW; /* return value */
  END IF;

  /* update the existing row */
  myquery := 'UPDATE '  || mytbl     || ' SET '
    || 'meanvalue = '   || myval     || ' '
    || 'WHERE fulldate = ' || quote_literal(dt) || ' '
    || 'AND id = ' || NEW.id;

  /* execute the update query */
  --RAISE NOTICE 'UPDATING raw TABLE [%]', myquery;
  EXECUTE myquery;

  GET DIAGNOSTICS get_diag = ROW_COUNT;
  --RAISE NOTICE 'GET DIAGNOSTICS get_diag [%]', get_diag;

  /* check if a row has benn updated */
  IF get_diag = 0 THEN

    /* we insert the new row in the vertical database */
    myquery := 'INSERT INTO ' || mytbl || ' '
            || '(fulldate, id, meanvalue) VALUES ('
            || quote_literal(dt) || ', ' || NEW.id || ', ' || myval || ')';
    --RAISE NOTICE 'INSERTING data [%]', myquery;

    /* execute the insert query */
    EXECUTE myquery;

  END IF;

  /* return value */
  RETURN NEW;

  /* errors check */
  EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'ERROR GENERAL v2v_raw() : %', SQLERRM ;
        RETURN NEW; /* return value */
END;
$$;


ALTER FUNCTION tables_ar.v2v_raw() OWNER TO postgres;

--
-- TOC entry 5789 (class 0 OID 0)
-- Dependencies: 914
-- Name: FUNCTION v2v_raw(); Type: COMMENT; Schema: tables_ar; Owner: postgres
--

COMMENT ON FUNCTION tables_ar.v2v_raw() IS 'Turn raw data into 60 minutes aggregation';


--
-- TOC entry 915 (class 1255 OID 17291)
-- Name: calib_results_tostring(integer); Type: FUNCTION; Schema: tool_netcom; Owner: postgres
--

CREATE FUNCTION tool_netcom.calib_results_tostring(res_code integer) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
    descr  text = '';
    result text [];
BEGIN

    /* TEST
    SELECT * FROM tool_netcom.calib_results_tostring(5);
    */
    IF (res_code = 0) THEN
        result := array_append(result, 'Ok');
        RETURN result;
    END IF;

    /* build the dynamic query_sql */
    IF (res_code | 1) = res_code THEN
        result := array_append(result, 'Span Low');
    END IF;
    IF (res_code | 2) = res_code THEN
        result := array_append(result, 'Span High');
    END IF;
    IF (res_code | 4) = res_code THEN
        result := array_append(result, 'Zero Low');
    END IF;
    IF (res_code | 8) = res_code THEN
        result := array_append(result, 'Zero High');
    END IF;

    /* return value */
    RETURN result ;

/* errors check */
EXCEPTION WHEN OTHERS THEN /* in case of any error */
    RAISE NOTICE 'ERROR IN tool_netcom.calib_results_tostring(integer) : %', SQLERRM ;
    RETURN NULL; /* return value */
END;
$$;


ALTER FUNCTION tool_netcom.calib_results_tostring(res_code integer) OWNER TO postgres;

--
-- TOC entry 916 (class 1255 OID 17292)
-- Name: calib_results_tostring(integer, text); Type: FUNCTION; Schema: tool_netcom; Owner: postgres
--

CREATE FUNCTION tool_netcom.calib_results_tostring(res_code integer, calib_step text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    result text;
BEGIN

    /* TEST
    SELECT * FROM tool_netcom.calib_results_tostring(5);
    */
    IF (res_code = 0) THEN
        result := 'Ok';
        RETURN result;
    END IF;

    /* build the dynamic query_sql */
    IF (calib_step = 'SPAN') THEN

        CASE 
            WHEN (res_code | 1) = res_code THEN result := 'Span Low';
            WHEN (res_code | 2) = res_code THEN result := 'Span High';
            ELSE result := 'Ok';
        END CASE;
    
    ELSE -- calib_step = 'ZERO'
        
        CASE 
            WHEN (res_code | 4) = res_code THEN result := 'Zero Low';
            WHEN (res_code | 8) = res_code THEN result := 'Zero High';
            ELSE result := 'Ok';
        END CASE;
    
    END IF;

    /* return value */
    RETURN result ;

/* errors check */
EXCEPTION WHEN OTHERS THEN /* in case of any error */
    RAISE NOTICE 'ERROR IN tool_netcom.calib_results_tostring(integer, text) : %', SQLERRM ;
    RETURN NULL; /* return value */
END;
$$;


ALTER FUNCTION tool_netcom.calib_results_tostring(res_code integer, calib_step text) OWNER TO postgres;

--
-- TOC entry 917 (class 1255 OID 17308)
-- Name: clone_user_pages(integer, integer); Type: FUNCTION; Schema: tool_visualizer_lily; Owner: postgres
--

CREATE FUNCTION tool_visualizer_lily.clone_user_pages(user_id integer, new_user_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
  view_pages       	RECORD;
  rec_pages_groups 	RECORD;
  rec_pages_windows RECORD;
  mygrid            INTEGER;
  mypgid            INTEGER;
  ret 				INTEGER;
BEGIN

    /* testing
		SELECT tool_visualizer_lily.clone_user_pages(1, 2);
    */

	/* notice */
	--RAISE NOTICE 'Deleting pages and windows ...';
	BEGIN

		RAISE NOTICE 'Deleting from table tool_visualizer_lily.pages_windows ...';
		DELETE FROM tool_visualizer_lily.pages_windows WHERE pg_id in (
			SELECT pg_id FROM tool_visualizer_lily.pages
			LEFT JOIN tool_visualizer_lily.pages_groups_users USING(gr_id)
			WHERE tool_visualizer_lily.pages_groups_users.us_id = new_user_id
		);

		RAISE NOTICE 'Deleting from table tool_visualizer_lily.pages ...';
		DELETE FROM tool_visualizer_lily.pages WHERE pg_id in (
			SELECT pg_id FROM tool_visualizer_lily.pages
			LEFT JOIN tool_visualizer_lily.pages_groups_users USING(gr_id)
			WHERE tool_visualizer_lily.pages_groups_users.us_id = new_user_id
		);

		RAISE NOTICE 'Deleting from table tool_visualizer_lily.pages_groups ...';
		DELETE FROM tool_visualizer_lily.pages_groups WHERE gr_id in (
			SELECT gr_id FROM tool_visualizer_lily.pages_groups
			LEFT JOIN tool_visualizer_lily.pages_groups_users USING(gr_id)
			WHERE tool_visualizer_lily.pages_groups_users.us_id = new_user_id
		);

		RAISE NOTICE 'Deleting from table tool_visualizer_lily.pages_groups_users ...';
		DELETE FROM tool_visualizer_lily.pages_groups_users WHERE us_id = new_user_id;

	EXCEPTION WHEN OTHERS THEN
		RAISE NOTICE 'ERROR in tool_visualizer_lily : %', SQLERRM;
	END;

	/* insert new pages */
    FOR view_pages IN SELECT * FROM tool_visualizer_lily.pages_groups_users
			JOIN tool_visualizer_lily.pages_groups USING(gr_id)
  			WHERE us_id = user_id ORDER BY gr_id LOOP

		/* notice */
		--RAISE NOTICE 'Group ID %, Name %', view_pages.gr_id, view_pages.name;

	    /* add the new groups returning gr_id */
	    INSERT INTO tool_visualizer_lily.pages_groups(name, po_id)
				VALUES (view_pages.name, view_pages.po_id) RETURNING gr_id INTO mygrid;

		/* notice */
		--RAISE NOTICE 'New group ID %', mygrid;

		/* add the new group into groups_users */
		INSERT INTO tool_visualizer_lily.pages_groups_users(us_id, gr_id) VALUES (new_user_id, mygrid);

		/* pages */
	    FOR rec_pages_groups IN SELECT * FROM tool_visualizer_lily.pages WHERE gr_id = view_pages.gr_id ORDER BY pg_id LOOP

			/* notice */
			--RAISE NOTICE 'page McId %', rec_pages_groups.mc_id;

			/* add the new page into pages */
			INSERT INTO tool_visualizer_lily.pages(gr_id, name, description, backgroundimage, po_id, defaultview)
				VALUES (mygrid, rec_pages_groups.name, rec_pages_groups.description,
						rec_pages_groups.backgroundimage, rec_pages_groups.po_id, rec_pages_groups.defaultview)
			RETURNING pg_id INTO mypgid;

	            /* pages windows */
		    FOR rec_pages_windows IN SELECT * FROM tool_visualizer_lily.pages_windows WHERE pg_id = rec_pages_groups.pg_id ORDER BY wd_id LOOP

		        /* notice */
		        --RAISE NOTICE 'Parameter StPrId %', rec_pages_windows.st_pr_id;

				/* add the new page into pages */
				INSERT INTO tool_visualizer_lily.pages_windows(
					pg_id, st_pr_id, useview, view_id, name, defaultview,
					charttype, stationname, parametername, decimals,
					nodays, inttime, useformule, color, thick, points,
					marks, marksdrawevery, autoscale, scalemin, scalemax,
					scaleminoffset, scalemaxoffset, linered, linegreen,
					alertmin, alertmax, chartfunction, showmaxvalues,
					showminvalues, showstddevvalues, showsgridband,
					fontsize, fontbold, fontcolor, wtop, wleft,
					wwidth, wheight, wpretop, wpreleft, wprewidth,
					wpreheight, wnumtop, wnumleft, wnumwidth,
					wnumheight, po_id
				) VALUES (mypgid, rec_pages_windows.st_pr_id, rec_pages_windows.useview,
					rec_pages_windows.view_id, rec_pages_windows.name,
					rec_pages_windows.defaultview, rec_pages_windows.charttype,
					rec_pages_windows.stationname, rec_pages_windows.parametername,
					rec_pages_windows.decimals, rec_pages_windows.nodays,
					rec_pages_windows.inttime, rec_pages_windows.useformule,
					rec_pages_windows.color, rec_pages_windows.thick,
					rec_pages_windows.points,  rec_pages_windows.marks,
					rec_pages_windows.marksdrawevery, rec_pages_windows.autoscale,
					rec_pages_windows.scalemin, rec_pages_windows.scalemax,
					rec_pages_windows.scaleminoffset, rec_pages_windows.scalemaxoffset,
					rec_pages_windows.linered, rec_pages_windows.linegreen,
					rec_pages_windows.alertmin, rec_pages_windows.alertmax,
					rec_pages_windows.chartfunction, rec_pages_windows.showmaxvalues,
					rec_pages_windows.showminvalues, rec_pages_windows.showstddevvalues,
					rec_pages_windows.showsgridband, rec_pages_windows.fontsize,
					rec_pages_windows.fontbold, rec_pages_windows.fontcolor,
					rec_pages_windows.wtop, rec_pages_windows.wleft,
					rec_pages_windows.wwidth, rec_pages_windows.wheight,
					rec_pages_windows.wpretop, rec_pages_windows.wpreleft,
					rec_pages_windows.wprewidth, rec_pages_windows.wpreheight,
					rec_pages_windows.wnumtop, rec_pages_windows.wnumleft,
					rec_pages_windows.wnumwidth, rec_pages_windows.wnumheight,
					rec_pages_windows.po_id
				);

			END LOOP;

	    END LOOP;

    END LOOP;

    RETURN true;

/* errors check */
EXCEPTION
  /* still errors */
  WHEN OTHERS THEN
    RAISE NOTICE 'ERROR IN tool_visualizer_lily.clone_user_pages : %', SQLERRM ;
    RETURN false;
END;
$$;


ALTER FUNCTION tool_visualizer_lily.clone_user_pages(user_id integer, new_user_id integer) OWNER TO postgres;

--
-- TOC entry 5790 (class 0 OID 0)
-- Dependencies: 917
-- Name: FUNCTION clone_user_pages(user_id integer, new_user_id integer); Type: COMMENT; Schema: tool_visualizer_lily; Owner: postgres
--

COMMENT ON FUNCTION tool_visualizer_lily.clone_user_pages(user_id integer, new_user_id integer) IS 'Clone a Analyser user tree';


--
-- TOC entry 918 (class 1255 OID 17309)
-- Name: clone_user_settings(integer, integer); Type: FUNCTION; Schema: tool_visualizer_lily; Owner: postgres
--

CREATE FUNCTION tool_visualizer_lily.clone_user_settings(user_id integer, new_user_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
  rec_us	RECORD;
BEGIN

    /* testing
			SELECT tool_visualizer_lily.clone_user_settings(1, 2);
    */

    /* tool_visualizer_lily.users_settings */
    BEGIN
        RAISE NOTICE 'Deleting from table tool_visualizer_lily.users_settings ...';
        DELETE FROM tool_visualizer_lily.users_settings WHERE us_id = new_user_id;
    EXCEPTION WHEN OTHERS THEN
    	RAISE NOTICE 'ERROR in tool_visualizer_lily.users_settings : %', SQLERRM;
    END;

    /* clone user settings */
    FOR rec_us IN SELECT * FROM tool_visualizer_lily.users_settings WHERE us_id = user_id LOOP
        -- actually one record
        /* add the new user stations grants */
        INSERT INTO tool_visualizer_lily.users_settings( us_id,
        			theme_01, theme_02, theme_03, theme_04, theme_05)
        VALUES (new_user_id,
        			rec_us.theme_01, rec_us.theme_02, rec_us.theme_03,
        			rec_us.theme_04, rec_us.theme_05
        );

    END LOOP;

    RETURN true;

/* errors check */
EXCEPTION
  /* still errors */
  WHEN OTHERS THEN
    RAISE NOTICE 'ERROR IN tool_visualizer_lily.clone_user_settings : %', SQLERRM ;
    RETURN false;
END;
$$;


ALTER FUNCTION tool_visualizer_lily.clone_user_settings(user_id integer, new_user_id integer) OWNER TO postgres;

--
-- TOC entry 5791 (class 0 OID 0)
-- Dependencies: 918
-- Name: FUNCTION clone_user_settings(user_id integer, new_user_id integer); Type: COMMENT; Schema: tool_visualizer_lily; Owner: postgres
--

COMMENT ON FUNCTION tool_visualizer_lily.clone_user_settings(user_id integer, new_user_id integer) IS 'Clone user sttings';


--
-- TOC entry 919 (class 1255 OID 17329)
-- Name: f_delete_tickets(integer, boolean); Type: FUNCTION; Schema: tool_web_lily; Owner: postgres
--

CREATE FUNCTION tool_web_lily.f_delete_tickets(integer, boolean) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$

DECLARE
    ticket_id   ALIAS FOR $1;
    delete_all  ALIAS FOR $2;

    parent_id    integer;
    n_children   integer;
    expiry_date  timestamp;
    closure_date timestamp;

BEGIN

    -- TEST SELECT tool_web_lily.f_delete_tickets(1, true);
    -- TEST SELECT tool_web_lily.f_delete_tickets(1, false);

    SELECT INTO parent_id, expiry_date, closure_date tk_parent_id_fk, tk_expiry_date, tk_closure_date FROM tool_web_lily.tickets WHERE tk_id = ticket_id;

    IF closure_date IS NOT NULL THEN
        RAISE NOTICE 'Closed ticket: cannot be deleted';
        RETURN false;
    END IF;

    IF delete_all IS TRUE THEN

        -- original ticket, not a copy
        IF parent_id IS NULL THEN

            DELETE FROM tool_web_lily.tickets WHERE tk_parent_id_fk = ticket_id; --First I remove children
            DELETE FROM tool_web_lily.tickets WHERE tk_id = ticket_id;

        -- possible copy of another ticket
        ELSE
            --remove all other copies after the one selected
            DELETE FROM tool_web_lily.tickets WHERE tk_parent_id_fk = parent_id AND tk_expiry_date > expiry_date;
            DELETE FROM tool_web_lily.tickets WHERE tk_id = ticket_id;
        END IF;


    ELSE

        -- Original ticket -> must check if it has children
        IF parent_id IS NULL THEN

            SELECT INTO n_children COUNT(*) FROM tool_web_lily.tickets WHERE tk_parent_id_fk = ticket_id;
            IF n_children > 0 THEN
                RAISE NOTICE 'Ticket has children: cannot be deleted';
                RETURN FALSE;
            END IF;

        END IF;

        DELETE FROM tool_web_lily.tickets WHERE tk_id = ticket_id;

    END IF;

    RETURN true;

    /* errors check */
    EXCEPTION WHEN OTHERS THEN /* in case of any error */
        RAISE NOTICE 'ERROR IN tool_web_lily.f_delete_tickets(integer; boolean) : %', SQLERRM ;
        RETURN false; /* return value */

END;


$_$;


ALTER FUNCTION tool_web_lily.f_delete_tickets(integer, boolean) OWNER TO postgres;

--
-- TOC entry 5792 (class 0 OID 0)
-- Dependencies: 919
-- Name: FUNCTION f_delete_tickets(integer, boolean); Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON FUNCTION tool_web_lily.f_delete_tickets(integer, boolean) IS 'Function for delete ticket';


--
-- TOC entry 920 (class 1255 OID 17330)
-- Name: f_insert_periodic_tickets(integer, timestamp without time zone, timestamp without time zone, integer); Type: FUNCTION; Schema: tool_web_lily; Owner: postgres
--

CREATE FUNCTION tool_web_lily.f_insert_periodic_tickets(integer, timestamp without time zone, timestamp without time zone, integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$

DECLARE
    tk_parent_id    ALIAS FOR $1;
    date_from       ALIAS FOR $2;
    date_to         ALIAS FOR $3;
    frequency       ALIAS FOR $4;

    delta_time text;

BEGIN

    -- TEST SELECT tool_web_lily.f_insert_periodic_tickets(1, '2019-04-29 09:00'::timestamp, '2020-04-29 09:00'::timestamp, 6);

    -- Check if parent ticket exists
    IF NOT EXISTS ( SELECT 1 FROM tool_web_lily.tickets WHERE tk_id = tk_parent_id ) THEN
        RAISE NOTICE 'ERROR IN tool_web_lily.f_delete_tickets(integer; boolean) : parent ticket doesn''t exist' ;
        RETURN false;
    END IF;

    CASE frequency
        WHEN 1 THEN -- 1   Settimanale
            delta_time = '7 days';
        WHEN 2 THEN -- 2   Mensile
            delta_time = '1 month';
        WHEN 3 THEN -- 3   Trimestrale
            delta_time = '3 month';
        WHEN 4 THEN -- 4   Semestrale
            delta_time = '6 month';
        WHEN 5 THEN -- 5   Annuale
            delta_time = '1 year';
        WHEN 6 THEN -- 6   Quindicinale
            delta_time = '15 days';
        WHEN 7 THEN -- 7   Bi-Annuale
            delta_time = '2 years';
        WHEN 9 THEN -- Ogni 6.000 ore
            delta_time = '6000 hours';
        WHEN 10 THEN -- Ogni 20.000 ore
            delta_time = '20000 hours';
        ELSE
    END CASE;

    RAISE NOTICE 'Frequenza: %', delta_time;

    -- Check if delta date is greater equal then 5 years _> not allowed
    IF (SELECT (date_to - date_from)  < interval '5 years') IS FALSE THEN
        RAISE NOTICE 'ERROR IN tool_web_lily.f_delete_tickets(integer; boolean) : max 5 years' ;
        RETURN false;
    END IF;

    -- Loop while date_from is lower than date_to
    WHILE date_from < date_to
    LOOP

        -- EXTRACT 'dow' -> [0-6] where 0 is Sunday
        -- If Saturday + 2 days, else if Sunday + 1 day, else OK
        SELECT INTO date_from
            CASE
                WHEN EXTRACT('dow' FROM (date_from + (delta_time)::interval)) = 6 THEN date_from + delta_time::interval + interval '2 days'
                WHEN EXTRACT('dow' FROM (date_from + (delta_time)::interval)) = 0 THEN date_from + delta_time::interval + interval '1 day'
                ELSE date_from + delta_time::interval
            END AS next_day;

        RAISE NOTICE 'Nuova data: %', date_from;

        -- Check if new date is lower then date_to
        IF date_from < date_to THEN
            INSERT INTO tool_web_lily.tickets
                (tk_opening_date, tk_expiry_date, tk_closure_date, tk_opening_operator_fk, tk_recipient_group_fk, tk_closure_operator_fk, st_id_fk, in_id_fk, cy_id_fk, eq_id_fk, tt_id_fk, tc_id_fk, tk_freq_fk, tk_title, tk_opening_note, tk_closure_note, tk_parent_id_fk)
            (
                SELECT
                    tk_opening_date,
                    date_from                                       AS tk_expiry_date,
                    NULL                                            AS tk_closure_date,
                    tk_opening_operator_fk,
                    tk_recipient_group_fk,
                    NULL                                            AS tk_closure_operator_fk,
                    st_id_fk, in_id_fk, cy_id_fk, eq_id_fk, tt_id_fk,
                    tc_id_fk, tk_freq_fk, tk_title, tk_opening_note,
                    NULL                                            AS tk_closure_note,
                    tk_parent_id                                    AS tk_parent_id_fk
                FROM tool_web_lily.tickets
                WHERE tk_id = tk_parent_id
            );
        END IF;

    END LOOP;

    RETURN TRUE;

    /* errors check */
    EXCEPTION WHEN OTHERS THEN /* in case of any error */
        RAISE NOTICE 'ERROR IN tool_web_lily.f_insert_periodic_tickets(integer, timestamp, timestamp, integer) : %', SQLERRM ;
        RETURN FALSE; /* return value */

END;


$_$;


ALTER FUNCTION tool_web_lily.f_insert_periodic_tickets(integer, timestamp without time zone, timestamp without time zone, integer) OWNER TO postgres;

--
-- TOC entry 5793 (class 0 OID 0)
-- Dependencies: 920
-- Name: FUNCTION f_insert_periodic_tickets(integer, timestamp without time zone, timestamp without time zone, integer); Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON FUNCTION tool_web_lily.f_insert_periodic_tickets(integer, timestamp without time zone, timestamp without time zone, integer) IS 'Function for delete ticket';


--
-- TOC entry 921 (class 1255 OID 17331)
-- Name: get_query_alldata_by_param(integer, timestamp without time zone, timestamp without time zone, boolean); Type: FUNCTION; Schema: tool_web_lily; Owner: postgres
--

CREATE FUNCTION tool_web_lily.get_query_alldata_by_param(integer, timestamp without time zone, timestamp without time zone, boolean) RETURNS text
    LANGUAGE plpgsql
    AS $_$

DECLARE
    prid        ALIAS FOR $1;
    datefrom    ALIAS FOR $2;
    dateto      ALIAS FOR $3;
    flag_active ALIAS FOR $4;

    st_row      record;
    rec         record;
    count       integer;
    select_txt  text;
    join_txt    text;
    sql_query   text;


--  res         public._stations%ROWTYPE;;
BEGIN

    select_txt := 'SELECT m.fulldate';
    join_txt   := 'FROM _master m ';

    count := 0;
    -- TEST SELECT tool_web_lily.get_query_alldata_by_param(1000, '19/11/2018'::timestamp, '21/11/2018'::timestamp, true)
    /* loop through all the stations and parameters */
    FOR st_row in ( SELECT spp.st_id, spp.schema, spp.tableid, spp.pr_id, spp.id
                    FROM public.view_stations_parameters_properties spp
                    LEFT JOIN _stations ss USING (st_id)
                    WHERE pr_id = prid AND station_roaming_type = 0 AND ss.active IS true
                    ORDER BY st_id ) LOOP

        count := count + 1;

        -- RAISE NOTICE 'Schema: %', st_row.schema;
        -- RAISE NOTICE 'Tabella: data_%', st_row.tableid;
        -- RAISE NOTICE 'Id: %', st_row.id;

        select_txt := select_txt || ',
            t' || count ||'.meanvalue AS meanvalue'||count;

        join_txt := join_txt ||'
        LEFT JOIN '|| st_row.schema ||'.data_'|| st_row.tableid ||' t'|| count ||' ON m.fulldate = t'|| count ||'.fulldate AND t'|| count ||'.id = '|| st_row.id::text;

        IF flag_active IS FALSE THEN
            join_txt := join_txt ||' AND t'||count||'.calccode <=2';
        END IF;

        -- RAISE NOTICE 'SELECT TXT: %', select_txt;
        -- RAISE NOTICE 'JOIN TXT: %', join_txt;

    END LOOP;

    -- SELECT m.fulldate, t1.meanvalue, t2.meanvalue
    -- FROM _master m
    -- LEFT JOIN tbl_arpal.data_ge_buozzi t1 ON m.fulldate= t1.fulldate AND t1.id = 12
    -- LEFT JOIN tbl_arpal.data_ge_sarissola_busalla t2 ON m.fulldate= t2.fulldate AND t2.id = 1
    -- WHERE m.fulldate BETWEEN '19-11-2018' AND '21-11-2018';

    sql_query := select_txt ||'
        '|| join_txt ||'
        '|| 'WHERE m.fulldate BETWEEN '''||datefrom||''' AND '''||dateto||''' ORDER BY fulldate;';

    -- RAISE NOTICE 'SQL QUERY: %', sql_query;

    RETURN sql_query;

END;

$_$;


ALTER FUNCTION tool_web_lily.get_query_alldata_by_param(integer, timestamp without time zone, timestamp without time zone, boolean) OWNER TO postgres;

--
-- TOC entry 5794 (class 0 OID 0)
-- Dependencies: 921
-- Name: FUNCTION get_query_alldata_by_param(integer, timestamp without time zone, timestamp without time zone, boolean); Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON FUNCTION tool_web_lily.get_query_alldata_by_param(integer, timestamp without time zone, timestamp without time zone, boolean) IS 'Get query for all stations data of a particular parameter during a certain period';


--
-- TOC entry 922 (class 1255 OID 17332)
-- Name: get_user_last_login(integer); Type: FUNCTION; Schema: tool_web_lily; Owner: postgres
--

CREATE FUNCTION tool_web_lily.get_user_last_login(integer) RETURNS timestamp without time zone
    LANGUAGE plpgsql
    AS $_$
declare
    usid        integer;
    lastonline  timestamp;
BEGIN

    /*userid*/
    usid := $1;

    /*select*/
    SELECT user_last_online AT TIME ZONE('Europe/Rome')
    INTO lastonline
    FROM tool_web_lily.users
    WHERE us_id = usid;

    /*return*/
    RETURN lastonline;

/* errors check */
EXCEPTION
   /* in case of any error */
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in tool_web_lily.get_user_last_login : %', SQLERRM;
END;
$_$;


ALTER FUNCTION tool_web_lily.get_user_last_login(integer) OWNER TO postgres;

--
-- TOC entry 5795 (class 0 OID 0)
-- Dependencies: 922
-- Name: FUNCTION get_user_last_login(integer); Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON FUNCTION tool_web_lily.get_user_last_login(integer) IS 'Get the user last login datetime';


--
-- TOC entry 3427 (class 1417 OID 17358)
-- Name: foreign_server_cf; Type: SERVER; Schema: -; Owner: postgres
--

CREATE SERVER foreign_server_cf FOREIGN DATA WRAPPER postgres_fdw OPTIONS (
    dbname 'rete_llpp',
    host 'cf-db-srv1',
    port '5432'
);


ALTER SERVER foreign_server_cf OWNER TO postgres;

--
-- TOC entry 5796 (class 0 OID 0)
-- Name: USER MAPPING postgres SERVER foreign_server_cf; Type: USER MAPPING; Schema: -; Owner: postgres
--



SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 237 (class 1259 OID 17532)
-- Name: cal_methods; Type: TABLE; Schema: calibrations; Owner: postgres
--

CREATE TABLE calibrations.cal_methods (
    me_id smallint NOT NULL,
    method_desc character varying(200) NOT NULL
);


ALTER TABLE calibrations.cal_methods OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 17535)
-- Name: cal_reasons; Type: TABLE; Schema: calibrations; Owner: postgres
--

CREATE TABLE calibrations.cal_reasons (
    re_id smallint NOT NULL,
    reason_desc character varying(200) NOT NULL
);


ALTER TABLE calibrations.cal_reasons OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 17538)
-- Name: calibrations; Type: TABLE; Schema: calibrations; Owner: postgres
--

CREATE TABLE calibrations.calibrations (
    id bigint NOT NULL,
    st_id smallint NOT NULL,
    pr_id smallint NOT NULL,
    arpa_id smallint NOT NULL,
    fulldate timestamp without time zone NOT NULL,
    zero real,
    zero_set real,
    zero_method smallint,
    cylinder real,
    cylinder_date date,
    span real,
    span_set real,
    span_method smallint,
    reason smallint,
    note text,
    surrogate boolean DEFAULT false
);


ALTER TABLE calibrations.calibrations OWNER TO postgres;

--
-- TOC entry 5797 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE calibrations; Type: COMMENT; Schema: calibrations; Owner: postgres
--

COMMENT ON TABLE calibrations.calibrations IS 'Holds the calibrations data';


--
-- TOC entry 5798 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN calibrations.id; Type: COMMENT; Schema: calibrations; Owner: postgres
--

COMMENT ON COLUMN calibrations.calibrations.id IS 'Holds the unique primary key ID';


--
-- TOC entry 5799 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN calibrations.st_id; Type: COMMENT; Schema: calibrations; Owner: postgres
--

COMMENT ON COLUMN calibrations.calibrations.st_id IS 'Holds the unique station identifier ID';


--
-- TOC entry 5800 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN calibrations.pr_id; Type: COMMENT; Schema: calibrations; Owner: postgres
--

COMMENT ON COLUMN calibrations.calibrations.pr_id IS 'Holds the unique parameter identifier ID';


--
-- TOC entry 5801 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN calibrations.arpa_id; Type: COMMENT; Schema: calibrations; Owner: postgres
--

COMMENT ON COLUMN calibrations.calibrations.arpa_id IS 'Holds the unique instrument identifier ID';


--
-- TOC entry 5802 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN calibrations.fulldate; Type: COMMENT; Schema: calibrations; Owner: postgres
--

COMMENT ON COLUMN calibrations.calibrations.fulldate IS 'Holds the date time of calibration';


--
-- TOC entry 5803 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN calibrations.zero; Type: COMMENT; Schema: calibrations; Owner: postgres
--

COMMENT ON COLUMN calibrations.calibrations.zero IS 'Holds the zero value found';


--
-- TOC entry 5804 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN calibrations.zero_set; Type: COMMENT; Schema: calibrations; Owner: postgres
--

COMMENT ON COLUMN calibrations.calibrations.zero_set IS 'Holds the zero value set';


--
-- TOC entry 5805 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN calibrations.zero_method; Type: COMMENT; Schema: calibrations; Owner: postgres
--

COMMENT ON COLUMN calibrations.calibrations.zero_method IS 'Holds the zero method used id';


--
-- TOC entry 5806 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN calibrations.cylinder; Type: COMMENT; Schema: calibrations; Owner: postgres
--

COMMENT ON COLUMN calibrations.calibrations.cylinder IS 'Holds the the cylinder value';


--
-- TOC entry 5807 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN calibrations.cylinder_date; Type: COMMENT; Schema: calibrations; Owner: postgres
--

COMMENT ON COLUMN calibrations.calibrations.cylinder_date IS 'Holds the the cylinder date';


--
-- TOC entry 5808 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN calibrations.span; Type: COMMENT; Schema: calibrations; Owner: postgres
--

COMMENT ON COLUMN calibrations.calibrations.span IS 'Holds the span found';


--
-- TOC entry 5809 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN calibrations.span_set; Type: COMMENT; Schema: calibrations; Owner: postgres
--

COMMENT ON COLUMN calibrations.calibrations.span_set IS 'Holds the span set';


--
-- TOC entry 5810 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN calibrations.span_method; Type: COMMENT; Schema: calibrations; Owner: postgres
--

COMMENT ON COLUMN calibrations.calibrations.span_method IS 'Holds the span method used id';


--
-- TOC entry 5811 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN calibrations.reason; Type: COMMENT; Schema: calibrations; Owner: postgres
--

COMMENT ON COLUMN calibrations.calibrations.reason IS 'Holds the reason';


--
-- TOC entry 5812 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN calibrations.note; Type: COMMENT; Schema: calibrations; Owner: postgres
--

COMMENT ON COLUMN calibrations.calibrations.note IS 'Holds the notes';


--
-- TOC entry 5813 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN calibrations.surrogate; Type: COMMENT; Schema: calibrations; Owner: postgres
--

COMMENT ON COLUMN calibrations.calibrations.surrogate IS 'Holds the surrogate instrument';


--
-- TOC entry 240 (class 1259 OID 17545)
-- Name: calibrations_id_seq; Type: SEQUENCE; Schema: calibrations; Owner: postgres
--

CREATE SEQUENCE calibrations.calibrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE calibrations.calibrations_id_seq OWNER TO postgres;

--
-- TOC entry 5814 (class 0 OID 0)
-- Dependencies: 240
-- Name: calibrations_id_seq; Type: SEQUENCE OWNED BY; Schema: calibrations; Owner: postgres
--

ALTER SEQUENCE calibrations.calibrations_id_seq OWNED BY calibrations.calibrations.id;


--
-- TOC entry 234 (class 1259 OID 17421)
-- Name: _parameters_list_master; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._parameters_list_master (
    pr_id smallint NOT NULL,
    name character varying(250) DEFAULT ''::character varying,
    shortname character varying(50) DEFAULT ''::character varying,
    unit character varying(25) DEFAULT ''::character varying,
    unitconv character varying(25) DEFAULT ''::character varying,
    formule character varying(200) DEFAULT 'y=x'::character varying,
    treatment smallint DEFAULT 0,
    decimals smallint DEFAULT 1,
    apat_code character varying(4),
    chartstyle smallint DEFAULT 0,
    color integer,
    root_pr_id smallint,
    decimals_ba smallint DEFAULT 0,
    apat_unit_code character varying(1),
    apat_decimals smallint,
    pr_id_scripta text
);


ALTER TABLE public._parameters_list_master OWNER TO postgres;

--
-- TOC entry 5815 (class 0 OID 0)
-- Dependencies: 234
-- Name: COLUMN _parameters_list_master.apat_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public._parameters_list_master.apat_code IS 'Codice apat del parametro';


--
-- TOC entry 5816 (class 0 OID 0)
-- Dependencies: 234
-- Name: COLUMN _parameters_list_master.decimals_ba; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public._parameters_list_master.decimals_ba IS 'The rounding to be applied during the data loading before aggregations';


--
-- TOC entry 5817 (class 0 OID 0)
-- Dependencies: 234
-- Name: COLUMN _parameters_list_master.apat_unit_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public._parameters_list_master.apat_unit_code IS 'Codice apat per l''unità di misura del parametro';


--
-- TOC entry 231 (class 1259 OID 17373)
-- Name: _stations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._stations (
    st_id smallint NOT NULL,
    stationname character varying(50) DEFAULT ''::character varying NOT NULL,
    tableid character varying(25) DEFAULT ''::character varying NOT NULL,
    station_roaming_type smallint DEFAULT 0 NOT NULL,
    po_id smallint DEFAULT 0,
    schema character varying(10) DEFAULT 'public'::character varying,
    active boolean DEFAULT true,
    stationshortname text,
    st_id_scripta smallint
);


ALTER TABLE public._stations OWNER TO postgres;

--
-- TOC entry 5818 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE _stations; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public._stations IS 'Stores the stations';


--
-- TOC entry 5819 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN _stations.schema; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public._stations.schema IS 'Schema the table belong';


--
-- TOC entry 241 (class 1259 OID 17547)
-- Name: view_calibrations; Type: VIEW; Schema: calibrations; Owner: postgres
--

CREATE VIEW calibrations.view_calibrations AS
 SELECT s.st_id,
    p.pr_id,
    s.stationname AS station,
    p.name AS parameter,
    c.arpa_id,
    c.fulldate,
    c.zero,
    c.zero_set,
    c.zero_method AS zero_metodo_id,
    cm1.method_desc AS zero_metodo,
    c.cylinder,
    c.cylinder_date,
    c.span,
    c.span_set,
    c.span_method AS span_metodo_id,
    cm2.method_desc AS span_metodo,
    c.reason AS motivo_id,
    r.reason_desc AS motivo,
    c.note,
    c.surrogate
   FROM (((((calibrations.calibrations c
     JOIN public._stations s USING (st_id))
     LEFT JOIN public._parameters_list_master p USING (pr_id))
     LEFT JOIN calibrations.cal_methods cm1 ON ((c.zero_method = cm1.me_id)))
     LEFT JOIN calibrations.cal_methods cm2 ON ((c.span_method = cm2.me_id)))
     LEFT JOIN calibrations.cal_reasons r ON ((c.reason = r.re_id)));


ALTER TABLE calibrations.view_calibrations OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 17606)
-- Name: daily_reports; Type: TABLE; Schema: journal; Owner: postgres
--

CREATE TABLE journal.daily_reports (
    id bigint NOT NULL,
    year character(4),
    rp_id smallint,
    us_id smallint,
    date_fill timestamp without time zone NOT NULL,
    problem text,
    measure text,
    updates text
);


ALTER TABLE journal.daily_reports OWNER TO postgres;

--
-- TOC entry 5820 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE daily_reports; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON TABLE journal.daily_reports IS 'Hold all the network daily reports';


--
-- TOC entry 5821 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN daily_reports.id; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.daily_reports.id IS 'Progressive total id';


--
-- TOC entry 5822 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN daily_reports.year; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.daily_reports.year IS 'The ref year';


--
-- TOC entry 5823 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN daily_reports.rp_id; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.daily_reports.rp_id IS 'Progressive report id per year';


--
-- TOC entry 5824 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN daily_reports.us_id; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.daily_reports.us_id IS 'The user who filled the report';


--
-- TOC entry 5825 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN daily_reports.date_fill; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.daily_reports.date_fill IS 'Filling date';


--
-- TOC entry 5826 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN daily_reports.problem; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.daily_reports.problem IS 'The problem';


--
-- TOC entry 5827 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN daily_reports.measure; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.daily_reports.measure IS 'The measure taken';


--
-- TOC entry 5828 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN daily_reports.updates; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.daily_reports.updates IS 'Daily status updates';


--
-- TOC entry 243 (class 1259 OID 17612)
-- Name: daily_reports_id_seq; Type: SEQUENCE; Schema: journal; Owner: postgres
--

CREATE SEQUENCE journal.daily_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE journal.daily_reports_id_seq OWNER TO postgres;

--
-- TOC entry 5829 (class 0 OID 0)
-- Dependencies: 243
-- Name: daily_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: journal; Owner: postgres
--

ALTER SEQUENCE journal.daily_reports_id_seq OWNED BY journal.daily_reports.id;


--
-- TOC entry 244 (class 1259 OID 17614)
-- Name: network_maintenances; Type: TABLE; Schema: journal; Owner: postgres
--

CREATE TABLE journal.network_maintenances (
    id integer NOT NULL,
    maintenance character varying(250)
);


ALTER TABLE journal.network_maintenances OWNER TO postgres;

--
-- TOC entry 5830 (class 0 OID 0)
-- Dependencies: 244
-- Name: TABLE network_maintenances; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON TABLE journal.network_maintenances IS 'Hold all the availables maintenances';


--
-- TOC entry 5831 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN network_maintenances.id; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.network_maintenances.id IS 'Progressive unique id';


--
-- TOC entry 5832 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN network_maintenances.maintenance; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.network_maintenances.maintenance IS 'The maintenance itself';


--
-- TOC entry 245 (class 1259 OID 17617)
-- Name: network_maintenances_id_seq; Type: SEQUENCE; Schema: journal; Owner: postgres
--

CREATE SEQUENCE journal.network_maintenances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE journal.network_maintenances_id_seq OWNER TO postgres;

--
-- TOC entry 5833 (class 0 OID 0)
-- Dependencies: 245
-- Name: network_maintenances_id_seq; Type: SEQUENCE OWNED BY; Schema: journal; Owner: postgres
--

ALTER SEQUENCE journal.network_maintenances_id_seq OWNED BY journal.network_maintenances.id;


--
-- TOC entry 246 (class 1259 OID 17619)
-- Name: network_problems; Type: TABLE; Schema: journal; Owner: postgres
--

CREATE TABLE journal.network_problems (
    id integer NOT NULL,
    problem character varying(250)
);


ALTER TABLE journal.network_problems OWNER TO postgres;

--
-- TOC entry 5834 (class 0 OID 0)
-- Dependencies: 246
-- Name: TABLE network_problems; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON TABLE journal.network_problems IS 'Hold all the availables problems';


--
-- TOC entry 5835 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN network_problems.id; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.network_problems.id IS 'Progressive unique id';


--
-- TOC entry 5836 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN network_problems.problem; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.network_problems.problem IS 'The problem itself';


--
-- TOC entry 247 (class 1259 OID 17622)
-- Name: network_problems_id_seq; Type: SEQUENCE; Schema: journal; Owner: postgres
--

CREATE SEQUENCE journal.network_problems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE journal.network_problems_id_seq OWNER TO postgres;

--
-- TOC entry 5837 (class 0 OID 0)
-- Dependencies: 247
-- Name: network_problems_id_seq; Type: SEQUENCE OWNED BY; Schema: journal; Owner: postgres
--

ALTER SEQUENCE journal.network_problems_id_seq OWNED BY journal.network_problems.id;


--
-- TOC entry 248 (class 1259 OID 17624)
-- Name: network_spare_parts; Type: TABLE; Schema: journal; Owner: postgres
--

CREATE TABLE journal.network_spare_parts (
    id integer NOT NULL,
    spare_part character varying(250)
);


ALTER TABLE journal.network_spare_parts OWNER TO postgres;

--
-- TOC entry 5838 (class 0 OID 0)
-- Dependencies: 248
-- Name: TABLE network_spare_parts; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON TABLE journal.network_spare_parts IS 'Hold all the availables spare_parts';


--
-- TOC entry 5839 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN network_spare_parts.id; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.network_spare_parts.id IS 'Progressive unique id';


--
-- TOC entry 5840 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN network_spare_parts.spare_part; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.network_spare_parts.spare_part IS 'The spare_part itself';


--
-- TOC entry 249 (class 1259 OID 17627)
-- Name: network_spare_parts_id_seq; Type: SEQUENCE; Schema: journal; Owner: postgres
--

CREATE SEQUENCE journal.network_spare_parts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE journal.network_spare_parts_id_seq OWNER TO postgres;

--
-- TOC entry 5841 (class 0 OID 0)
-- Dependencies: 249
-- Name: network_spare_parts_id_seq; Type: SEQUENCE OWNED BY; Schema: journal; Owner: postgres
--

ALTER SEQUENCE journal.network_spare_parts_id_seq OWNED BY journal.network_spare_parts.id;


--
-- TOC entry 250 (class 1259 OID 17629)
-- Name: network_stations; Type: TABLE; Schema: journal; Owner: postgres
--

CREATE TABLE journal.network_stations (
    st_id smallint NOT NULL,
    site_name character varying(250)
);


ALTER TABLE journal.network_stations OWNER TO postgres;

--
-- TOC entry 5842 (class 0 OID 0)
-- Dependencies: 250
-- Name: TABLE network_stations; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON TABLE journal.network_stations IS 'Hold all the network stations and sites';


--
-- TOC entry 5843 (class 0 OID 0)
-- Dependencies: 250
-- Name: COLUMN network_stations.st_id; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.network_stations.st_id IS 'Station st_id when applicable';


--
-- TOC entry 5844 (class 0 OID 0)
-- Dependencies: 250
-- Name: COLUMN network_stations.site_name; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.network_stations.site_name IS 'Station or site name';


--
-- TOC entry 251 (class 1259 OID 17632)
-- Name: network_users; Type: TABLE; Schema: journal; Owner: postgres
--

CREATE TABLE journal.network_users (
    id integer NOT NULL,
    username character varying(250),
    create_report boolean DEFAULT false
);


ALTER TABLE journal.network_users OWNER TO postgres;

--
-- TOC entry 5845 (class 0 OID 0)
-- Dependencies: 251
-- Name: TABLE network_users; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON TABLE journal.network_users IS 'Hold all the availables users';


--
-- TOC entry 5846 (class 0 OID 0)
-- Dependencies: 251
-- Name: COLUMN network_users.id; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.network_users.id IS 'Progressive unique id';


--
-- TOC entry 5847 (class 0 OID 0)
-- Dependencies: 251
-- Name: COLUMN network_users.username; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.network_users.username IS 'The user name';


--
-- TOC entry 5848 (class 0 OID 0)
-- Dependencies: 251
-- Name: COLUMN network_users.create_report; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.network_users.create_report IS 'The user can create reports';


--
-- TOC entry 252 (class 1259 OID 17636)
-- Name: network_users_id_seq; Type: SEQUENCE; Schema: journal; Owner: postgres
--

CREATE SEQUENCE journal.network_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE journal.network_users_id_seq OWNER TO postgres;

--
-- TOC entry 5849 (class 0 OID 0)
-- Dependencies: 252
-- Name: network_users_id_seq; Type: SEQUENCE OWNED BY; Schema: journal; Owner: postgres
--

ALTER SEQUENCE journal.network_users_id_seq OWNED BY journal.network_users.id;


--
-- TOC entry 253 (class 1259 OID 17638)
-- Name: reports; Type: TABLE; Schema: journal; Owner: postgres
--

CREATE TABLE journal.reports (
    id bigint NOT NULL,
    year character(4),
    rp_id smallint,
    us_id smallint,
    st_id smallint NOT NULL,
    pr_id smallint,
    date_start timestamp without time zone NOT NULL,
    date_end timestamp without time zone,
    problem text,
    description text,
    solved boolean,
    maintenance text,
    spare_parts text,
    checked boolean DEFAULT false,
    us_id_checked smallint,
    gt_visible boolean DEFAULT false,
    gt_note text,
    gt_color smallint DEFAULT 0
);


ALTER TABLE journal.reports OWNER TO postgres;

--
-- TOC entry 5850 (class 0 OID 0)
-- Dependencies: 253
-- Name: TABLE reports; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON TABLE journal.reports IS 'Hold all the network reports';


--
-- TOC entry 5851 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN reports.id; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports.id IS 'Progressive total id';


--
-- TOC entry 5852 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN reports.year; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports.year IS 'The ref year';


--
-- TOC entry 5853 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN reports.rp_id; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports.rp_id IS 'Progressive report id per year';


--
-- TOC entry 5854 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN reports.us_id; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports.us_id IS 'The user who filled the report';


--
-- TOC entry 5855 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN reports.st_id; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports.st_id IS 'Station or site st_id';


--
-- TOC entry 5856 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN reports.pr_id; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports.pr_id IS 'Parameter prid';


--
-- TOC entry 5857 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN reports.date_start; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports.date_start IS 'Beginning of an event. (or date of the events)';


--
-- TOC entry 5858 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN reports.date_end; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports.date_end IS 'End of the event if not punctual.';


--
-- TOC entry 5859 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN reports.problem; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports.problem IS 'The problem';


--
-- TOC entry 5860 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN reports.description; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports.description IS 'A descriprion';


--
-- TOC entry 5861 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN reports.solved; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports.solved IS 'If solved or not';


--
-- TOC entry 5862 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN reports.maintenance; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports.maintenance IS 'Maintenance executed';


--
-- TOC entry 5863 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN reports.spare_parts; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports.spare_parts IS 'Changed spare parts';


--
-- TOC entry 5864 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN reports.checked; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports.checked IS 'Checked by a user or not';


--
-- TOC entry 5865 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN reports.us_id_checked; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports.us_id_checked IS 'The user id who checked the report';


--
-- TOC entry 5866 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN reports.gt_visible; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports.gt_visible IS 'If set to true is visible in graphical tools (analyser)';


--
-- TOC entry 5867 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN reports.gt_note; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports.gt_note IS 'Graphical tools note (analyser)';


--
-- TOC entry 5868 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN reports.gt_color; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports.gt_color IS 'Color: 0->yellow, 1->green 2->red';


--
-- TOC entry 254 (class 1259 OID 17647)
-- Name: reports2; Type: TABLE; Schema: journal; Owner: postgres
--

CREATE TABLE journal.reports2 (
    id bigint,
    year character(4),
    rp_id smallint,
    us_id smallint,
    st_id smallint,
    pr_id smallint,
    date_start timestamp without time zone,
    date_end timestamp without time zone,
    problem text,
    description text,
    solved boolean,
    maintenance text,
    spare_parts text,
    checked boolean,
    us_id_checked smallint,
    gt_visible boolean,
    gt_note text,
    gt_color smallint
);


ALTER TABLE journal.reports2 OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 17653)
-- Name: reports_id_seq; Type: SEQUENCE; Schema: journal; Owner: postgres
--

CREATE SEQUENCE journal.reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE journal.reports_id_seq OWNER TO postgres;

--
-- TOC entry 5869 (class 0 OID 0)
-- Dependencies: 255
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: journal; Owner: postgres
--

ALTER SEQUENCE journal.reports_id_seq OWNED BY journal.reports.id;


--
-- TOC entry 256 (class 1259 OID 17655)
-- Name: reports_pics; Type: TABLE; Schema: journal; Owner: postgres
--

CREATE TABLE journal.reports_pics (
    id bigint NOT NULL,
    rp_id smallint NOT NULL,
    picture character varying(250) NOT NULL
);


ALTER TABLE journal.reports_pics OWNER TO postgres;

--
-- TOC entry 5870 (class 0 OID 0)
-- Dependencies: 256
-- Name: TABLE reports_pics; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON TABLE journal.reports_pics IS 'Hold all the reports picture paths';


--
-- TOC entry 5871 (class 0 OID 0)
-- Dependencies: 256
-- Name: COLUMN reports_pics.id; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports_pics.id IS 'Progressive total id';


--
-- TOC entry 5872 (class 0 OID 0)
-- Dependencies: 256
-- Name: COLUMN reports_pics.rp_id; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports_pics.rp_id IS 'The reference report';


--
-- TOC entry 5873 (class 0 OID 0)
-- Dependencies: 256
-- Name: COLUMN reports_pics.picture; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON COLUMN journal.reports_pics.picture IS 'Picture path';


--
-- TOC entry 257 (class 1259 OID 17658)
-- Name: reports_pics_id_seq; Type: SEQUENCE; Schema: journal; Owner: postgres
--

CREATE SEQUENCE journal.reports_pics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE journal.reports_pics_id_seq OWNER TO postgres;

--
-- TOC entry 5874 (class 0 OID 0)
-- Dependencies: 257
-- Name: reports_pics_id_seq; Type: SEQUENCE OWNED BY; Schema: journal; Owner: postgres
--

ALTER SEQUENCE journal.reports_pics_id_seq OWNED BY journal.reports_pics.id;


--
-- TOC entry 258 (class 1259 OID 17660)
-- Name: vista_daily_reports; Type: VIEW; Schema: journal; Owner: postgres
--

CREATE VIEW journal.vista_daily_reports AS
 SELECT dr.id AS progressivo,
    dr.year AS anno,
    dr.rp_id AS rpid,
    dr.us_id AS usid,
    nu.username AS utente,
    dr.date_fill AS data_creazione,
    dr.problem AS malfunzionamento,
    dr.measure AS provvedimento,
    dr.updates AS stato_aggiornamento
   FROM (journal.daily_reports dr
     JOIN journal.network_users nu ON ((dr.us_id = nu.id)));


ALTER TABLE journal.vista_daily_reports OWNER TO postgres;

--
-- TOC entry 5875 (class 0 OID 0)
-- Dependencies: 258
-- Name: VIEW vista_daily_reports; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON VIEW journal.vista_daily_reports IS 'Show all the daily reports';


--
-- TOC entry 259 (class 1259 OID 17664)
-- Name: vista_events_notes; Type: VIEW; Schema: journal; Owner: postgres
--

CREATE VIEW journal.vista_events_notes AS
 SELECT jr.id,
    jr.date_start,
    jr.date_end,
    jr.st_id,
    jr.pr_id,
    jr.gt_note,
    jr.description,
    jr.gt_color,
    st.stationname AS station,
    pl.name AS parameter
   FROM ((journal.reports jr
     LEFT JOIN public._stations st USING (st_id))
     LEFT JOIN public._parameters_list_master pl ON ((jr.pr_id = pl.pr_id)))
  WHERE (jr.gt_visible = true);


ALTER TABLE journal.vista_events_notes OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 17669)
-- Name: station_networktype; Type: TABLE; Schema: metadata; Owner: postgres
--

CREATE TABLE metadata.station_networktype (
    id smallint NOT NULL,
    networktype character varying(25) NOT NULL
);


ALTER TABLE metadata.station_networktype OWNER TO postgres;

--
-- TOC entry 5876 (class 0 OID 0)
-- Dependencies: 260
-- Name: TABLE station_networktype; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON TABLE metadata.station_networktype IS 'Support reference table for station types';


--
-- TOC entry 261 (class 1259 OID 17672)
-- Name: station_typology; Type: TABLE; Schema: metadata; Owner: postgres
--

CREATE TABLE metadata.station_typology (
    id smallint NOT NULL,
    typology character varying(25) DEFAULT ''::character varying
);


ALTER TABLE metadata.station_typology OWNER TO postgres;

--
-- TOC entry 5877 (class 0 OID 0)
-- Dependencies: 261
-- Name: TABLE station_typology; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON TABLE metadata.station_typology IS 'Support reference table for station types';


--
-- TOC entry 232 (class 1259 OID 17390)
-- Name: stations_metadata; Type: TABLE; Schema: metadata; Owner: postgres
--

CREATE TABLE metadata.stations_metadata (
    st_id smallint NOT NULL,
    startupdate timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone,
    typology smallint DEFAULT 0,
    locality character varying(25),
    commune character varying(25),
    province character varying(25),
    region character varying(50),
    latitude character varying(15),
    longitude character varying(15),
    note text,
    zone text,
    networktype smallint,
    dismissdate timestamp without time zone,
    basin character varying(250),
    community character varying(250),
    altitude numeric,
    east numeric,
    north numeric,
    lon numeric,
    lat numeric,
    north_wgs84 numeric,
    east_wgs84 numeric,
    lat_wgs84 numeric,
    lon_wgs84 numeric,
    data_collection text,
    type_zone smallint,
    station_type smallint,
    teamviewer_id bigint
);


ALTER TABLE metadata.stations_metadata OWNER TO postgres;

--
-- TOC entry 5878 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN stations_metadata.zone; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON COLUMN metadata.stations_metadata.zone IS 'Zones : A, B, C, D';


--
-- TOC entry 5879 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN stations_metadata.networktype; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON COLUMN metadata.stations_metadata.networktype IS 'Net : cf, arpa, pc, cva ...';


--
-- TOC entry 5880 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN stations_metadata.lon; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON COLUMN metadata.stations_metadata.lon IS 'Longitude coordinate in degrees';


--
-- TOC entry 5881 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN stations_metadata.lat; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON COLUMN metadata.stations_metadata.lat IS 'Latitude coordinate in degrees';


--
-- TOC entry 5882 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN stations_metadata.north_wgs84; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON COLUMN metadata.stations_metadata.north_wgs84 IS 'Nord coordinate in meters for WGS84';


--
-- TOC entry 5883 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN stations_metadata.east_wgs84; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON COLUMN metadata.stations_metadata.east_wgs84 IS 'East coordinate in meters for WGS84';


--
-- TOC entry 5884 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN stations_metadata.lat_wgs84; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON COLUMN metadata.stations_metadata.lat_wgs84 IS 'Nord coordinate in degrees for WGS84';


--
-- TOC entry 5885 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN stations_metadata.lon_wgs84; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON COLUMN metadata.stations_metadata.lon_wgs84 IS 'East coordinate in degrees for WGS84';


--
-- TOC entry 5886 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN stations_metadata.data_collection; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON COLUMN metadata.stations_metadata.data_collection IS 'The data collection notes';


--
-- TOC entry 5887 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN stations_metadata.type_zone; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON COLUMN metadata.stations_metadata.type_zone IS 'Type zone as urban, rural, ecc';


--
-- TOC entry 5888 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN stations_metadata.station_type; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON COLUMN metadata.stations_metadata.station_type IS 'European station type';


--
-- TOC entry 5889 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN stations_metadata.teamviewer_id; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON COLUMN metadata.stations_metadata.teamviewer_id IS 'teamviewer station id';


--
-- TOC entry 262 (class 1259 OID 17676)
-- Name: metadati_standard; Type: VIEW; Schema: metadata; Owner: postgres
--

CREATE VIEW metadata.metadati_standard AS
 SELECT st.st_id,
    st.stationname AS stazione,
    st.po_id AS posizione,
    mstty.typology AS tipo_stazione,
    mstnt.networktype AS tipo_rete,
    mst.startupdate AS data_inizio,
    mst.dismissdate AS data_fine,
    mst.zone AS zona,
    mst.basin AS bacino,
    mst.locality AS localita,
    mst.commune AS comune,
    mst.community AS comunita,
    mst.province AS provincia,
    mst.region AS regione,
    mst.longitude AS longitudine,
    mst.latitude AS latitudine,
    mst.north AS utm_nord,
    mst.east AS utm_est,
    mst.lat AS lat_gradi,
    mst.lon AS lon_gradi,
    mst.north_wgs84 AS utm_nord_wgs84,
    mst.east_wgs84 AS utm_est_wgs84,
    mst.lat_wgs84 AS lat_gradi_wgs84,
    mst.lon_wgs84 AS lon_gradi_wgs84,
    mst.altitude AS altitudine,
    mst.note,
    mstty.id AS tipo_stazione_id,
    mstnt.id AS tipo_rete_id
   FROM (((public._stations st
     LEFT JOIN metadata.stations_metadata mst USING (st_id))
     LEFT JOIN metadata.station_typology mstty ON ((mst.typology = mstty.id)))
     LEFT JOIN metadata.station_networktype mstnt ON ((mst.networktype = mstnt.id)))
  ORDER BY st.st_id;


ALTER TABLE metadata.metadati_standard OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 17681)
-- Name: vista_network_stations; Type: VIEW; Schema: journal; Owner: postgres
--

CREATE VIEW journal.vista_network_stations AS
 SELECT network_stations.st_id,
    network_stations.site_name,
    mt.stazione,
    mt.posizione,
    mt.tipo_stazione,
    mt.tipo_rete,
    mt.data_inizio,
    mt.data_fine,
    mt.zona,
    mt.bacino,
    mt.localita,
    mt.comune,
    mt.comunita,
    mt.provincia,
    mt.regione,
    mt.longitudine,
    mt.latitudine,
    mt.utm_est,
    mt.utm_nord,
    mt.altitudine,
    mt.note
   FROM (journal.network_stations
     LEFT JOIN metadata.metadati_standard mt USING (st_id));


ALTER TABLE journal.vista_network_stations OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 17686)
-- Name: vista_reports; Type: VIEW; Schema: journal; Owner: postgres
--

CREATE VIEW journal.vista_reports AS
 SELECT nr.id AS progressivo,
    nr.year AS anno,
    nr.rp_id AS rpid,
    nr.us_id AS usid,
    nu.username AS utente,
    ns.site_name AS sito,
    pl.name AS parametro,
    nr.st_id AS stid,
    nr.pr_id AS prid,
    nr.date_start AS datainizio,
    nr.date_end AS datafine,
    nr.problem AS problema,
    nr.description AS descrizione,
    nr.solved AS risolto,
    nr.maintenance AS manutenzione,
    nr.spare_parts AS partiricambio,
    nr.checked AS verificato,
    nr.us_id_checked AS utente_verifica_usid,
    nr.gt_visible AS g_visiblile,
    nr.gt_note AS g_nota,
    nr.gt_color AS g_colore
   FROM (((journal.reports nr
     LEFT JOIN journal.network_stations ns USING (st_id))
     LEFT JOIN public._parameters_list_master pl USING (pr_id))
     LEFT JOIN journal.network_users nu ON ((nr.us_id = nu.id)));


ALTER TABLE journal.vista_reports OWNER TO postgres;

--
-- TOC entry 5890 (class 0 OID 0)
-- Dependencies: 264
-- Name: VIEW vista_reports; Type: COMMENT; Schema: journal; Owner: postgres
--

COMMENT ON VIEW journal.vista_reports IS 'Show all the reports';


--
-- TOC entry 265 (class 1259 OID 17691)
-- Name: _laboratory_analysis; Type: TABLE; Schema: labanalysis; Owner: postgres
--

CREATE TABLE labanalysis._laboratory_analysis (
    an_id smallint NOT NULL,
    analysis character varying(50) DEFAULT ''::character varying,
    unit character varying(25) DEFAULT 'ng/m³'::character varying,
    unitconv character varying(25) DEFAULT 'ng/m³'::character varying,
    formule character varying(200) DEFAULT '1'::character varying
);


ALTER TABLE labanalysis._laboratory_analysis OWNER TO postgres;

--
-- TOC entry 5891 (class 0 OID 0)
-- Dependencies: 265
-- Name: TABLE _laboratory_analysis; Type: COMMENT; Schema: labanalysis; Owner: postgres
--

COMMENT ON TABLE labanalysis._laboratory_analysis IS 'Support reference table for laboratory';


--
-- TOC entry 266 (class 1259 OID 17698)
-- Name: _laboratory_analysis_parameters; Type: TABLE; Schema: labanalysis; Owner: postgres
--

CREATE TABLE labanalysis._laboratory_analysis_parameters (
    lab_pr_id integer NOT NULL,
    an_id smallint,
    pr_id smallint,
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE labanalysis._laboratory_analysis_parameters OWNER TO postgres;

--
-- TOC entry 5892 (class 0 OID 0)
-- Dependencies: 266
-- Name: TABLE _laboratory_analysis_parameters; Type: COMMENT; Schema: labanalysis; Owner: postgres
--

COMMENT ON TABLE labanalysis._laboratory_analysis_parameters IS 'Support reference table for laboratory';


--
-- TOC entry 267 (class 1259 OID 17702)
-- Name: _laboratory_analysis_parameters_lab_pr_id_seq; Type: SEQUENCE; Schema: labanalysis; Owner: postgres
--

CREATE SEQUENCE labanalysis._laboratory_analysis_parameters_lab_pr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE labanalysis._laboratory_analysis_parameters_lab_pr_id_seq OWNER TO postgres;

--
-- TOC entry 5893 (class 0 OID 0)
-- Dependencies: 267
-- Name: _laboratory_analysis_parameters_lab_pr_id_seq; Type: SEQUENCE OWNED BY; Schema: labanalysis; Owner: postgres
--

ALTER SEQUENCE labanalysis._laboratory_analysis_parameters_lab_pr_id_seq OWNED BY labanalysis._laboratory_analysis_parameters.lab_pr_id;


--
-- TOC entry 268 (class 1259 OID 17704)
-- Name: _laboratory_filter; Type: TABLE; Schema: labanalysis; Owner: postgres
--

CREATE TABLE labanalysis._laboratory_filter (
    fi_id integer NOT NULL,
    filter character varying(25) DEFAULT ''::character varying
);


ALTER TABLE labanalysis._laboratory_filter OWNER TO postgres;

--
-- TOC entry 5894 (class 0 OID 0)
-- Dependencies: 268
-- Name: TABLE _laboratory_filter; Type: COMMENT; Schema: labanalysis; Owner: postgres
--

COMMENT ON TABLE labanalysis._laboratory_filter IS 'Support reference table for laboratory';


--
-- TOC entry 269 (class 1259 OID 17708)
-- Name: _laboratory_filter_fi_id_seq; Type: SEQUENCE; Schema: labanalysis; Owner: postgres
--

CREATE SEQUENCE labanalysis._laboratory_filter_fi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE labanalysis._laboratory_filter_fi_id_seq OWNER TO postgres;

--
-- TOC entry 5895 (class 0 OID 0)
-- Dependencies: 269
-- Name: _laboratory_filter_fi_id_seq; Type: SEQUENCE OWNED BY; Schema: labanalysis; Owner: postgres
--

ALTER SEQUENCE labanalysis._laboratory_filter_fi_id_seq OWNED BY labanalysis._laboratory_filter.fi_id;


--
-- TOC entry 270 (class 1259 OID 17710)
-- Name: deposimeters_input_data; Type: TABLE; Schema: labanalysis; Owner: postgres
--

CREATE TABLE labanalysis.deposimeters_input_data (
    id integer NOT NULL,
    sp_id integer NOT NULL,
    lab_pr_id smallint NOT NULL,
    measure numeric,
    filter numeric,
    filtered numeric
);


ALTER TABLE labanalysis.deposimeters_input_data OWNER TO postgres;

--
-- TOC entry 5896 (class 0 OID 0)
-- Dependencies: 270
-- Name: TABLE deposimeters_input_data; Type: COMMENT; Schema: labanalysis; Owner: postgres
--

COMMENT ON TABLE labanalysis.deposimeters_input_data IS 'Deposimeters data table for original data';


--
-- TOC entry 5897 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN deposimeters_input_data.id; Type: COMMENT; Schema: labanalysis; Owner: postgres
--

COMMENT ON COLUMN labanalysis.deposimeters_input_data.id IS 'Unique id';


--
-- TOC entry 5898 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN deposimeters_input_data.sp_id; Type: COMMENT; Schema: labanalysis; Owner: postgres
--

COMMENT ON COLUMN labanalysis.deposimeters_input_data.sp_id IS 'Filter sample id';


--
-- TOC entry 5899 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN deposimeters_input_data.lab_pr_id; Type: COMMENT; Schema: labanalysis; Owner: postgres
--

COMMENT ON COLUMN labanalysis.deposimeters_input_data.lab_pr_id IS 'Data prid';


--
-- TOC entry 5900 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN deposimeters_input_data.measure; Type: COMMENT; Schema: labanalysis; Owner: postgres
--

COMMENT ON COLUMN labanalysis.deposimeters_input_data.measure IS 'Measure value';


--
-- TOC entry 5901 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN deposimeters_input_data.filter; Type: COMMENT; Schema: labanalysis; Owner: postgres
--

COMMENT ON COLUMN labanalysis.deposimeters_input_data.filter IS 'Filter value';


--
-- TOC entry 5902 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN deposimeters_input_data.filtered; Type: COMMENT; Schema: labanalysis; Owner: postgres
--

COMMENT ON COLUMN labanalysis.deposimeters_input_data.filtered IS 'Filtered value';


--
-- TOC entry 271 (class 1259 OID 17716)
-- Name: deposimeters_input_data_id_seq; Type: SEQUENCE; Schema: labanalysis; Owner: postgres
--

CREATE SEQUENCE labanalysis.deposimeters_input_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE labanalysis.deposimeters_input_data_id_seq OWNER TO postgres;

--
-- TOC entry 5903 (class 0 OID 0)
-- Dependencies: 271
-- Name: deposimeters_input_data_id_seq; Type: SEQUENCE OWNED BY; Schema: labanalysis; Owner: postgres
--

ALTER SEQUENCE labanalysis.deposimeters_input_data_id_seq OWNED BY labanalysis.deposimeters_input_data.id;


--
-- TOC entry 272 (class 1259 OID 17718)
-- Name: laboratory_data; Type: TABLE; Schema: labanalysis; Owner: postgres
--

CREATE TABLE labanalysis.laboratory_data (
    id integer NOT NULL,
    sp_id integer NOT NULL,
    lab_pr_id smallint NOT NULL,
    conc double precision,
    mass double precision
);


ALTER TABLE labanalysis.laboratory_data OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 17721)
-- Name: laboratory_data_id_seq; Type: SEQUENCE; Schema: labanalysis; Owner: postgres
--

CREATE SEQUENCE labanalysis.laboratory_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE labanalysis.laboratory_data_id_seq OWNER TO postgres;

--
-- TOC entry 5904 (class 0 OID 0)
-- Dependencies: 273
-- Name: laboratory_data_id_seq; Type: SEQUENCE OWNED BY; Schema: labanalysis; Owner: postgres
--

ALTER SEQUENCE labanalysis.laboratory_data_id_seq OWNED BY labanalysis.laboratory_data.id;


--
-- TOC entry 274 (class 1259 OID 17723)
-- Name: laboratory_data_white; Type: TABLE; Schema: labanalysis; Owner: postgres
--

CREATE TABLE labanalysis.laboratory_data_white (
    id integer NOT NULL,
    sp_id integer NOT NULL,
    lab_pr_id smallint NOT NULL,
    conc double precision,
    mass double precision
);


ALTER TABLE labanalysis.laboratory_data_white OWNER TO postgres;

--
-- TOC entry 5905 (class 0 OID 0)
-- Dependencies: 274
-- Name: TABLE laboratory_data_white; Type: COMMENT; Schema: labanalysis; Owner: postgres
--

COMMENT ON TABLE labanalysis.laboratory_data_white IS 'Laboratorio analisi filtri bianchi dati';


--
-- TOC entry 275 (class 1259 OID 17726)
-- Name: laboratory_data_white_id_seq; Type: SEQUENCE; Schema: labanalysis; Owner: postgres
--

CREATE SEQUENCE labanalysis.laboratory_data_white_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE labanalysis.laboratory_data_white_id_seq OWNER TO postgres;

--
-- TOC entry 5906 (class 0 OID 0)
-- Dependencies: 275
-- Name: laboratory_data_white_id_seq; Type: SEQUENCE OWNED BY; Schema: labanalysis; Owner: postgres
--

ALTER SEQUENCE labanalysis.laboratory_data_white_id_seq OWNED BY labanalysis.laboratory_data_white.id;


--
-- TOC entry 276 (class 1259 OID 17728)
-- Name: laboratory_samples; Type: TABLE; Schema: labanalysis; Owner: postgres
--

CREATE TABLE labanalysis.laboratory_samples (
    id integer NOT NULL,
    sp_id integer NOT NULL,
    st_id smallint,
    fi_id smallint,
    an_id smallint,
    date_start timestamp without time zone NOT NULL,
    no_days smallint NOT NULL,
    volume double precision,
    date_insert timestamp without time zone,
    note text,
    locked_sample boolean DEFAULT false,
    locked_data boolean DEFAULT false
);


ALTER TABLE labanalysis.laboratory_samples OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 17736)
-- Name: laboratory_samples_id_seq; Type: SEQUENCE; Schema: labanalysis; Owner: postgres
--

CREATE SEQUENCE labanalysis.laboratory_samples_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE labanalysis.laboratory_samples_id_seq OWNER TO postgres;

--
-- TOC entry 5907 (class 0 OID 0)
-- Dependencies: 277
-- Name: laboratory_samples_id_seq; Type: SEQUENCE OWNED BY; Schema: labanalysis; Owner: postgres
--

ALTER SEQUENCE labanalysis.laboratory_samples_id_seq OWNED BY labanalysis.laboratory_samples.id;


--
-- TOC entry 278 (class 1259 OID 17738)
-- Name: laboratory_samples_white; Type: TABLE; Schema: labanalysis; Owner: postgres
--

CREATE TABLE labanalysis.laboratory_samples_white (
    id integer NOT NULL,
    sp_id integer NOT NULL,
    st_id smallint,
    fi_id smallint,
    an_id smallint,
    date_start timestamp without time zone NOT NULL,
    no_days smallint NOT NULL,
    volume double precision,
    note text,
    date_insert timestamp without time zone
);


ALTER TABLE labanalysis.laboratory_samples_white OWNER TO postgres;

--
-- TOC entry 5908 (class 0 OID 0)
-- Dependencies: 278
-- Name: TABLE laboratory_samples_white; Type: COMMENT; Schema: labanalysis; Owner: postgres
--

COMMENT ON TABLE labanalysis.laboratory_samples_white IS 'Laboratorio analisi filtri bianchi';


--
-- TOC entry 279 (class 1259 OID 17744)
-- Name: laboratory_samples_white_id_seq; Type: SEQUENCE; Schema: labanalysis; Owner: postgres
--

CREATE SEQUENCE labanalysis.laboratory_samples_white_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE labanalysis.laboratory_samples_white_id_seq OWNER TO postgres;

--
-- TOC entry 5909 (class 0 OID 0)
-- Dependencies: 279
-- Name: laboratory_samples_white_id_seq; Type: SEQUENCE OWNED BY; Schema: labanalysis; Owner: postgres
--

ALTER SEQUENCE labanalysis.laboratory_samples_white_id_seq OWNED BY labanalysis.laboratory_samples_white.id;


--
-- TOC entry 280 (class 1259 OID 17746)
-- Name: users_laboratory_analysis; Type: TABLE; Schema: labanalysis; Owner: postgres
--

CREATE TABLE labanalysis.users_laboratory_analysis (
    us_id smallint NOT NULL,
    an_id smallint NOT NULL
);


ALTER TABLE labanalysis.users_laboratory_analysis OWNER TO postgres;

--
-- TOC entry 5910 (class 0 OID 0)
-- Dependencies: 280
-- Name: TABLE users_laboratory_analysis; Type: COMMENT; Schema: labanalysis; Owner: postgres
--

COMMENT ON TABLE labanalysis.users_laboratory_analysis IS 'Filter visible by user';


--
-- TOC entry 281 (class 1259 OID 17749)
-- Name: view_analysis_parameters; Type: VIEW; Schema: labanalysis; Owner: postgres
--

CREATE VIEW labanalysis.view_analysis_parameters AS
 SELECT _laboratory_analysis.analysis,
    _parameters_list.name,
    _laboratory_analysis.an_id,
    _laboratory_analysis_parameters.lab_pr_id,
    _laboratory_analysis_parameters.pr_id,
    _laboratory_analysis_parameters.enabled
   FROM ((labanalysis._laboratory_analysis
     JOIN labanalysis._laboratory_analysis_parameters USING (an_id))
     JOIN public._parameters_list_master _parameters_list USING (pr_id))
  ORDER BY _laboratory_analysis.an_id, _laboratory_analysis_parameters.lab_pr_id;


ALTER TABLE labanalysis.view_analysis_parameters OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 17754)
-- Name: view_analysis_samples; Type: VIEW; Schema: labanalysis; Owner: postgres
--

CREATE VIEW labanalysis.view_analysis_samples AS
 SELECT laboratory_samples.sp_id,
    laboratory_samples.st_id,
    laboratory_samples.fi_id,
    laboratory_samples.an_id,
    laboratory_samples.date_start,
    laboratory_samples.no_days,
    laboratory_samples.volume,
    laboratory_samples.date_insert,
    laboratory_samples.note,
    laboratory_samples.locked_sample,
    laboratory_samples.locked_data,
    _stations.stationname,
    _laboratory_filter.filter AS filter_name,
    _laboratory_analysis.analysis AS analysis_name
   FROM (((labanalysis.laboratory_samples
     JOIN public._stations ON ((laboratory_samples.st_id = _stations.st_id)))
     JOIN labanalysis._laboratory_analysis ON ((laboratory_samples.an_id = _laboratory_analysis.an_id)))
     JOIN labanalysis._laboratory_filter ON ((laboratory_samples.fi_id = _laboratory_filter.fi_id)));


ALTER TABLE labanalysis.view_analysis_samples OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 17759)
-- Name: view_analysis_samples_by_user; Type: VIEW; Schema: labanalysis; Owner: postgres
--

CREATE VIEW labanalysis.view_analysis_samples_by_user AS
 SELECT laboratory_samples.sp_id,
    laboratory_samples.st_id,
    laboratory_samples.fi_id,
    laboratory_samples.an_id,
    laboratory_samples.date_start,
    laboratory_samples.no_days,
    laboratory_samples.volume,
    laboratory_samples.date_insert,
    laboratory_samples.note,
    laboratory_samples.locked_sample,
    laboratory_samples.locked_data,
    _stations.stationname,
    _laboratory_filter.filter AS filter_name,
    _laboratory_analysis.analysis AS analysis_name,
    users_laboratory_analysis.us_id
   FROM ((((labanalysis.laboratory_samples
     JOIN public._stations ON ((laboratory_samples.st_id = _stations.st_id)))
     JOIN labanalysis._laboratory_analysis ON ((laboratory_samples.an_id = _laboratory_analysis.an_id)))
     JOIN labanalysis._laboratory_filter ON ((laboratory_samples.fi_id = _laboratory_filter.fi_id)))
     JOIN labanalysis.users_laboratory_analysis ON ((users_laboratory_analysis.an_id = _laboratory_analysis.an_id)));


ALTER TABLE labanalysis.view_analysis_samples_by_user OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 17764)
-- Name: view_analysis_samples_lily; Type: VIEW; Schema: labanalysis; Owner: postgres
--

CREATE VIEW labanalysis.view_analysis_samples_lily AS
 SELECT ls.id,
    ls.sp_id,
    ls.st_id,
    ls.fi_id,
    ls.an_id,
    ls.date_start,
    ls.no_days,
    ls.volume,
    ls.date_insert,
    ls.note,
    ls.locked_sample,
    ls.locked_data,
    ss.stationname,
    lf.filter AS filter_name,
    la.analysis AS analysis_name,
    ula.us_id
   FROM ((((labanalysis.laboratory_samples ls
     LEFT JOIN public._stations ss USING (st_id))
     LEFT JOIN labanalysis._laboratory_analysis la USING (an_id))
     LEFT JOIN labanalysis._laboratory_filter lf USING (fi_id))
     LEFT JOIN labanalysis.users_laboratory_analysis ula USING (an_id));


ALTER TABLE labanalysis.view_analysis_samples_lily OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 17801)
-- Name: view_sample_data; Type: VIEW; Schema: labanalysis; Owner: postgres
--

CREATE VIEW labanalysis.view_sample_data AS
 SELECT laboratory_samples.sp_id,
    laboratory_samples.st_id,
    laboratory_samples.date_start,
    (laboratory_samples.no_days)::character varying AS no_days,
    laboratory_data.lab_pr_id,
    _laboratory_analysis_parameters.pr_id,
    round((laboratory_data.mass)::numeric, 3) AS lab_mass,
    round((laboratory_data.conc)::numeric, 3) AS lab_conc
   FROM ((labanalysis.laboratory_samples
     JOIN labanalysis.laboratory_data USING (sp_id))
     JOIN labanalysis._laboratory_analysis_parameters USING (lab_pr_id))
  ORDER BY laboratory_samples.sp_id;


ALTER TABLE labanalysis.view_sample_data OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17436)
-- Name: _stations_parameters_master; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._stations_parameters_master (
    st_pr_id integer NOT NULL,
    st_id smallint,
    pr_id smallint,
    id smallint,
    hidden boolean DEFAULT false,
    description character varying(25),
    active boolean DEFAULT true,
    pubblica_web boolean DEFAULT false
);


ALTER TABLE public._stations_parameters_master OWNER TO postgres;

--
-- TOC entry 5911 (class 0 OID 0)
-- Dependencies: 235
-- Name: TABLE _stations_parameters_master; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public._stations_parameters_master IS 'Associazione degli ID web dei parametri con gli ID dei parametri di ogni stazione.
Gli ID web dei parametri sono unici per tutte le stazioni.
Ma ogni stazione ha un proprio ID per gli stessi parametri.';


--
-- TOC entry 286 (class 1259 OID 17806)
-- Name: view_sample_data_parameters; Type: VIEW; Schema: labanalysis; Owner: postgres
--

CREATE VIEW labanalysis.view_sample_data_parameters AS
 SELECT sd.sp_id,
    sd.st_id,
    sd.date_start,
    sd.no_days,
    sd.lab_pr_id,
    sd.pr_id,
    sd.lab_conc,
    sp.id
   FROM (labanalysis.view_sample_data sd
     JOIN public._stations_parameters_master sp USING (pr_id))
  WHERE (sp.st_id = sd.st_id);


ALTER TABLE labanalysis.view_sample_data_parameters OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17418)
-- Name: stations_metadata_extended; Type: TABLE; Schema: metadata; Owner: postgres
--

CREATE TABLE metadata.stations_metadata_extended (
    st_id smallint NOT NULL,
    apat_code character varying(7)
);


ALTER TABLE metadata.stations_metadata_extended OWNER TO postgres;

--
-- TOC entry 5912 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE stations_metadata_extended; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON TABLE metadata.stations_metadata_extended IS 'Holds other stations metadata';


--
-- TOC entry 287 (class 1259 OID 17810)
-- Name: metadati_estesa; Type: VIEW; Schema: metadata; Owner: postgres
--

CREATE VIEW metadata.metadati_estesa AS
 SELECT mst.st_id,
    mst.stazione,
    mst.posizione,
    mst.tipo_stazione,
    mst.tipo_rete,
    mst.data_inizio,
    mst.data_fine,
    mst.zona,
    mst.bacino,
    mst.localita,
    mst.comune,
    mst.comunita,
    mst.provincia,
    mst.regione,
    mst.longitudine,
    mst.latitudine,
    mst.utm_nord,
    mst.utm_est,
    mst.lat_gradi,
    mst.lon_gradi,
    mst.utm_nord_wgs84,
    mst.utm_est_wgs84,
    mst.lat_gradi_wgs84,
    mst.lon_gradi_wgs84,
    mst.altitudine,
    mst.note,
    mst.tipo_stazione_id,
    mst.tipo_rete_id,
    mstex.apat_code AS codice_apat
   FROM (metadata.metadati_standard mst
     LEFT JOIN metadata.stations_metadata_extended mstex USING (st_id));


ALTER TABLE metadata.metadati_estesa OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 17815)
-- Name: station_type; Type: TABLE; Schema: metadata; Owner: postgres
--

CREATE TABLE metadata.station_type (
    id smallint NOT NULL,
    type text NOT NULL
);


ALTER TABLE metadata.station_type OWNER TO postgres;

--
-- TOC entry 5913 (class 0 OID 0)
-- Dependencies: 288
-- Name: TABLE station_type; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON TABLE metadata.station_type IS 'Support reference table for station types';


--
-- TOC entry 289 (class 1259 OID 17821)
-- Name: station_zone; Type: TABLE; Schema: metadata; Owner: postgres
--

CREATE TABLE metadata.station_zone (
    id smallint NOT NULL,
    zone text NOT NULL
);


ALTER TABLE metadata.station_zone OWNER TO postgres;

--
-- TOC entry 5914 (class 0 OID 0)
-- Dependencies: 289
-- Name: TABLE station_zone; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON TABLE metadata.station_zone IS 'Support reference table for station zones';


--
-- TOC entry 290 (class 1259 OID 17827)
-- Name: stations_metadata_info; Type: TABLE; Schema: metadata; Owner: postgres
--

CREATE TABLE metadata.stations_metadata_info (
    st_id smallint NOT NULL,
    info json NOT NULL,
    last_update timestamp without time zone DEFAULT now()
);


ALTER TABLE metadata.stations_metadata_info OWNER TO postgres;

--
-- TOC entry 5915 (class 0 OID 0)
-- Dependencies: 290
-- Name: TABLE stations_metadata_info; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON TABLE metadata.stations_metadata_info IS 'Info about stations metadata';


--
-- TOC entry 5916 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN stations_metadata_info.st_id; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON COLUMN metadata.stations_metadata_info.st_id IS 'Station ID';


--
-- TOC entry 5917 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN stations_metadata_info.info; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON COLUMN metadata.stations_metadata_info.info IS 'All the info about this station';


--
-- TOC entry 5918 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN stations_metadata_info.last_update; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON COLUMN metadata.stations_metadata_info.last_update IS 'Last time updating infos';


--
-- TOC entry 291 (class 1259 OID 17834)
-- Name: stations_metadata_instruments; Type: TABLE; Schema: metadata; Owner: postgres
--

CREATE TABLE metadata.stations_metadata_instruments (
    st_id smallint NOT NULL,
    rain_gauge_heated boolean
);


ALTER TABLE metadata.stations_metadata_instruments OWNER TO postgres;

--
-- TOC entry 5919 (class 0 OID 0)
-- Dependencies: 291
-- Name: TABLE stations_metadata_instruments; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON TABLE metadata.stations_metadata_instruments IS 'Holds stations metadata per parameter';


--
-- TOC entry 5920 (class 0 OID 0)
-- Dependencies: 291
-- Name: COLUMN stations_metadata_instruments.rain_gauge_heated; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON COLUMN metadata.stations_metadata_instruments.rain_gauge_heated IS 'True if the gauge is heated';


--
-- TOC entry 292 (class 1259 OID 17837)
-- Name: stations_metadata_pictures_maps; Type: TABLE; Schema: metadata; Owner: postgres
--

CREATE TABLE metadata.stations_metadata_pictures_maps (
    st_id smallint NOT NULL,
    dateedit timestamp without time zone DEFAULT now(),
    img bytea,
    map bytea
);


ALTER TABLE metadata.stations_metadata_pictures_maps OWNER TO postgres;

--
-- TOC entry 5921 (class 0 OID 0)
-- Dependencies: 292
-- Name: TABLE stations_metadata_pictures_maps; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON TABLE metadata.stations_metadata_pictures_maps IS 'Holds the stations metadata';


--
-- TOC entry 5922 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN stations_metadata_pictures_maps.st_id; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON COLUMN metadata.stations_metadata_pictures_maps.st_id IS 'The stid';


--
-- TOC entry 5923 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN stations_metadata_pictures_maps.dateedit; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON COLUMN metadata.stations_metadata_pictures_maps.dateedit IS 'The last update date';


--
-- TOC entry 5924 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN stations_metadata_pictures_maps.img; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON COLUMN metadata.stations_metadata_pictures_maps.img IS 'The image';


--
-- TOC entry 5925 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN stations_metadata_pictures_maps.map; Type: COMMENT; Schema: metadata; Owner: postgres
--

COMMENT ON COLUMN metadata.stations_metadata_pictures_maps.map IS 'The map';


--
-- TOC entry 293 (class 1259 OID 17844)
-- Name: cylinders; Type: TABLE; Schema: operations; Owner: postgres
--

CREATE TABLE operations.cylinders (
    cy_id text NOT NULL,
    cy_descrizione text NOT NULL,
    produttore text,
    fornitore text,
    capacity text,
    stability text,
    production_date date NOT NULL,
    expire_date date NOT NULL,
    pressione integer,
    note text
);


ALTER TABLE operations.cylinders OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 17850)
-- Name: cylinders_parameters; Type: TABLE; Schema: operations; Owner: postgres
--

CREATE TABLE operations.cylinders_parameters (
    cy_id text NOT NULL,
    pr_id smallint NOT NULL,
    concentration smallint,
    uncertainty text
);


ALTER TABLE operations.cylinders_parameters OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 17856)
-- Name: instruments; Type: TABLE; Schema: operations; Owner: postgres
--

CREATE TABLE operations.instruments (
    arpa_id integer NOT NULL,
    n_matricola integer,
    n_serie integer,
    n_inventario integer,
    stato_ricevimento text,
    d_ricevimento date,
    d_collaudo date,
    d_servizio date,
    range_utilizzo text,
    note text,
    tp_in_id integer,
    fl_sk_strumento boolean DEFAULT true
);


ALTER TABLE operations.instruments OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 17863)
-- Name: instruments_has_ricambi; Type: TABLE; Schema: operations; Owner: postgres
--

CREATE TABLE operations.instruments_has_ricambi (
    arpa_id smallint NOT NULL,
    ri_id smallint NOT NULL
);


ALTER TABLE operations.instruments_has_ricambi OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 17866)
-- Name: instruments_type; Type: TABLE; Schema: operations; Owner: postgres
--

CREATE TABLE operations.instruments_type (
    tp_in_id integer NOT NULL,
    marca text,
    modello text,
    costruttore text,
    classe smallint,
    fl_taratura boolean,
    istruzioni_operative text,
    collocazioni_istruzioni text,
    range_lavoro text,
    manuale text,
    descrizione text,
    ct_id smallint
);


ALTER TABLE operations.instruments_type OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 17872)
-- Name: instruments_type_category; Type: TABLE; Schema: operations; Owner: postgres
--

CREATE TABLE operations.instruments_type_category (
    ct_id smallint NOT NULL,
    ds_category text
);


ALTER TABLE operations.instruments_type_category OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 17878)
-- Name: instruments_type_has_operations; Type: TABLE; Schema: operations; Owner: postgres
--

CREATE TABLE operations.instruments_type_has_operations (
    tp_in_id integer NOT NULL,
    op_id integer NOT NULL
);


ALTER TABLE operations.instruments_type_has_operations OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 17881)
-- Name: instruments_type_has_parameters; Type: TABLE; Schema: operations; Owner: postgres
--

CREATE TABLE operations.instruments_type_has_parameters (
    pr_id smallint NOT NULL,
    tp_in_id smallint NOT NULL
);


ALTER TABLE operations.instruments_type_has_parameters OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 17884)
-- Name: operations; Type: TABLE; Schema: operations; Owner: postgres
--

CREATE TABLE operations.operations (
    op_id integer NOT NULL,
    tp_op_id integer NOT NULL,
    descrizione text,
    note text
);


ALTER TABLE operations.operations OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 17890)
-- Name: operations_data; Type: TABLE; Schema: operations; Owner: postgres
--

CREATE TABLE operations.operations_data (
    fulldate timestamp without time zone NOT NULL,
    st_id smallint NOT NULL,
    pr_id smallint NOT NULL,
    op_id smallint NOT NULL,
    fl_utilizzo character(1) NOT NULL,
    note text
);


ALTER TABLE operations.operations_data OWNER TO postgres;

--
-- TOC entry 303 (class 1259 OID 17896)
-- Name: operations_type; Type: TABLE; Schema: operations; Owner: postgres
--

CREATE TABLE operations.operations_type (
    tp_op_id integer NOT NULL,
    categoria text,
    frequenza text,
    ds_type text
);


ALTER TABLE operations.operations_type OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 17902)
-- Name: ricambi; Type: TABLE; Schema: operations; Owner: postgres
--

CREATE TABLE operations.ricambi (
    ri_id integer NOT NULL,
    descrizione text,
    marca text,
    tipo text,
    modello text
);


ALTER TABLE operations.ricambi OWNER TO postgres;

--
-- TOC entry 305 (class 1259 OID 17908)
-- Name: ricambi_data; Type: TABLE; Schema: operations; Owner: postgres
--

CREATE TABLE operations.ricambi_data (
    fulldate timestamp without time zone NOT NULL,
    arpa_id smallint NOT NULL,
    ri_id smallint NOT NULL,
    note text
);


ALTER TABLE operations.ricambi_data OWNER TO postgres;

--
-- TOC entry 306 (class 1259 OID 17914)
-- Name: stations_has_instruments; Type: TABLE; Schema: operations; Owner: postgres
--

CREATE TABLE operations.stations_has_instruments (
    st_id integer NOT NULL,
    arpa_id integer NOT NULL,
    d_dal date NOT NULL,
    d_al date,
    fl_utilizzo character(1) NOT NULL,
    note text
);


ALTER TABLE operations.stations_has_instruments OWNER TO postgres;

--
-- TOC entry 307 (class 1259 OID 17920)
-- Name: v_instruments_operations; Type: VIEW; Schema: operations; Owner: postgres
--

CREATE VIEW operations.v_instruments_operations AS
 SELECT _instruments.arpa_id AS in_id,
    inst.range_lavoro,
    _instruments.range_utilizzo,
    inst.marca,
    inst.modello,
    pl.pr_id,
    inst.descrizione AS inst_desc,
    pl.name,
    op.op_id,
    op.descrizione AS op_desc,
    _operations_type.categoria,
    _operations_type.frequenza
   FROM ((((((operations.instruments _instruments
     JOIN operations.instruments_type inst USING (tp_in_id))
     JOIN operations.instruments_type_has_parameters _instruments_type_has_parameters USING (tp_in_id))
     JOIN public._parameters_list_master pl USING (pr_id))
     JOIN operations.instruments_type_has_operations _instruments_type_has_operations USING (tp_in_id))
     JOIN operations.operations op USING (op_id))
     JOIN operations.operations_type _operations_type USING (tp_op_id))
  ORDER BY _instruments.arpa_id;


ALTER TABLE operations.v_instruments_operations OWNER TO postgres;

--
-- TOC entry 308 (class 1259 OID 17925)
-- Name: v_instruments_stations; Type: VIEW; Schema: operations; Owner: postgres
--

CREATE VIEW operations.v_instruments_stations AS
 SELECT s.stationname,
    _stations_has_instruments.st_id,
    i.arpa_id AS in_id,
    i.tp_in_id,
    _instruments_type.marca,
    _instruments_type.modello,
    _instruments_type.descrizione,
    _instruments_type_has_parameters.pr_id,
    plm.name,
    _stations_has_instruments.d_dal,
    _stations_has_instruments.d_al,
    _stations_has_instruments.fl_utilizzo,
    _stations_has_instruments.note
   FROM (((((operations.instruments i
     JOIN operations.instruments_type _instruments_type USING (tp_in_id))
     JOIN operations.instruments_type_has_parameters _instruments_type_has_parameters USING (tp_in_id))
     JOIN operations.stations_has_instruments _stations_has_instruments USING (arpa_id))
     JOIN public._stations s USING (st_id))
     JOIN public._parameters_list_master plm USING (pr_id))
  ORDER BY s.st_id, plm.pr_id;


ALTER TABLE operations.v_instruments_stations OWNER TO postgres;

--
-- TOC entry 309 (class 1259 OID 17930)
-- Name: v_instruments_stations_long; Type: VIEW; Schema: operations; Owner: postgres
--

CREATE VIEW operations.v_instruments_stations_long AS
 SELECT i.arpa_id AS in_id,
    i.tp_in_id,
    _instruments_type.marca,
    _instruments_type.modello,
    _instruments_type.descrizione,
    _instruments_type_has_parameters.pr_id,
    _parameters_list.name,
    _stations_has_instruments.st_id,
    _stations.stationname,
    _stations_has_instruments.d_dal,
    _stations_has_instruments.d_al
   FROM (((((operations.instruments i
     JOIN operations.instruments_type _instruments_type USING (tp_in_id))
     JOIN operations.instruments_type_has_parameters _instruments_type_has_parameters USING (tp_in_id))
     JOIN operations.stations_has_instruments _stations_has_instruments USING (arpa_id))
     JOIN public._parameters_list_master _parameters_list USING (pr_id))
     JOIN public._stations USING (st_id));


ALTER TABLE operations.v_instruments_stations_long OWNER TO postgres;

--
-- TOC entry 310 (class 1259 OID 17935)
-- Name: __versions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.__versions (
    id smallint NOT NULL,
    db_schema character varying(25),
    visualizer character varying(25),
    analyser character varying(25)
);


ALTER TABLE public.__versions OWNER TO postgres;

--
-- TOC entry 5926 (class 0 OID 0)
-- Dependencies: 310
-- Name: TABLE __versions; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.__versions IS 'Database and tools versions';


--
-- TOC entry 311 (class 1259 OID 17938)
-- Name: _groups_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._groups_list (
    gr_id smallint NOT NULL,
    gr_name text NOT NULL
);


ALTER TABLE public._groups_list OWNER TO postgres;

--
-- TOC entry 5927 (class 0 OID 0)
-- Dependencies: 311
-- Name: TABLE _groups_list; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public._groups_list IS 'Stores the groups of parameters';


--
-- TOC entry 5928 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN _groups_list.gr_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public._groups_list.gr_id IS 'The unique id';


--
-- TOC entry 5929 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN _groups_list.gr_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public._groups_list.gr_name IS 'The group name';


--
-- TOC entry 312 (class 1259 OID 17944)
-- Name: _groups_parameters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._groups_parameters (
    gr_pr_id integer NOT NULL,
    gr_id smallint,
    pr_id integer
);


ALTER TABLE public._groups_parameters OWNER TO postgres;

--
-- TOC entry 5930 (class 0 OID 0)
-- Dependencies: 312
-- Name: TABLE _groups_parameters; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public._groups_parameters IS 'Stores the groups of parameters';


--
-- TOC entry 5931 (class 0 OID 0)
-- Dependencies: 312
-- Name: COLUMN _groups_parameters.gr_pr_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public._groups_parameters.gr_pr_id IS 'The unique id';


--
-- TOC entry 5932 (class 0 OID 0)
-- Dependencies: 312
-- Name: COLUMN _groups_parameters.gr_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public._groups_parameters.gr_id IS 'The group id';


--
-- TOC entry 5933 (class 0 OID 0)
-- Dependencies: 312
-- Name: COLUMN _groups_parameters.pr_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public._groups_parameters.pr_id IS 'The parameter pr_id';


--
-- TOC entry 313 (class 1259 OID 17947)
-- Name: _groups_parameters_gr_pr_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public._groups_parameters_gr_pr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public._groups_parameters_gr_pr_id_seq OWNER TO postgres;

--
-- TOC entry 5934 (class 0 OID 0)
-- Dependencies: 313
-- Name: _groups_parameters_gr_pr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public._groups_parameters_gr_pr_id_seq OWNED BY public._groups_parameters.gr_pr_id;


--
-- TOC entry 314 (class 1259 OID 17949)
-- Name: _instruments_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._instruments_list (
    in_id smallint NOT NULL,
    instr_name text NOT NULL,
    notes text
);


ALTER TABLE public._instruments_list OWNER TO postgres;

--
-- TOC entry 5935 (class 0 OID 0)
-- Dependencies: 314
-- Name: TABLE _instruments_list; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public._instruments_list IS 'Holds the network instruments';


--
-- TOC entry 5936 (class 0 OID 0)
-- Dependencies: 314
-- Name: COLUMN _instruments_list.in_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public._instruments_list.in_id IS 'The unique internal id';


--
-- TOC entry 5937 (class 0 OID 0)
-- Dependencies: 314
-- Name: COLUMN _instruments_list.instr_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public._instruments_list.instr_name IS 'The unique instrument name';


--
-- TOC entry 5938 (class 0 OID 0)
-- Dependencies: 314
-- Name: COLUMN _instruments_list.notes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public._instruments_list.notes IS 'Notes about the instruments';


--
-- TOC entry 315 (class 1259 OID 17955)
-- Name: _instruments_parameters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._instruments_parameters (
    in_pr_id integer NOT NULL,
    in_id smallint,
    pr_id smallint
);


ALTER TABLE public._instruments_parameters OWNER TO postgres;

--
-- TOC entry 5939 (class 0 OID 0)
-- Dependencies: 315
-- Name: TABLE _instruments_parameters; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public._instruments_parameters IS 'Holds the relations between instruments and parameters';


--
-- TOC entry 5940 (class 0 OID 0)
-- Dependencies: 315
-- Name: COLUMN _instruments_parameters.in_pr_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public._instruments_parameters.in_pr_id IS 'The unique internal id';


--
-- TOC entry 5941 (class 0 OID 0)
-- Dependencies: 315
-- Name: COLUMN _instruments_parameters.in_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public._instruments_parameters.in_id IS 'The instrument id';


--
-- TOC entry 5942 (class 0 OID 0)
-- Dependencies: 315
-- Name: COLUMN _instruments_parameters.pr_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public._instruments_parameters.pr_id IS 'The parameter id';


--
-- TOC entry 316 (class 1259 OID 17958)
-- Name: _instruments_parameters_in_pr_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public._instruments_parameters_in_pr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public._instruments_parameters_in_pr_id_seq OWNER TO postgres;

--
-- TOC entry 5943 (class 0 OID 0)
-- Dependencies: 316
-- Name: _instruments_parameters_in_pr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public._instruments_parameters_in_pr_id_seq OWNED BY public._instruments_parameters.in_pr_id;


--
-- TOC entry 317 (class 1259 OID 17960)
-- Name: _log_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._log_type (
    id smallint NOT NULL,
    type character varying(25) DEFAULT ''::character varying
);


ALTER TABLE public._log_type OWNER TO postgres;

--
-- TOC entry 5944 (class 0 OID 0)
-- Dependencies: 317
-- Name: TABLE _log_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public._log_type IS 'Support reference table for warning types';


--
-- TOC entry 318 (class 1259 OID 17964)
-- Name: _logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._logs (
    fulldate timestamp without time zone NOT NULL,
    type smallint,
    message text DEFAULT ''::text
);


ALTER TABLE public._logs OWNER TO postgres;

--
-- TOC entry 319 (class 1259 OID 17971)
-- Name: _master; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._master (
    fulldate timestamp without time zone NOT NULL
);


ALTER TABLE public._master OWNER TO postgres;

--
-- TOC entry 320 (class 1259 OID 17974)
-- Name: _master_1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._master_1 (
    fulldate timestamp without time zone NOT NULL
);


ALTER TABLE public._master_1 OWNER TO postgres;

--
-- TOC entry 5945 (class 0 OID 0)
-- Dependencies: 320
-- Name: TABLE _master_1; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public._master_1 IS 'Master table for 1 minutes aggregations';


--
-- TOC entry 5946 (class 0 OID 0)
-- Dependencies: 320
-- Name: COLUMN _master_1.fulldate; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public._master_1.fulldate IS 'Reference date time';


--
-- TOC entry 321 (class 1259 OID 17977)
-- Name: _master_30; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._master_30 (
    fulldate timestamp without time zone NOT NULL
);


ALTER TABLE public._master_30 OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 17514)
-- Name: _stations_override; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._stations_override (
    id integer NOT NULL,
    st_id smallint NOT NULL,
    st_id_override smallint NOT NULL,
    datefrom timestamp without time zone DEFAULT '2005-01-01 00:00:00'::timestamp without time zone NOT NULL,
    dateto timestamp without time zone DEFAULT '2100-01-01 00:00:00'::timestamp without time zone NOT NULL,
    note text
);


ALTER TABLE public._stations_override OWNER TO postgres;

--
-- TOC entry 322 (class 1259 OID 17980)
-- Name: _master_override; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public._master_override AS
 SELECT _stations_override.st_id,
    _stations_override.st_id_override,
    m.fulldate
   FROM public._stations_override,
    public._master m
  WHERE ((m.fulldate >= _stations_override.datefrom) AND (m.fulldate <= _stations_override.dateto))
  ORDER BY m.fulldate;


ALTER TABLE public._master_override OWNER TO postgres;

--
-- TOC entry 323 (class 1259 OID 17984)
-- Name: _parameter_treatment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._parameter_treatment (
    id smallint NOT NULL,
    treatment character varying(25) DEFAULT ''::character varying
);


ALTER TABLE public._parameter_treatment OWNER TO postgres;

--
-- TOC entry 5947 (class 0 OID 0)
-- Dependencies: 323
-- Name: TABLE _parameter_treatment; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public._parameter_treatment IS 'Support reference table for macros';


--
-- TOC entry 324 (class 1259 OID 17988)
-- Name: _parameters_formules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._parameters_formules (
    st_pr_id smallint NOT NULL,
    formuleoverride character varying(200)
);


ALTER TABLE public._parameters_formules OWNER TO postgres;

--
-- TOC entry 325 (class 1259 OID 17991)
-- Name: _station_roaming_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._station_roaming_type (
    id smallint NOT NULL,
    roaming_type character varying(250) DEFAULT ''::character varying
);


ALTER TABLE public._station_roaming_type OWNER TO postgres;

--
-- TOC entry 5948 (class 0 OID 0)
-- Dependencies: 325
-- Name: TABLE _station_roaming_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public._station_roaming_type IS 'Support reference table for roaming station';


--
-- TOC entry 326 (class 1259 OID 17995)
-- Name: _stations_override_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public._stations_override_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public._stations_override_id_seq OWNER TO postgres;

--
-- TOC entry 5949 (class 0 OID 0)
-- Dependencies: 326
-- Name: _stations_override_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public._stations_override_id_seq OWNED BY public._stations_override.id;


--
-- TOC entry 327 (class 1259 OID 18021)
-- Name: _stations_parameters_st_pr_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public._stations_parameters_st_pr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public._stations_parameters_st_pr_id_seq OWNER TO postgres;

--
-- TOC entry 5950 (class 0 OID 0)
-- Dependencies: 327
-- Name: _stations_parameters_st_pr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public._stations_parameters_st_pr_id_seq OWNED BY public._stations_parameters_master.st_pr_id;


--
-- TOC entry 328 (class 1259 OID 18023)
-- Name: _users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._users (
    us_id integer NOT NULL,
    username character varying(50),
    userpass character varying(50),
    userlevel smallint,
    userremark character varying(255),
    userlastlogin timestamp without time zone,
    userweblevel smallint,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public._users OWNER TO postgres;

--
-- TOC entry 5951 (class 0 OID 0)
-- Dependencies: 328
-- Name: COLUMN _users.userweblevel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public._users.userweblevel IS 'Dedicated level for web interfaces use';


--
-- TOC entry 5952 (class 0 OID 0)
-- Dependencies: 328
-- Name: COLUMN _users.created_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public._users.created_at IS 'User creation date';


--
-- TOC entry 329 (class 1259 OID 18027)
-- Name: _users_logins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._users_logins (
    id integer NOT NULL,
    us_id smallint,
    userlogin timestamp without time zone
);


ALTER TABLE public._users_logins OWNER TO postgres;

--
-- TOC entry 5953 (class 0 OID 0)
-- Dependencies: 329
-- Name: TABLE _users_logins; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public._users_logins IS 'Users login history';


--
-- TOC entry 330 (class 1259 OID 18030)
-- Name: _users_logins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public._users_logins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public._users_logins_id_seq OWNER TO postgres;

--
-- TOC entry 5954 (class 0 OID 0)
-- Dependencies: 330
-- Name: _users_logins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public._users_logins_id_seq OWNED BY public._users_logins.id;


--
-- TOC entry 331 (class 1259 OID 18032)
-- Name: _users_parameters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._users_parameters (
    us_id smallint NOT NULL,
    pr_id smallint NOT NULL
);


ALTER TABLE public._users_parameters OWNER TO postgres;

--
-- TOC entry 332 (class 1259 OID 18035)
-- Name: _users_stations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._users_stations (
    us_id smallint NOT NULL,
    st_id smallint NOT NULL
);


ALTER TABLE public._users_stations OWNER TO postgres;

--
-- TOC entry 5955 (class 0 OID 0)
-- Dependencies: 332
-- Name: TABLE _users_stations; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public._users_stations IS 'Parameters visible by user';


--
-- TOC entry 333 (class 1259 OID 18038)
-- Name: _users_us_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public._users_us_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public._users_us_id_seq OWNER TO postgres;

--
-- TOC entry 5956 (class 0 OID 0)
-- Dependencies: 333
-- Name: _users_us_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public._users_us_id_seq OWNED BY public._users.us_id;


--
-- TOC entry 334 (class 1259 OID 18040)
-- Name: codemanager; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.codemanager (
    id integer NOT NULL,
    st_id smallint NOT NULL,
    table_id smallint NOT NULL,
    date_from timestamp without time zone DEFAULT now() NOT NULL,
    date_to timestamp without time zone DEFAULT 'infinity'::timestamp without time zone,
    code smallint NOT NULL
);


ALTER TABLE public.codemanager OWNER TO postgres;

--
-- TOC entry 5957 (class 0 OID 0)
-- Dependencies: 334
-- Name: TABLE codemanager; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.codemanager IS 'Store station and parameter records to manage validation codes';


--
-- TOC entry 5958 (class 0 OID 0)
-- Dependencies: 334
-- Name: COLUMN codemanager.st_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.codemanager.st_id IS 'Station stid';


--
-- TOC entry 5959 (class 0 OID 0)
-- Dependencies: 334
-- Name: COLUMN codemanager.table_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.codemanager.table_id IS 'Parameter id';


--
-- TOC entry 5960 (class 0 OID 0)
-- Dependencies: 334
-- Name: COLUMN codemanager.date_from; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.codemanager.date_from IS 'Start date to apply code';


--
-- TOC entry 5961 (class 0 OID 0)
-- Dependencies: 334
-- Name: COLUMN codemanager.date_to; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.codemanager.date_to IS 'End date to apply code';


--
-- TOC entry 5962 (class 0 OID 0)
-- Dependencies: 334
-- Name: COLUMN codemanager.code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.codemanager.code IS 'Override code';


--
-- TOC entry 335 (class 1259 OID 18045)
-- Name: codemanager_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.codemanager_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.codemanager_id_seq OWNER TO postgres;

--
-- TOC entry 5963 (class 0 OID 0)
-- Dependencies: 335
-- Name: codemanager_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.codemanager_id_seq OWNED BY public.codemanager.id;


--
-- TOC entry 336 (class 1259 OID 18047)
-- Name: data_import_tmp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_import_tmp (
    fulldate timestamp without time zone NOT NULL,
    id smallint,
    value1 real
);


ALTER TABLE public.data_import_tmp OWNER TO postgres;

--
-- TOC entry 337 (class 1259 OID 18050)
-- Name: history_changes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.history_changes (
    date_update timestamp without time zone DEFAULT now(),
    st_id smallint,
    fulldate timestamp without time zone NOT NULL,
    id smallint NOT NULL,
    meanvalue_old real,
    meanvalue_new real,
    code_old integer DEFAULT 0,
    code_new integer DEFAULT 0,
    min_old real,
    min_new real,
    max_old real,
    max_new real,
    calccode_old smallint DEFAULT 0,
    calccode_new smallint DEFAULT 0
);


ALTER TABLE public.history_changes OWNER TO postgres;

--
-- TOC entry 338 (class 1259 OID 18068)
-- Name: stations_properties; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.stations_properties AS
 SELECT _stations.st_id,
    _stations.stationname,
    _stations.schema,
    _stations.tableid,
    _stations.po_id,
    (((_stations.schema)::text || '.data_'::text) || (_stations.tableid)::text) AS vertical_table,
    (((_stations.schema)::text || '.tbl_'::text) || (_stations.tableid)::text) AS horizonatal_table,
    station_typology.typology,
    station_networktype.networktype,
    stations_metadata.locality,
    stations_metadata.commune,
    stations_metadata.province,
    stations_metadata.region,
    stations_metadata.longitude,
    stations_metadata.latitude,
    stations_metadata.east,
    stations_metadata.north,
    stations_metadata.altitude,
    stations_metadata.note,
    _users_stations.us_id
   FROM ((((public._stations
     JOIN public._users_stations USING (st_id))
     LEFT JOIN metadata.stations_metadata USING (st_id))
     LEFT JOIN metadata.station_typology ON ((stations_metadata.typology = station_typology.id)))
     LEFT JOIN metadata.station_networktype ON ((stations_metadata.networktype = station_networktype.id)))
  ORDER BY _stations.po_id;


ALTER TABLE public.stations_properties OWNER TO postgres;

--
-- TOC entry 339 (class 1259 OID 18073)
-- Name: v_verifiche_taratura_gamma; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_verifiche_taratura_gamma AS
 SELECT t1."SourceId",
    t1."DetID",
    t1."data di acquisizione",
    t1."Nuclide",
    t1."PeakNum",
    t1."NuclideKevEnergy",
    t1."Peak Centroid Energy (Kev)",
    t1."limite accettabilità energia",
    t1."FWHM (KeV)",
    t1."FWHM_cal",
    t1."limite perc accettabilità FWHM",
    t1."Attività certificata",
    t1."Attività misurata",
    t1."limite perc accettabilità attività",
    t1."CpsFondo",
    t1."limite perc accettabilità cps fondo"
   FROM public.dblink('dbname=gamma'::text, 'select "SourceId","DetID","data di acquisizione","Nuclide","PeakNum","NuclideKevEnergy" ,
"Peak Centroid Energy (Kev)", 0.5 AS "limite Kev accettabilità energia" ,"FWHM (KeV)","FWHM_cal",
10 as "limite perc accettabilità FWHM" , "Attività certificata", "Concentrazione di attività * coeff effetto somma" ,
"Incertezza percentuale estesa certificata" as "limite perc accettabilità attività" ,
"ArpaCps" as "CpsFondo",50 as "limite perc accettabilità cps fondo" from "GammaVerificheTaraturaReport"'::text) t1("SourceId" text, "DetID" integer, "data di acquisizione" date, "Nuclide" text, "PeakNum" integer, "NuclideKevEnergy" numeric, "Peak Centroid Energy (Kev)" numeric, "limite accettabilità energia" numeric, "FWHM (KeV)" numeric, "FWHM_cal" numeric, "limite perc accettabilità FWHM" numeric, "Attività certificata" numeric, "Attività misurata" numeric, "limite perc accettabilità attività" numeric, "CpsFondo" numeric, "limite perc accettabilità cps fondo" numeric);


ALTER TABLE public.v_verifiche_taratura_gamma OWNER TO postgres;

--
-- TOC entry 340 (class 1259 OID 18078)
-- Name: view_history_changes; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_history_changes AS
 SELECT history_changes.date_update AS edit_date,
    _stations.stationname AS station,
    _parameters_list.name AS parameter,
    history_changes.fulldate AS date,
    history_changes.meanvalue_old,
    history_changes.meanvalue_new,
    history_changes.id,
    history_changes.code_old,
    history_changes.code_new,
    history_changes.min_old,
    history_changes.min_new,
    history_changes.max_old,
    history_changes.max_new,
    history_changes.calccode_old,
    history_changes.calccode_new
   FROM (((public.history_changes
     JOIN public._stations USING (st_id))
     JOIN public._stations_parameters_master _stations_parameters ON (((_stations.st_id = _stations_parameters.st_id) AND (_stations_parameters.id = history_changes.id))))
     JOIN public._parameters_list_master _parameters_list ON ((_stations_parameters.pr_id = _parameters_list.pr_id)));


ALTER TABLE public.view_history_changes OWNER TO postgres;

--
-- TOC entry 341 (class 1259 OID 18083)
-- Name: view_instruments_properties; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_instruments_properties AS
 SELECT ip.in_pr_id,
    i.in_id,
    pl.pr_id,
    i.instr_name AS instrument,
    pl.name AS parameter
   FROM ((public._instruments_list i
     JOIN public._instruments_parameters ip USING (in_id))
     JOIN public._parameters_list_master pl USING (pr_id))
  ORDER BY i.in_id;


ALTER TABLE public.view_instruments_properties OWNER TO postgres;

--
-- TOC entry 342 (class 1259 OID 18088)
-- Name: view_laboratories_roaming; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_laboratories_roaming AS
 SELECT _stations_override.id,
    _stations_override.st_id,
    _stations_override.datefrom,
    _stations_override.dateto,
    _stations_override.note,
    _stations_override.st_id_override,
    (_stations_override.dateto - _stations_override.datefrom) AS duration,
    _stations.stationname,
    ( SELECT _stations_1.station_roaming_type
           FROM public._stations _stations_1
          WHERE (_stations_1.st_id = _stations_override.st_id_override)) AS stationroamingtype,
    ( SELECT _stations_1.stationname
           FROM public._stations _stations_1
          WHERE (_stations_1.st_id = _stations_override.st_id_override)) AS stationnameoverride,
    _stations.tableid,
    ( SELECT _stations_1.tableid
           FROM public._stations _stations_1
          WHERE (_stations_1.st_id = _stations_override.st_id_override)) AS tableidoverride
   FROM (public._stations_override
     JOIN public._stations USING (st_id))
  ORDER BY _stations_override.datefrom;


ALTER TABLE public.view_laboratories_roaming OWNER TO postgres;

--
-- TOC entry 343 (class 1259 OID 18093)
-- Name: view_logs; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_logs AS
 SELECT l.fulldate,
    t.type,
    l.message
   FROM (public._logs l
     JOIN public._log_type t ON ((l.type = t.id)))
  ORDER BY l.fulldate;


ALTER TABLE public.view_logs OWNER TO postgres;

--
-- TOC entry 344 (class 1259 OID 18134)
-- Name: view_users_logins; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_users_logins AS
 SELECT _users.username AS "user",
    _users.userlevel AS level,
    _users.userlastlogin AS last,
    _users_logins.userlogin AS logins
   FROM (public._users
     JOIN public._users_logins USING (us_id))
  ORDER BY _users.us_id, _users_logins.userlogin;


ALTER TABLE public.view_users_logins OWNER TO postgres;

--
-- TOC entry 346 (class 1259 OID 18775)
-- Name: data_calibrations; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.data_calibrations (
    id integer NOT NULL,
    st_id integer NOT NULL,
    us_id integer NOT NULL,
    arpa_id text NOT NULL,
    fulldate timestamp without time zone NOT NULL,
    re_id integer,
    zero_found real,
    zero_set real,
    zero_found2 real,
    zero_set2 real,
    zero_found3 real,
    zero_set3 real,
    zero_me_id integer,
    zero_cyl_arpa_id text,
    span_found real,
    span_set real,
    span_found2 real,
    span_set2 real,
    span_found3 real,
    span_set3 real,
    span_changed boolean,
    span_me_id integer,
    span_cyl_arpa_id text,
    cal_arpa_id text,
    flux real,
    flux2 real,
    flux3 real,
    freqf0nofilter real,
    freqf0filter real,
    calculateddelta boolean,
    concentrationref real,
    note text,
    ca_id integer,
    zero_changed boolean,
    temperature real,
    presssure real,
    flux_changed boolean,
    span_found4 real,
    span_set4 real,
    span_found5 real,
    span_set5 real,
    span_found6 real,
    span_set6 real,
    span_found7 real,
    span_set7 real,
    span_found8 real,
    span_set8 real,
    span_found9 real,
    span_set9 real
);


ALTER TABLE tool_netcom.data_calibrations OWNER TO postgres;

--
-- TOC entry 347 (class 1259 OID 18781)
-- Name: instruments; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.instruments (
    in_id integer NOT NULL,
    arpa_id text NOT NULL,
    in_ty_id integer NOT NULL,
    name text NOT NULL,
    serial_number text,
    date_delivery date,
    date_eol date,
    note text
);


ALTER TABLE tool_netcom.instruments OWNER TO postgres;

--
-- TOC entry 5964 (class 0 OID 0)
-- Dependencies: 347
-- Name: TABLE instruments; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON TABLE tool_netcom.instruments IS 'Holds the instruments list';


--
-- TOC entry 5965 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN instruments.in_id; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.instruments.in_id IS 'The instrument id';


--
-- TOC entry 5966 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN instruments.arpa_id; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.instruments.arpa_id IS 'The instrument arpa_id';


--
-- TOC entry 5967 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN instruments.in_ty_id; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.instruments.in_ty_id IS 'The instrument name';


--
-- TOC entry 5968 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN instruments.name; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.instruments.name IS 'The instrument in_ty_id';


--
-- TOC entry 5969 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN instruments.serial_number; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.instruments.serial_number IS 'The instrument serial number';


--
-- TOC entry 5970 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN instruments.date_delivery; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.instruments.date_delivery IS 'The instrument delivery date';


--
-- TOC entry 5971 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN instruments.date_eol; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.instruments.date_eol IS 'The instrument end of life date';


--
-- TOC entry 348 (class 1259 OID 18787)
-- Name: data_anas_etroub_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.data_anas_etroub_calibrations AS
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (1)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4180) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (2)::smallint AS id,
    c.zero_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4180) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (3)::smallint AS id,
    c.zero_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4180) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (4)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4180) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (5)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4180) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (6)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4180) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (7)::smallint AS id,
    c.span_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4180) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (8)::smallint AS id,
    c.span_set2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4180) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (9)::smallint AS id,
        CASE
            WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4180) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (10)::smallint AS id,
    c.span_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4180) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (11)::smallint AS id,
    c.span_set3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4180) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (12)::smallint AS id,
        CASE
            WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4180) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (13)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4180) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
  ORDER BY 1;


ALTER TABLE tables_ar.data_anas_etroub_calibrations OWNER TO postgres;

--
-- TOC entry 349 (class 1259 OID 18883)
-- Name: data_donnas_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.data_donnas_calibrations AS
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (1)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (2)::smallint AS id,
    c.zero_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (3)::smallint AS id,
    c.zero_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (4)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (5)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (6)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (7)::smallint AS id,
    c.span_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (8)::smallint AS id,
    c.span_set2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (9)::smallint AS id,
        CASE
            WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (10)::smallint AS id,
    c.span_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (11)::smallint AS id,
    c.span_set3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (12)::smallint AS id,
        CASE
            WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (13)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (14)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (15)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (16)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (17)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (18)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (42)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00156'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text])) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (43)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00156'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text])) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (44)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00156'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text])) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (45)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00156'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text])) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
  ORDER BY 1;


ALTER TABLE tables_ar.data_donnas_calibrations OWNER TO postgres;

--
-- TOC entry 350 (class 1259 OID 18904)
-- Name: data_dora_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.data_dora_calibrations AS
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (1)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4030) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (2)::smallint AS id,
    c.zero_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4030) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (3)::smallint AS id,
    c.zero_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4030) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (4)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4030) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (5)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4030) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (6)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4030) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (7)::smallint AS id,
    c.span_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4030) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (8)::smallint AS id,
    c.span_set2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4030) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (9)::smallint AS id,
        CASE
            WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4030) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (10)::smallint AS id,
    c.span_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4030) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (11)::smallint AS id,
    c.span_set3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4030) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (12)::smallint AS id,
        CASE
            WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4030) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (13)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4030) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (42)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00156'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text])) AND (c.st_id = 4030) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (43)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00156'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text])) AND (c.st_id = 4030) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (44)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00156'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text])) AND (c.st_id = 4030) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (45)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00156'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text])) AND (c.st_id = 4030) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
  ORDER BY 1;


ALTER TABLE tables_ar.data_dora_calibrations OWNER TO postgres;

--
-- TOC entry 351 (class 1259 OID 18939)
-- Name: data_imaggio_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.data_imaggio_calibrations AS
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (1)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4120) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (2)::smallint AS id,
    c.zero_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4120) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (3)::smallint AS id,
    c.zero_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4120) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (4)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4120) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (5)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4120) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (6)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4120) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (7)::smallint AS id,
    c.span_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4120) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (8)::smallint AS id,
    c.span_set2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4120) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (9)::smallint AS id,
        CASE
            WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4120) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (10)::smallint AS id,
    c.span_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4120) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (11)::smallint AS id,
    c.span_set3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4120) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (12)::smallint AS id,
        CASE
            WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4120) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (13)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4120) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
  ORDER BY 1;


ALTER TABLE tables_ar.data_imaggio_calibrations OWNER TO postgres;

--
-- TOC entry 352 (class 1259 OID 18944)
-- Name: data_la_thuile_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.data_la_thuile_calibrations AS
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (1)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (2)::smallint AS id,
    c.zero_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (3)::smallint AS id,
    c.zero_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (4)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (5)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (6)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (7)::smallint AS id,
    c.span_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (8)::smallint AS id,
    c.span_set2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (9)::smallint AS id,
        CASE
            WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (10)::smallint AS id,
    c.span_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (11)::smallint AS id,
    c.span_set3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (12)::smallint AS id,
        CASE
            WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (13)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (14)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (15)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (16)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (17)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (18)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (24)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1000) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (25)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1000) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (26)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1000) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (27)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1000) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (28)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1000) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (50)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00520'::text, '00521'::text, '00314'::text, '09001'::text, '00422'::text])) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (51)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00520'::text, '00521'::text, '00314'::text, '09001'::text, '00422'::text])) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (52)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00520'::text, '00521'::text, '00314'::text, '09001'::text, '00422'::text])) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (53)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00520'::text, '00521'::text, '00314'::text, '09001'::text, '00422'::text])) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
  ORDER BY 1;


ALTER TABLE tables_ar.data_la_thuile_calibrations OWNER TO postgres;

--
-- TOC entry 353 (class 1259 OID 18955)
-- Name: data_lab02_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.data_lab02_calibrations AS
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (1)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (2)::smallint AS id,
    c.zero_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (3)::smallint AS id,
    c.zero_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (4)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (5)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (6)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (7)::smallint AS id,
    c.span_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (8)::smallint AS id,
    c.span_set2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (9)::smallint AS id,
        CASE
            WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (10)::smallint AS id,
    c.span_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (11)::smallint AS id,
    c.span_set3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (12)::smallint AS id,
        CASE
            WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (13)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (14)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (15)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (16)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (17)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (18)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (42)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00156'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (43)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00156'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (44)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00156'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (45)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00156'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (50)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00520'::text, '00521'::text, '00314'::text, '09001'::text, '00422'::text])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (51)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00520'::text, '00521'::text, '00314'::text, '09001'::text, '00422'::text])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (52)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00520'::text, '00521'::text, '00314'::text, '09001'::text, '00422'::text])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (53)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00520'::text, '00521'::text, '00314'::text, '09001'::text, '00422'::text])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (58)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1210) AND (c.arpa_id = ANY (ARRAY['04416'::text, '04360'::text, '04415'::text, '04418'::text, 'mcz_9999'::text])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (59)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1210) AND (c.arpa_id = ANY (ARRAY['04416'::text, '04360'::text, '04415'::text, '04418'::text, 'mcz_9999'::text])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (60)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1210) AND (c.arpa_id = ANY (ARRAY['04416'::text, '04360'::text, '04415'::text, '04418'::text, 'mcz_9999'::text])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (61)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1210) AND (c.arpa_id = ANY (ARRAY['04416'::text, '04360'::text, '04415'::text, '04418'::text, 'mcz_9999'::text])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
  ORDER BY 1;


ALTER TABLE tables_ar.data_lab02_calibrations OWNER TO postgres;

--
-- TOC entry 354 (class 1259 OID 18982)
-- Name: data_liconi_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.data_liconi_calibrations AS
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (1)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (2)::smallint AS id,
    c.zero_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (3)::smallint AS id,
    c.zero_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (4)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (5)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (6)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (7)::smallint AS id,
    c.span_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (8)::smallint AS id,
    c.span_set2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (9)::smallint AS id,
        CASE
            WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (10)::smallint AS id,
    c.span_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (11)::smallint AS id,
    c.span_set3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (12)::smallint AS id,
        CASE
            WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (13)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (14)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (15)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (16)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (17)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (18)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (19)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text, '04188'::text, '03776'::text, '03850'::text])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (20)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text, '04188'::text, '03776'::text, '03850'::text])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (21)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text, '04188'::text, '03776'::text, '03850'::text])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (22)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text, '04188'::text, '03776'::text, '03850'::text])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (23)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['03777'::text, '00156'::text, '04417'::text])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (24)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['03777'::text, '00156'::text, '04417'::text])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (25)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['03777'::text, '00156'::text, '04417'::text])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (26)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['03777'::text, '00156'::text, '04417'::text])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (58)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1210) AND (c.arpa_id = ANY (ARRAY['04416'::text, '04360'::text, '04415'::text, '04418'::text, 'mcz_9999'::text])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (59)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1210) AND (c.arpa_id = ANY (ARRAY['04416'::text, '04360'::text, '04415'::text, '04418'::text, 'mcz_9999'::text])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (60)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1210) AND (c.arpa_id = ANY (ARRAY['04416'::text, '04360'::text, '04415'::text, '04418'::text, 'mcz_9999'::text])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (61)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1210) AND (c.arpa_id = ANY (ARRAY['04416'::text, '04360'::text, '04415'::text, '04418'::text, 'mcz_9999'::text])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
  ORDER BY 1;


ALTER TABLE tables_ar.data_liconi_calibrations OWNER TO postgres;

--
-- TOC entry 355 (class 1259 OID 19020)
-- Name: data_mt_fleury_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.data_mt_fleury_calibrations AS
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (1)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4020) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (2)::smallint AS id,
    c.zero_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4020) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (3)::smallint AS id,
    c.zero_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4020) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (4)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4020) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (5)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4020) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (6)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4020) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (7)::smallint AS id,
    c.span_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4020) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (8)::smallint AS id,
    c.span_set2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4020) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (9)::smallint AS id,
        CASE
            WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4020) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (10)::smallint AS id,
    c.span_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4020) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (11)::smallint AS id,
    c.span_set3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4020) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (12)::smallint AS id,
        CASE
            WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4020) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (13)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4020) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (14)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4020) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (15)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4020) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (16)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4020) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (17)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4020) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (18)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4020) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
  ORDER BY 1;


ALTER TABLE tables_ar.data_mt_fleury_calibrations OWNER TO postgres;

--
-- TOC entry 356 (class 1259 OID 19039)
-- Name: data_pepiniere_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.data_pepiniere_calibrations AS
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (1)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (2)::smallint AS id,
    c.zero_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (3)::smallint AS id,
    c.zero_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (4)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (5)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (6)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (7)::smallint AS id,
    c.span_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (8)::smallint AS id,
    c.span_set2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (9)::smallint AS id,
        CASE
            WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (10)::smallint AS id,
    c.span_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (11)::smallint AS id,
    c.span_set3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (12)::smallint AS id,
        CASE
            WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (13)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (19)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1020) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (20)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1020) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (21)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1020) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (22)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1020) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (23)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1020) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (42)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text, '04188'::text, '03776'::text])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (43)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text, '04188'::text, '03776'::text])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (44)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text, '04188'::text, '03776'::text])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (45)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text, '04188'::text, '03776'::text])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (58)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1210) AND (c.arpa_id = ANY (ARRAY['04416'::text, '04360'::text, '04415'::text, '04418'::text, 'mcz_9999'::text])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (59)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1210) AND (c.arpa_id = ANY (ARRAY['04416'::text, '04360'::text, '04415'::text, '04418'::text, 'mcz_9999'::text])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (60)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1210) AND (c.arpa_id = ANY (ARRAY['04416'::text, '04360'::text, '04415'::text, '04418'::text, 'mcz_9999'::text])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (61)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1210) AND (c.arpa_id = ANY (ARRAY['04416'::text, '04360'::text, '04415'::text, '04418'::text, 'mcz_9999'::text])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
  ORDER BY 1;


ALTER TABLE tables_ar.data_pepiniere_calibrations OWNER TO postgres;

--
-- TOC entry 345 (class 1259 OID 18271)
-- Name: data_plouves; Type: TABLE; Schema: tables_ar; Owner: postgres
--

CREATE TABLE tables_ar.data_plouves (
    fulldate timestamp without time zone NOT NULL,
    id smallint NOT NULL,
    meanvalue real,
    code smallint DEFAULT 0,
    stationalarm smallint DEFAULT 0,
    readings smallint,
    min double precision,
    mintime time without time zone,
    max double precision,
    maxtime time without time zone,
    stddev real,
    calccode smallint DEFAULT 0,
    flag_valid smallint DEFAULT 0,
    time_stamp timestamp without time zone DEFAULT now(),
    checked boolean DEFAULT false
);


ALTER TABLE tables_ar.data_plouves OWNER TO postgres;

--
-- TOC entry 357 (class 1259 OID 19052)
-- Name: data_plouves_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.data_plouves_calibrations AS
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (1)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (2)::smallint AS id,
    c.zero_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (3)::smallint AS id,
    c.zero_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (4)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (5)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (6)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (7)::smallint AS id,
    c.span_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (8)::smallint AS id,
    c.span_set2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (9)::smallint AS id,
        CASE
            WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (10)::smallint AS id,
    c.span_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (11)::smallint AS id,
    c.span_set3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (12)::smallint AS id,
        CASE
            WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (13)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (14)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (15)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (16)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (17)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (18)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (19)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1020) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (20)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1020) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (21)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1020) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (22)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1020) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (23)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1020) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (24)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1000) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (25)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1000) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (26)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1000) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (27)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1000) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (28)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1000) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (29)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1090) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (30)::smallint AS id,
    c.zero_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1090) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (31)::smallint AS id,
    c.zero_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1090) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (32)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1090) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (33)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1090) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (34)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1090) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (35)::smallint AS id,
    c.span_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1090) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (36)::smallint AS id,
    c.span_set2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1090) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (37)::smallint AS id,
        CASE
            WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1090) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (38)::smallint AS id,
    c.span_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1090) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (39)::smallint AS id,
    c.span_set3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1090) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (40)::smallint AS id,
        CASE
            WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1090) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (41)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1090) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (42)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text, '04188'::text, '03776'::text])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (43)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text, '04188'::text, '03776'::text])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (44)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text, '04188'::text, '03776'::text])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (45)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text, '04188'::text, '03776'::text])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (46)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['03777'::text, '00156'::text])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (47)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['03777'::text, '00156'::text])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (48)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['03777'::text, '00156'::text])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (49)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['03777'::text, '00156'::text])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (50)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00520'::text, '00521'::text, '00314'::text, '09001'::text])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (51)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00520'::text, '00521'::text, '00314'::text, '09001'::text])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (52)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00520'::text, '00521'::text, '00314'::text, '09001'::text])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (53)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00520'::text, '00521'::text, '00314'::text, '09001'::text])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (58)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1210) AND (c.arpa_id = ANY (ARRAY['04416'::text, '04360'::text, '04415'::text, '04418'::text, 'mcz_9999'::text])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (59)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1210) AND (c.arpa_id = ANY (ARRAY['04416'::text, '04360'::text, '04415'::text, '04418'::text, 'mcz_9999'::text])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (60)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1210) AND (c.arpa_id = ANY (ARRAY['04416'::text, '04360'::text, '04415'::text, '04418'::text, 'mcz_9999'::text])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (61)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1210) AND (c.arpa_id = ANY (ARRAY['04416'::text, '04360'::text, '04415'::text, '04418'::text, 'mcz_9999'::text])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
  ORDER BY 1;


ALTER TABLE tables_ar.data_plouves_calibrations OWNER TO postgres;

--
-- TOC entry 358 (class 1259 OID 19193)
-- Name: data_tunnel_mb_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.data_tunnel_mb_calibrations AS
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (1)::smallint AS id,
    c.zero_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (2)::smallint AS id,
    c.zero_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (3)::smallint AS id,
    c.zero_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (4)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (5)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (6)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (7)::smallint AS id,
    c.span_found2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (8)::smallint AS id,
    c.span_set2 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (9)::smallint AS id,
        CASE
            WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (10)::smallint AS id,
    c.span_found3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (11)::smallint AS id,
    c.span_set3 AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (12)::smallint AS id,
        CASE
            WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (13)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (50)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00520'::text, '00521'::text, '00314'::text, '09001'::text])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (51)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00520'::text, '00521'::text, '00314'::text, '09001'::text])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (52)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00520'::text, '00521'::text, '00314'::text, '09001'::text])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (53)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00520'::text, '00521'::text, '00314'::text, '09001'::text])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (54)::smallint AS id,
    c.span_found AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00369'::text, '00422'::text])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (55)::smallint AS id,
    c.span_set AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00369'::text, '00422'::text])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (56)::smallint AS id,
        CASE
            WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
            ELSE NULL::numeric
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00369'::text, '00422'::text])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
UNION ALL
 SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
    (57)::smallint AS id,
        CASE
            WHEN c.span_changed THEN (1)::real
            ELSE (0)::real
        END AS meanvalue,
    (0)::smallint AS code,
    (0)::smallint AS stationalarm,
    NULL::smallint AS readings,
    NULL::smallint AS min,
    NULL::smallint AS max,
    (0)::smallint AS calccode
   FROM (tool_netcom.data_calibrations c
     LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
  WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00369'::text, '00422'::text])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
  ORDER BY 1;


ALTER TABLE tables_ar.data_tunnel_mb_calibrations OWNER TO postgres;

--
-- TOC entry 359 (class 1259 OID 19268)
-- Name: tbl_anas_etroub_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.tbl_anas_etroub_calibrations AS
 WITH table1 AS (
         SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_1,
            (0)::smallint AS id_1_cod,
            c.zero_found2 AS id_2,
            (0)::smallint AS id_2_cod,
            c.zero_found3 AS id_3,
            (0)::smallint AS id_3_cod,
            c.span_found AS id_4,
            (0)::smallint AS id_4_cod,
            c.span_set AS id_5,
            (0)::smallint AS id_5_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_6,
            (0)::smallint AS id_6_cod,
            c.span_found2 AS id_7,
            (0)::smallint AS id_7_cod,
            c.span_set2 AS id_8,
            (0)::smallint AS id_8_cod,
                CASE
                    WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_9,
            (0)::smallint AS id_9_cod,
            c.span_found3 AS id_10,
            (0)::smallint AS id_10_cod,
            c.span_set3 AS id_11,
            (0)::smallint AS id_11_cod,
                CASE
                    WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_12,
            (0)::smallint AS id_12_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_13,
            (0)::smallint AS id_13_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4180) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))
        )
 SELECT m.fulldate,
    table1.id_1,
    table1.id_1_cod,
    table1.id_2,
    table1.id_2_cod,
    table1.id_3,
    table1.id_3_cod,
    table1.id_4,
    table1.id_4_cod,
    table1.id_5,
    table1.id_5_cod,
    table1.id_6,
    table1.id_6_cod,
    table1.id_7,
    table1.id_7_cod,
    table1.id_8,
    table1.id_8_cod,
    table1.id_9,
    table1.id_9_cod,
    table1.id_10,
    table1.id_10_cod,
    table1.id_11,
    table1.id_11_cod,
    table1.id_12,
    table1.id_12_cod,
    table1.id_13,
    table1.id_13_cod
   FROM (public._master m
     LEFT JOIN table1 USING (fulldate))
  WHERE (m.fulldate > '2015-10-01 00:00:00'::timestamp without time zone)
  ORDER BY m.fulldate;


ALTER TABLE tables_ar.tbl_anas_etroub_calibrations OWNER TO postgres;

--
-- TOC entry 360 (class 1259 OID 19314)
-- Name: tbl_donnas_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.tbl_donnas_calibrations AS
 SELECT m.fulldate,
    table1.id_1,
    table1.id_1_cod,
    table1.id_2,
    table1.id_2_cod,
    table1.id_3,
    table1.id_3_cod,
    table1.id_4,
    table1.id_4_cod,
    table1.id_5,
    table1.id_5_cod,
    table1.id_6,
    table1.id_6_cod,
    table1.id_7,
    table1.id_7_cod,
    table1.id_8,
    table1.id_8_cod,
    table1.id_9,
    table1.id_9_cod,
    table1.id_10,
    table1.id_10_cod,
    table1.id_11,
    table1.id_11_cod,
    table1.id_12,
    table1.id_12_cod,
    table1.id_13,
    table1.id_13_cod,
    table2.id_14,
    table2.id_14_cod,
    table2.id_15,
    table2.id_15_cod,
    table2.id_16,
    table2.id_16_cod,
    table2.id_17,
    table2.id_17_cod,
    table2.id_18,
    table2.id_18_cod,
    table3.id_42,
    table3.id_42_cod,
    table3.id_43,
    table3.id_43_cod,
    table3.id_44,
    table3.id_44_cod,
    table3.id_45,
    table3.id_45_cod
   FROM (((public._master m
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_1,
            (0)::smallint AS id_1_cod,
            c.zero_found2 AS id_2,
            (0)::smallint AS id_2_cod,
            c.zero_found3 AS id_3,
            (0)::smallint AS id_3_cod,
            c.span_found AS id_4,
            (0)::smallint AS id_4_cod,
            c.span_set AS id_5,
            (0)::smallint AS id_5_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_6,
            (0)::smallint AS id_6_cod,
            c.span_found2 AS id_7,
            (0)::smallint AS id_7_cod,
            c.span_set2 AS id_8,
            (0)::smallint AS id_8_cod,
                CASE
                    WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_9,
            (0)::smallint AS id_9_cod,
            c.span_found3 AS id_10,
            (0)::smallint AS id_10_cod,
            c.span_set3 AS id_11,
            (0)::smallint AS id_11_cod,
                CASE
                    WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_12,
            (0)::smallint AS id_12_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_13,
            (0)::smallint AS id_13_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table1 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_14,
            (0)::smallint AS id_14_cod,
            c.span_found AS id_15,
            (0)::smallint AS id_15_cod,
            c.span_set AS id_16,
            (0)::smallint AS id_16_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_17,
            (0)::smallint AS id_17_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_18,
            (0)::smallint AS id_18_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table2 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.span_found AS id_42,
            (0)::smallint AS id_42_cod,
            c.span_set AS id_43,
            (0)::smallint AS id_43_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_44,
            (0)::smallint AS id_44_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_45,
            (0)::smallint AS id_45_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00156'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text])) AND (c.st_id = 4110) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table3 USING (fulldate))
  WHERE (m.fulldate > '2010-07-01 00:00:00'::timestamp without time zone)
  ORDER BY m.fulldate;


ALTER TABLE tables_ar.tbl_donnas_calibrations OWNER TO postgres;

--
-- TOC entry 361 (class 1259 OID 19322)
-- Name: tbl_dora_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.tbl_dora_calibrations AS
 SELECT m.fulldate,
    table1.id_1,
    table1.id_1_cod,
    table1.id_2,
    table1.id_2_cod,
    table1.id_3,
    table1.id_3_cod,
    table1.id_4,
    table1.id_4_cod,
    table1.id_5,
    table1.id_5_cod,
    table1.id_6,
    table1.id_6_cod,
    table1.id_7,
    table1.id_7_cod,
    table1.id_8,
    table1.id_8_cod,
    table1.id_9,
    table1.id_9_cod,
    table1.id_10,
    table1.id_10_cod,
    table1.id_11,
    table1.id_11_cod,
    table1.id_12,
    table1.id_12_cod,
    table1.id_13,
    table1.id_13_cod,
    table2.id_42,
    table2.id_42_cod,
    table2.id_43,
    table2.id_43_cod,
    table2.id_44,
    table2.id_44_cod,
    table2.id_45,
    table2.id_45_cod
   FROM ((public._master m
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_1,
            (0)::smallint AS id_1_cod,
            c.zero_found2 AS id_2,
            (0)::smallint AS id_2_cod,
            c.zero_found3 AS id_3,
            (0)::smallint AS id_3_cod,
            c.span_found AS id_4,
            (0)::smallint AS id_4_cod,
            c.span_set AS id_5,
            (0)::smallint AS id_5_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_6,
            (0)::smallint AS id_6_cod,
            c.span_found2 AS id_7,
            (0)::smallint AS id_7_cod,
            c.span_set2 AS id_8,
            (0)::smallint AS id_8_cod,
                CASE
                    WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_9,
            (0)::smallint AS id_9_cod,
            c.span_found3 AS id_10,
            (0)::smallint AS id_10_cod,
            c.span_set3 AS id_11,
            (0)::smallint AS id_11_cod,
                CASE
                    WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_12,
            (0)::smallint AS id_12_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_13,
            (0)::smallint AS id_13_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4030) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table1 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.span_found AS id_42,
            (0)::smallint AS id_42_cod,
            c.span_set AS id_43,
            (0)::smallint AS id_43_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_44,
            (0)::smallint AS id_44_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_45,
            (0)::smallint AS id_45_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00156'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text])) AND (c.st_id = 4030) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table2 USING (fulldate))
  WHERE (m.fulldate > '2010-07-01 00:00:00'::timestamp without time zone)
  ORDER BY m.fulldate;


ALTER TABLE tables_ar.tbl_dora_calibrations OWNER TO postgres;

--
-- TOC entry 362 (class 1259 OID 19381)
-- Name: tbl_imaggio_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.tbl_imaggio_calibrations AS
 WITH table1 AS (
         SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_1,
            (0)::smallint AS id_1_cod,
            c.zero_found2 AS id_2,
            (0)::smallint AS id_2_cod,
            c.zero_found3 AS id_3,
            (0)::smallint AS id_3_cod,
            c.span_found AS id_4,
            (0)::smallint AS id_4_cod,
            c.span_set AS id_5,
            (0)::smallint AS id_5_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_6,
            (0)::smallint AS id_6_cod,
            c.span_found2 AS id_7,
            (0)::smallint AS id_7_cod,
            c.span_set2 AS id_8,
            (0)::smallint AS id_8_cod,
                CASE
                    WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_9,
            (0)::smallint AS id_9_cod,
            c.span_found3 AS id_10,
            (0)::smallint AS id_10_cod,
            c.span_set3 AS id_11,
            (0)::smallint AS id_11_cod,
                CASE
                    WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_12,
            (0)::smallint AS id_12_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_13,
            (0)::smallint AS id_13_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4120) AND (c.fulldate > '2015-10-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))
        )
 SELECT m.fulldate,
    table1.id_1,
    table1.id_1_cod,
    table1.id_2,
    table1.id_2_cod,
    table1.id_3,
    table1.id_3_cod,
    table1.id_4,
    table1.id_4_cod,
    table1.id_5,
    table1.id_5_cod,
    table1.id_6,
    table1.id_6_cod,
    table1.id_7,
    table1.id_7_cod,
    table1.id_8,
    table1.id_8_cod,
    table1.id_9,
    table1.id_9_cod,
    table1.id_10,
    table1.id_10_cod,
    table1.id_11,
    table1.id_11_cod,
    table1.id_12,
    table1.id_12_cod,
    table1.id_13,
    table1.id_13_cod
   FROM (public._master m
     LEFT JOIN table1 USING (fulldate))
  WHERE (m.fulldate > '2015-10-01 00:00:00'::timestamp without time zone)
  ORDER BY m.fulldate;


ALTER TABLE tables_ar.tbl_imaggio_calibrations OWNER TO postgres;

--
-- TOC entry 363 (class 1259 OID 19386)
-- Name: tbl_la_thuile_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.tbl_la_thuile_calibrations AS
 SELECT m.fulldate,
    table1.id_1,
    table1.id_1_cod,
    table1.id_2,
    table1.id_2_cod,
    table1.id_3,
    table1.id_3_cod,
    table1.id_4,
    table1.id_4_cod,
    table1.id_5,
    table1.id_5_cod,
    table1.id_6,
    table1.id_6_cod,
    table1.id_7,
    table1.id_7_cod,
    table1.id_8,
    table1.id_8_cod,
    table1.id_9,
    table1.id_9_cod,
    table1.id_10,
    table1.id_10_cod,
    table1.id_11,
    table1.id_11_cod,
    table1.id_12,
    table1.id_12_cod,
    table1.id_13,
    table1.id_13_cod,
    table2.id_14,
    table2.id_14_cod,
    table2.id_15,
    table2.id_15_cod,
    table2.id_16,
    table2.id_16_cod,
    table2.id_17,
    table2.id_17_cod,
    table2.id_18,
    table2.id_18_cod,
    table3.id_24,
    table3.id_24cod,
    table3.id_25,
    table3.id_25_cod,
    table3.id_26,
    table3.id_26_cod,
    table3.id_27,
    table3.id_27_cod,
    table3.id_28,
    table3.id_28_cod,
    table4.id_50,
    table4.id_50_cod,
    table4.id_51,
    table4.id_51_cod,
    table4.id_52,
    table4.id_52_cod,
    table4.id_53,
    table4.id_53_cod
   FROM ((((public._master m
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_1,
            (0)::smallint AS id_1_cod,
            c.zero_found2 AS id_2,
            (0)::smallint AS id_2_cod,
            c.zero_found3 AS id_3,
            (0)::smallint AS id_3_cod,
            c.span_found AS id_4,
            (0)::smallint AS id_4_cod,
            c.span_set AS id_5,
            (0)::smallint AS id_5_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_6,
            (0)::smallint AS id_6_cod,
            c.span_found2 AS id_7,
            (0)::smallint AS id_7_cod,
            c.span_set2 AS id_8,
            (0)::smallint AS id_8_cod,
                CASE
                    WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_9,
            (0)::smallint AS id_9_cod,
            c.span_found3 AS id_10,
            (0)::smallint AS id_10_cod,
            c.span_set3 AS id_11,
            (0)::smallint AS id_11_cod,
                CASE
                    WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_12,
            (0)::smallint AS id_12_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_13,
            (0)::smallint AS id_13_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table1 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_14,
            (0)::smallint AS id_14_cod,
            c.span_found AS id_15,
            (0)::smallint AS id_15_cod,
            c.span_set AS id_16,
            (0)::smallint AS id_16_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_17,
            (0)::smallint AS id_17_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_18,
            (0)::smallint AS id_18_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table2 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_24,
            (0)::smallint AS id_24cod,
            c.span_found AS id_25,
            (0)::smallint AS id_25_cod,
            c.span_set AS id_26,
            (0)::smallint AS id_26_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_27,
            (0)::smallint AS id_27_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_28,
            (0)::smallint AS id_28_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1000) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table3 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.span_found AS id_50,
            (0)::smallint AS id_50_cod,
            c.span_set AS id_51,
            (0)::smallint AS id_51_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_52,
            (0)::smallint AS id_52_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_53,
            (0)::smallint AS id_53_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00520'::text, '00521'::text, '00314'::text, '09001'::text, '00422'::text])) AND (c.st_id = 4050) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table4 USING (fulldate))
  WHERE (m.fulldate > '2010-07-01 00:00:00'::timestamp without time zone)
  ORDER BY m.fulldate;


ALTER TABLE tables_ar.tbl_la_thuile_calibrations OWNER TO postgres;

--
-- TOC entry 364 (class 1259 OID 19475)
-- Name: tbl_lab02_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.tbl_lab02_calibrations AS
 SELECT m.fulldate,
    table1.id_1,
    table1.id_1_cod,
    table1.id_2,
    table1.id_2_cod,
    table1.id_3,
    table1.id_3_cod,
    table1.id_4,
    table1.id_4_cod,
    table1.id_5,
    table1.id_5_cod,
    table1.id_6,
    table1.id_6_cod,
    table1.id_7,
    table1.id_7_cod,
    table1.id_8,
    table1.id_8_cod,
    table1.id_9,
    table1.id_9_cod,
    table1.id_10,
    table1.id_10_cod,
    table1.id_11,
    table1.id_11_cod,
    table1.id_12,
    table1.id_12_cod,
    table1.id_13,
    table1.id_13_cod,
    table2.id_14,
    table2.id_14_cod,
    table2.id_15,
    table2.id_15_cod,
    table2.id_16,
    table2.id_16_cod,
    table2.id_17,
    table2.id_17_cod,
    table2.id_18,
    table2.id_18_cod,
    table3.id_42,
    table3.id_42_cod,
    table3.id_43,
    table3.id_43_cod,
    table3.id_44,
    table3.id_44_cod,
    table3.id_45,
    table3.id_45_cod,
    table4.id_50,
    table4.id_50_cod,
    table4.id_51,
    table4.id_51_cod,
    table4.id_52,
    table4.id_52_cod,
    table4.id_53,
    table4.id_53_cod,
    table5.id_58,
    table5.id_58_cod,
    table5.id_59,
    table5.id_59_cod,
    table5.id_60,
    table5.id_60_cod,
    table5.id_61,
    table5.id_61_cod
   FROM (((((public._master m
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_1,
            (0)::smallint AS id_1_cod,
            c.zero_found2 AS id_2,
            (0)::smallint AS id_2_cod,
            c.zero_found3 AS id_3,
            (0)::smallint AS id_3_cod,
            c.span_found AS id_4,
            (0)::smallint AS id_4_cod,
            c.span_set AS id_5,
            (0)::smallint AS id_5_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_6,
            (0)::smallint AS id_6_cod,
            c.span_found2 AS id_7,
            (0)::smallint AS id_7_cod,
            c.span_set2 AS id_8,
            (0)::smallint AS id_8_cod,
                CASE
                    WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_9,
            (0)::smallint AS id_9_cod,
            c.span_found3 AS id_10,
            (0)::smallint AS id_10_cod,
            c.span_set3 AS id_11,
            (0)::smallint AS id_11_cod,
                CASE
                    WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_12,
            (0)::smallint AS id_12_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_13,
            (0)::smallint AS id_13_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table1 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_14,
            (0)::smallint AS id_14_cod,
            c.span_found AS id_15,
            (0)::smallint AS id_15_cod,
            c.span_set AS id_16,
            (0)::smallint AS id_16_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_17,
            (0)::smallint AS id_17_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_18,
            (0)::smallint AS id_18_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table2 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.span_found AS id_42,
            (0)::smallint AS id_42_cod,
            c.span_set AS id_43,
            (0)::smallint AS id_43_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_44,
            (0)::smallint AS id_44_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_45,
            (0)::smallint AS id_45_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00156'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table3 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.span_found AS id_50,
            (0)::smallint AS id_50_cod,
            c.span_set AS id_51,
            (0)::smallint AS id_51_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_52,
            (0)::smallint AS id_52_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_53,
            (0)::smallint AS id_53_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00520'::text, '00521'::text, '00314'::text, '09001'::text, '00422'::text])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table4 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.span_found AS id_58,
            (0)::smallint AS id_58_cod,
            c.span_set AS id_59,
            (0)::smallint AS id_59_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_60,
            (0)::smallint AS id_60_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_61,
            (0)::smallint AS id_61_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1210) AND (c.arpa_id = ANY (ARRAY['04416'::text, '04360'::text, '04415'::text, '04418'::text, 'mcz_9999'::text])) AND (c.st_id = 4510) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table5 USING (fulldate))
  WHERE (m.fulldate > '2010-07-01 00:00:00'::timestamp without time zone)
  ORDER BY m.fulldate;


ALTER TABLE tables_ar.tbl_lab02_calibrations OWNER TO postgres;

--
-- TOC entry 365 (class 1259 OID 19656)
-- Name: tbl_liconi_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.tbl_liconi_calibrations AS
 SELECT m.fulldate,
    table1.id_1,
    table1.id_1_cod,
    table1.id_2,
    table1.id_2_cod,
    table1.id_3,
    table1.id_3_cod,
    table1.id_4,
    table1.id_4_cod,
    table1.id_5,
    table1.id_5_cod,
    table1.id_6,
    table1.id_6_cod,
    table1.id_7,
    table1.id_7_cod,
    table1.id_8,
    table1.id_8_cod,
    table1.id_9,
    table1.id_9_cod,
    table1.id_10,
    table1.id_10_cod,
    table1.id_11,
    table1.id_11_cod,
    table1.id_12,
    table1.id_12_cod,
    table1.id_13,
    table1.id_13_cod,
    table2.id_14,
    table2.id_14_cod,
    table2.id_15,
    table2.id_15_cod,
    table2.id_16,
    table2.id_16_cod,
    table2.id_17,
    table2.id_17_cod,
    table2.id_18,
    table2.id_18_cod,
    table3.id_19,
    table3.id_19_cod,
    table3.id_20,
    table3.id_20_cod,
    table3.id_21,
    table3.id_21_cod,
    table3.id_22,
    table3.id_22_cod,
    table4.id_23,
    table4.id_23_cod,
    table4.id_24,
    table4.id_24_cod,
    table4.id_25,
    table4.id_25_cod,
    table4.id_26,
    table4.id_26_cod,
    table5.id_58,
    table5.id_58_cod,
    table5.id_59,
    table5.id_59_cod,
    table5.id_60,
    table5.id_60_cod,
    table5.id_61,
    table5.id_61_cod
   FROM (((((public._master m
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_1,
            (0)::smallint AS id_1_cod,
            c.zero_found2 AS id_2,
            (0)::smallint AS id_2_cod,
            c.zero_found3 AS id_3,
            (0)::smallint AS id_3_cod,
            c.span_found AS id_4,
            (0)::smallint AS id_4_cod,
            c.span_set AS id_5,
            (0)::smallint AS id_5_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_6,
            (0)::smallint AS id_6_cod,
            c.span_found2 AS id_7,
            (0)::smallint AS id_7_cod,
            c.span_set2 AS id_8,
            (0)::smallint AS id_8_cod,
                CASE
                    WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_9,
            (0)::smallint AS id_9_cod,
            c.span_found3 AS id_10,
            (0)::smallint AS id_10_cod,
            c.span_set3 AS id_11,
            (0)::smallint AS id_11_cod,
                CASE
                    WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_12,
            (0)::smallint AS id_12_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_13,
            (0)::smallint AS id_13_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table1 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_14,
            (0)::smallint AS id_14_cod,
            c.span_found AS id_15,
            (0)::smallint AS id_15_cod,
            c.span_set AS id_16,
            (0)::smallint AS id_16_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_17,
            (0)::smallint AS id_17_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_18,
            (0)::smallint AS id_18_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table2 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.span_found AS id_19,
            (0)::smallint AS id_19_cod,
            c.span_set AS id_20,
            (0)::smallint AS id_20_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_21,
            (0)::smallint AS id_21_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_22,
            (0)::smallint AS id_22_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text, '04188'::text, '03776'::text, '03850'::text])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table3 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.span_found AS id_23,
            (0)::smallint AS id_23_cod,
            c.span_set AS id_24,
            (0)::smallint AS id_24_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_25,
            (0)::smallint AS id_25_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_26,
            (0)::smallint AS id_26_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['03777'::text, '00156'::text, '04417'::text])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table4 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.span_found AS id_58,
            (0)::smallint AS id_58_cod,
            c.span_set AS id_59,
            (0)::smallint AS id_59_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_60,
            (0)::smallint AS id_60_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_61,
            (0)::smallint AS id_61_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1210) AND (c.arpa_id = ANY (ARRAY['04416'::text, '04360'::text, '04415'::text, '04418'::text, 'mcz_9999'::text])) AND (c.st_id = 4160) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table5 USING (fulldate))
  WHERE (m.fulldate > '2010-07-01 00:00:00'::timestamp without time zone)
  ORDER BY m.fulldate;


ALTER TABLE tables_ar.tbl_liconi_calibrations OWNER TO postgres;

--
-- TOC entry 366 (class 1259 OID 19683)
-- Name: tbl_mt_fleury_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.tbl_mt_fleury_calibrations AS
 SELECT m.fulldate,
    table1.id_1,
    table1.id_1_cod,
    table1.id_2,
    table1.id_2_cod,
    table1.id_3,
    table1.id_3_cod,
    table1.id_4,
    table1.id_4_cod,
    table1.id_5,
    table1.id_5_cod,
    table1.id_6,
    table1.id_6_cod,
    table1.id_7,
    table1.id_7_cod,
    table1.id_8,
    table1.id_8_cod,
    table1.id_9,
    table1.id_9_cod,
    table1.id_10,
    table1.id_10_cod,
    table1.id_11,
    table1.id_11_cod,
    table1.id_12,
    table1.id_12_cod,
    table1.id_13,
    table1.id_13_cod,
    table2.id_14,
    table2.id_14_cod,
    table2.id_15,
    table2.id_15_cod,
    table2.id_16,
    table2.id_16_cod,
    table2.id_17,
    table2.id_17_cod,
    table2.id_18,
    table2.id_18_cod
   FROM ((public._master m
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_1,
            (0)::smallint AS id_1_cod,
            c.zero_found2 AS id_2,
            (0)::smallint AS id_2_cod,
            c.zero_found3 AS id_3,
            (0)::smallint AS id_3_cod,
            c.span_found AS id_4,
            (0)::smallint AS id_4_cod,
            c.span_set AS id_5,
            (0)::smallint AS id_5_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_6,
            (0)::smallint AS id_6_cod,
            c.span_found2 AS id_7,
            (0)::smallint AS id_7_cod,
            c.span_set2 AS id_8,
            (0)::smallint AS id_8_cod,
                CASE
                    WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_9,
            (0)::smallint AS id_9_cod,
            c.span_found3 AS id_10,
            (0)::smallint AS id_10_cod,
            c.span_set3 AS id_11,
            (0)::smallint AS id_11_cod,
                CASE
                    WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_12,
            (0)::smallint AS id_12_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_13,
            (0)::smallint AS id_13_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4020) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table1 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_14,
            (0)::smallint AS id_14_cod,
            c.span_found AS id_15,
            (0)::smallint AS id_15_cod,
            c.span_set AS id_16,
            (0)::smallint AS id_16_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_17,
            (0)::smallint AS id_17_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_18,
            (0)::smallint AS id_18_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4020) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table2 USING (fulldate))
  WHERE (m.fulldate > '2010-07-01 00:00:00'::timestamp without time zone)
  ORDER BY m.fulldate;


ALTER TABLE tables_ar.tbl_mt_fleury_calibrations OWNER TO postgres;

--
-- TOC entry 367 (class 1259 OID 19694)
-- Name: tbl_pepiniere_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.tbl_pepiniere_calibrations AS
 SELECT m.fulldate,
    table1.id_1,
    table1.id_1_cod,
    table1.id_2,
    table1.id_2_cod,
    table1.id_3,
    table1.id_3_cod,
    table1.id_4,
    table1.id_4_cod,
    table1.id_5,
    table1.id_5_cod,
    table1.id_6,
    table1.id_6_cod,
    table1.id_7,
    table1.id_7_cod,
    table1.id_8,
    table1.id_8_cod,
    table1.id_9,
    table1.id_9_cod,
    table1.id_10,
    table1.id_10_cod,
    table1.id_11,
    table1.id_11_cod,
    table1.id_12,
    table1.id_12_cod,
    table1.id_13,
    table1.id_13_cod,
    table2.id_19,
    table2.id_19_cod,
    table2.id_20,
    table2.id_20_cod,
    table2.id_21,
    table2.id_21_cod,
    table2.id_22,
    table2.id_22_cod,
    table2.id_23,
    table2.id_23_cod,
    table3.id_42,
    table3.id_42_cod,
    table3.id_43,
    table3.id_43_cod,
    table3.id_44,
    table3.id_44_cod,
    table3.id_45,
    table3.id_45_cod,
    table4.id_58,
    table4.id_58_cod,
    table4.id_59,
    table4.id_59_cod,
    table4.id_60,
    table4.id_60_cod,
    table4.id_61,
    table4.id_61_cod
   FROM ((((public._master m
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_1,
            (0)::smallint AS id_1_cod,
            c.zero_found2 AS id_2,
            (0)::smallint AS id_2_cod,
            c.zero_found3 AS id_3,
            (0)::smallint AS id_3_cod,
            c.span_found AS id_4,
            (0)::smallint AS id_4_cod,
            c.span_set AS id_5,
            (0)::smallint AS id_5_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_6,
            (0)::smallint AS id_6_cod,
            c.span_found2 AS id_7,
            (0)::smallint AS id_7_cod,
            c.span_set2 AS id_8,
            (0)::smallint AS id_8_cod,
                CASE
                    WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_9,
            (0)::smallint AS id_9_cod,
            c.span_found3 AS id_10,
            (0)::smallint AS id_10_cod,
            c.span_set3 AS id_11,
            (0)::smallint AS id_11_cod,
                CASE
                    WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_12,
            (0)::smallint AS id_12_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_13,
            (0)::smallint AS id_13_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table1 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_19,
            (0)::smallint AS id_19_cod,
            c.span_found AS id_20,
            (0)::smallint AS id_20_cod,
            c.span_set AS id_21,
            (0)::smallint AS id_21_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_22,
            (0)::smallint AS id_22_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_23,
            (0)::smallint AS id_23_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1020) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table2 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.span_found AS id_42,
            (0)::smallint AS id_42_cod,
            c.span_set AS id_43,
            (0)::smallint AS id_43_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_44,
            (0)::smallint AS id_44_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_45,
            (0)::smallint AS id_45_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text, '04188'::text, '03776'::text])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table3 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.span_found AS id_58,
            (0)::smallint AS id_58_cod,
            c.span_set AS id_59,
            (0)::smallint AS id_59_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_60,
            (0)::smallint AS id_60_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_61,
            (0)::smallint AS id_61_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1210) AND (c.arpa_id = ANY (ARRAY['04416'::text, '04360'::text, '04415'::text, '04418'::text, 'mcz_9999'::text])) AND (c.st_id = 4140) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table4 USING (fulldate))
  WHERE (m.fulldate > '2010-07-01 00:00:00'::timestamp without time zone)
  ORDER BY m.fulldate;


ALTER TABLE tables_ar.tbl_pepiniere_calibrations OWNER TO postgres;

--
-- TOC entry 368 (class 1259 OID 19702)
-- Name: tbl_plouves_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.tbl_plouves_calibrations AS
 SELECT m.fulldate,
    table1.id_1,
    table1.id_1_cod,
    table1.id_2,
    table1.id_2_cod,
    table1.id_3,
    table1.id_3_cod,
    table1.id_4,
    table1.id_4_cod,
    table1.id_5,
    table1.id_5_cod,
    table1.id_6,
    table1.id_6_cod,
    table1.id_7,
    table1.id_7_cod,
    table1.id_8,
    table1.id_8_cod,
    table1.id_9,
    table1.id_9_cod,
    table1.id_10,
    table1.id_10_cod,
    table1.id_11,
    table1.id_11_cod,
    table1.id_12,
    table1.id_12_cod,
    table1.id_13,
    table1.id_13_cod,
    table2.id_14,
    table2.id_14_cod,
    table2.id_15,
    table2.id_15_cod,
    table2.id_16,
    table2.id_16_cod,
    table2.id_17,
    table2.id_17_cod,
    table2.id_18,
    table2.id_18_cod,
    table3.id_19,
    table3.id_19_cod,
    table3.id_20,
    table3.id_20_cod,
    table3.id_21,
    table3.id_21_cod,
    table3.id_22,
    table3.id_22_cod,
    table3.id_23,
    table3.id_23_cod,
    table4.id_24,
    table4.id_24cod,
    table4.id_25,
    table4.id_25_cod,
    table4.id_26,
    table4.id_26_cod,
    table4.id_27,
    table4.id_27_cod,
    table4.id_28,
    table4.id_28_cod,
    table5.id_29,
    table5.id_29_cod,
    table5.id_30,
    table5.id_30_cod,
    table5.id_31,
    table5.id_31_cod,
    table5.id_32,
    table5.id_32_cod,
    table5.id_33,
    table5.id_33_cod,
    table5.id_34,
    table5.id_34_cod,
    table5.id_35,
    table5.id_35_cod,
    table5.id_36,
    table5.id_36_cod,
    table5.id_37,
    table5.id_37_cod,
    table5.id_38,
    table5.id_38_cod,
    table5.id_39,
    table5.id_39_cod,
    table5.id_40,
    table5.id_40_cod,
    table5.id_41,
    table5.id_41_cod,
    table6.id_42,
    table6.id_42_cod,
    table6.id_43,
    table6.id_43_cod,
    table6.id_44,
    table6.id_44_cod,
    table6.id_45,
    table6.id_45_cod,
    table7.id_46,
    table7.id_46_cod,
    table7.id_47,
    table7.id_47_cod,
    table7.id_48,
    table7.id_48_cod,
    table7.id_49,
    table7.id_49_cod,
    table8.id_50,
    table8.id_50_cod,
    table8.id_51,
    table8.id_51_cod,
    table8.id_52,
    table8.id_52_cod,
    table8.id_53,
    table8.id_53_cod,
    table9.id_58,
    table9.id_58_cod,
    table9.id_59,
    table9.id_59_cod,
    table9.id_60,
    table9.id_60_cod,
    table9.id_61,
    table9.id_61_cod
   FROM (((((((((public._master m
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_1,
            (0)::smallint AS id_1_cod,
            c.zero_found2 AS id_2,
            (0)::smallint AS id_2_cod,
            c.zero_found3 AS id_3,
            (0)::smallint AS id_3_cod,
            c.span_found AS id_4,
            (0)::smallint AS id_4_cod,
            c.span_set AS id_5,
            (0)::smallint AS id_5_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_6,
            (0)::smallint AS id_6_cod,
            c.span_found2 AS id_7,
            (0)::smallint AS id_7_cod,
            c.span_set2 AS id_8,
            (0)::smallint AS id_8_cod,
                CASE
                    WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_9,
            (0)::smallint AS id_9_cod,
            c.span_found3 AS id_10,
            (0)::smallint AS id_10_cod,
            c.span_set3 AS id_11,
            (0)::smallint AS id_11_cod,
                CASE
                    WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_12,
            (0)::smallint AS id_12_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_13,
            (0)::smallint AS id_13_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table1 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_14,
            (0)::smallint AS id_14_cod,
            c.span_found AS id_15,
            (0)::smallint AS id_15_cod,
            c.span_set AS id_16,
            (0)::smallint AS id_16_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_17,
            (0)::smallint AS id_17_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_18,
            (0)::smallint AS id_18_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1110) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table2 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_19,
            (0)::smallint AS id_19_cod,
            c.span_found AS id_20,
            (0)::smallint AS id_20_cod,
            c.span_set AS id_21,
            (0)::smallint AS id_21_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_22,
            (0)::smallint AS id_22_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_23,
            (0)::smallint AS id_23_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1020) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table3 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_24,
            (0)::smallint AS id_24cod,
            c.span_found AS id_25,
            (0)::smallint AS id_25_cod,
            c.span_set AS id_26,
            (0)::smallint AS id_26_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_27,
            (0)::smallint AS id_27_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_28,
            (0)::smallint AS id_28_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1000) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table4 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_29,
            (0)::smallint AS id_29_cod,
            c.zero_found2 AS id_30,
            (0)::smallint AS id_30_cod,
            c.zero_found3 AS id_31,
            (0)::smallint AS id_31_cod,
            c.span_found AS id_32,
            (0)::smallint AS id_32_cod,
            c.span_set AS id_33,
            (0)::smallint AS id_33_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_34,
            (0)::smallint AS id_34_cod,
            c.span_found2 AS id_35,
            (0)::smallint AS id_35_cod,
            c.span_set2 AS id_36,
            (0)::smallint AS id_36_cod,
                CASE
                    WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_37,
            (0)::smallint AS id_37_cod,
            c.span_found3 AS id_38,
            (0)::smallint AS id_38_cod,
            c.span_set3 AS id_39,
            (0)::smallint AS id_39_cod,
                CASE
                    WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_40,
            (0)::smallint AS id_40_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_41,
            (0)::smallint AS id_41_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1090) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table5 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.span_found AS id_42,
            (0)::smallint AS id_42_cod,
            c.span_set AS id_43,
            (0)::smallint AS id_43_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_44,
            (0)::smallint AS id_44_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_45,
            (0)::smallint AS id_45_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['00347'::text, '00155'::text, '00154'::text, '00158'::text, '00159'::text, '04188'::text, '03776'::text])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table6 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.span_found AS id_46,
            (0)::smallint AS id_46_cod,
            c.span_set AS id_47,
            (0)::smallint AS id_47_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_48,
            (0)::smallint AS id_48_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_49,
            (0)::smallint AS id_49_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1070) AND (c.arpa_id = ANY (ARRAY['03777'::text, '00156'::text])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table7 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.span_found AS id_50,
            (0)::smallint AS id_50_cod,
            c.span_set AS id_51,
            (0)::smallint AS id_51_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_52,
            (0)::smallint AS id_52_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_53,
            (0)::smallint AS id_53_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00520'::text, '00521'::text, '00314'::text, '09001'::text, '00422'::text])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table8 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.span_found AS id_58,
            (0)::smallint AS id_58_cod,
            c.span_set AS id_59,
            (0)::smallint AS id_59_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_60,
            (0)::smallint AS id_60_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_61,
            (0)::smallint AS id_61_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1210) AND (c.arpa_id = ANY (ARRAY['04416'::text, '04360'::text, '04415'::text, '04418'::text, 'mcz_9999'::text])) AND (c.st_id = 4000) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table9 USING (fulldate))
  WHERE (m.fulldate > '2010-07-01 00:00:00'::timestamp without time zone)
  ORDER BY m.fulldate;


ALTER TABLE tables_ar.tbl_plouves_calibrations OWNER TO postgres;

--
-- TOC entry 369 (class 1259 OID 19919)
-- Name: tbl_tunnel_mb_calibrations; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.tbl_tunnel_mb_calibrations AS
 SELECT m.fulldate,
    table1.id_1,
    table1.id_1_cod,
    table1.id_2,
    table1.id_2_cod,
    table1.id_3,
    table1.id_3_cod,
    table1.id_4,
    table1.id_4_cod,
    table1.id_5,
    table1.id_5_cod,
    table1.id_6,
    table1.id_6_cod,
    table1.id_7,
    table1.id_7_cod,
    table1.id_8,
    table1.id_8_cod,
    table1.id_9,
    table1.id_9_cod,
    table1.id_10,
    table1.id_10_cod,
    table1.id_11,
    table1.id_11_cod,
    table1.id_12,
    table1.id_12_cod,
    table1.id_13,
    table1.id_13_cod,
    table2.id_50,
    table2.id_50_cod,
    table2.id_51,
    table2.id_51_cod,
    table2.id_52,
    table2.id_52_cod,
    table2.id_53,
    table2.id_53_cod,
    table3.id_54,
    table3.id_54_cod,
    table3.id_55,
    table3.id_55_cod,
    table3.id_56,
    table3.id_56_cod,
    table3.id_57,
    table3.id_57_cod
   FROM (((public._master m
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.zero_found AS id_1,
            (0)::smallint AS id_1_cod,
            c.zero_found2 AS id_2,
            (0)::smallint AS id_2_cod,
            c.zero_found3 AS id_3,
            (0)::smallint AS id_3_cod,
            c.span_found AS id_4,
            (0)::smallint AS id_4_cod,
            c.span_set AS id_5,
            (0)::smallint AS id_5_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_6,
            (0)::smallint AS id_6_cod,
            c.span_found2 AS id_7,
            (0)::smallint AS id_7_cod,
            c.span_set2 AS id_8,
            (0)::smallint AS id_8_cod,
                CASE
                    WHEN (c.span_set2 <> (0)::double precision) THEN round((((100)::real - ((c.span_found2 / c.span_set2) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_9,
            (0)::smallint AS id_9_cod,
            c.span_found3 AS id_10,
            (0)::smallint AS id_10_cod,
            c.span_set3 AS id_11,
            (0)::smallint AS id_11_cod,
                CASE
                    WHEN (c.span_set3 <> (0)::double precision) THEN round((((100)::real - ((c.span_found3 / c.span_set3) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_12,
            (0)::smallint AS id_12_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_13,
            (0)::smallint AS id_13_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = ANY (ARRAY[1010, 1100, 1200])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table1 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.span_found AS id_50,
            (0)::smallint AS id_50_cod,
            c.span_set AS id_51,
            (0)::smallint AS id_51_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_52,
            (0)::smallint AS id_52_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_53,
            (0)::smallint AS id_53_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00520'::text, '00521'::text, '00314'::text, '09001'::text])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table2 USING (fulldate))
     LEFT JOIN ( SELECT date_trunc('hour'::text, c.fulldate) AS fulldate,
            c.span_found AS id_54,
            (0)::smallint AS id_54_cod,
            c.span_set AS id_55,
            (0)::smallint AS id_55_cod,
                CASE
                    WHEN (c.span_set <> (0)::double precision) THEN round((((100)::real - ((c.span_found / c.span_set) * (100)::real)))::numeric, 2)
                    ELSE NULL::numeric
                END AS id_56,
            (0)::smallint AS id_56_cod,
                CASE
                    WHEN c.span_changed THEN (1)::real
                    ELSE (0)::real
                END AS id_57,
            (0)::smallint AS id_57_cod
           FROM (tool_netcom.data_calibrations c
             LEFT JOIN tool_netcom.instruments i ON ((c.arpa_id = i.arpa_id)))
          WHERE ((i.in_ty_id = 1050) AND (c.arpa_id = ANY (ARRAY['00369'::text, '00422'::text])) AND (c.st_id = 4040) AND (c.fulldate > '2010-07-01 00:00:00'::timestamp without time zone))
          ORDER BY (date_trunc('hour'::text, c.fulldate))) table3 USING (fulldate))
  WHERE (m.fulldate > '2010-07-01 00:00:00'::timestamp without time zone)
  ORDER BY m.fulldate;


ALTER TABLE tables_ar.tbl_tunnel_mb_calibrations OWNER TO postgres;

--
-- TOC entry 370 (class 1259 OID 20029)
-- Name: view_data_cogne; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.view_data_cogne AS
 SELECT get_cf_data_cogne.fulldate,
    get_cf_data_cogne.id,
    get_cf_data_cogne.meanvalue,
    get_cf_data_cogne.code,
    get_cf_data_cogne.stationalarm,
    get_cf_data_cogne.readings,
    get_cf_data_cogne.min,
    get_cf_data_cogne.mintime,
    get_cf_data_cogne.max,
    get_cf_data_cogne.maxtime,
    get_cf_data_cogne.stddev,
    get_cf_data_cogne.calccode
   FROM tables_ar.get_cf_data_cogne((('now'::text)::date - '2 mons'::interval), (now())::timestamp without time zone) get_cf_data_cogne(fulldate, id, meanvalue, code, stationalarm, readings, min, mintime, max, maxtime, stddev, calccode);


ALTER TABLE tables_ar.view_data_cogne OWNER TO postgres;

--
-- TOC entry 5972 (class 0 OID 0)
-- Dependencies: 370
-- Name: VIEW view_data_cogne; Type: COMMENT; Schema: tables_ar; Owner: postgres
--

COMMENT ON VIEW tables_ar.view_data_cogne IS 'Tabella foreign dati Cogne';


--
-- TOC entry 371 (class 1259 OID 20033)
-- Name: view_data_donnas; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.view_data_donnas AS
 SELECT get_cf_data_donnas.fulldate,
    get_cf_data_donnas.id,
    get_cf_data_donnas.meanvalue,
    get_cf_data_donnas.code,
    get_cf_data_donnas.stationalarm,
    get_cf_data_donnas.readings,
    get_cf_data_donnas.min,
    get_cf_data_donnas.mintime,
    get_cf_data_donnas.max,
    get_cf_data_donnas.maxtime,
    get_cf_data_donnas.stddev,
    get_cf_data_donnas.calccode
   FROM tables_ar.get_cf_data_donnas((('now'::text)::date - '2 mons'::interval), (now())::timestamp without time zone) get_cf_data_donnas(fulldate, id, meanvalue, code, stationalarm, readings, min, mintime, max, maxtime, stddev, calccode);


ALTER TABLE tables_ar.view_data_donnas OWNER TO postgres;

--
-- TOC entry 5973 (class 0 OID 0)
-- Dependencies: 371
-- Name: VIEW view_data_donnas; Type: COMMENT; Schema: tables_ar; Owner: postgres
--

COMMENT ON VIEW tables_ar.view_data_donnas IS 'Tabella foreign dati donnas';


--
-- TOC entry 372 (class 1259 OID 20037)
-- Name: view_data_etroubles; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.view_data_etroubles AS
 SELECT get_cf_data_etroubles.fulldate,
    get_cf_data_etroubles.id,
    get_cf_data_etroubles.meanvalue,
    get_cf_data_etroubles.code,
    get_cf_data_etroubles.stationalarm,
    get_cf_data_etroubles.readings,
    get_cf_data_etroubles.min,
    get_cf_data_etroubles.mintime,
    get_cf_data_etroubles.max,
    get_cf_data_etroubles.maxtime,
    get_cf_data_etroubles.stddev,
    get_cf_data_etroubles.calccode
   FROM tables_ar.get_cf_data_etroubles((('now'::text)::date - '2 mons'::interval), (now())::timestamp without time zone) get_cf_data_etroubles(fulldate, id, meanvalue, code, stationalarm, readings, min, mintime, max, maxtime, stddev, calccode);


ALTER TABLE tables_ar.view_data_etroubles OWNER TO postgres;

--
-- TOC entry 5974 (class 0 OID 0)
-- Dependencies: 372
-- Name: VIEW view_data_etroubles; Type: COMMENT; Schema: tables_ar; Owner: postgres
--

COMMENT ON VIEW tables_ar.view_data_etroubles IS 'Tabella foreign dati etroubles';


--
-- TOC entry 373 (class 1259 OID 20041)
-- Name: view_data_la_thuile; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.view_data_la_thuile AS
 SELECT get_cf_data_la_thuile.fulldate,
    get_cf_data_la_thuile.id,
    get_cf_data_la_thuile.meanvalue,
    get_cf_data_la_thuile.code,
    get_cf_data_la_thuile.stationalarm,
    get_cf_data_la_thuile.readings,
    get_cf_data_la_thuile.min,
    get_cf_data_la_thuile.mintime,
    get_cf_data_la_thuile.max,
    get_cf_data_la_thuile.maxtime,
    get_cf_data_la_thuile.stddev,
    get_cf_data_la_thuile.calccode
   FROM tables_ar.get_cf_data_la_thuile((('now'::text)::date - '2 mons'::interval), (now())::timestamp without time zone) get_cf_data_la_thuile(fulldate, id, meanvalue, code, stationalarm, readings, min, mintime, max, maxtime, stddev, calccode);


ALTER TABLE tables_ar.view_data_la_thuile OWNER TO postgres;

--
-- TOC entry 5975 (class 0 OID 0)
-- Dependencies: 373
-- Name: VIEW view_data_la_thuile; Type: COMMENT; Schema: tables_ar; Owner: postgres
--

COMMENT ON VIEW tables_ar.view_data_la_thuile IS 'Tabella foreign dati la_thuile';


--
-- TOC entry 374 (class 1259 OID 20058)
-- Name: view_data_mt_fleury; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.view_data_mt_fleury AS
 SELECT get_cf_data_mt_fleury.fulldate,
    get_cf_data_mt_fleury.id,
    get_cf_data_mt_fleury.meanvalue,
    get_cf_data_mt_fleury.code,
    get_cf_data_mt_fleury.stationalarm,
    get_cf_data_mt_fleury.readings,
    get_cf_data_mt_fleury.min,
    get_cf_data_mt_fleury.mintime,
    get_cf_data_mt_fleury.max,
    get_cf_data_mt_fleury.maxtime,
    get_cf_data_mt_fleury.stddev,
    get_cf_data_mt_fleury.calccode
   FROM tables_ar.get_cf_data_mt_fleury((('now'::text)::date - '2 mons'::interval), (now())::timestamp without time zone) get_cf_data_mt_fleury(fulldate, id, meanvalue, code, stationalarm, readings, min, mintime, max, maxtime, stddev, calccode);


ALTER TABLE tables_ar.view_data_mt_fleury OWNER TO postgres;

--
-- TOC entry 5976 (class 0 OID 0)
-- Dependencies: 374
-- Name: VIEW view_data_mt_fleury; Type: COMMENT; Schema: tables_ar; Owner: postgres
--

COMMENT ON VIEW tables_ar.view_data_mt_fleury IS 'Tabella foreign dati mont_fleury';


--
-- TOC entry 375 (class 1259 OID 20062)
-- Name: view_data_plouves; Type: VIEW; Schema: tables_ar; Owner: postgres
--

CREATE VIEW tables_ar.view_data_plouves AS
 SELECT get_cf_data_plouves.fulldate,
    get_cf_data_plouves.id,
    get_cf_data_plouves.meanvalue,
    get_cf_data_plouves.code,
    get_cf_data_plouves.stationalarm,
    get_cf_data_plouves.readings,
    get_cf_data_plouves.min,
    get_cf_data_plouves.mintime,
    get_cf_data_plouves.max,
    get_cf_data_plouves.maxtime,
    get_cf_data_plouves.stddev,
    get_cf_data_plouves.calccode
   FROM tables_ar.get_cf_data_plouves((('now'::text)::date - '2 mons'::interval), (now())::timestamp without time zone) get_cf_data_plouves(fulldate, id, meanvalue, code, stationalarm, readings, min, mintime, max, maxtime, stddev, calccode);


ALTER TABLE tables_ar.view_data_plouves OWNER TO postgres;

--
-- TOC entry 5977 (class 0 OID 0)
-- Dependencies: 375
-- Name: VIEW view_data_plouves; Type: COMMENT; Schema: tables_ar; Owner: postgres
--

COMMENT ON VIEW tables_ar.view_data_plouves IS 'Tabella foreign dati plouves';


--
-- TOC entry 516 (class 1259 OID 27224)
-- Name: stations_alarms; Type: TABLE; Schema: tool_builder; Owner: postgres
--

CREATE TABLE tool_builder.stations_alarms (
    id bigint NOT NULL,
    st_id smallint NOT NULL,
    fulldate timestamp without time zone NOT NULL,
    alarm integer
);


ALTER TABLE tool_builder.stations_alarms OWNER TO postgres;

--
-- TOC entry 5978 (class 0 OID 0)
-- Dependencies: 516
-- Name: TABLE stations_alarms; Type: COMMENT; Schema: tool_builder; Owner: postgres
--

COMMENT ON TABLE tool_builder.stations_alarms IS 'Main table used only by builder to log station alarms';


--
-- TOC entry 517 (class 1259 OID 27227)
-- Name: builder_stations_alarms_id_seq; Type: SEQUENCE; Schema: tool_builder; Owner: postgres
--

CREATE SEQUENCE tool_builder.builder_stations_alarms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_builder.builder_stations_alarms_id_seq OWNER TO postgres;

--
-- TOC entry 5979 (class 0 OID 0)
-- Dependencies: 517
-- Name: builder_stations_alarms_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_builder; Owner: postgres
--

ALTER SEQUENCE tool_builder.builder_stations_alarms_id_seq OWNED BY tool_builder.stations_alarms.id;


--
-- TOC entry 518 (class 1259 OID 27229)
-- Name: stations_polling; Type: TABLE; Schema: tool_builder; Owner: postgres
--

CREATE TABLE tool_builder.stations_polling (
    st_id smallint NOT NULL,
    active boolean DEFAULT false,
    hoursframe boolean[] DEFAULT '{f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f}'::boolean[] NOT NULL,
    conntype smallint DEFAULT 0,
    conntype2 smallint DEFAULT 0,
    rasentry character varying(20),
    ftpfiletype smallint DEFAULT 0,
    ftpusername character varying(50),
    ftppassword character varying(50),
    ftpremotedir character varying(250),
    timeoutftpfile smallint DEFAULT 0,
    timeoutradiofile smallint DEFAULT 0,
    lastupdate timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone,
    status smallint DEFAULT 0,
    ordering smallint DEFAULT 0,
    filesystem character varying(250),
    tcpip character varying(100),
    startminutes smallint DEFAULT 0,
    startseconds smallint DEFAULT 0,
    check_update boolean DEFAULT false,
    conntype3 smallint DEFAULT 0,
    conntype4 smallint DEFAULT 0,
    rasentry2 character varying(20),
    tcpip2 character varying(100),
    calibrations boolean DEFAULT false,
    check_update_telegram boolean DEFAULT false
);


ALTER TABLE tool_builder.stations_polling OWNER TO postgres;

--
-- TOC entry 377 (class 1259 OID 21639)
-- Name: calibration_methods; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.calibration_methods (
    me_id integer NOT NULL,
    method_desc text NOT NULL
);


ALTER TABLE tool_netcom.calibration_methods OWNER TO postgres;

--
-- TOC entry 378 (class 1259 OID 21645)
-- Name: calibration_methods_me_id_seq; Type: SEQUENCE; Schema: tool_netcom; Owner: postgres
--

CREATE SEQUENCE tool_netcom.calibration_methods_me_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_netcom.calibration_methods_me_id_seq OWNER TO postgres;

--
-- TOC entry 5980 (class 0 OID 0)
-- Dependencies: 378
-- Name: calibration_methods_me_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_netcom; Owner: postgres
--

ALTER SEQUENCE tool_netcom.calibration_methods_me_id_seq OWNED BY tool_netcom.calibration_methods.me_id;


--
-- TOC entry 379 (class 1259 OID 21647)
-- Name: calibration_reasons; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.calibration_reasons (
    re_id integer NOT NULL,
    reason_desc text NOT NULL
);


ALTER TABLE tool_netcom.calibration_reasons OWNER TO postgres;

--
-- TOC entry 380 (class 1259 OID 21653)
-- Name: calibration_reasons_re_id_seq; Type: SEQUENCE; Schema: tool_netcom; Owner: postgres
--

CREATE SEQUENCE tool_netcom.calibration_reasons_re_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_netcom.calibration_reasons_re_id_seq OWNER TO postgres;

--
-- TOC entry 5981 (class 0 OID 0)
-- Dependencies: 380
-- Name: calibration_reasons_re_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_netcom; Owner: postgres
--

ALTER SEQUENCE tool_netcom.calibration_reasons_re_id_seq OWNED BY tool_netcom.calibration_reasons.re_id;


--
-- TOC entry 381 (class 1259 OID 21655)
-- Name: cylinders; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.cylinders (
    cy_id integer NOT NULL,
    arpa_id text NOT NULL,
    is_zero boolean NOT NULL,
    in_ca_id integer NOT NULL,
    date_built timestamp without time zone NOT NULL,
    date_expiry date,
    description text,
    ch1_value real,
    ch2_value real,
    ch3_value real,
    exhausted boolean,
    returned boolean,
    delivery_note text,
    shipment_note text,
    purchase_invoice text,
    reversal_invoice text,
    payment_invoice text,
    not_compliant boolean,
    note text,
    attachment text,
    all_stations boolean
);


ALTER TABLE tool_netcom.cylinders OWNER TO postgres;

--
-- TOC entry 382 (class 1259 OID 21661)
-- Name: cylinders_cy_id_seq; Type: SEQUENCE; Schema: tool_netcom; Owner: postgres
--

CREATE SEQUENCE tool_netcom.cylinders_cy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_netcom.cylinders_cy_id_seq OWNER TO postgres;

--
-- TOC entry 5982 (class 0 OID 0)
-- Dependencies: 382
-- Name: cylinders_cy_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_netcom; Owner: postgres
--

ALTER SEQUENCE tool_netcom.cylinders_cy_id_seq OWNED BY tool_netcom.cylinders.cy_id;


--
-- TOC entry 383 (class 1259 OID 21663)
-- Name: data_calibrations_2013_03_18; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.data_calibrations_2013_03_18 (
    id integer,
    st_id integer,
    us_id integer,
    arpa_id text,
    fulldate timestamp without time zone,
    re_id integer,
    zero_found real,
    zero_set real,
    zero_found2 real,
    zero_set2 real,
    zero_found3 real,
    zero_set3 real,
    zero_me_id integer,
    zero_cyl_arpa_id text,
    span_found real,
    span_set real,
    span_found2 real,
    span_set2 real,
    span_found3 real,
    span_set3 real,
    span_changed boolean,
    span_me_id integer,
    span_cyl_arpa_id text,
    cal_arpa_id text,
    flux real,
    flux2 real,
    flux3 real,
    freqf0nofilter real,
    freqf0filter real,
    calculateddelta boolean,
    concentrationref real,
    note text,
    ca_id integer
);


ALTER TABLE tool_netcom.data_calibrations_2013_03_18 OWNER TO postgres;

--
-- TOC entry 384 (class 1259 OID 21669)
-- Name: data_calibrations_id_seq; Type: SEQUENCE; Schema: tool_netcom; Owner: postgres
--

CREATE SEQUENCE tool_netcom.data_calibrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_netcom.data_calibrations_id_seq OWNER TO postgres;

--
-- TOC entry 5983 (class 0 OID 0)
-- Dependencies: 384
-- Name: data_calibrations_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_netcom; Owner: postgres
--

ALTER SEQUENCE tool_netcom.data_calibrations_id_seq OWNED BY tool_netcom.data_calibrations.id;


--
-- TOC entry 385 (class 1259 OID 21671)
-- Name: data_documents; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.data_documents (
    id integer NOT NULL,
    ma_id integer NOT NULL,
    description text NOT NULL,
    filename text NOT NULL
);


ALTER TABLE tool_netcom.data_documents OWNER TO postgres;

--
-- TOC entry 386 (class 1259 OID 21677)
-- Name: data_documents_id_seq; Type: SEQUENCE; Schema: tool_netcom; Owner: postgres
--

CREATE SEQUENCE tool_netcom.data_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_netcom.data_documents_id_seq OWNER TO postgres;

--
-- TOC entry 5984 (class 0 OID 0)
-- Dependencies: 386
-- Name: data_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_netcom; Owner: postgres
--

ALTER SEQUENCE tool_netcom.data_documents_id_seq OWNED BY tool_netcom.data_documents.id;


--
-- TOC entry 387 (class 1259 OID 21679)
-- Name: data_maintenances; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.data_maintenances (
    ma_id integer NOT NULL,
    st_id integer NOT NULL,
    us_id smallint NOT NULL,
    fulldate timestamp without time zone NOT NULL,
    note text
);


ALTER TABLE tool_netcom.data_maintenances OWNER TO postgres;

--
-- TOC entry 388 (class 1259 OID 21685)
-- Name: data_maintenances_ma_id_seq; Type: SEQUENCE; Schema: tool_netcom; Owner: postgres
--

CREATE SEQUENCE tool_netcom.data_maintenances_ma_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_netcom.data_maintenances_ma_id_seq OWNER TO postgres;

--
-- TOC entry 5985 (class 0 OID 0)
-- Dependencies: 388
-- Name: data_maintenances_ma_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_netcom; Owner: postgres
--

ALTER SEQUENCE tool_netcom.data_maintenances_ma_id_seq OWNED BY tool_netcom.data_maintenances.ma_id;


--
-- TOC entry 389 (class 1259 OID 21687)
-- Name: data_operations; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.data_operations (
    id integer NOT NULL,
    ma_id integer NOT NULL,
    arpa_id text,
    op_id integer NOT NULL,
    note text,
    ca_id integer,
    filters_expdate timestamp without time zone
);


ALTER TABLE tool_netcom.data_operations OWNER TO postgres;

--
-- TOC entry 390 (class 1259 OID 21693)
-- Name: data_operations_20180207; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.data_operations_20180207 (
    id integer,
    ma_id integer,
    arpa_id text,
    op_id integer,
    note text,
    ca_id integer,
    filters_expdate timestamp without time zone
);


ALTER TABLE tool_netcom.data_operations_20180207 OWNER TO postgres;

--
-- TOC entry 391 (class 1259 OID 21699)
-- Name: data_operations_id_seq; Type: SEQUENCE; Schema: tool_netcom; Owner: postgres
--

CREATE SEQUENCE tool_netcom.data_operations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_netcom.data_operations_id_seq OWNER TO postgres;

--
-- TOC entry 5986 (class 0 OID 0)
-- Dependencies: 391
-- Name: data_operations_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_netcom; Owner: postgres
--

ALTER SEQUENCE tool_netcom.data_operations_id_seq OWNED BY tool_netcom.data_operations.id;


--
-- TOC entry 392 (class 1259 OID 21701)
-- Name: data_spare_parts; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.data_spare_parts (
    id integer NOT NULL,
    ma_id integer NOT NULL,
    arpa_id text,
    sp_id integer NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE tool_netcom.data_spare_parts OWNER TO postgres;

--
-- TOC entry 393 (class 1259 OID 21707)
-- Name: data_spare_parts_id_seq; Type: SEQUENCE; Schema: tool_netcom; Owner: postgres
--

CREATE SEQUENCE tool_netcom.data_spare_parts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_netcom.data_spare_parts_id_seq OWNER TO postgres;

--
-- TOC entry 5987 (class 0 OID 0)
-- Dependencies: 393
-- Name: data_spare_parts_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_netcom; Owner: postgres
--

ALTER SEQUENCE tool_netcom.data_spare_parts_id_seq OWNED BY tool_netcom.data_spare_parts.id;


--
-- TOC entry 394 (class 1259 OID 21709)
-- Name: equipments; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.equipments (
    eq_id integer NOT NULL,
    arpa_id text NOT NULL,
    equipment text NOT NULL,
    dismiss_date date,
    note text
);


ALTER TABLE tool_netcom.equipments OWNER TO postgres;

--
-- TOC entry 5988 (class 0 OID 0)
-- Dependencies: 394
-- Name: TABLE equipments; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON TABLE tool_netcom.equipments IS 'Equipments table';


--
-- TOC entry 5989 (class 0 OID 0)
-- Dependencies: 394
-- Name: COLUMN equipments.eq_id; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.equipments.eq_id IS 'Equipment Arpa Id';


--
-- TOC entry 5990 (class 0 OID 0)
-- Dependencies: 394
-- Name: COLUMN equipments.equipment; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.equipments.equipment IS 'Equipment description';


--
-- TOC entry 395 (class 1259 OID 21715)
-- Name: equipments_eq_id_seq; Type: SEQUENCE; Schema: tool_netcom; Owner: postgres
--

CREATE SEQUENCE tool_netcom.equipments_eq_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_netcom.equipments_eq_id_seq OWNER TO postgres;

--
-- TOC entry 5991 (class 0 OID 0)
-- Dependencies: 395
-- Name: equipments_eq_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_netcom; Owner: postgres
--

ALTER SEQUENCE tool_netcom.equipments_eq_id_seq OWNED BY tool_netcom.equipments.eq_id;


--
-- TOC entry 396 (class 1259 OID 21717)
-- Name: instrument_categories; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.instrument_categories (
    in_ca_id smallint NOT NULL,
    instrument_category text
);


ALTER TABLE tool_netcom.instrument_categories OWNER TO postgres;

--
-- TOC entry 397 (class 1259 OID 21723)
-- Name: instruments_categories_parameters; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.instruments_categories_parameters (
    id integer NOT NULL,
    in_ca_id integer,
    pr_id integer
);


ALTER TABLE tool_netcom.instruments_categories_parameters OWNER TO postgres;

--
-- TOC entry 398 (class 1259 OID 21726)
-- Name: instruments_categories_parameters_id_seq; Type: SEQUENCE; Schema: tool_netcom; Owner: postgres
--

CREATE SEQUENCE tool_netcom.instruments_categories_parameters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_netcom.instruments_categories_parameters_id_seq OWNER TO postgres;

--
-- TOC entry 5992 (class 0 OID 0)
-- Dependencies: 398
-- Name: instruments_categories_parameters_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_netcom; Owner: postgres
--

ALTER SEQUENCE tool_netcom.instruments_categories_parameters_id_seq OWNED BY tool_netcom.instruments_categories_parameters.id;


--
-- TOC entry 399 (class 1259 OID 21728)
-- Name: instruments_in_id_seq; Type: SEQUENCE; Schema: tool_netcom; Owner: postgres
--

CREATE SEQUENCE tool_netcom.instruments_in_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_netcom.instruments_in_id_seq OWNER TO postgres;

--
-- TOC entry 5993 (class 0 OID 0)
-- Dependencies: 399
-- Name: instruments_in_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_netcom; Owner: postgres
--

ALTER SEQUENCE tool_netcom.instruments_in_id_seq OWNED BY tool_netcom.instruments.in_id;


--
-- TOC entry 400 (class 1259 OID 21730)
-- Name: instruments_metadata; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.instruments_metadata (
    arpa_id text NOT NULL,
    n_matricola integer,
    n_serie integer,
    n_inventario integer,
    stato_ricevimento text,
    d_ricevimento date,
    d_collaudo date,
    d_servizio date,
    range_utilizzo text,
    note text,
    in_ty_id integer,
    fl_sk_strumento boolean DEFAULT true
);


ALTER TABLE tool_netcom.instruments_metadata OWNER TO postgres;

--
-- TOC entry 401 (class 1259 OID 21737)
-- Name: instruments_operations; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.instruments_operations (
    id integer NOT NULL,
    in_ty_id integer NOT NULL,
    op_id integer NOT NULL
);


ALTER TABLE tool_netcom.instruments_operations OWNER TO postgres;

--
-- TOC entry 402 (class 1259 OID 21740)
-- Name: instruments_operations_id_seq; Type: SEQUENCE; Schema: tool_netcom; Owner: postgres
--

CREATE SEQUENCE tool_netcom.instruments_operations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_netcom.instruments_operations_id_seq OWNER TO postgres;

--
-- TOC entry 5994 (class 0 OID 0)
-- Dependencies: 402
-- Name: instruments_operations_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_netcom; Owner: postgres
--

ALTER SEQUENCE tool_netcom.instruments_operations_id_seq OWNED BY tool_netcom.instruments_operations.id;


--
-- TOC entry 403 (class 1259 OID 21742)
-- Name: instruments_spare_parts; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.instruments_spare_parts (
    id integer NOT NULL,
    in_ty_id integer NOT NULL,
    sp_id integer NOT NULL
);


ALTER TABLE tool_netcom.instruments_spare_parts OWNER TO postgres;

--
-- TOC entry 404 (class 1259 OID 21745)
-- Name: instruments_spare_parts_id_seq; Type: SEQUENCE; Schema: tool_netcom; Owner: postgres
--

CREATE SEQUENCE tool_netcom.instruments_spare_parts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_netcom.instruments_spare_parts_id_seq OWNER TO postgres;

--
-- TOC entry 5995 (class 0 OID 0)
-- Dependencies: 404
-- Name: instruments_spare_parts_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_netcom; Owner: postgres
--

ALTER SEQUENCE tool_netcom.instruments_spare_parts_id_seq OWNED BY tool_netcom.instruments_spare_parts.id;


--
-- TOC entry 405 (class 1259 OID 21747)
-- Name: instruments_types; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.instruments_types (
    in_ty_id integer NOT NULL,
    brand text,
    model text,
    constructor text NOT NULL,
    in_ca_id integer
);


ALTER TABLE tool_netcom.instruments_types OWNER TO postgres;

--
-- TOC entry 406 (class 1259 OID 21753)
-- Name: network_users; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.network_users (
    id integer NOT NULL,
    username text,
    location text,
    create_report boolean DEFAULT false
);


ALTER TABLE tool_netcom.network_users OWNER TO postgres;

--
-- TOC entry 5996 (class 0 OID 0)
-- Dependencies: 406
-- Name: TABLE network_users; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON TABLE tool_netcom.network_users IS 'Holds all the availables users';


--
-- TOC entry 5997 (class 0 OID 0)
-- Dependencies: 406
-- Name: COLUMN network_users.id; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.network_users.id IS 'Progressive unique id';


--
-- TOC entry 5998 (class 0 OID 0)
-- Dependencies: 406
-- Name: COLUMN network_users.username; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.network_users.username IS 'The user name';


--
-- TOC entry 5999 (class 0 OID 0)
-- Dependencies: 406
-- Name: COLUMN network_users.location; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.network_users.location IS 'The user location';


--
-- TOC entry 6000 (class 0 OID 0)
-- Dependencies: 406
-- Name: COLUMN network_users.create_report; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.network_users.create_report IS 'The user can create reports';


--
-- TOC entry 407 (class 1259 OID 21760)
-- Name: network_users_id_seq; Type: SEQUENCE; Schema: tool_netcom; Owner: postgres
--

CREATE SEQUENCE tool_netcom.network_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_netcom.network_users_id_seq OWNER TO postgres;

--
-- TOC entry 6001 (class 0 OID 0)
-- Dependencies: 407
-- Name: network_users_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_netcom; Owner: postgres
--

ALTER SEQUENCE tool_netcom.network_users_id_seq OWNED BY tool_netcom.network_users.id;


--
-- TOC entry 408 (class 1259 OID 21762)
-- Name: operation_category; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.operation_category (
    op_ca_id integer NOT NULL,
    category text
);


ALTER TABLE tool_netcom.operation_category OWNER TO postgres;

--
-- TOC entry 409 (class 1259 OID 21768)
-- Name: operation_frequency; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.operation_frequency (
    op_fr_id integer NOT NULL,
    frequency text,
    freq_days text
);


ALTER TABLE tool_netcom.operation_frequency OWNER TO postgres;

--
-- TOC entry 410 (class 1259 OID 21774)
-- Name: operations; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.operations (
    op_id integer NOT NULL,
    op_ca_id integer NOT NULL,
    op_fr_id integer NOT NULL,
    description text,
    used_frequency smallint
);


ALTER TABLE tool_netcom.operations OWNER TO postgres;

--
-- TOC entry 6002 (class 0 OID 0)
-- Dependencies: 410
-- Name: COLUMN operations.used_frequency; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.operations.used_frequency IS 'Heavy of most used operations';


--
-- TOC entry 411 (class 1259 OID 21780)
-- Name: raw_data_calibrations; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.raw_data_calibrations (
    calib_id integer NOT NULL,
    fulldate timestamp without time zone NOT NULL,
    st_id integer NOT NULL,
    id smallint NOT NULL,
    type text NOT NULL,
    step text NOT NULL,
    measure real NOT NULL
);


ALTER TABLE tool_netcom.raw_data_calibrations OWNER TO postgres;

--
-- TOC entry 6003 (class 0 OID 0)
-- Dependencies: 411
-- Name: TABLE raw_data_calibrations; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON TABLE tool_netcom.raw_data_calibrations IS 'Remote stations calibrations data';


--
-- TOC entry 6004 (class 0 OID 0)
-- Dependencies: 411
-- Name: COLUMN raw_data_calibrations.calib_id; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.raw_data_calibrations.calib_id IS 'Calibration id';


--
-- TOC entry 6005 (class 0 OID 0)
-- Dependencies: 411
-- Name: COLUMN raw_data_calibrations.fulldate; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.raw_data_calibrations.fulldate IS 'Calibration fulldate';


--
-- TOC entry 6006 (class 0 OID 0)
-- Dependencies: 411
-- Name: COLUMN raw_data_calibrations.id; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.raw_data_calibrations.id IS 'Parameter id';


--
-- TOC entry 6007 (class 0 OID 0)
-- Dependencies: 411
-- Name: COLUMN raw_data_calibrations.type; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.raw_data_calibrations.type IS 'Calibration type (AUTO,USER)';


--
-- TOC entry 6008 (class 0 OID 0)
-- Dependencies: 411
-- Name: COLUMN raw_data_calibrations.step; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.raw_data_calibrations.step IS 'Calibration step (ZERO,SPAN,PURGE,UNKNOWN)';


--
-- TOC entry 6009 (class 0 OID 0)
-- Dependencies: 411
-- Name: COLUMN raw_data_calibrations.measure; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.raw_data_calibrations.measure IS 'Parameter measure';


--
-- TOC entry 412 (class 1259 OID 21786)
-- Name: raw_data_calibrations_calib_id_seq; Type: SEQUENCE; Schema: tool_netcom; Owner: postgres
--

CREATE SEQUENCE tool_netcom.raw_data_calibrations_calib_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_netcom.raw_data_calibrations_calib_id_seq OWNER TO postgres;

--
-- TOC entry 413 (class 1259 OID 21788)
-- Name: result_data_calibrations; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.result_data_calibrations (
    calib_id integer NOT NULL,
    fulldate timestamp without time zone NOT NULL,
    st_id integer NOT NULL,
    id smallint NOT NULL,
    type text NOT NULL,
    step text NOT NULL,
    reference real NOT NULL,
    defect real NOT NULL,
    code smallint NOT NULL,
    meanvalue real NOT NULL
);


ALTER TABLE tool_netcom.result_data_calibrations OWNER TO postgres;

--
-- TOC entry 6010 (class 0 OID 0)
-- Dependencies: 413
-- Name: TABLE result_data_calibrations; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON TABLE tool_netcom.result_data_calibrations IS 'Remote stations calibrations results';


--
-- TOC entry 6011 (class 0 OID 0)
-- Dependencies: 413
-- Name: COLUMN result_data_calibrations.calib_id; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.result_data_calibrations.calib_id IS 'Calibration id';


--
-- TOC entry 6012 (class 0 OID 0)
-- Dependencies: 413
-- Name: COLUMN result_data_calibrations.fulldate; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.result_data_calibrations.fulldate IS 'Calibration fulldate';


--
-- TOC entry 6013 (class 0 OID 0)
-- Dependencies: 413
-- Name: COLUMN result_data_calibrations.id; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.result_data_calibrations.id IS 'Parameter id';


--
-- TOC entry 6014 (class 0 OID 0)
-- Dependencies: 413
-- Name: COLUMN result_data_calibrations.type; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.result_data_calibrations.type IS 'Calibration type (AUTO,USER)';


--
-- TOC entry 6015 (class 0 OID 0)
-- Dependencies: 413
-- Name: COLUMN result_data_calibrations.step; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.result_data_calibrations.step IS 'Calibration step (ZERO,SPAN,PURGE,UNKNOWN)';


--
-- TOC entry 6016 (class 0 OID 0)
-- Dependencies: 413
-- Name: COLUMN result_data_calibrations.reference; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.result_data_calibrations.reference IS 'Calibration reference value';


--
-- TOC entry 6017 (class 0 OID 0)
-- Dependencies: 413
-- Name: COLUMN result_data_calibrations.defect; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.result_data_calibrations.defect IS 'Calibration defect value';


--
-- TOC entry 6018 (class 0 OID 0)
-- Dependencies: 413
-- Name: COLUMN result_data_calibrations.meanvalue; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.result_data_calibrations.meanvalue IS 'Parameter meanvalue';


--
-- TOC entry 414 (class 1259 OID 21794)
-- Name: spare_parts; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.spare_parts (
    sp_id integer NOT NULL,
    description text
);


ALTER TABLE tool_netcom.spare_parts OWNER TO postgres;

--
-- TOC entry 415 (class 1259 OID 21800)
-- Name: stations_calibrators; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.stations_calibrators (
    st_ca_id integer NOT NULL,
    st_id integer NOT NULL,
    arpa_id text NOT NULL,
    fl_active boolean NOT NULL
);


ALTER TABLE tool_netcom.stations_calibrators OWNER TO postgres;

--
-- TOC entry 6019 (class 0 OID 0)
-- Dependencies: 415
-- Name: TABLE stations_calibrators; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON TABLE tool_netcom.stations_calibrators IS 'Holds the calibrators';


--
-- TOC entry 6020 (class 0 OID 0)
-- Dependencies: 415
-- Name: COLUMN stations_calibrators.fl_active; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.stations_calibrators.fl_active IS 'The calibrator is active and in use';


--
-- TOC entry 416 (class 1259 OID 21806)
-- Name: stations_calibrators_st_ca_id_seq; Type: SEQUENCE; Schema: tool_netcom; Owner: postgres
--

CREATE SEQUENCE tool_netcom.stations_calibrators_st_ca_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_netcom.stations_calibrators_st_ca_id_seq OWNER TO postgres;

--
-- TOC entry 6021 (class 0 OID 0)
-- Dependencies: 416
-- Name: stations_calibrators_st_ca_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_netcom; Owner: postgres
--

ALTER SEQUENCE tool_netcom.stations_calibrators_st_ca_id_seq OWNED BY tool_netcom.stations_calibrators.st_ca_id;


--
-- TOC entry 417 (class 1259 OID 21808)
-- Name: stations_cylinders; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.stations_cylinders (
    st_cy_id integer NOT NULL,
    st_id integer NOT NULL,
    date_start date NOT NULL,
    date_end date,
    note text,
    arpa_id text NOT NULL
);


ALTER TABLE tool_netcom.stations_cylinders OWNER TO postgres;

--
-- TOC entry 418 (class 1259 OID 21814)
-- Name: stations_cylinders_st_cy_id_seq; Type: SEQUENCE; Schema: tool_netcom; Owner: postgres
--

CREATE SEQUENCE tool_netcom.stations_cylinders_st_cy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_netcom.stations_cylinders_st_cy_id_seq OWNER TO postgres;

--
-- TOC entry 6022 (class 0 OID 0)
-- Dependencies: 418
-- Name: stations_cylinders_st_cy_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_netcom; Owner: postgres
--

ALTER SEQUENCE tool_netcom.stations_cylinders_st_cy_id_seq OWNED BY tool_netcom.stations_cylinders.st_cy_id;


--
-- TOC entry 419 (class 1259 OID 21816)
-- Name: stations_equipments; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.stations_equipments (
    st_eq_id integer NOT NULL,
    st_id integer NOT NULL,
    eq_id integer NOT NULL,
    date_start date NOT NULL,
    date_end date,
    note text
);


ALTER TABLE tool_netcom.stations_equipments OWNER TO postgres;

--
-- TOC entry 6023 (class 0 OID 0)
-- Dependencies: 419
-- Name: TABLE stations_equipments; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON TABLE tool_netcom.stations_equipments IS 'Stations equipments table';


--
-- TOC entry 6024 (class 0 OID 0)
-- Dependencies: 419
-- Name: COLUMN stations_equipments.st_eq_id; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.stations_equipments.st_eq_id IS 'Univocal item Id';


--
-- TOC entry 6025 (class 0 OID 0)
-- Dependencies: 419
-- Name: COLUMN stations_equipments.st_id; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.stations_equipments.st_id IS 'Station Id';


--
-- TOC entry 6026 (class 0 OID 0)
-- Dependencies: 419
-- Name: COLUMN stations_equipments.eq_id; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.stations_equipments.eq_id IS 'Equipment Id';


--
-- TOC entry 6027 (class 0 OID 0)
-- Dependencies: 419
-- Name: COLUMN stations_equipments.date_start; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.stations_equipments.date_start IS 'Allocation date start';


--
-- TOC entry 6028 (class 0 OID 0)
-- Dependencies: 419
-- Name: COLUMN stations_equipments.date_end; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.stations_equipments.date_end IS 'Allocation date end';


--
-- TOC entry 6029 (class 0 OID 0)
-- Dependencies: 419
-- Name: COLUMN stations_equipments.note; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON COLUMN tool_netcom.stations_equipments.note IS 'Note';


--
-- TOC entry 420 (class 1259 OID 21822)
-- Name: stations_equipments_st_eq_id_seq; Type: SEQUENCE; Schema: tool_netcom; Owner: postgres
--

CREATE SEQUENCE tool_netcom.stations_equipments_st_eq_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_netcom.stations_equipments_st_eq_id_seq OWNER TO postgres;

--
-- TOC entry 6030 (class 0 OID 0)
-- Dependencies: 420
-- Name: stations_equipments_st_eq_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_netcom; Owner: postgres
--

ALTER SEQUENCE tool_netcom.stations_equipments_st_eq_id_seq OWNED BY tool_netcom.stations_equipments.st_eq_id;


--
-- TOC entry 421 (class 1259 OID 21824)
-- Name: stations_instruments; Type: TABLE; Schema: tool_netcom; Owner: postgres
--

CREATE TABLE tool_netcom.stations_instruments (
    st_in_id integer NOT NULL,
    st_id integer NOT NULL,
    arpa_id text NOT NULL,
    fl_active boolean NOT NULL,
    date_start timestamp without time zone NOT NULL,
    date_end timestamp without time zone NOT NULL,
    note text
);


ALTER TABLE tool_netcom.stations_instruments OWNER TO postgres;

--
-- TOC entry 422 (class 1259 OID 21830)
-- Name: stations_instruments_st_in_id_seq; Type: SEQUENCE; Schema: tool_netcom; Owner: postgres
--

CREATE SEQUENCE tool_netcom.stations_instruments_st_in_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_netcom.stations_instruments_st_in_id_seq OWNER TO postgres;

--
-- TOC entry 6031 (class 0 OID 0)
-- Dependencies: 422
-- Name: stations_instruments_st_in_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_netcom; Owner: postgres
--

ALTER SEQUENCE tool_netcom.stations_instruments_st_in_id_seq OWNED BY tool_netcom.stations_instruments.st_in_id;


--
-- TOC entry 423 (class 1259 OID 21832)
-- Name: view_cylinders; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_cylinders AS
 SELECT c.cy_id,
    c.is_zero AS di_zero,
    c.arpa_id,
    c.in_ca_id,
    c.date_built AS data_produzione,
    c.date_expiry AS data_scadenza,
    c.exhausted AS esaurita,
    c.returned AS resa,
    c.description AS descrizione,
    c.ch1_value AS ch1_valore,
    c.ch2_value AS ch2_valore,
    c.ch3_value AS ch3_valore,
    ic.instrument_category AS cat_strumento
   FROM (tool_netcom.cylinders c
     JOIN tool_netcom.instrument_categories ic USING (in_ca_id))
  ORDER BY c.cy_id;


ALTER TABLE tool_netcom.view_cylinders OWNER TO postgres;

--
-- TOC entry 424 (class 1259 OID 21837)
-- Name: view_cylinders_stations; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_cylinders_stations AS
 SELECT sc.st_cy_id,
    sc.st_id,
    c.arpa_id,
    c.in_ca_id,
    c.date_built,
    c.date_expiry,
    c.exhausted,
    c.returned,
    c.description,
    sc.date_start,
    sc.date_end,
    ((((((date_part('epoch'::text, ((sc.date_end)::timestamp without time zone - (sc.date_start)::timestamp without time zone)) / (3600)::double precision))::integer / 24) || ' giorni e '::text) || (((date_part('epoch'::text, ((sc.date_end)::timestamp without time zone - (sc.date_start)::timestamp without time zone)) / (3600)::double precision))::integer % 24)) || ' ore '::text) AS duration,
    sc.note,
    s.stationname
   FROM ((tool_netcom.cylinders c
     LEFT JOIN tool_netcom.stations_cylinders sc USING (arpa_id))
     LEFT JOIN public._stations s USING (st_id))
  ORDER BY c.cy_id;


ALTER TABLE tool_netcom.view_cylinders_stations OWNER TO postgres;

--
-- TOC entry 425 (class 1259 OID 21842)
-- Name: view_cylinders_stations_ud; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_cylinders_stations_ud AS
 SELECT c.di_zero AS "Bombola di zero",
    c.arpa_id AS "ArpaId",
    c.in_ca_id AS "Categoria bombola",
    c.data_produzione AS "Data di produzione",
    c.data_scadenza AS "Data di scadenza",
    c.esaurita AS "Bombola esaurita",
    c.resa AS "Bombola resa",
    c.descrizione AS "Descrizione",
    c.ch1_valore AS "Valore parametro #1",
    c.ch2_valore AS "Valore parametro #2",
    c.ch3_valore AS "Valore parametro #3",
    c.cat_strumento AS "Categoria strumento",
    sc.date_start AS "Data posizionamento",
    sc.date_end AS "Data rimozione",
    sc.st_id AS "StId",
    s.stationname AS "Stazione"
   FROM ((tool_netcom.view_cylinders c
     LEFT JOIN tool_netcom.stations_cylinders sc USING (arpa_id))
     LEFT JOIN public._stations s USING (st_id))
  ORDER BY c.arpa_id;


ALTER TABLE tool_netcom.view_cylinders_stations_ud OWNER TO postgres;

--
-- TOC entry 426 (class 1259 OID 21847)
-- Name: view_cylinders_ud; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_cylinders_ud AS
 SELECT c.di_zero AS "Bombola di zero",
    c.arpa_id AS "ArpaId",
    c.in_ca_id AS "Categoria bombola",
    c.data_produzione AS "Data di produzione",
    c.data_scadenza AS "Data di scadenza",
    c.esaurita AS "Bombola esaurita",
    c.resa AS "Bombola resa",
    c.descrizione AS "Descrizione",
    c.di_zero AS "Di zero",
    c.ch1_valore AS "Valore parametro #1",
    c.ch2_valore AS "Valore parametro #2",
    c.ch3_valore AS "Valore parametro #3",
    c.cat_strumento AS "Categoria strumento"
   FROM tool_netcom.view_cylinders c
  ORDER BY c.cy_id;


ALTER TABLE tool_netcom.view_cylinders_ud OWNER TO postgres;

--
-- TOC entry 427 (class 1259 OID 21851)
-- Name: view_stations_instruments; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_stations_instruments AS
 SELECT si.st_in_id,
    si.st_id,
    si.fl_active AS attivo,
    i.in_id,
    i.arpa_id,
    it.in_ty_id,
    ic.in_ca_id,
    i.name AS strumento,
    i.serial_number AS numero_serie,
    i.date_delivery AS data_consegna,
    i.date_eol AS data_dismissione,
    it.brand AS marca,
    it.model AS modello,
    it.constructor AS costruttore,
    ic.instrument_category AS tipo
   FROM (((tool_netcom.instruments i
     JOIN tool_netcom.stations_instruments si ON ((si.arpa_id = i.arpa_id)))
     JOIN tool_netcom.instruments_types it ON ((it.in_ty_id = i.in_ty_id)))
     JOIN tool_netcom.instrument_categories ic ON ((ic.in_ca_id = it.in_ca_id)))
UNION ALL
 SELECT sc.st_ca_id AS st_in_id,
    sc.st_id,
    sc.fl_active AS attivo,
    i.in_id,
    i.arpa_id,
    it.in_ty_id,
    ic.in_ca_id,
    i.name AS strumento,
    i.serial_number AS numero_serie,
    i.date_delivery AS data_consegna,
    i.date_eol AS data_dismissione,
    it.brand AS marca,
    it.model AS modello,
    it.constructor AS costruttore,
    ic.instrument_category AS tipo
   FROM (((tool_netcom.instruments i
     JOIN tool_netcom.stations_calibrators sc ON ((sc.arpa_id = i.arpa_id)))
     JOIN tool_netcom.instruments_types it ON ((it.in_ty_id = i.in_ty_id)))
     JOIN tool_netcom.instrument_categories ic ON ((ic.in_ca_id = it.in_ca_id)))
  ORDER BY 5;


ALTER TABLE tool_netcom.view_stations_instruments OWNER TO postgres;

--
-- TOC entry 428 (class 1259 OID 21856)
-- Name: view_data_calibrations; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_data_calibrations AS
 SELECT c.id AS cal_id,
    c.st_id,
    c.us_id,
    u.username AS operatore,
    c.arpa_id AS strum_arpa_id,
    vi1.strumento AS strum_nome,
    vi1.attivo AS strum_attivo,
    vi1.marca AS strum_marca,
    vi1.modello AS strum_modello,
    vi1.costruttore AS strum_costruttore,
    vi1.tipo AS strum_tipo,
    vi1.in_ty_id AS strum_in_ty_id,
    vi1.in_ca_id AS strum_in_ca_id,
    c.fulldate AS data,
    c.zero_found AS zero_trovato1,
    c.zero_set AS zero_impostato1,
    c.zero_found2 AS zero_trovato2,
    c.zero_set2 AS zero_impostato2,
    c.zero_found3 AS zero_trovato3,
    c.zero_set3 AS zero_impostato3,
    c.zero_me_id,
    cm1.method_desc AS zero_metodo,
    c.span_found AS span_trovato1,
    c.span_set AS span_impostato1,
    c.span_found2 AS span_trovato2,
    c.span_set2 AS span_impostato2,
    c.span_found3 AS span_trovato3,
    c.span_set3 AS span_impostato3,
    c.span_changed AS span_cambiato,
    c.span_me_id,
    cm2.method_desc AS span_metodo,
    c.flux AS flusso1,
    c.flux2 AS flusso2,
    c.flux3 AS flusso3,
    c.freqf0nofilter AS freqf0,
    c.freqf0filter AS freqf0_filtro,
    c.calculateddelta AS calc_delta,
    c.concentrationref AS conc_ref,
    c.note,
    c.re_id,
    r.reason_desc AS motivo,
    c.zero_cyl_arpa_id AS bombola_zero_arpa_id,
    cyz.date_expiry AS bombola_zero_scadenza,
    cyz.description AS bombola_zero_desc,
    cyz.ch1_value AS bombola_zero_ch1,
    cyz.ch1_value AS bombola_zero_ch2,
    cyz.ch1_value AS bombola_zero_ch3,
    c.span_cyl_arpa_id AS bombola_span_arpa_id,
    cys.date_expiry AS bombola_span_scadenza,
    cys.description AS bombola_span_desc,
    cys.ch1_value AS bombola_span_ch1,
    cys.ch1_value AS bombola_span_ch2,
    cys.ch1_value AS bombola_span_ch3,
    c.cal_arpa_id AS calib_arpa_id,
    vi2.strumento AS calib_nome,
    vi2.attivo AS calib_attivo,
    vi2.marca AS calib_marca,
    vi2.modello AS calib_modello,
    vi2.costruttore AS calib_costruttore,
    vi2.tipo AS calib_tipo,
    vi2.in_ty_id AS calib_in_ty_id,
    vi2.in_ca_id AS calib_in_ca_id
   FROM ((((((((tool_netcom.data_calibrations c
     LEFT JOIN public._users u ON ((c.us_id = u.us_id)))
     LEFT JOIN tool_netcom.view_stations_instruments vi1 ON ((c.arpa_id = vi1.arpa_id)))
     LEFT JOIN tool_netcom.view_stations_instruments vi2 ON ((c.cal_arpa_id = vi2.arpa_id)))
     LEFT JOIN tool_netcom.calibration_reasons r ON ((c.re_id = r.re_id)))
     LEFT JOIN tool_netcom.calibration_methods cm1 ON ((c.zero_me_id = cm1.me_id)))
     LEFT JOIN tool_netcom.calibration_methods cm2 ON ((c.span_me_id = cm2.me_id)))
     LEFT JOIN tool_netcom.cylinders cyz ON ((c.zero_cyl_arpa_id = cyz.arpa_id)))
     LEFT JOIN tool_netcom.cylinders cys ON ((c.span_cyl_arpa_id = cys.arpa_id)))
  ORDER BY c.id;


ALTER TABLE tool_netcom.view_data_calibrations OWNER TO postgres;

--
-- TOC entry 429 (class 1259 OID 21861)
-- Name: view_data_calibrations_details_ud; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_data_calibrations_details_ud AS
 SELECT DISTINCT c.id,
    c.id AS "CalId",
    c.st_id AS "StId",
    s.stationname AS "Stazione",
    c.us_id,
    u.username AS "Operatore",
    c.arpa_id AS "Strumento Arpa ID",
    vi1.strumento AS "Strumento",
    vi1.attivo AS strum_attivo,
    vi1.marca AS strum_marca,
    vi1.modello AS strum_modello,
    vi1.costruttore AS strum_costruttore,
    vi1.tipo AS strum_tipo,
    vi1.in_ty_id AS strum_in_ty_id,
    vi1.in_ca_id AS strum_in_ca_id,
    c.fulldate AS "Data",
    c.zero_found AS zero_trovato1,
    c.zero_set AS zero_impostato1,
    c.zero_found2 AS zero_trovato2,
    c.zero_set2 AS zero_impostato2,
    c.zero_found3 AS zero_trovato3,
    c.zero_set3 AS zero_impostato3,
    c.zero_me_id,
    cm1.method_desc AS zero_metodo,
    c.span_set AS "Span verifica",
    c.span_found AS span_trovato1,
    c.span_set AS span_impostato1,
    c.span_found2 AS span_trovato2,
    c.span_set2 AS span_impostato2,
    c.span_found3 AS span_trovato3,
    c.span_set3 AS span_impostato3,
    c.span_changed AS "Span modificato",
    c.span_me_id,
    cm2.method_desc AS span_metodo,
    c.flux AS flusso1,
    c.flux2 AS flusso2,
    c.flux3 AS flusso3,
    c.freqf0nofilter AS freqf0,
    c.freqf0filter AS freqf0_filtro,
    c.calculateddelta AS calc_delta,
    c.concentrationref AS conc_ref,
    c.note AS "Note",
    c.re_id,
    r.reason_desc AS motivo,
    c.zero_cyl_arpa_id AS "Bombola di zero Arpa ID",
    cyz.date_expiry AS bombola_zero_scadenza,
    cyz.description AS "Bombola di zero",
    cyz.ch1_value AS bombola_zero_ch1,
    cyz.ch2_value AS bombola_zero_ch2,
    cyz.ch3_value AS bombola_zero_ch3,
    c.span_cyl_arpa_id AS "Bombola di span Arpa ID",
    cys.date_expiry AS bombola_span_scadenza,
    cys.description AS "Bombola di span",
    cys.ch1_value AS bombola_span_ch1,
    cys.ch2_value AS bombola_span_ch2,
    cys.ch3_value AS bombola_span_ch3,
    c.cal_arpa_id AS "Calibratore Arpa ID",
    vi2.strumento AS calib_nome,
    vi2.attivo AS calib_attivo,
    vi2.marca AS calib_marca,
    vi2.modello AS calib_modello,
    vi2.costruttore AS calib_costruttore,
    vi2.tipo AS calib_tipo,
    vi2.in_ty_id AS calib_in_ty_id,
    vi2.in_ca_id AS calib_in_ca_id
   FROM (((((((((tool_netcom.data_calibrations c
     LEFT JOIN public._stations s ON ((s.st_id = c.st_id)))
     LEFT JOIN tool_netcom.network_users u ON ((c.us_id = u.id)))
     LEFT JOIN tool_netcom.view_stations_instruments vi1 ON ((c.arpa_id = vi1.arpa_id)))
     LEFT JOIN tool_netcom.view_stations_instruments vi2 ON ((c.cal_arpa_id = vi2.arpa_id)))
     LEFT JOIN tool_netcom.calibration_reasons r ON ((c.re_id = r.re_id)))
     LEFT JOIN tool_netcom.calibration_methods cm1 ON ((c.zero_me_id = cm1.me_id)))
     LEFT JOIN tool_netcom.calibration_methods cm2 ON ((c.span_me_id = cm2.me_id)))
     LEFT JOIN tool_netcom.cylinders cyz ON ((c.zero_cyl_arpa_id = cyz.arpa_id)))
     LEFT JOIN tool_netcom.cylinders cys ON ((c.span_cyl_arpa_id = cys.arpa_id)))
  ORDER BY c.fulldate DESC, c.st_id, c.id, s.stationname, c.us_id, u.username, c.arpa_id, vi1.strumento, vi1.attivo, vi1.marca, vi1.modello, vi1.costruttore, vi1.tipo, vi1.in_ty_id, vi1.in_ca_id, c.zero_found, c.zero_set, c.zero_found2, c.zero_set2, c.zero_found3, c.zero_set3, c.zero_me_id, cm1.method_desc, c.span_set, c.span_found, c.span_found2, c.span_set2, c.span_found3, c.span_set3, c.span_changed, c.span_me_id, cm2.method_desc, c.flux, c.flux2, c.flux3, c.freqf0nofilter, c.freqf0filter, c.calculateddelta, c.concentrationref, c.note, c.re_id, r.reason_desc, c.zero_cyl_arpa_id, cyz.date_expiry, cyz.description, cyz.ch1_value, cyz.ch2_value, cyz.ch3_value, c.span_cyl_arpa_id, cys.date_expiry, cys.description, cys.ch1_value, cys.ch2_value, cys.ch3_value, c.cal_arpa_id, vi2.strumento, vi2.attivo, vi2.marca, vi2.modello, vi2.costruttore, vi2.tipo, vi2.in_ty_id, vi2.in_ca_id;


ALTER TABLE tool_netcom.view_data_calibrations_details_ud OWNER TO postgres;

--
-- TOC entry 430 (class 1259 OID 21866)
-- Name: view_data_calibrations_master_ud; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_data_calibrations_master_ud AS
 SELECT DISTINCT c.id,
    c.id AS "CalId",
    c.st_id AS "StId",
    s.stationname AS "Stazione",
    u.username AS "Operatore",
    vi1.in_ca_id AS "InCaId",
    vi1.strumento AS "Strumento",
    c.fulldate AS "Data",
    array_to_string(ARRAY[c.span_set, c.span_set2, c.span_set3], ','::text) AS "Span verifica",
    c.span_changed AS "Span modificato",
    c.note AS "Note",
    cyz.description AS "Bombola di zero",
    cys.description AS "Bombola di span",
    vi2.strumento AS "Calibratore"
   FROM (((((((((tool_netcom.data_calibrations c
     LEFT JOIN public._stations s ON ((s.st_id = c.st_id)))
     LEFT JOIN tool_netcom.network_users u ON ((c.us_id = u.id)))
     LEFT JOIN tool_netcom.view_stations_instruments vi1 ON ((c.arpa_id = vi1.arpa_id)))
     LEFT JOIN tool_netcom.view_stations_instruments vi2 ON ((c.cal_arpa_id = vi2.arpa_id)))
     LEFT JOIN tool_netcom.calibration_reasons r ON ((c.re_id = r.re_id)))
     LEFT JOIN tool_netcom.calibration_methods cm1 ON ((c.zero_me_id = cm1.me_id)))
     LEFT JOIN tool_netcom.calibration_methods cm2 ON ((c.span_me_id = cm2.me_id)))
     LEFT JOIN tool_netcom.cylinders cyz ON ((c.zero_cyl_arpa_id = cyz.arpa_id)))
     LEFT JOIN tool_netcom.cylinders cys ON ((c.span_cyl_arpa_id = cys.arpa_id)))
  ORDER BY c.fulldate DESC, c.st_id, c.id, s.stationname, u.username, vi1.in_ca_id, vi1.strumento, (array_to_string(ARRAY[c.span_set, c.span_set2, c.span_set3], ','::text)), c.span_changed, c.note, cyz.description, cys.description, vi2.strumento;


ALTER TABLE tool_netcom.view_data_calibrations_master_ud OWNER TO postgres;

--
-- TOC entry 431 (class 1259 OID 21871)
-- Name: view_data_calibrations_print_ud; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_data_calibrations_print_ud AS
 SELECT c.id AS "CalId",
    c.st_id AS "StId",
    s.stationname AS "Stazione",
    vi1.in_ca_id AS "InCaId",
    vi1.strumento AS "Strumento",
    c.fulldate AS "Data",
    r.reason_desc AS "Motivo",
    cyz.description AS "Bombola di zero",
    cys.description AS "Bombola di span",
    vi2.strumento AS "Calibratore",
    c.zero_found AS "Zero",
    c.zero_set AS "Zero imposto",
    c.zero_found2 AS "Zero ch2",
    c.zero_set2 AS "Zero ch2 imposto",
    c.zero_found3 AS "Zero ch",
    c.zero_set3 AS "Zero ch3 imposto",
    cm1.method_desc AS "Metodo zero",
    c.span_found AS "Span",
    c.span_set AS "Span imposto",
    c.span_found2 AS "Span ch2",
    c.span_set2 AS "Span ch2 imposto",
    c.span_found3 AS "Span ch",
    c.span_set3 AS "Span ch3 imposto",
    c.span_changed AS "Span modificato",
    cm2.method_desc AS "Metodo span",
    c.note AS "Note"
   FROM (((((((((tool_netcom.data_calibrations c
     LEFT JOIN public._stations s ON ((s.st_id = c.st_id)))
     LEFT JOIN tool_netcom.network_users u ON ((c.us_id = u.id)))
     LEFT JOIN tool_netcom.view_stations_instruments vi1 ON ((c.arpa_id = vi1.arpa_id)))
     LEFT JOIN tool_netcom.view_stations_instruments vi2 ON ((c.cal_arpa_id = vi2.arpa_id)))
     LEFT JOIN tool_netcom.calibration_reasons r ON ((c.re_id = r.re_id)))
     LEFT JOIN tool_netcom.calibration_methods cm1 ON ((c.zero_me_id = cm1.me_id)))
     LEFT JOIN tool_netcom.calibration_methods cm2 ON ((c.span_me_id = cm2.me_id)))
     LEFT JOIN tool_netcom.cylinders cyz ON ((c.zero_cyl_arpa_id = cyz.arpa_id)))
     LEFT JOIN tool_netcom.cylinders cys ON ((c.span_cyl_arpa_id = cys.arpa_id)))
  ORDER BY c.fulldate DESC, c.st_id;


ALTER TABLE tool_netcom.view_data_calibrations_print_ud OWNER TO postgres;

--
-- TOC entry 432 (class 1259 OID 21876)
-- Name: view_data_documents_ud; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_data_documents_ud AS
 SELECT d.filename AS "Nome file",
    d.description AS "Descrizione",
    d.ma_id AS "MaId",
    d.id AS "ID"
   FROM tool_netcom.data_documents d
  ORDER BY d.id;


ALTER TABLE tool_netcom.view_data_documents_ud OWNER TO postgres;

--
-- TOC entry 433 (class 1259 OID 21880)
-- Name: view_data_maintenances; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_data_maintenances AS
 SELECT us_id,
    data_maintenances.ma_id,
    data_maintenances.st_id,
    data_maintenances.fulldate,
    data_maintenances.note,
    _users.username,
    _users.userpass,
    _users.userlevel,
    _users.userremark,
    _users.userlastlogin
   FROM (tool_netcom.data_maintenances
     LEFT JOIN public._users USING (us_id))
  ORDER BY data_maintenances.ma_id;


ALTER TABLE tool_netcom.view_data_maintenances OWNER TO postgres;

--
-- TOC entry 434 (class 1259 OID 21884)
-- Name: view_data_maintenances_ud; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_data_maintenances_ud AS
 SELECT m.fulldate AS "Data",
    u.username AS "Operatore",
    s.stationname AS "Stazione",
    m.note AS "Note",
    m.st_id AS "StId",
    m.ma_id AS "ID"
   FROM ((tool_netcom.data_maintenances m
     LEFT JOIN public._users u USING (us_id))
     LEFT JOIN public._stations s ON ((s.st_id = m.st_id)))
  ORDER BY m.ma_id;


ALTER TABLE tool_netcom.view_data_maintenances_ud OWNER TO postgres;

--
-- TOC entry 435 (class 1259 OID 21889)
-- Name: view_operations; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_operations AS
 SELECT o.op_id,
    o.op_ca_id,
    o.op_fr_id,
    o.description AS descrizione,
    of.frequency AS frequenza,
    oc.category AS categoria
   FROM ((tool_netcom.operations o
     JOIN tool_netcom.operation_frequency of USING (op_fr_id))
     JOIN tool_netcom.operation_category oc ON ((o.op_ca_id = oc.op_ca_id)))
  ORDER BY o.op_id;


ALTER TABLE tool_netcom.view_operations OWNER TO postgres;

--
-- TOC entry 436 (class 1259 OID 21893)
-- Name: view_data_operations; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_data_operations AS
 SELECT data_operations.op_id,
    data_operations.id,
    data_operations.ma_id,
    data_operations.arpa_id,
    data_operations.note,
    view_operations.op_ca_id,
    view_operations.op_fr_id,
    view_operations.descrizione,
    view_operations.frequenza,
    view_operations.categoria
   FROM (tool_netcom.data_operations
     LEFT JOIN tool_netcom.view_operations USING (op_id))
  ORDER BY data_operations.id;


ALTER TABLE tool_netcom.view_data_operations OWNER TO postgres;

--
-- TOC entry 437 (class 1259 OID 21897)
-- Name: view_data_operations_ud; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_data_operations_ud AS
 SELECT DISTINCT o.id,
    i.name AS "Strumento",
    o.note AS "Note",
    o.filters_expdate AS "Scadenza",
    o.ca_id AS "Calibrazione Id",
    vo.descrizione AS "Descrizione",
    vo.frequenza AS "Frequenza",
    vo.categoria AS "Categoria",
    o.arpa_id AS "ArpaId",
    o.ma_id AS "MaId",
    o.op_id AS "OpId",
    o.id AS "ID"
   FROM (((tool_netcom.data_operations o
     LEFT JOIN tool_netcom.view_operations vo USING (op_id))
     LEFT JOIN tool_netcom.stations_instruments si ON ((o.arpa_id = si.arpa_id)))
     LEFT JOIN tool_netcom.instruments i ON ((i.arpa_id = si.arpa_id)))
  ORDER BY o.id, i.name, o.note, o.filters_expdate, o.ca_id, vo.descrizione, vo.frequenza, vo.categoria, o.arpa_id, o.ma_id, o.op_id;


ALTER TABLE tool_netcom.view_data_operations_ud OWNER TO postgres;

--
-- TOC entry 438 (class 1259 OID 21902)
-- Name: view_spare_parts; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_spare_parts AS
 SELECT sp.sp_id,
    sp.description AS descrizione
   FROM tool_netcom.spare_parts sp
  ORDER BY sp.sp_id;


ALTER TABLE tool_netcom.view_spare_parts OWNER TO postgres;

--
-- TOC entry 439 (class 1259 OID 21906)
-- Name: view_data_spare_parts; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_data_spare_parts AS
 SELECT data_spare_parts.sp_id,
    data_spare_parts.id,
    data_spare_parts.ma_id,
    data_spare_parts.arpa_id,
    data_spare_parts.quantity,
    view_spare_parts.descrizione
   FROM (tool_netcom.data_spare_parts
     LEFT JOIN tool_netcom.view_spare_parts USING (sp_id))
  ORDER BY data_spare_parts.id;


ALTER TABLE tool_netcom.view_data_spare_parts OWNER TO postgres;

--
-- TOC entry 440 (class 1259 OID 21910)
-- Name: view_data_spare_parts_ud; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_data_spare_parts_ud AS
 SELECT i.name AS "Strumento",
    vps.descrizione AS "Descrizione",
    sp.quantity AS "Quantità",
    sp.arpa_id AS "ArpaId",
    sp.ma_id AS "MaId",
    sp.sp_id AS "SpId",
    sp.id AS "ID"
   FROM (((tool_netcom.data_spare_parts sp
     LEFT JOIN tool_netcom.view_spare_parts vps USING (sp_id))
     LEFT JOIN tool_netcom.stations_instruments si ON ((sp.arpa_id = si.arpa_id)))
     LEFT JOIN tool_netcom.instruments i ON ((i.arpa_id = si.arpa_id)))
  ORDER BY sp.id;


ALTER TABLE tool_netcom.view_data_spare_parts_ud OWNER TO postgres;

--
-- TOC entry 441 (class 1259 OID 21915)
-- Name: view_equipments_stations; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_equipments_stations AS
 SELECT se.st_eq_id,
    eq.eq_id,
    eq.arpa_id,
    eq.equipment,
    se.date_start,
    se.date_end,
    se.note,
    ss.st_id,
    ss.stationname AS station,
    '--'::text AS duration
   FROM ((tool_netcom.stations_equipments se
     LEFT JOIN tool_netcom.equipments eq USING (eq_id))
     LEFT JOIN public._stations ss USING (st_id))
  ORDER BY se.st_eq_id;


ALTER TABLE tool_netcom.view_equipments_stations OWNER TO postgres;

--
-- TOC entry 6032 (class 0 OID 0)
-- Dependencies: 441
-- Name: VIEW view_equipments_stations; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON VIEW tool_netcom.view_equipments_stations IS 'Stations equipments view';


--
-- TOC entry 442 (class 1259 OID 21920)
-- Name: view_instruments; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_instruments AS
 SELECT i.in_id,
    i.arpa_id,
    i.in_ty_id,
    ic.in_ca_id,
    i.name AS strumento,
    i.serial_number AS numero_serie,
    i.date_delivery AS data_consegna,
    i.date_eol AS data_dismissione,
    it.brand AS marca,
    it.model AS modello,
    it.constructor AS costruttore,
    ic.instrument_category AS tipo,
    i.note
   FROM ((tool_netcom.instruments i
     JOIN tool_netcom.instruments_types it ON ((it.in_ty_id = i.in_ty_id)))
     JOIN tool_netcom.instrument_categories ic ON ((ic.in_ca_id = it.in_ca_id)))
  ORDER BY i.arpa_id;


ALTER TABLE tool_netcom.view_instruments OWNER TO postgres;

--
-- TOC entry 443 (class 1259 OID 21925)
-- Name: view_instruments_operations; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_instruments_operations AS
 SELECT i.in_ty_id,
    o.op_id,
    o.op_ca_id,
    o.op_fr_id,
    i.brand AS marca,
    i.model AS modello,
    i.constructor AS costruttore,
    o.description AS descrizione,
    of.frequency AS frequenza,
    oc.category AS categoria
   FROM ((((tool_netcom.operations o
     JOIN tool_netcom.operation_frequency of USING (op_fr_id))
     JOIN tool_netcom.operation_category oc ON ((o.op_ca_id = oc.op_ca_id)))
     JOIN tool_netcom.instruments_operations io ON ((o.op_id = io.op_id)))
     JOIN tool_netcom.instruments_types i ON ((i.in_ty_id = io.in_ty_id)))
  ORDER BY i.in_ty_id, o.op_id;


ALTER TABLE tool_netcom.view_instruments_operations OWNER TO postgres;

--
-- TOC entry 444 (class 1259 OID 21930)
-- Name: view_instruments_roaming; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_instruments_roaming AS
 SELECT i.in_id,
    i.arpa_id,
    i.in_ty_id,
    i.name AS instrument,
    si.st_in_id,
    si.st_id,
    si.date_start,
    si.date_end,
    (si.date_end - si.date_start) AS duration,
    si.fl_active AS active,
    si.note,
    s.stationname AS station
   FROM ((tool_netcom.stations_instruments si
     JOIN tool_netcom.instruments i USING (arpa_id))
     JOIN public._stations s USING (st_id))
  ORDER BY si.date_start;


ALTER TABLE tool_netcom.view_instruments_roaming OWNER TO postgres;

--
-- TOC entry 445 (class 1259 OID 21935)
-- Name: view_instruments_spare_parts; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_instruments_spare_parts AS
 SELECT i.in_ty_id,
    sp.sp_id,
    sp.description AS descrizione,
    i.brand AS marca,
    i.model AS modello,
    i.constructor AS costruttore
   FROM ((tool_netcom.spare_parts sp
     JOIN tool_netcom.instruments_spare_parts isp USING (sp_id))
     JOIN tool_netcom.instruments_types i ON ((i.in_ty_id = isp.in_ty_id)))
  ORDER BY isp.in_ty_id, sp.sp_id;


ALTER TABLE tool_netcom.view_instruments_spare_parts OWNER TO postgres;

--
-- TOC entry 446 (class 1259 OID 21939)
-- Name: view_raw_data_calibrations; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_raw_data_calibrations AS
 SELECT dc.calib_id,
    dc.fulldate,
    dc.st_id,
    dc.id,
    dc.type AS calib_type,
    dc.step AS calib_step,
    dc.measure,
    s.stationname AS station_name,
    s.tableid,
    s.schema,
    plm.name AS param_name,
    plm.unit AS param_unit
   FROM (((tool_netcom.raw_data_calibrations dc
     LEFT JOIN public._stations s USING (st_id))
     LEFT JOIN public._stations_parameters_master spm USING (st_id, id))
     LEFT JOIN public._parameters_list_master plm USING (pr_id))
  ORDER BY dc.calib_id, dc.fulldate;


ALTER TABLE tool_netcom.view_raw_data_calibrations OWNER TO postgres;

--
-- TOC entry 6033 (class 0 OID 0)
-- Dependencies: 446
-- Name: VIEW view_raw_data_calibrations; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON VIEW tool_netcom.view_raw_data_calibrations IS 'Calibrations data view';


--
-- TOC entry 447 (class 1259 OID 21944)
-- Name: view_result_data_calibrations; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_result_data_calibrations AS
 SELECT dc.calib_id,
    dc.fulldate,
    dc.st_id,
    dc.id,
    dc.type AS calib_type,
    dc.step AS calib_step,
    dc.reference AS calib_reference,
        CASE
            WHEN (dc.step = 'ZERO'::text) THEN ((dc.defect)::text || ' ppb'::text)
            ELSE ((dc.defect)::text || ' %'::text)
        END AS calib_defect,
    dc.code AS calib_code,
    dc.meanvalue,
    s.stationname AS station_name,
    s.tableid,
    s.schema,
    plm.name AS param_name,
    plm.unit AS param_unit,
        CASE
            WHEN (((plm.name)::text = 'NO'::text) OR ((plm.name)::text = 'NO2'::text)) THEN ''::text
            ELSE tool_netcom.calib_results_tostring((dc.code)::integer, dc.step)
        END AS calib_code_string
   FROM (((tool_netcom.result_data_calibrations dc
     LEFT JOIN public._stations s USING (st_id))
     LEFT JOIN public._stations_parameters_master spm USING (st_id, id))
     LEFT JOIN public._parameters_list_master plm USING (pr_id))
  ORDER BY dc.calib_id, dc.fulldate;


ALTER TABLE tool_netcom.view_result_data_calibrations OWNER TO postgres;

--
-- TOC entry 6034 (class 0 OID 0)
-- Dependencies: 447
-- Name: VIEW view_result_data_calibrations; Type: COMMENT; Schema: tool_netcom; Owner: postgres
--

COMMENT ON VIEW tool_netcom.view_result_data_calibrations IS 'Calibrations result view';


--
-- TOC entry 448 (class 1259 OID 21949)
-- Name: view_station_and_instruments; Type: VIEW; Schema: tool_netcom; Owner: postgres
--

CREATE VIEW tool_netcom.view_station_and_instruments AS
 SELECT si.st_in_id,
    si.st_id,
    si.arpa_id,
    i.in_ty_id,
    it.in_ca_id,
    si.name AS strumento,
    si.serial_number AS numero_serie,
    si.date_delivery AS data_consegna,
    si.date_eol AS data_dismissione,
    si.fl_active AS attivo,
    i.brand AS marca,
    i.model AS modello,
    i.constructor AS costruttore,
    it.instrument_category AS tipo,
    si.date_start,
    si.date_end,
    s.stationname AS station_name,
    si.note,
    si.in_id
   FROM (((( SELECT 0 AS st_in_id,
            'ST0000'::text AS arpa_id,
            0 AS st_id,
            0 AS in_id,
            100 AS in_ty_id,
            'Stazione'::text AS name,
            NULL::text AS serial_number,
            NULL::date AS date_delivery,
            NULL::date AS date_eol,
            true AS fl_active,
            now() AS date_start,
            now() AS date_end,
            NULL::text AS note
        UNION ALL
         SELECT 1 AS st_in_id,
            'ST4999'::text AS arpa_id,
            4999 AS st_id,
            0 AS in_id,
            200 AS in_ty_id,
            'Arpa CED'::text AS name,
            NULL::text AS serial_number,
            NULL::date AS date_delivery,
            NULL::date AS date_eol,
            true AS fl_active,
            now() AS date_start,
            now() AS date_end,
            NULL::text AS note
        UNION ALL
         SELECT stations_instruments.st_in_id,
            stations_instruments.arpa_id,
            stations_instruments.st_id,
            i_1.in_id,
            i_1.in_ty_id,
            i_1.name,
            i_1.serial_number,
            i_1.date_delivery,
            i_1.date_eol,
            stations_instruments.fl_active,
            stations_instruments.date_start,
            stations_instruments.date_end,
            stations_instruments.note
           FROM (tool_netcom.stations_instruments
             JOIN tool_netcom.instruments i_1 USING (arpa_id))) si
     LEFT JOIN public._stations s ON ((s.st_id = si.st_id)))
     LEFT JOIN tool_netcom.instruments_types i ON ((i.in_ty_id = si.in_ty_id)))
     LEFT JOIN tool_netcom.instrument_categories it ON ((it.in_ca_id = i.in_ca_id)))
  ORDER BY si.arpa_id;


ALTER TABLE tool_netcom.view_station_and_instruments OWNER TO postgres;

--
-- TOC entry 449 (class 1259 OID 22172)
-- Name: page_autoscale; Type: TABLE; Schema: tool_visualizer_lily; Owner: postgres
--

CREATE TABLE tool_visualizer_lily.page_autoscale (
    id smallint NOT NULL,
    autoscale character varying(25) DEFAULT ''::character varying
);


ALTER TABLE tool_visualizer_lily.page_autoscale OWNER TO postgres;

--
-- TOC entry 6035 (class 0 OID 0)
-- Dependencies: 449
-- Name: TABLE page_autoscale; Type: COMMENT; Schema: tool_visualizer_lily; Owner: postgres
--

COMMENT ON TABLE tool_visualizer_lily.page_autoscale IS 'Support reference table for pages';


--
-- TOC entry 450 (class 1259 OID 22176)
-- Name: page_charttype; Type: TABLE; Schema: tool_visualizer_lily; Owner: postgres
--

CREATE TABLE tool_visualizer_lily.page_charttype (
    id smallint NOT NULL,
    charttype character varying(25) DEFAULT ''::character varying
);


ALTER TABLE tool_visualizer_lily.page_charttype OWNER TO postgres;

--
-- TOC entry 6036 (class 0 OID 0)
-- Dependencies: 450
-- Name: TABLE page_charttype; Type: COMMENT; Schema: tool_visualizer_lily; Owner: postgres
--

COMMENT ON TABLE tool_visualizer_lily.page_charttype IS 'Support reference table for pages';


--
-- TOC entry 451 (class 1259 OID 22180)
-- Name: page_defaultview; Type: TABLE; Schema: tool_visualizer_lily; Owner: postgres
--

CREATE TABLE tool_visualizer_lily.page_defaultview (
    id smallint NOT NULL,
    defaultview character varying(25) DEFAULT ''::character varying
);


ALTER TABLE tool_visualizer_lily.page_defaultview OWNER TO postgres;

--
-- TOC entry 6037 (class 0 OID 0)
-- Dependencies: 451
-- Name: TABLE page_defaultview; Type: COMMENT; Schema: tool_visualizer_lily; Owner: postgres
--

COMMENT ON TABLE tool_visualizer_lily.page_defaultview IS 'Support reference table for pages';


--
-- TOC entry 452 (class 1259 OID 22184)
-- Name: page_integration; Type: TABLE; Schema: tool_visualizer_lily; Owner: postgres
--

CREATE TABLE tool_visualizer_lily.page_integration (
    id smallint NOT NULL,
    integration character varying(25) DEFAULT ''::character varying
);


ALTER TABLE tool_visualizer_lily.page_integration OWNER TO postgres;

--
-- TOC entry 6038 (class 0 OID 0)
-- Dependencies: 452
-- Name: TABLE page_integration; Type: COMMENT; Schema: tool_visualizer_lily; Owner: postgres
--

COMMENT ON TABLE tool_visualizer_lily.page_integration IS 'Support reference table for pages';


--
-- TOC entry 453 (class 1259 OID 22188)
-- Name: pages; Type: TABLE; Schema: tool_visualizer_lily; Owner: postgres
--

CREATE TABLE tool_visualizer_lily.pages (
    pg_id integer NOT NULL,
    gr_id smallint,
    po_id smallint DEFAULT 0,
    name character varying(100) DEFAULT ''::character varying,
    description character varying(100) DEFAULT ''::character varying,
    backgroundimage character varying(250) DEFAULT NULL::character varying,
    defaultview smallint DEFAULT 0 NOT NULL,
    flag_visible boolean DEFAULT true,
    st_id_fk smallint
);


ALTER TABLE tool_visualizer_lily.pages OWNER TO postgres;

--
-- TOC entry 6039 (class 0 OID 0)
-- Dependencies: 453
-- Name: COLUMN pages.defaultview; Type: COMMENT; Schema: tool_visualizer_lily; Owner: postgres
--

COMMENT ON COLUMN tool_visualizer_lily.pages.defaultview IS 'Default view 0=standard, 1=map, 2=numeric';


--
-- TOC entry 454 (class 1259 OID 22197)
-- Name: pages_groups; Type: TABLE; Schema: tool_visualizer_lily; Owner: postgres
--

CREATE TABLE tool_visualizer_lily.pages_groups (
    gr_id integer NOT NULL,
    name character varying(25) DEFAULT ''::character varying,
    po_id smallint DEFAULT 0,
    flag_visible boolean DEFAULT true
);


ALTER TABLE tool_visualizer_lily.pages_groups OWNER TO postgres;

--
-- TOC entry 455 (class 1259 OID 22203)
-- Name: pages_groups_gr_id_seq; Type: SEQUENCE; Schema: tool_visualizer_lily; Owner: postgres
--

CREATE SEQUENCE tool_visualizer_lily.pages_groups_gr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_visualizer_lily.pages_groups_gr_id_seq OWNER TO postgres;

--
-- TOC entry 6040 (class 0 OID 0)
-- Dependencies: 455
-- Name: pages_groups_gr_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER SEQUENCE tool_visualizer_lily.pages_groups_gr_id_seq OWNED BY tool_visualizer_lily.pages_groups.gr_id;


--
-- TOC entry 456 (class 1259 OID 22205)
-- Name: pages_groups_users; Type: TABLE; Schema: tool_visualizer_lily; Owner: postgres
--

CREATE TABLE tool_visualizer_lily.pages_groups_users (
    us_id smallint NOT NULL,
    gr_id smallint NOT NULL
);


ALTER TABLE tool_visualizer_lily.pages_groups_users OWNER TO postgres;

--
-- TOC entry 457 (class 1259 OID 22208)
-- Name: pages_pg_id_seq; Type: SEQUENCE; Schema: tool_visualizer_lily; Owner: postgres
--

CREATE SEQUENCE tool_visualizer_lily.pages_pg_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_visualizer_lily.pages_pg_id_seq OWNER TO postgres;

--
-- TOC entry 6041 (class 0 OID 0)
-- Dependencies: 457
-- Name: pages_pg_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER SEQUENCE tool_visualizer_lily.pages_pg_id_seq OWNED BY tool_visualizer_lily.pages.pg_id;


--
-- TOC entry 458 (class 1259 OID 22210)
-- Name: pages_windows; Type: TABLE; Schema: tool_visualizer_lily; Owner: postgres
--

CREATE TABLE tool_visualizer_lily.pages_windows (
    wd_id integer NOT NULL,
    pg_id smallint,
    st_pr_id smallint,
    useview boolean DEFAULT false,
    view_id smallint,
    name character varying(250) NOT NULL,
    defaultview smallint DEFAULT 0,
    charttype smallint DEFAULT 0,
    stationname character varying(250) DEFAULT NULL::character varying,
    parametername character varying(250) DEFAULT NULL::character varying,
    decimals smallint DEFAULT 2,
    nodays smallint DEFAULT 2,
    inttime smallint DEFAULT 4,
    useformule boolean DEFAULT false,
    color integer DEFAULT 16711680,
    thick smallint DEFAULT 0,
    points boolean DEFAULT false,
    marks boolean DEFAULT false,
    marksdrawevery smallint DEFAULT 2,
    autoscale smallint DEFAULT 0,
    scalemin real DEFAULT 0,
    scalemax real DEFAULT 1,
    scaleminoffset real DEFAULT 5,
    scalemaxoffset real DEFAULT 5,
    linered real,
    lineorange real,
    linegreen real,
    alertmin real,
    alertmax real,
    chartfunction integer,
    showmaxvalues boolean DEFAULT false,
    showminvalues boolean DEFAULT false,
    showstddevvalues boolean DEFAULT false,
    showsgridband boolean DEFAULT false,
    fontsize smallint DEFAULT 0,
    fontbold boolean DEFAULT false,
    fontcolor integer DEFAULT 16711680,
    wtop integer DEFAULT 0,
    wleft integer DEFAULT 0,
    wwidth integer DEFAULT 0,
    wheight integer DEFAULT 0,
    wpretop integer DEFAULT 0,
    wpreleft integer DEFAULT 0,
    wprewidth integer DEFAULT 0,
    wpreheight integer DEFAULT 0,
    wnumtop integer DEFAULT 0,
    wnumleft integer DEFAULT 0,
    wnumwidth integer DEFAULT 0,
    wnumheight integer DEFAULT 0,
    po_id smallint DEFAULT 0,
    flag_visible boolean DEFAULT true
);


ALTER TABLE tool_visualizer_lily.pages_windows OWNER TO postgres;

--
-- TOC entry 459 (class 1259 OID 22256)
-- Name: pages_windows_wd_id_seq; Type: SEQUENCE; Schema: tool_visualizer_lily; Owner: postgres
--

CREATE SEQUENCE tool_visualizer_lily.pages_windows_wd_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_visualizer_lily.pages_windows_wd_id_seq OWNER TO postgres;

--
-- TOC entry 6042 (class 0 OID 0)
-- Dependencies: 459
-- Name: pages_windows_wd_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER SEQUENCE tool_visualizer_lily.pages_windows_wd_id_seq OWNED BY tool_visualizer_lily.pages_windows.wd_id;


--
-- TOC entry 460 (class 1259 OID 22263)
-- Name: stations_properties; Type: VIEW; Schema: tool_visualizer_lily; Owner: postgres
--

CREATE VIEW tool_visualizer_lily.stations_properties AS
 SELECT _stations.st_id,
    _stations.stationname,
    _stations.schema,
    _stations.tableid,
    _stations.po_id,
    station_typology.typology,
    stations_metadata.locality,
    stations_metadata.commune,
    stations_metadata.province,
    stations_metadata.region,
    stations_metadata.longitude,
    stations_metadata.latitude,
    stations_metadata.east,
    stations_metadata.north,
    stations_metadata.altitude,
    stations_metadata.note,
    _users_stations.us_id
   FROM (((public._stations
     JOIN public._users_stations USING (st_id))
     LEFT JOIN metadata.stations_metadata USING (st_id))
     LEFT JOIN metadata.station_typology ON ((stations_metadata.typology = station_typology.id)))
  ORDER BY _stations.po_id;


ALTER TABLE tool_visualizer_lily.stations_properties OWNER TO postgres;

--
-- TOC entry 461 (class 1259 OID 22268)
-- Name: users_settings; Type: TABLE; Schema: tool_visualizer_lily; Owner: postgres
--

CREATE TABLE tool_visualizer_lily.users_settings (
    us_id smallint NOT NULL,
    theme_01 smallint DEFAULT 0,
    theme_02 smallint DEFAULT 0,
    theme_03 smallint DEFAULT 0,
    theme_04 smallint DEFAULT 0,
    theme_05 smallint DEFAULT 0
);


ALTER TABLE tool_visualizer_lily.users_settings OWNER TO postgres;

--
-- TOC entry 6043 (class 0 OID 0)
-- Dependencies: 461
-- Name: TABLE users_settings; Type: COMMENT; Schema: tool_visualizer_lily; Owner: postgres
--

COMMENT ON TABLE tool_visualizer_lily.users_settings IS 'Hold the setting by user';


--
-- TOC entry 462 (class 1259 OID 22276)
-- Name: users_settings_colors; Type: TABLE; Schema: tool_visualizer_lily; Owner: postgres
--

CREATE TABLE tool_visualizer_lily.users_settings_colors (
    us_id smallint NOT NULL,
    color_01 integer NOT NULL,
    color_02 integer NOT NULL,
    color_03 integer NOT NULL,
    color_04 integer NOT NULL,
    color_05 integer NOT NULL,
    color_06 integer NOT NULL,
    color_07 integer NOT NULL,
    color_08 integer NOT NULL,
    color_09 integer NOT NULL,
    color_10 integer NOT NULL,
    color_11 integer NOT NULL,
    color_12 integer NOT NULL,
    color_13 integer NOT NULL,
    color_14 integer NOT NULL,
    color_15 integer NOT NULL,
    color_16 integer NOT NULL,
    color_17 integer NOT NULL,
    color_18 integer NOT NULL,
    color_19 integer NOT NULL,
    color_20 integer NOT NULL,
    color_21 integer NOT NULL,
    color_22 integer NOT NULL,
    color_23 integer NOT NULL,
    color_24 integer NOT NULL,
    color_25 integer NOT NULL,
    color_26 integer NOT NULL,
    color_27 integer NOT NULL,
    color_28 integer NOT NULL,
    color_29 integer NOT NULL,
    color_30 integer NOT NULL
);


ALTER TABLE tool_visualizer_lily.users_settings_colors OWNER TO postgres;

--
-- TOC entry 6044 (class 0 OID 0)
-- Dependencies: 462
-- Name: TABLE users_settings_colors; Type: COMMENT; Schema: tool_visualizer_lily; Owner: postgres
--

COMMENT ON TABLE tool_visualizer_lily.users_settings_colors IS 'Hold the series colors settings by user';


--
-- TOC entry 463 (class 1259 OID 22279)
-- Name: visualizer; Type: VIEW; Schema: tool_visualizer_lily; Owner: postgres
--

CREATE VIEW tool_visualizer_lily.visualizer AS
 SELECT u.username AS user_name,
    pw.wd_id,
    pg_id,
    pw.st_pr_id,
    pw.name AS window_name,
    pw.defaultview AS window_defaultview,
    pw.charttype,
    spm.st_id,
    pw.stationname,
    pw.parametername,
    pw.decimals,
    pw.nodays,
    pw.inttime,
    pw.useformule,
    pw.color,
    pw.thick,
    pw.points,
    pw.marks,
    pw.autoscale,
    pw.scalemin,
    pw.scalemax,
    pw.linered,
    pw.linegreen,
    pw.alertmin,
    pw.alertmax,
    pw.chartfunction,
    pw.showmaxvalues,
    pw.showminvalues,
    pw.wtop,
    pw.wleft,
    pw.wwidth,
    pw.wheight,
    pw.po_id,
    pw.showstddevvalues,
    pw.wpretop,
    pw.wpreleft,
    pw.wprewidth,
    pw.wpreheight,
    pw.useview,
    pw.wnumtop,
    pw.wnumleft,
    pw.wnumwidth,
    pw.wnumheight,
    pw.view_id,
    pw.scaleminoffset,
    pw.scalemaxoffset,
    pw.showsgridband,
    pw.fontsize,
    pw.fontbold,
    pw.fontcolor,
    pw.marksdrawevery,
    p.name AS page_name,
    p.description,
    p.backgroundimage,
    p.po_id AS page_po,
    p.defaultview AS page_defaultview,
    pg.name,
    pg.po_id AS group_po,
    gu.us_id,
    gr_id
   FROM (((((tool_visualizer_lily.pages_windows pw
     LEFT JOIN public._stations_parameters_master spm USING (st_pr_id))
     LEFT JOIN tool_visualizer_lily.pages p USING (pg_id))
     LEFT JOIN tool_visualizer_lily.pages_groups pg USING (gr_id))
     LEFT JOIN tool_visualizer_lily.pages_groups_users gu USING (gr_id))
     LEFT JOIN public._users u USING (us_id))
  ORDER BY gu.us_id, gr_id, pg_id, pw.wd_id;


ALTER TABLE tool_visualizer_lily.visualizer OWNER TO postgres;

--
-- TOC entry 464 (class 1259 OID 22731)
-- Name: analysis_types; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.analysis_types (
    type_id smallint NOT NULL,
    analysis text NOT NULL
);


ALTER TABLE tool_web_lily.analysis_types OWNER TO postgres;

--
-- TOC entry 6045 (class 0 OID 0)
-- Dependencies: 464
-- Name: TABLE analysis_types; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.analysis_types IS 'Lab analisys files type';


--
-- TOC entry 6046 (class 0 OID 0)
-- Dependencies: 464
-- Name: COLUMN analysis_types.type_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.analysis_types.type_id IS 'Analysis id';


--
-- TOC entry 6047 (class 0 OID 0)
-- Dependencies: 464
-- Name: COLUMN analysis_types.analysis; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.analysis_types.analysis IS 'Analysis name';


--
-- TOC entry 465 (class 1259 OID 22737)
-- Name: group_stations; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.group_stations (
    gs_id integer NOT NULL,
    gr_id integer NOT NULL,
    st_id integer NOT NULL
);


ALTER TABLE tool_web_lily.group_stations OWNER TO postgres;

--
-- TOC entry 6048 (class 0 OID 0)
-- Dependencies: 465
-- Name: TABLE group_stations; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.group_stations IS 'Table that holds info about relation between groups and stations';


--
-- TOC entry 6049 (class 0 OID 0)
-- Dependencies: 465
-- Name: COLUMN group_stations.gs_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.group_stations.gs_id IS 'Group stations relation id';


--
-- TOC entry 6050 (class 0 OID 0)
-- Dependencies: 465
-- Name: COLUMN group_stations.gr_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.group_stations.gr_id IS 'Group id';


--
-- TOC entry 6051 (class 0 OID 0)
-- Dependencies: 465
-- Name: COLUMN group_stations.st_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.group_stations.st_id IS 'Station id';


--
-- TOC entry 466 (class 1259 OID 22740)
-- Name: group_stations_gs_id_seq; Type: SEQUENCE; Schema: tool_web_lily; Owner: postgres
--

CREATE SEQUENCE tool_web_lily.group_stations_gs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_web_lily.group_stations_gs_id_seq OWNER TO postgres;

--
-- TOC entry 6052 (class 0 OID 0)
-- Dependencies: 466
-- Name: group_stations_gs_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_web_lily; Owner: postgres
--

ALTER SEQUENCE tool_web_lily.group_stations_gs_id_seq OWNED BY tool_web_lily.group_stations.gs_id;


--
-- TOC entry 467 (class 1259 OID 22742)
-- Name: groups; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.groups (
    gr_id smallint NOT NULL,
    group_name text NOT NULL
);


ALTER TABLE tool_web_lily.groups OWNER TO postgres;

--
-- TOC entry 6053 (class 0 OID 0)
-- Dependencies: 467
-- Name: TABLE groups; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.groups IS 'ARPA section group';


--
-- TOC entry 6054 (class 0 OID 0)
-- Dependencies: 467
-- Name: COLUMN groups.gr_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.groups.gr_id IS 'Univocal ID group';


--
-- TOC entry 6055 (class 0 OID 0)
-- Dependencies: 467
-- Name: COLUMN groups.group_name; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.groups.group_name IS 'Group name';


--
-- TOC entry 468 (class 1259 OID 22748)
-- Name: labanalysis_files; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.labanalysis_files (
    file_id integer NOT NULL,
    analysis_type_fk smallint NOT NULL,
    source_filename text NOT NULL,
    stored_filename text NOT NULL,
    processed boolean DEFAULT false,
    result boolean,
    upload_date timestamp without time zone DEFAULT now()
);


ALTER TABLE tool_web_lily.labanalysis_files OWNER TO postgres;

--
-- TOC entry 6056 (class 0 OID 0)
-- Dependencies: 468
-- Name: TABLE labanalysis_files; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.labanalysis_files IS 'Lab analisys files table';


--
-- TOC entry 6057 (class 0 OID 0)
-- Dependencies: 468
-- Name: COLUMN labanalysis_files.file_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.labanalysis_files.file_id IS 'File id';


--
-- TOC entry 6058 (class 0 OID 0)
-- Dependencies: 468
-- Name: COLUMN labanalysis_files.analysis_type_fk; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.labanalysis_files.analysis_type_fk IS 'Analisys type';


--
-- TOC entry 6059 (class 0 OID 0)
-- Dependencies: 468
-- Name: COLUMN labanalysis_files.source_filename; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.labanalysis_files.source_filename IS 'Master file name';


--
-- TOC entry 6060 (class 0 OID 0)
-- Dependencies: 468
-- Name: COLUMN labanalysis_files.stored_filename; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.labanalysis_files.stored_filename IS 'Archived file name';


--
-- TOC entry 6061 (class 0 OID 0)
-- Dependencies: 468
-- Name: COLUMN labanalysis_files.processed; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.labanalysis_files.processed IS 'File has been processed';


--
-- TOC entry 6062 (class 0 OID 0)
-- Dependencies: 468
-- Name: COLUMN labanalysis_files.result; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.labanalysis_files.result IS 'The process result';


--
-- TOC entry 6063 (class 0 OID 0)
-- Dependencies: 468
-- Name: COLUMN labanalysis_files.upload_date; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.labanalysis_files.upload_date IS 'Upload date file';


--
-- TOC entry 469 (class 1259 OID 22756)
-- Name: labanalysis_files_file_id_seq; Type: SEQUENCE; Schema: tool_web_lily; Owner: postgres
--

CREATE SEQUENCE tool_web_lily.labanalysis_files_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_web_lily.labanalysis_files_file_id_seq OWNER TO postgres;

--
-- TOC entry 6064 (class 0 OID 0)
-- Dependencies: 469
-- Name: labanalysis_files_file_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_web_lily; Owner: postgres
--

ALTER SEQUENCE tool_web_lily.labanalysis_files_file_id_seq OWNED BY tool_web_lily.labanalysis_files.file_id;


--
-- TOC entry 470 (class 1259 OID 22758)
-- Name: memo_participants; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.memo_participants (
    me_pa_id integer NOT NULL,
    me_id integer NOT NULL,
    pa_id integer NOT NULL
);


ALTER TABLE tool_web_lily.memo_participants OWNER TO postgres;

--
-- TOC entry 6065 (class 0 OID 0)
-- Dependencies: 470
-- Name: TABLE memo_participants; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.memo_participants IS 'memos participants table';


--
-- TOC entry 6066 (class 0 OID 0)
-- Dependencies: 470
-- Name: COLUMN memo_participants.me_pa_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.memo_participants.me_pa_id IS 'memos participants id';


--
-- TOC entry 6067 (class 0 OID 0)
-- Dependencies: 470
-- Name: COLUMN memo_participants.me_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.memo_participants.me_id IS 'memos id';


--
-- TOC entry 6068 (class 0 OID 0)
-- Dependencies: 470
-- Name: COLUMN memo_participants.pa_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.memo_participants.pa_id IS 'participants id';


--
-- TOC entry 471 (class 1259 OID 22761)
-- Name: memo_participants_me_pa_id_seq; Type: SEQUENCE; Schema: tool_web_lily; Owner: postgres
--

CREATE SEQUENCE tool_web_lily.memo_participants_me_pa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_web_lily.memo_participants_me_pa_id_seq OWNER TO postgres;

--
-- TOC entry 6069 (class 0 OID 0)
-- Dependencies: 471
-- Name: memo_participants_me_pa_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_web_lily; Owner: postgres
--

ALTER SEQUENCE tool_web_lily.memo_participants_me_pa_id_seq OWNED BY tool_web_lily.memo_participants.me_pa_id;


--
-- TOC entry 472 (class 1259 OID 22763)
-- Name: memos; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.memos (
    me_id integer NOT NULL,
    us_id integer NOT NULL,
    memo_place text NOT NULL,
    memo_date date NOT NULL,
    memo_start_time time without time zone NOT NULL,
    memo_end_time time without time zone NOT NULL,
    memo_title text NOT NULL,
    memo_body text NOT NULL,
    memo_insert_time timestamp without time zone DEFAULT now()
);


ALTER TABLE tool_web_lily.memos OWNER TO postgres;

--
-- TOC entry 6070 (class 0 OID 0)
-- Dependencies: 472
-- Name: TABLE memos; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.memos IS 'memos table';


--
-- TOC entry 6071 (class 0 OID 0)
-- Dependencies: 472
-- Name: COLUMN memos.me_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.memos.me_id IS 'memo id';


--
-- TOC entry 6072 (class 0 OID 0)
-- Dependencies: 472
-- Name: COLUMN memos.us_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.memos.us_id IS 'memo user';


--
-- TOC entry 6073 (class 0 OID 0)
-- Dependencies: 472
-- Name: COLUMN memos.memo_place; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.memos.memo_place IS 'memo place';


--
-- TOC entry 6074 (class 0 OID 0)
-- Dependencies: 472
-- Name: COLUMN memos.memo_date; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.memos.memo_date IS 'memo date';


--
-- TOC entry 6075 (class 0 OID 0)
-- Dependencies: 472
-- Name: COLUMN memos.memo_start_time; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.memos.memo_start_time IS 'memo start time';


--
-- TOC entry 6076 (class 0 OID 0)
-- Dependencies: 472
-- Name: COLUMN memos.memo_end_time; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.memos.memo_end_time IS 'memo end time';


--
-- TOC entry 6077 (class 0 OID 0)
-- Dependencies: 472
-- Name: COLUMN memos.memo_title; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.memos.memo_title IS 'memo title';


--
-- TOC entry 6078 (class 0 OID 0)
-- Dependencies: 472
-- Name: COLUMN memos.memo_body; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.memos.memo_body IS 'memo body';


--
-- TOC entry 6079 (class 0 OID 0)
-- Dependencies: 472
-- Name: COLUMN memos.memo_insert_time; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.memos.memo_insert_time IS 'memo insert time';


--
-- TOC entry 473 (class 1259 OID 22770)
-- Name: memos_me_id_seq; Type: SEQUENCE; Schema: tool_web_lily; Owner: postgres
--

CREATE SEQUENCE tool_web_lily.memos_me_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_web_lily.memos_me_id_seq OWNER TO postgres;

--
-- TOC entry 6080 (class 0 OID 0)
-- Dependencies: 473
-- Name: memos_me_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_web_lily; Owner: postgres
--

ALTER SEQUENCE tool_web_lily.memos_me_id_seq OWNED BY tool_web_lily.memos.me_id;


--
-- TOC entry 474 (class 1259 OID 22772)
-- Name: menu; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.menu (
    id smallint NOT NULL,
    menu_name text NOT NULL,
    menu_href text NOT NULL,
    menu_desc text NOT NULL,
    menu_css text,
    badge_css text,
    isdropdown boolean NOT NULL,
    isvisible boolean DEFAULT true NOT NULL,
    CONSTRAINT menu_menu_desc_check CHECK ((menu_desc <> ''::text)),
    CONSTRAINT menu_menu_name_check CHECK ((menu_name <> ''::text))
);


ALTER TABLE tool_web_lily.menu OWNER TO postgres;

--
-- TOC entry 6081 (class 0 OID 0)
-- Dependencies: 474
-- Name: TABLE menu; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.menu IS 'Web menu';


--
-- TOC entry 6082 (class 0 OID 0)
-- Dependencies: 474
-- Name: COLUMN menu.id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.menu.id IS 'Menu id';


--
-- TOC entry 6083 (class 0 OID 0)
-- Dependencies: 474
-- Name: COLUMN menu.menu_name; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.menu.menu_name IS 'Menu name';


--
-- TOC entry 6084 (class 0 OID 0)
-- Dependencies: 474
-- Name: COLUMN menu.menu_href; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.menu.menu_href IS 'Menu link';


--
-- TOC entry 6085 (class 0 OID 0)
-- Dependencies: 474
-- Name: COLUMN menu.menu_desc; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.menu.menu_desc IS 'Menu description';


--
-- TOC entry 6086 (class 0 OID 0)
-- Dependencies: 474
-- Name: COLUMN menu.menu_css; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.menu.menu_css IS 'Menu css - icon';


--
-- TOC entry 6087 (class 0 OID 0)
-- Dependencies: 474
-- Name: COLUMN menu.badge_css; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.menu.badge_css IS 'Badge css - icon';


--
-- TOC entry 475 (class 1259 OID 22781)
-- Name: participants; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.participants (
    pa_id integer NOT NULL,
    name text NOT NULL,
    surname text NOT NULL,
    CONSTRAINT participants_name_check CHECK ((name <> ''::text)),
    CONSTRAINT participants_name_check1 CHECK ((name <> ''::text))
);


ALTER TABLE tool_web_lily.participants OWNER TO postgres;

--
-- TOC entry 6088 (class 0 OID 0)
-- Dependencies: 475
-- Name: TABLE participants; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.participants IS 'participant table';


--
-- TOC entry 6089 (class 0 OID 0)
-- Dependencies: 475
-- Name: COLUMN participants.pa_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.participants.pa_id IS 'Univocal ID board participant';


--
-- TOC entry 6090 (class 0 OID 0)
-- Dependencies: 475
-- Name: COLUMN participants.name; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.participants.name IS 'participant name';


--
-- TOC entry 6091 (class 0 OID 0)
-- Dependencies: 475
-- Name: COLUMN participants.surname; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.participants.surname IS 'participant surname';


--
-- TOC entry 476 (class 1259 OID 22789)
-- Name: participants_pa_id_seq; Type: SEQUENCE; Schema: tool_web_lily; Owner: postgres
--

CREATE SEQUENCE tool_web_lily.participants_pa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_web_lily.participants_pa_id_seq OWNER TO postgres;

--
-- TOC entry 6092 (class 0 OID 0)
-- Dependencies: 476
-- Name: participants_pa_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_web_lily; Owner: postgres
--

ALTER SEQUENCE tool_web_lily.participants_pa_id_seq OWNED BY tool_web_lily.participants.pa_id;


--
-- TOC entry 477 (class 1259 OID 22791)
-- Name: surveys; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.surveys (
    su_id integer NOT NULL,
    us_id integer NOT NULL,
    survey_place text NOT NULL,
    survey_date timestamp without time zone NOT NULL,
    survey_start_time time without time zone NOT NULL,
    survey_end_time time without time zone NOT NULL,
    survey_desc text NOT NULL,
    user_insert_time timestamp without time zone DEFAULT now()
);


ALTER TABLE tool_web_lily.surveys OWNER TO postgres;

--
-- TOC entry 6093 (class 0 OID 0)
-- Dependencies: 477
-- Name: TABLE surveys; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.surveys IS 'Surveys table';


--
-- TOC entry 6094 (class 0 OID 0)
-- Dependencies: 477
-- Name: COLUMN surveys.su_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.surveys.su_id IS 'Survey id';


--
-- TOC entry 6095 (class 0 OID 0)
-- Dependencies: 477
-- Name: COLUMN surveys.us_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.surveys.us_id IS 'Survey user';


--
-- TOC entry 6096 (class 0 OID 0)
-- Dependencies: 477
-- Name: COLUMN surveys.survey_place; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.surveys.survey_place IS 'Survey place';


--
-- TOC entry 6097 (class 0 OID 0)
-- Dependencies: 477
-- Name: COLUMN surveys.survey_date; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.surveys.survey_date IS 'Survey date';


--
-- TOC entry 6098 (class 0 OID 0)
-- Dependencies: 477
-- Name: COLUMN surveys.survey_start_time; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.surveys.survey_start_time IS 'Survey start time';


--
-- TOC entry 6099 (class 0 OID 0)
-- Dependencies: 477
-- Name: COLUMN surveys.survey_end_time; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.surveys.survey_end_time IS 'Survey end time';


--
-- TOC entry 6100 (class 0 OID 0)
-- Dependencies: 477
-- Name: COLUMN surveys.survey_desc; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.surveys.survey_desc IS 'Survey description';


--
-- TOC entry 6101 (class 0 OID 0)
-- Dependencies: 477
-- Name: COLUMN surveys.user_insert_time; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.surveys.user_insert_time IS 'Survey insert time';


--
-- TOC entry 478 (class 1259 OID 22798)
-- Name: surveys_attachements; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.surveys_attachements (
    attachement_id integer NOT NULL,
    su_id integer NOT NULL,
    source_filename text NOT NULL,
    stored_filename text NOT NULL,
    is_image boolean DEFAULT false NOT NULL,
    upload_date timestamp without time zone DEFAULT now()
);


ALTER TABLE tool_web_lily.surveys_attachements OWNER TO postgres;

--
-- TOC entry 6102 (class 0 OID 0)
-- Dependencies: 478
-- Name: TABLE surveys_attachements; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.surveys_attachements IS 'Attachments table';


--
-- TOC entry 6103 (class 0 OID 0)
-- Dependencies: 478
-- Name: COLUMN surveys_attachements.attachement_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.surveys_attachements.attachement_id IS 'Attachment id';


--
-- TOC entry 6104 (class 0 OID 0)
-- Dependencies: 478
-- Name: COLUMN surveys_attachements.su_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.surveys_attachements.su_id IS 'Survey id';


--
-- TOC entry 6105 (class 0 OID 0)
-- Dependencies: 478
-- Name: COLUMN surveys_attachements.source_filename; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.surveys_attachements.source_filename IS 'Master attachment name';


--
-- TOC entry 6106 (class 0 OID 0)
-- Dependencies: 478
-- Name: COLUMN surveys_attachements.stored_filename; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.surveys_attachements.stored_filename IS 'Archived attachment name';


--
-- TOC entry 6107 (class 0 OID 0)
-- Dependencies: 478
-- Name: COLUMN surveys_attachements.is_image; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.surveys_attachements.is_image IS 'Valid image or not';


--
-- TOC entry 6108 (class 0 OID 0)
-- Dependencies: 478
-- Name: COLUMN surveys_attachements.upload_date; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.surveys_attachements.upload_date IS 'Upload date file';


--
-- TOC entry 479 (class 1259 OID 22806)
-- Name: surveys_attachements_attachement_id_seq; Type: SEQUENCE; Schema: tool_web_lily; Owner: postgres
--

CREATE SEQUENCE tool_web_lily.surveys_attachements_attachement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_web_lily.surveys_attachements_attachement_id_seq OWNER TO postgres;

--
-- TOC entry 6109 (class 0 OID 0)
-- Dependencies: 479
-- Name: surveys_attachements_attachement_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_web_lily; Owner: postgres
--

ALTER SEQUENCE tool_web_lily.surveys_attachements_attachement_id_seq OWNED BY tool_web_lily.surveys_attachements.attachement_id;


--
-- TOC entry 480 (class 1259 OID 22808)
-- Name: surveys_su_id_seq; Type: SEQUENCE; Schema: tool_web_lily; Owner: postgres
--

CREATE SEQUENCE tool_web_lily.surveys_su_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_web_lily.surveys_su_id_seq OWNER TO postgres;

--
-- TOC entry 481 (class 1259 OID 22810)
-- Name: task_types; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.task_types (
    ty_id integer NOT NULL,
    ty_desc text NOT NULL
);


ALTER TABLE tool_web_lily.task_types OWNER TO postgres;

--
-- TOC entry 6110 (class 0 OID 0)
-- Dependencies: 481
-- Name: TABLE task_types; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.task_types IS 'Task types table';


--
-- TOC entry 6111 (class 0 OID 0)
-- Dependencies: 481
-- Name: COLUMN task_types.ty_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.task_types.ty_id IS 'Type Id';


--
-- TOC entry 6112 (class 0 OID 0)
-- Dependencies: 481
-- Name: COLUMN task_types.ty_desc; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.task_types.ty_desc IS 'Type description';


--
-- TOC entry 482 (class 1259 OID 22816)
-- Name: tasks; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.tasks (
    ta_id integer NOT NULL,
    us_id integer NOT NULL,
    task_name text,
    task_done boolean,
    task_type integer NOT NULL,
    task_assignee tool_web_lily.enum_task_assignee NOT NULL,
    task_insert_time timestamp without time zone DEFAULT now(),
    us_id_close integer,
    task_close_time timestamp without time zone,
    task_stid smallint
);


ALTER TABLE tool_web_lily.tasks OWNER TO postgres;

--
-- TOC entry 6113 (class 0 OID 0)
-- Dependencies: 482
-- Name: TABLE tasks; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.tasks IS 'tasks table';


--
-- TOC entry 6114 (class 0 OID 0)
-- Dependencies: 482
-- Name: COLUMN tasks.ta_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tasks.ta_id IS 'Univocal task ID';


--
-- TOC entry 6115 (class 0 OID 0)
-- Dependencies: 482
-- Name: COLUMN tasks.us_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tasks.us_id IS 'Univocal user ID';


--
-- TOC entry 6116 (class 0 OID 0)
-- Dependencies: 482
-- Name: COLUMN tasks.task_name; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tasks.task_name IS 'Task name';


--
-- TOC entry 6117 (class 0 OID 0)
-- Dependencies: 482
-- Name: COLUMN tasks.task_done; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tasks.task_done IS 'Task done';


--
-- TOC entry 6118 (class 0 OID 0)
-- Dependencies: 482
-- Name: COLUMN tasks.task_type; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tasks.task_type IS 'Task type';


--
-- TOC entry 6119 (class 0 OID 0)
-- Dependencies: 482
-- Name: COLUMN tasks.task_assignee; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tasks.task_assignee IS 'Task assignee';


--
-- TOC entry 6120 (class 0 OID 0)
-- Dependencies: 482
-- Name: COLUMN tasks.task_insert_time; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tasks.task_insert_time IS 'Task insert time';


--
-- TOC entry 6121 (class 0 OID 0)
-- Dependencies: 482
-- Name: COLUMN tasks.us_id_close; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tasks.us_id_close IS 'Univocal user ID which has closed the task';


--
-- TOC entry 6122 (class 0 OID 0)
-- Dependencies: 482
-- Name: COLUMN tasks.task_close_time; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tasks.task_close_time IS 'Task closed time';


--
-- TOC entry 6123 (class 0 OID 0)
-- Dependencies: 482
-- Name: COLUMN tasks.task_stid; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tasks.task_stid IS 'Task station id';


--
-- TOC entry 483 (class 1259 OID 22823)
-- Name: tasks_ta_id_seq; Type: SEQUENCE; Schema: tool_web_lily; Owner: postgres
--

CREATE SEQUENCE tool_web_lily.tasks_ta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_web_lily.tasks_ta_id_seq OWNER TO postgres;

--
-- TOC entry 6124 (class 0 OID 0)
-- Dependencies: 483
-- Name: tasks_ta_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_web_lily; Owner: postgres
--

ALTER SEQUENCE tool_web_lily.tasks_ta_id_seq OWNED BY tool_web_lily.tasks.ta_id;


--
-- TOC entry 484 (class 1259 OID 22825)
-- Name: ticket_categories; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.ticket_categories (
    tc_id integer NOT NULL,
    tc_desc text NOT NULL
);


ALTER TABLE tool_web_lily.ticket_categories OWNER TO postgres;

--
-- TOC entry 6125 (class 0 OID 0)
-- Dependencies: 484
-- Name: TABLE ticket_categories; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.ticket_categories IS 'ticket category table';


--
-- TOC entry 6126 (class 0 OID 0)
-- Dependencies: 484
-- Name: COLUMN ticket_categories.tc_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.ticket_categories.tc_id IS 'category Id';


--
-- TOC entry 6127 (class 0 OID 0)
-- Dependencies: 484
-- Name: COLUMN ticket_categories.tc_desc; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.ticket_categories.tc_desc IS 'category description';


--
-- TOC entry 485 (class 1259 OID 22831)
-- Name: ticket_types; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.ticket_types (
    tt_id integer NOT NULL,
    tt_desc text NOT NULL
);


ALTER TABLE tool_web_lily.ticket_types OWNER TO postgres;

--
-- TOC entry 6128 (class 0 OID 0)
-- Dependencies: 485
-- Name: TABLE ticket_types; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.ticket_types IS 'ticket type table';


--
-- TOC entry 6129 (class 0 OID 0)
-- Dependencies: 485
-- Name: COLUMN ticket_types.tt_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.ticket_types.tt_id IS 'type Id';


--
-- TOC entry 6130 (class 0 OID 0)
-- Dependencies: 485
-- Name: COLUMN ticket_types.tt_desc; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.ticket_types.tt_desc IS 'type description';


--
-- TOC entry 486 (class 1259 OID 22837)
-- Name: tickets; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.tickets (
    tk_id integer NOT NULL,
    tk_opening_date timestamp without time zone DEFAULT now(),
    tk_expiry_date timestamp without time zone NOT NULL,
    tk_closure_date timestamp without time zone,
    tk_opening_operator_fk integer NOT NULL,
    tk_recipient_group_fk integer NOT NULL,
    tk_closure_operator_fk integer,
    st_id_fk integer NOT NULL,
    in_id_fk integer,
    cy_id_fk integer,
    eq_id_fk integer,
    tt_id_fk integer NOT NULL,
    tc_id_fk integer NOT NULL,
    tk_freq_fk integer,
    tk_title text NOT NULL,
    tk_opening_note text NOT NULL,
    tk_closure_note text,
    tk_parent_id_fk integer,
    tk_incharge_date timestamp without time zone,
    CONSTRAINT tool_web_lily_tickets_check CHECK ((((
CASE
    WHEN (in_id_fk IS NULL) THEN 0
    ELSE 1
END +
CASE
    WHEN (cy_id_fk IS NULL) THEN 0
    ELSE 1
END) +
CASE
    WHEN (eq_id_fk IS NULL) THEN 0
    ELSE 1
END) <= 1))
);


ALTER TABLE tool_web_lily.tickets OWNER TO postgres;

--
-- TOC entry 6131 (class 0 OID 0)
-- Dependencies: 486
-- Name: TABLE tickets; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.tickets IS 'Tickets table';


--
-- TOC entry 6132 (class 0 OID 0)
-- Dependencies: 486
-- Name: COLUMN tickets.tk_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tickets.tk_id IS 'Ticket id';


--
-- TOC entry 6133 (class 0 OID 0)
-- Dependencies: 486
-- Name: COLUMN tickets.tk_opening_date; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tickets.tk_opening_date IS 'Ticket opening date';


--
-- TOC entry 6134 (class 0 OID 0)
-- Dependencies: 486
-- Name: COLUMN tickets.tk_expiry_date; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tickets.tk_expiry_date IS 'Ticket expiration date';


--
-- TOC entry 6135 (class 0 OID 0)
-- Dependencies: 486
-- Name: COLUMN tickets.tk_closure_date; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tickets.tk_closure_date IS 'Ticket closure date';


--
-- TOC entry 6136 (class 0 OID 0)
-- Dependencies: 486
-- Name: COLUMN tickets.tk_opening_operator_fk; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tickets.tk_opening_operator_fk IS 'Ticket opening operator FK';


--
-- TOC entry 6137 (class 0 OID 0)
-- Dependencies: 486
-- Name: COLUMN tickets.tk_recipient_group_fk; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tickets.tk_recipient_group_fk IS 'Ticket recipient group FK';


--
-- TOC entry 6138 (class 0 OID 0)
-- Dependencies: 486
-- Name: COLUMN tickets.tk_closure_operator_fk; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tickets.tk_closure_operator_fk IS 'Ticket closure operator FK';


--
-- TOC entry 6139 (class 0 OID 0)
-- Dependencies: 486
-- Name: COLUMN tickets.st_id_fk; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tickets.st_id_fk IS 'Station id FK';


--
-- TOC entry 6140 (class 0 OID 0)
-- Dependencies: 486
-- Name: COLUMN tickets.in_id_fk; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tickets.in_id_fk IS 'Instrument id FK';


--
-- TOC entry 6141 (class 0 OID 0)
-- Dependencies: 486
-- Name: COLUMN tickets.eq_id_fk; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tickets.eq_id_fk IS 'Equipment id FK';


--
-- TOC entry 6142 (class 0 OID 0)
-- Dependencies: 486
-- Name: COLUMN tickets.tt_id_fk; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tickets.tt_id_fk IS 'Ticket type id FK';


--
-- TOC entry 6143 (class 0 OID 0)
-- Dependencies: 486
-- Name: COLUMN tickets.tc_id_fk; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tickets.tc_id_fk IS 'Ticket category id FK';


--
-- TOC entry 6144 (class 0 OID 0)
-- Dependencies: 486
-- Name: COLUMN tickets.tk_freq_fk; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tickets.tk_freq_fk IS 'Frequency id FK';


--
-- TOC entry 6145 (class 0 OID 0)
-- Dependencies: 486
-- Name: COLUMN tickets.tk_title; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tickets.tk_title IS 'Ticket title';


--
-- TOC entry 6146 (class 0 OID 0)
-- Dependencies: 486
-- Name: COLUMN tickets.tk_opening_note; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tickets.tk_opening_note IS 'Ticket opening note';


--
-- TOC entry 6147 (class 0 OID 0)
-- Dependencies: 486
-- Name: COLUMN tickets.tk_closure_note; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tickets.tk_closure_note IS 'Ticket closure note';


--
-- TOC entry 6148 (class 0 OID 0)
-- Dependencies: 486
-- Name: COLUMN tickets.tk_parent_id_fk; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tickets.tk_parent_id_fk IS 'Ticket parent id FK';


--
-- TOC entry 6149 (class 0 OID 0)
-- Dependencies: 486
-- Name: COLUMN tickets.tk_incharge_date; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.tickets.tk_incharge_date IS 'Ticket taken in charge date';


--
-- TOC entry 487 (class 1259 OID 22845)
-- Name: tickets_tk_id_seq; Type: SEQUENCE; Schema: tool_web_lily; Owner: postgres
--

CREATE SEQUENCE tool_web_lily.tickets_tk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_web_lily.tickets_tk_id_seq OWNER TO postgres;

--
-- TOC entry 6150 (class 0 OID 0)
-- Dependencies: 487
-- Name: tickets_tk_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_web_lily; Owner: postgres
--

ALTER SEQUENCE tool_web_lily.tickets_tk_id_seq OWNED BY tool_web_lily.tickets.tk_id;


--
-- TOC entry 488 (class 1259 OID 22847)
-- Name: user_menu; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.user_menu (
    id integer NOT NULL,
    us_id smallint NOT NULL,
    menu_id smallint NOT NULL,
    menu_level smallint NOT NULL,
    menu_order smallint NOT NULL,
    menu_published boolean DEFAULT true NOT NULL,
    user_grants public.hstore
);


ALTER TABLE tool_web_lily.user_menu OWNER TO postgres;

--
-- TOC entry 6151 (class 0 OID 0)
-- Dependencies: 488
-- Name: TABLE user_menu; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.user_menu IS 'Lookup table';


--
-- TOC entry 6152 (class 0 OID 0)
-- Dependencies: 488
-- Name: COLUMN user_menu.id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.user_menu.id IS 'Progressive id';


--
-- TOC entry 6153 (class 0 OID 0)
-- Dependencies: 488
-- Name: COLUMN user_menu.us_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.user_menu.us_id IS 'User id';


--
-- TOC entry 6154 (class 0 OID 0)
-- Dependencies: 488
-- Name: COLUMN user_menu.menu_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.user_menu.menu_id IS 'Menu id';


--
-- TOC entry 6155 (class 0 OID 0)
-- Dependencies: 488
-- Name: COLUMN user_menu.menu_level; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.user_menu.menu_level IS 'Menu level';


--
-- TOC entry 6156 (class 0 OID 0)
-- Dependencies: 488
-- Name: COLUMN user_menu.menu_order; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.user_menu.menu_order IS 'Menu order';


--
-- TOC entry 489 (class 1259 OID 22854)
-- Name: user_menu_id_seq; Type: SEQUENCE; Schema: tool_web_lily; Owner: postgres
--

CREATE SEQUENCE tool_web_lily.user_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_web_lily.user_menu_id_seq OWNER TO postgres;

--
-- TOC entry 6157 (class 0 OID 0)
-- Dependencies: 489
-- Name: user_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_web_lily; Owner: postgres
--

ALTER SEQUENCE tool_web_lily.user_menu_id_seq OWNED BY tool_web_lily.user_menu.id;


--
-- TOC entry 376 (class 1259 OID 20311)
-- Name: users; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.users (
    us_id integer NOT NULL,
    user_name text NOT NULL,
    user_surname text NOT NULL,
    user_password text NOT NULL,
    user_telephone text,
    user_email text,
    user_avatar text,
    user_active boolean DEFAULT true,
    user_main_id integer,
    user_insert_time timestamp without time zone DEFAULT now(),
    user_last_online timestamp without time zone,
    CONSTRAINT users_user_name_check CHECK ((user_name <> ''::text)),
    CONSTRAINT users_user_password_check CHECK ((user_password <> ''::text)),
    CONSTRAINT users_user_surname_check CHECK ((user_surname <> ''::text))
);


ALTER TABLE tool_web_lily.users OWNER TO postgres;

--
-- TOC entry 6158 (class 0 OID 0)
-- Dependencies: 376
-- Name: TABLE users; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.users IS 'Users table';


--
-- TOC entry 6159 (class 0 OID 0)
-- Dependencies: 376
-- Name: COLUMN users.us_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.users.us_id IS 'Univocal User Id';


--
-- TOC entry 6160 (class 0 OID 0)
-- Dependencies: 376
-- Name: COLUMN users.user_name; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.users.user_name IS 'User name';


--
-- TOC entry 6161 (class 0 OID 0)
-- Dependencies: 376
-- Name: COLUMN users.user_surname; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.users.user_surname IS 'User surname';


--
-- TOC entry 6162 (class 0 OID 0)
-- Dependencies: 376
-- Name: COLUMN users.user_telephone; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.users.user_telephone IS 'User phone number';


--
-- TOC entry 6163 (class 0 OID 0)
-- Dependencies: 376
-- Name: COLUMN users.user_email; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.users.user_email IS 'User e-mail';


--
-- TOC entry 6164 (class 0 OID 0)
-- Dependencies: 376
-- Name: COLUMN users.user_avatar; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.users.user_avatar IS 'User avatar image name';


--
-- TOC entry 6165 (class 0 OID 0)
-- Dependencies: 376
-- Name: COLUMN users.user_active; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.users.user_active IS 'User active status';


--
-- TOC entry 6166 (class 0 OID 0)
-- Dependencies: 376
-- Name: COLUMN users.user_main_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.users.user_main_id IS 'Main table [_users] UserId';


--
-- TOC entry 6167 (class 0 OID 0)
-- Dependencies: 376
-- Name: COLUMN users.user_insert_time; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.users.user_insert_time IS 'User inserted time';


--
-- TOC entry 6168 (class 0 OID 0)
-- Dependencies: 376
-- Name: COLUMN users.user_last_online; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.users.user_last_online IS 'User last online time';


--
-- TOC entry 490 (class 1259 OID 22856)
-- Name: users_groups; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.users_groups (
    us_gr_id integer NOT NULL,
    us_id integer NOT NULL,
    gr_id integer NOT NULL
);


ALTER TABLE tool_web_lily.users_groups OWNER TO postgres;

--
-- TOC entry 6169 (class 0 OID 0)
-- Dependencies: 490
-- Name: TABLE users_groups; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.users_groups IS 'Users and groups table';


--
-- TOC entry 6170 (class 0 OID 0)
-- Dependencies: 490
-- Name: COLUMN users_groups.us_gr_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.users_groups.us_gr_id IS 'Univocal ID Users-groups';


--
-- TOC entry 6171 (class 0 OID 0)
-- Dependencies: 490
-- Name: COLUMN users_groups.us_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.users_groups.us_id IS 'Univocal ID User';


--
-- TOC entry 6172 (class 0 OID 0)
-- Dependencies: 490
-- Name: COLUMN users_groups.gr_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.users_groups.gr_id IS 'Univocal ID group';


--
-- TOC entry 491 (class 1259 OID 22859)
-- Name: users_groups_us_gr_id_seq; Type: SEQUENCE; Schema: tool_web_lily; Owner: postgres
--

CREATE SEQUENCE tool_web_lily.users_groups_us_gr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_web_lily.users_groups_us_gr_id_seq OWNER TO postgres;

--
-- TOC entry 6173 (class 0 OID 0)
-- Dependencies: 491
-- Name: users_groups_us_gr_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_web_lily; Owner: postgres
--

ALTER SEQUENCE tool_web_lily.users_groups_us_gr_id_seq OWNED BY tool_web_lily.users_groups.us_gr_id;


--
-- TOC entry 492 (class 1259 OID 22861)
-- Name: users_logs; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.users_logs (
    id integer NOT NULL,
    log_info public.hstore NOT NULL,
    log_date timestamp without time zone DEFAULT now()
);


ALTER TABLE tool_web_lily.users_logs OWNER TO postgres;

--
-- TOC entry 6174 (class 0 OID 0)
-- Dependencies: 492
-- Name: TABLE users_logs; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.users_logs IS 'Users authentication logs';


--
-- TOC entry 6175 (class 0 OID 0)
-- Dependencies: 492
-- Name: COLUMN users_logs.log_info; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.users_logs.log_info IS 'Login/Logout info';


--
-- TOC entry 493 (class 1259 OID 22868)
-- Name: users_logs_id_seq; Type: SEQUENCE; Schema: tool_web_lily; Owner: postgres
--

CREATE SEQUENCE tool_web_lily.users_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_web_lily.users_logs_id_seq OWNER TO postgres;

--
-- TOC entry 6176 (class 0 OID 0)
-- Dependencies: 493
-- Name: users_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_web_lily; Owner: postgres
--

ALTER SEQUENCE tool_web_lily.users_logs_id_seq OWNED BY tool_web_lily.users_logs.id;


--
-- TOC entry 494 (class 1259 OID 22870)
-- Name: users_settings; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.users_settings (
    us_id integer NOT NULL,
    homepage public.hstore
);


ALTER TABLE tool_web_lily.users_settings OWNER TO postgres;

--
-- TOC entry 6177 (class 0 OID 0)
-- Dependencies: 494
-- Name: TABLE users_settings; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.users_settings IS 'Users settings table';


--
-- TOC entry 6178 (class 0 OID 0)
-- Dependencies: 494
-- Name: COLUMN users_settings.us_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.users_settings.us_id IS 'Univocal User Id';


--
-- TOC entry 495 (class 1259 OID 22876)
-- Name: users_us_id_seq; Type: SEQUENCE; Schema: tool_web_lily; Owner: postgres
--

CREATE SEQUENCE tool_web_lily.users_us_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_web_lily.users_us_id_seq OWNER TO postgres;

--
-- TOC entry 6179 (class 0 OID 0)
-- Dependencies: 495
-- Name: users_us_id_seq; Type: SEQUENCE OWNED BY; Schema: tool_web_lily; Owner: postgres
--

ALTER SEQUENCE tool_web_lily.users_us_id_seq OWNED BY tool_web_lily.users.us_id;


--
-- TOC entry 496 (class 1259 OID 22878)
-- Name: val_codes; Type: TABLE; Schema: tool_web_lily; Owner: postgres
--

CREATE TABLE tool_web_lily.val_codes (
    val_code_id smallint NOT NULL,
    val_code_desc text
);


ALTER TABLE tool_web_lily.val_codes OWNER TO postgres;

--
-- TOC entry 6180 (class 0 OID 0)
-- Dependencies: 496
-- Name: TABLE val_codes; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON TABLE tool_web_lily.val_codes IS 'Validation codes table';


--
-- TOC entry 6181 (class 0 OID 0)
-- Dependencies: 496
-- Name: COLUMN val_codes.val_code_id; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.val_codes.val_code_id IS 'Validation code id';


--
-- TOC entry 6182 (class 0 OID 0)
-- Dependencies: 496
-- Name: COLUMN val_codes.val_code_desc; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON COLUMN tool_web_lily.val_codes.val_code_desc IS 'Validation code description';


--
-- TOC entry 497 (class 1259 OID 22889)
-- Name: view_cylinders; Type: VIEW; Schema: tool_web_lily; Owner: postgres
--

CREATE VIEW tool_web_lily.view_cylinders AS
 SELECT c.cy_id,
    c.arpa_id,
    c.is_zero,
    c.in_ca_id,
    c.date_built,
    c.date_expiry,
    (c.date_expiry - ('now'::text)::date) AS time_left,
    c.description,
    c.ch1_value,
    c.ch2_value,
    c.ch3_value,
    c.exhausted,
    c.returned,
        CASE
            WHEN (c.exhausted IS TRUE) THEN 'Sì'::text
            ELSE 'No'::text
        END AS exhausted_format,
        CASE
            WHEN (c.returned IS TRUE) THEN 'Sì'::text
            ELSE 'No'::text
        END AS returned_format,
    ic.instrument_category AS category
   FROM (tool_netcom.cylinders c
     LEFT JOIN tool_netcom.instrument_categories ic USING (in_ca_id))
  ORDER BY (c.date_expiry - ('now'::text)::date) DESC;


ALTER TABLE tool_web_lily.view_cylinders OWNER TO postgres;

--
-- TOC entry 6183 (class 0 OID 0)
-- Dependencies: 497
-- Name: VIEW view_cylinders; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON VIEW tool_web_lily.view_cylinders IS 'cylinders information view';


--
-- TOC entry 498 (class 1259 OID 22894)
-- Name: view_data_calibrations_details; Type: VIEW; Schema: tool_web_lily; Owner: postgres
--

CREATE VIEW tool_web_lily.view_data_calibrations_details AS
 SELECT c.id AS ca_id,
    c.fulldate,
    c.st_id,
    s.stationname AS station_name,
    c.us_id,
    u.us_id AS user_id_lily,
    ((u.user_name || ' '::text) || u.user_surname) AS user_fullname,
    COALESCE(u.user_avatar, 'default.png'::text) AS user_avatar,
    c.arpa_id AS instrument_arpa_id,
    i1.name AS instrument_name,
    i1.serial_number AS instrument_serial_number,
    si1.fl_active AS instrument_active,
    it1.brand AS instrument_brand,
    it1.model AS instrument_model,
    it1.constructor AS instrument_constructor,
    ic1.instrument_category,
    i1.in_ty_id AS instrument_in_ty_id,
    it1.in_ca_id AS instrument_in_ca_id,
    c.zero_found,
    c.zero_set,
    c.zero_found2,
    c.zero_set2,
    c.zero_found3,
    c.zero_set3,
    c.zero_changed,
    c.zero_me_id,
    cm1.method_desc AS zero_method_description,
    c.span_found,
    c.span_set,
    c.span_found2,
    c.span_set2,
    c.span_found3,
    c.span_set3,
    c.span_found4,
    c.span_set4,
    c.span_found5,
    c.span_set5,
    c.span_found6,
    c.span_set6,
    c.span_found7,
    c.span_set7,
    c.span_found8,
    c.span_set8,
    c.span_found9,
    c.span_set9,
    c.span_changed,
    c.span_me_id,
    cm2.method_desc AS span_method_description,
    c.flux,
    c.flux2,
    c.flux3,
    c.temperature,
    c.presssure,
    c.flux_changed,
    c.note,
    c.re_id,
    r.reason_desc AS reason_description,
    c.zero_cyl_arpa_id AS tank_zero_cyl_arpa_id,
    cyz.is_zero AS tank_zero_is_zero,
    cyz.date_expiry AS tank_zero_date_expiry,
    cyz.description AS tank_zero_description,
    cyz.ch1_value AS tank_zero_ch1,
    cyz.ch2_value AS tank_zero_ch2,
    cyz.ch3_value AS tank_zero_ch3,
    c.span_cyl_arpa_id AS tank_span_cyl_arpa_id,
    cys.is_zero AS tank_span_is_zero,
    cys.date_expiry AS tank_span_date_expiry,
    cys.description AS tank_span_description,
    cys.ch1_value AS tank_span_ch1,
    cys.ch2_value AS tank_span_ch2,
    cys.ch3_value AS tank_span_ch3,
    c.cal_arpa_id AS calibrator_arpa_id,
    i2.name AS calibrator_name,
    si2.fl_active AS calibrator_active,
    it2.brand AS calibrator_brand,
    it2.model AS calibrator_model,
    it2.constructor AS calibrator_constructor,
    ic2.instrument_category AS calibrator_category,
    i2.in_ty_id AS calibrator_in_ty_id,
    it2.in_ca_id AS calibrator_in_ca_id
   FROM (((((((((((((((tool_netcom.data_calibrations c
     LEFT JOIN public._stations s ON ((s.st_id = c.st_id)))
     LEFT JOIN tool_web_lily.users u ON ((c.us_id = u.user_main_id)))
     LEFT JOIN tool_netcom.instruments i1 ON ((c.arpa_id = i1.arpa_id)))
     LEFT JOIN tool_netcom.instruments_types it1 ON ((i1.in_ty_id = it1.in_ty_id)))
     LEFT JOIN tool_netcom.instrument_categories ic1 ON ((it1.in_ca_id = ic1.in_ca_id)))
     LEFT JOIN tool_netcom.stations_instruments si1 ON ((c.arpa_id = ( SELECT stations_instruments.arpa_id
           FROM tool_netcom.stations_instruments
          WHERE (si1.arpa_id = c.arpa_id)
         LIMIT 1))))
     LEFT JOIN tool_netcom.instruments i2 ON ((c.cal_arpa_id = i2.arpa_id)))
     LEFT JOIN tool_netcom.instruments_types it2 ON ((i2.in_ty_id = it2.in_ty_id)))
     LEFT JOIN tool_netcom.instrument_categories ic2 ON ((it2.in_ca_id = ic2.in_ca_id)))
     LEFT JOIN tool_netcom.stations_instruments si2 ON ((c.arpa_id = ( SELECT stations_instruments.arpa_id
           FROM tool_netcom.stations_instruments
          WHERE (si2.arpa_id = c.arpa_id)
         LIMIT 1))))
     LEFT JOIN tool_netcom.calibration_reasons r ON ((c.re_id = r.re_id)))
     LEFT JOIN tool_netcom.calibration_methods cm1 ON ((c.zero_me_id = cm1.me_id)))
     LEFT JOIN tool_netcom.calibration_methods cm2 ON ((c.span_me_id = cm2.me_id)))
     LEFT JOIN tool_netcom.cylinders cyz ON ((c.zero_cyl_arpa_id = cyz.arpa_id)))
     LEFT JOIN tool_netcom.cylinders cys ON ((c.span_cyl_arpa_id = cys.arpa_id)))
  ORDER BY c.fulldate DESC, c.st_id;


ALTER TABLE tool_web_lily.view_data_calibrations_details OWNER TO postgres;

--
-- TOC entry 6184 (class 0 OID 0)
-- Dependencies: 498
-- Name: VIEW view_data_calibrations_details; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON VIEW tool_web_lily.view_data_calibrations_details IS 'calibrations reports details view';


--
-- TOC entry 499 (class 1259 OID 22899)
-- Name: view_data_calibrations_master; Type: VIEW; Schema: tool_web_lily; Owner: postgres
--

CREATE VIEW tool_web_lily.view_data_calibrations_master AS
 SELECT c.id AS ca_id,
    c.fulldate,
    c.st_id,
    s.stationname AS station_name,
    g.gr_id,
    u.us_id,
    ((u.user_name || ' '::text) || u.user_surname) AS user_fullname,
    COALESCE(u.user_avatar, 'default.png'::text) AS user_avatar,
    i1.in_id AS instrument_in_id,
    ic.in_ca_id AS instrument_ca_id,
    i1.name AS instrument,
    array_to_string(ARRAY[c.zero_found, c.zero_found2, c.zero_found3], ','::text) AS zero_info,
    c.zero_changed,
    array_to_string(ARRAY[c.span_found, c.span_found2, c.span_found3], ','::text) AS span_info,
    c.span_changed,
    c.note,
    cyz.description AS tank_zero,
    cys.description AS tank_span,
    i2.in_id AS calibrator_in_id,
    i2.name AS calibrator
   FROM (((((((((((((tool_netcom.data_calibrations c
     LEFT JOIN public._stations s ON ((s.st_id = c.st_id)))
     LEFT JOIN tool_web_lily.users u ON ((c.us_id = u.user_main_id)))
     LEFT JOIN tool_web_lily.users_groups ug ON ((u.us_id = ug.us_id)))
     LEFT JOIN tool_web_lily.groups g ON ((g.gr_id = ug.gr_id)))
     LEFT JOIN tool_netcom.instruments i1 ON ((c.arpa_id = i1.arpa_id)))
     LEFT JOIN tool_netcom.instruments i2 ON ((c.cal_arpa_id = i2.arpa_id)))
     LEFT JOIN tool_netcom.calibration_reasons r ON ((c.re_id = r.re_id)))
     LEFT JOIN tool_netcom.calibration_methods cm1 ON ((c.zero_me_id = cm1.me_id)))
     LEFT JOIN tool_netcom.calibration_methods cm2 ON ((c.span_me_id = cm2.me_id)))
     LEFT JOIN tool_netcom.cylinders cyz ON ((c.zero_cyl_arpa_id = cyz.arpa_id)))
     LEFT JOIN tool_netcom.cylinders cys ON ((c.span_cyl_arpa_id = cys.arpa_id)))
     LEFT JOIN tool_netcom.instruments_types it ON ((i1.in_ty_id = it.in_ty_id)))
     LEFT JOIN tool_netcom.instrument_categories ic ON ((it.in_ca_id = ic.in_ca_id)))
  ORDER BY c.fulldate DESC, c.st_id;


ALTER TABLE tool_web_lily.view_data_calibrations_master OWNER TO postgres;

--
-- TOC entry 6185 (class 0 OID 0)
-- Dependencies: 499
-- Name: VIEW view_data_calibrations_master; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON VIEW tool_web_lily.view_data_calibrations_master IS 'calibrations reports master view';


--
-- TOC entry 500 (class 1259 OID 22904)
-- Name: view_data_maintenances; Type: VIEW; Schema: tool_web_lily; Owner: postgres
--

CREATE VIEW tool_web_lily.view_data_maintenances AS
 SELECT m.ma_id,
    m.st_id,
    m.fulldate,
    u.username,
    s.stationname,
    m.note
   FROM ((tool_netcom.data_maintenances m
     LEFT JOIN public._users u USING (us_id))
     LEFT JOIN public._stations s ON ((s.st_id = m.st_id)))
  ORDER BY m.ma_id;


ALTER TABLE tool_web_lily.view_data_maintenances OWNER TO postgres;

--
-- TOC entry 6186 (class 0 OID 0)
-- Dependencies: 500
-- Name: VIEW view_data_maintenances; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON VIEW tool_web_lily.view_data_maintenances IS 'maintenances reports view';


--
-- TOC entry 501 (class 1259 OID 22919)
-- Name: view_filtered_groups; Type: VIEW; Schema: tool_web_lily; Owner: postgres
--

CREATE VIEW tool_web_lily.view_filtered_groups AS
 SELECT g.gr_id AS group_id,
        CASE
            WHEN (g.group_name = 'Sezione Aria'::text) THEN 'Arpa'::text
            ELSE g.group_name
        END AS group_name
   FROM tool_web_lily.groups g
  WHERE (g.gr_id = ANY (ARRAY[200, 300, 201]));


ALTER TABLE tool_web_lily.view_filtered_groups OWNER TO postgres;

--
-- TOC entry 502 (class 1259 OID 22928)
-- Name: view_instruments_metadata; Type: VIEW; Schema: tool_web_lily; Owner: postgres
--

CREATE VIEW tool_web_lily.view_instruments_metadata AS
 SELECT i.in_id,
    i.arpa_id,
    i.in_ty_id,
    ic.in_ca_id,
    i.name AS strumento,
    i.serial_number AS numero_serie,
    i.date_delivery AS data_consegna,
    it.brand AS marca,
    it.model AS modello,
    it.constructor AS costruttore,
    ic.instrument_category AS tipo
   FROM ((tool_netcom.instruments i
     LEFT JOIN tool_netcom.instruments_types it ON ((it.in_ty_id = i.in_ty_id)))
     LEFT JOIN tool_netcom.instrument_categories ic ON ((ic.in_ca_id = it.in_ca_id)))
  ORDER BY i.arpa_id;


ALTER TABLE tool_web_lily.view_instruments_metadata OWNER TO postgres;

--
-- TOC entry 6187 (class 0 OID 0)
-- Dependencies: 502
-- Name: VIEW view_instruments_metadata; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON VIEW tool_web_lily.view_instruments_metadata IS 'Get instruments metadata used by mobile application';


--
-- TOC entry 503 (class 1259 OID 22943)
-- Name: view_main_stations; Type: VIEW; Schema: tool_web_lily; Owner: postgres
--

CREATE VIEW tool_web_lily.view_main_stations AS
 SELECT s.st_id,
    s.stationname,
    s.schema,
    s.tableid,
    (((s.schema)::text || '.'::text) || (s.tableid)::text) AS tablename,
    s.station_roaming_type,
    st.roaming_type,
    s.po_id,
    s.active,
    t.pos
   FROM ((public._stations s
     LEFT JOIN public._station_roaming_type st ON ((st.id = s.station_roaming_type)))
     LEFT JOIN ( VALUES (4000,1), (4160,2), (4120,3), (4140,4), (4020,5), (4050,6), (4070,7), (4080,8), (4180,9), (4110,10), (4100,11), (4510,12), (4040,13), (4570,14), (4580,15), (4590,16), (4620,17), (4150,18), (4130,21), (4030,22), (4090,23), (4999,24), (9000,25), (4990,26), (4991,27), (4992,28)) t(st_id, pos) ON ((t.st_id = s.st_id)))
  WHERE ((s.st_id = ANY (ARRAY[4000, 4020, 4030, 4040, 4050, 4070, 4080, 4090, 4100, 4110, 4120, 4130, 4140, 4160, 4510, 4570, 4580, 4590, 4620, 4999, 9000, 4180, 4150, 4990, 4991, 4992])) AND (s.active IS TRUE))
  ORDER BY t.pos;


ALTER TABLE tool_web_lily.view_main_stations OWNER TO postgres;

--
-- TOC entry 6188 (class 0 OID 0)
-- Dependencies: 503
-- Name: VIEW view_main_stations; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON VIEW tool_web_lily.view_main_stations IS 'get main stations used by reports';


--
-- TOC entry 504 (class 1259 OID 22948)
-- Name: view_main_stations_all; Type: VIEW; Schema: tool_web_lily; Owner: postgres
--

CREATE VIEW tool_web_lily.view_main_stations_all AS
 SELECT s.st_id,
    s.stationname,
    s.schema,
    s.tableid,
    (((s.schema)::text || '.'::text) || (s.tableid)::text) AS tablename,
    s.station_roaming_type,
    st.roaming_type,
    s.po_id,
    s.active,
    t.pos
   FROM ((public._stations s
     LEFT JOIN public._station_roaming_type st ON ((st.id = s.station_roaming_type)))
     LEFT JOIN ( VALUES (4000,1), (4010,2), (4020,3), (4030,4), (4040,5), (4050,6), (4070,7), (4080,8), (4110,9), (4120,10), (4130,11), (4140,12), (4155,13), (4160,14), (4170,15), (4180,16), (4250,17), (4420,18), (4510,19), (4560,20), (4565,21), (4570,22), (4580,23), (4590,24), (4999,25), (9000,26)) t(st_id, pos) ON ((t.st_id = s.st_id)))
  WHERE (s.st_id = ANY (ARRAY[4000, 4010, 4020, 4030, 4040, 4050, 4070, 4080, 4110, 4120, 4130, 4140, 4155, 4160, 4170, 4180, 4250, 4420, 4510, 4560, 4565, 4570, 4580, 4590, 4999, 9000]))
  ORDER BY t.pos;


ALTER TABLE tool_web_lily.view_main_stations_all OWNER TO postgres;

--
-- TOC entry 6189 (class 0 OID 0)
-- Dependencies: 504
-- Name: VIEW view_main_stations_all; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON VIEW tool_web_lily.view_main_stations_all IS 'get main stations used by reports';


--
-- TOC entry 505 (class 1259 OID 22953)
-- Name: view_memos; Type: VIEW; Schema: tool_web_lily; Owner: postgres
--

CREATE VIEW tool_web_lily.view_memos AS
 SELECT m.me_id,
    m.us_id,
    m.memo_place,
    m.memo_date,
    m.memo_start_time,
    m.memo_end_time,
    m.memo_title,
    m.memo_body,
    m.memo_insert_time,
    ((u.user_name || ' '::text) || u.user_surname) AS memo_username,
    array_to_string((ARRAY( SELECT mp.pa_id
           FROM (tool_web_lily.memo_participants mp
             LEFT JOIN tool_web_lily.participants p ON ((mp.pa_id = p.pa_id)))
          WHERE (mp.me_id = m.me_id)
          ORDER BY mp.pa_id))::text[], ', '::text) AS participant_ids,
    array_to_string(ARRAY( SELECT ((p.name || ' '::text) || p.surname)
           FROM (tool_web_lily.memo_participants mp
             LEFT JOIN tool_web_lily.participants p ON ((mp.pa_id = p.pa_id)))
          WHERE (mp.me_id = m.me_id)
          ORDER BY ((p.name || ' '::text) || p.surname)), ', '::text) AS participant_names
   FROM (tool_web_lily.memos m
     LEFT JOIN tool_web_lily.users u USING (us_id))
  ORDER BY m.me_id;


ALTER TABLE tool_web_lily.view_memos OWNER TO postgres;

--
-- TOC entry 6190 (class 0 OID 0)
-- Dependencies: 505
-- Name: VIEW view_memos; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON VIEW tool_web_lily.view_memos IS 'memos information view';


--
-- TOC entry 506 (class 1259 OID 22963)
-- Name: view_operations_filters; Type: VIEW; Schema: tool_web_lily; Owner: postgres
--

CREATE VIEW tool_web_lily.view_operations_filters AS
 SELECT o.id AS oper_id,
    o.ma_id AS oper_ma_id,
    o.arpa_id AS oper_arpa_id,
    o.op_id AS oper_op_id,
    o.note AS oper_op_note,
    o.ca_id AS oper_ca_id,
    (o.filters_expdate)::date AS oper_filter_expdate,
    ((o.filters_expdate)::date - ('now'::text)::date) AS oper_filter_time_left,
    m.st_id AS main_st_id,
    m.us_id AS main_us_id,
    m.fulldate AS main_fulldate,
    m.note AS main_note,
    i.name AS instr_name,
    t.brand AS instr_brand,
    t.model AS instr_model,
    t.constructor AS instr_constructor,
    c.instrument_category AS instr_category,
    s.stationname AS station_name,
    initcap((u.username)::text) AS user_name,
    u.userremark AS user_remark
   FROM ((((((tool_netcom.data_operations o
     LEFT JOIN tool_netcom.data_maintenances m USING (ma_id))
     LEFT JOIN tool_netcom.instruments i USING (arpa_id))
     LEFT JOIN tool_netcom.instruments_types t USING (in_ty_id))
     LEFT JOIN tool_netcom.instrument_categories c USING (in_ca_id))
     LEFT JOIN public._stations s USING (st_id))
     LEFT JOIN public._users u USING (us_id))
  WHERE (o.filters_expdate IS NOT NULL)
  ORDER BY ((o.filters_expdate)::date - ('now'::text)::date);


ALTER TABLE tool_web_lily.view_operations_filters OWNER TO postgres;

--
-- TOC entry 6191 (class 0 OID 0)
-- Dependencies: 506
-- Name: VIEW view_operations_filters; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON VIEW tool_web_lily.view_operations_filters IS 'filter expiration information view';


--
-- TOC entry 507 (class 1259 OID 23020)
-- Name: view_surveys; Type: VIEW; Schema: tool_web_lily; Owner: postgres
--

CREATE VIEW tool_web_lily.view_surveys AS
 SELECT s.su_id,
    s.us_id,
    ((u.user_name || ' '::text) || u.user_surname) AS user_fullname,
    s.survey_place,
    s.survey_date,
    to_char(s.survey_date, 'DD/MM/YYYY'::text) AS survey_date_format,
    s.survey_start_time,
    to_char((s.survey_start_time)::interval, 'HH24:MI'::text) AS survey_start_time_format,
    s.survey_end_time,
    to_char((s.survey_end_time)::interval, 'HH24:MI'::text) AS survey_end_time_format,
    s.survey_desc,
    array_to_string(ARRAY( SELECT a.stored_filename
           FROM tool_web_lily.surveys_attachements a
          WHERE (a.su_id = s.su_id)
          ORDER BY a.attachement_id), ', '::text) AS stored_attachments,
    array_to_string(ARRAY( SELECT a.source_filename
           FROM tool_web_lily.surveys_attachements a
          WHERE (a.su_id = s.su_id)
          ORDER BY a.attachement_id), ', '::text) AS attachments
   FROM (tool_web_lily.surveys s
     LEFT JOIN tool_web_lily.users u ON ((s.us_id = u.us_id)))
  ORDER BY s.su_id;


ALTER TABLE tool_web_lily.view_surveys OWNER TO postgres;

--
-- TOC entry 6192 (class 0 OID 0)
-- Dependencies: 507
-- Name: VIEW view_surveys; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON VIEW tool_web_lily.view_surveys IS 'surveys reports view';


--
-- TOC entry 508 (class 1259 OID 23025)
-- Name: view_tasks; Type: VIEW; Schema: tool_web_lily; Owner: postgres
--

CREATE VIEW tool_web_lily.view_tasks AS
 SELECT t.ta_id,
    t.task_name,
    t.task_done,
    t.task_type,
    t.task_stid,
    t.task_assignee,
    t.task_insert_time,
    tt.ty_desc,
    ss.stationname AS task_station,
    ((u1.user_name || ' '::text) || u1.user_surname) AS user_fullname,
    t.task_close_time,
    ((u2.user_name || ' '::text) || u2.user_surname) AS user_fullname_close
   FROM ((((tool_web_lily.tasks t
     LEFT JOIN tool_web_lily.task_types tt ON ((t.task_type = tt.ty_id)))
     LEFT JOIN tool_web_lily.users u1 ON ((t.us_id = u1.us_id)))
     LEFT JOIN tool_web_lily.users u2 ON ((t.us_id_close = u2.us_id)))
     LEFT JOIN public._stations ss ON ((t.task_stid = ss.st_id)))
  ORDER BY t.ta_id;


ALTER TABLE tool_web_lily.view_tasks OWNER TO postgres;

--
-- TOC entry 6193 (class 0 OID 0)
-- Dependencies: 508
-- Name: VIEW view_tasks; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON VIEW tool_web_lily.view_tasks IS 'tasks view';


--
-- TOC entry 509 (class 1259 OID 23030)
-- Name: view_tickets; Type: VIEW; Schema: tool_web_lily; Owner: postgres
--

CREATE VIEW tool_web_lily.view_tickets AS
 SELECT t.tk_id AS ticket_id,
    t.tk_opening_date AS ticket_opening_date,
    t.tk_expiry_date AS ticket_expiry_date,
    t.tk_incharge_date AS ticket_incharge_date,
    t.tk_closure_date AS ticket_closure_date,
    t.tk_opening_operator_fk AS ticket_opening_user_id,
    ug.gr_id AS ticket_opening_operator_group_id,
    u1.user_name AS ticket_opening_user_name,
    u1.user_surname AS ticket_opening_user_surname,
    ((u1.user_name || ' '::text) || u1.user_surname) AS ticket_opening_user_fullname,
    u1.user_telephone AS ticket_opening_user_tel,
    u1.user_email AS ticket_opening_user_email,
    t.tk_recipient_group_fk AS ticket_recipient_group_id,
    g.group_name AS ticket_recipient_group_name,
    t.tk_closure_operator_fk AS ticket_closure_user_id,
    u2.user_name AS ticket_closure_user_name,
    u2.user_surname AS ticket_closure_user_surname,
    ((u2.user_name || ' '::text) || u2.user_surname) AS ticket_closure_user_fullname,
    u2.user_telephone AS ticket_closure_user_tel,
    u2.user_email AS ticket_closure_user_email,
    t.st_id_fk AS ticket_station_id,
    st.stationname AS ticket_station_name,
    st.stationshortname AS ticket_station_shortname,
    st.schema AS ticket_station_schema,
    st.tableid AS ticket_station_table,
    st.active AS ticket_station_active,
    t.in_id_fk AS ticket_instrument_id,
    i.arpa_id AS ticket_instrument_arpaid,
    i.name AS ticket_instrument_name,
    t.cy_id_fk AS ticket_cylinder_id,
    c.arpa_id AS ticket_cylinder_arpaid,
    c.description AS ticket_cylinder_name,
    t.eq_id_fk AS ticket_equipment_id,
    e.arpa_id AS ticket_equipment_arpaid,
    e.equipment AS ticket_equipment_name,
    t.tt_id_fk AS ticket_type_id,
    tt.tt_desc AS ticket_type_desc,
    t.tc_id_fk AS ticket_category_id,
    tc.tc_desc AS ticket_category_desc,
    t.tk_freq_fk AS ticket_frequency_id,
    of.frequency AS ticket_frequency_desc,
    of.freq_days AS ticket_frequency_day,
    t.tk_title AS ticket_title,
    t.tk_opening_note AS ticket_opening_note,
    t.tk_closure_note AS ticket_closure_note,
    t.tk_parent_id_fk AS ticket_parent_id
   FROM (((((((((((tool_web_lily.tickets t
     LEFT JOIN tool_web_lily.users u1 ON ((u1.us_id = t.tk_opening_operator_fk)))
     LEFT JOIN tool_web_lily.users u2 ON ((u2.us_id = t.tk_closure_operator_fk)))
     LEFT JOIN tool_web_lily.groups g ON ((g.gr_id = t.tk_recipient_group_fk)))
     LEFT JOIN tool_web_lily.users_groups ug ON ((ug.us_id = t.tk_opening_operator_fk)))
     LEFT JOIN public._stations st ON ((st.st_id = t.st_id_fk)))
     LEFT JOIN tool_netcom.instruments i ON ((i.in_id = t.in_id_fk)))
     LEFT JOIN tool_netcom.cylinders c ON ((c.cy_id = t.cy_id_fk)))
     LEFT JOIN tool_netcom.equipments e ON ((e.eq_id = t.eq_id_fk)))
     LEFT JOIN tool_web_lily.ticket_types tt ON ((tt.tt_id = t.tt_id_fk)))
     LEFT JOIN tool_web_lily.ticket_categories tc ON ((tc.tc_id = t.tc_id_fk)))
     LEFT JOIN tool_netcom.operation_frequency of ON ((of.op_fr_id = t.tk_freq_fk)));


ALTER TABLE tool_web_lily.view_tickets OWNER TO postgres;

--
-- TOC entry 510 (class 1259 OID 23040)
-- Name: view_user_menu; Type: VIEW; Schema: tool_web_lily; Owner: postgres
--

CREATE VIEW tool_web_lily.view_user_menu AS
 SELECT us.us_id,
    me.menu_name,
    me.menu_href,
    me.menu_desc,
    me.menu_css,
    me.badge_css,
    me.isdropdown,
    me.isvisible,
    um.menu_id,
    um.menu_level,
    um.menu_order,
    um.menu_published,
    um.user_grants
   FROM ((tool_web_lily.user_menu um
     LEFT JOIN tool_web_lily.menu me ON ((me.id = um.menu_id)))
     LEFT JOIN tool_web_lily.users us USING (us_id))
  ORDER BY um.us_id, um.menu_order;


ALTER TABLE tool_web_lily.view_user_menu OWNER TO postgres;

--
-- TOC entry 6194 (class 0 OID 0)
-- Dependencies: 510
-- Name: VIEW view_user_menu; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON VIEW tool_web_lily.view_user_menu IS 'Web application menu view';


--
-- TOC entry 511 (class 1259 OID 23045)
-- Name: view_user_stations; Type: VIEW; Schema: tool_web_lily; Owner: postgres
--

CREATE VIEW tool_web_lily.view_user_stations AS
 SELECT DISTINCT ON (u.us_id, s.st_id) u.us_id AS user_id,
    u.user_name,
    u.user_surname,
    u.user_telephone,
    u.user_email,
    u.user_avatar,
    u.user_active,
    u.user_main_id,
    u.user_last_online,
    u.user_insert_time,
    ARRAY( SELECT users_groups.gr_id
           FROM tool_web_lily.users_groups
          WHERE (users_groups.us_id = u.us_id)) AS user_groups_array,
    s.st_id AS station_id,
    s.stationname AS station_name,
    s.stationshortname AS station_shortname,
    s.schema AS station_schema,
    s.tableid AS station_table,
    s.station_roaming_type,
    s.active AS station_active
   FROM ((((tool_web_lily.users u
     LEFT JOIN tool_web_lily.users_groups ug USING (us_id))
     LEFT JOIN tool_web_lily.groups g USING (gr_id))
     LEFT JOIN tool_web_lily.group_stations gs USING (gr_id))
     LEFT JOIN public._stations s USING (st_id))
  WHERE ((u.user_active IS TRUE) AND (s.active IS TRUE))
  ORDER BY u.us_id;


ALTER TABLE tool_web_lily.view_user_stations OWNER TO postgres;

--
-- TOC entry 512 (class 1259 OID 23050)
-- Name: view_user_stations_all; Type: VIEW; Schema: tool_web_lily; Owner: postgres
--

CREATE VIEW tool_web_lily.view_user_stations_all AS
 SELECT DISTINCT ON (u.us_id, s.st_id) u.us_id AS user_id,
    u.user_name,
    u.user_surname,
    u.user_telephone,
    u.user_email,
    u.user_avatar,
    u.user_active,
    u.user_main_id,
    u.user_last_online,
    u.user_insert_time,
    ARRAY( SELECT users_groups.gr_id
           FROM tool_web_lily.users_groups
          WHERE (users_groups.us_id = u.us_id)) AS user_groups_array,
    s.st_id AS station_id,
    s.stationname AS station_name,
    s.stationshortname AS station_shortname,
    s.schema AS station_schema,
    s.tableid AS station_table,
    s.station_roaming_type,
    s.active AS station_active
   FROM ((((tool_web_lily.users u
     LEFT JOIN tool_web_lily.users_groups ug USING (us_id))
     LEFT JOIN tool_web_lily.groups g USING (gr_id))
     LEFT JOIN tool_web_lily.group_stations gs USING (gr_id))
     LEFT JOIN public._stations s USING (st_id))
  WHERE (u.user_active IS TRUE)
  ORDER BY u.us_id;


ALTER TABLE tool_web_lily.view_user_stations_all OWNER TO postgres;

--
-- TOC entry 513 (class 1259 OID 23055)
-- Name: view_users; Type: VIEW; Schema: tool_web_lily; Owner: postgres
--

CREATE VIEW tool_web_lily.view_users AS
 SELECT u.us_id,
    u.user_name,
    u.user_surname,
    ((u.user_name || ' '::text) || u.user_surname) AS user_fullname,
    u.user_password,
    u.user_telephone,
    u.user_email,
    u.user_active,
    u.user_insert_time,
    COALESCE(u.user_avatar, 'default.png'::text) AS user_avatar,
    u.user_main_id,
    ug.gr_id,
    g.group_name
   FROM ((tool_web_lily.users u
     LEFT JOIN tool_web_lily.users_groups ug USING (us_id))
     LEFT JOIN tool_web_lily.groups g USING (gr_id))
  ORDER BY u.us_id;


ALTER TABLE tool_web_lily.view_users OWNER TO postgres;

--
-- TOC entry 6195 (class 0 OID 0)
-- Dependencies: 513
-- Name: VIEW view_users; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON VIEW tool_web_lily.view_users IS 'Users and groups view';


--
-- TOC entry 514 (class 1259 OID 23060)
-- Name: view_users_logs; Type: VIEW; Schema: tool_web_lily; Owner: postgres
--

CREATE VIEW tool_web_lily.view_users_logs AS
 SELECT l.log_date,
    u.us_id,
    ((u.user_name || ' '::text) || u.user_surname) AS user_fullname,
    (l.log_info OPERATOR(public.->) 'action'::text) AS action
   FROM (tool_web_lily.users_logs l
     LEFT JOIN tool_web_lily.users u ON ((((l.log_info OPERATOR(public.->) 'usid'::text))::integer = u.us_id)))
  ORDER BY l.log_date;


ALTER TABLE tool_web_lily.view_users_logs OWNER TO postgres;

--
-- TOC entry 6196 (class 0 OID 0)
-- Dependencies: 514
-- Name: VIEW view_users_logs; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON VIEW tool_web_lily.view_users_logs IS 'Users authentication logs';


--
-- TOC entry 515 (class 1259 OID 23064)
-- Name: view_visualizer_map_stations; Type: VIEW; Schema: tool_web_lily; Owner: postgres
--

CREATE VIEW tool_web_lily.view_visualizer_map_stations AS
 SELECT DISTINCT ON (s.st_id) s.st_id,
    pg.pg_id,
    s.stationname AS station_name,
    m.networktype AS network_id,
    n.networktype AS network_type,
    s.station_roaming_type AS roaming_type,
    m.zone,
    m.basin,
    m.locality,
    m.commune,
    m.community,
    m.province,
    m.region,
    m.note,
    m.altitude,
    m.lat_wgs84,
    m.lon_wgs84
   FROM ((((public._stations s
     LEFT JOIN public._stations_parameters_master p USING (st_id))
     LEFT JOIN metadata.stations_metadata m USING (st_id))
     LEFT JOIN metadata.station_networktype n ON ((m.networktype = n.id)))
     LEFT JOIN tool_visualizer_lily.pages pg ON ((s.st_id = pg.st_id_fk)))
  WHERE ((m.lat_wgs84 IS NOT NULL) AND (m.lon_wgs84 IS NOT NULL))
  ORDER BY s.st_id;


ALTER TABLE tool_web_lily.view_visualizer_map_stations OWNER TO postgres;

--
-- TOC entry 6197 (class 0 OID 0)
-- Dependencies: 515
-- Name: VIEW view_visualizer_map_stations; Type: COMMENT; Schema: tool_web_lily; Owner: postgres
--

COMMENT ON VIEW tool_web_lily.view_visualizer_map_stations IS 'Visualizer map stations';


--
-- TOC entry 519 (class 1259 OID 27254)
-- Name: warnings_list; Type: TABLE; Schema: warnings; Owner: postgres
--

CREATE TABLE warnings.warnings_list (
    id bigint NOT NULL,
    st_pr_id smallint,
    fulldate timestamp without time zone NOT NULL,
    value real,
    warning_type smallint
);


ALTER TABLE warnings.warnings_list OWNER TO postgres;

--
-- TOC entry 6198 (class 0 OID 0)
-- Dependencies: 519
-- Name: TABLE warnings_list; Type: COMMENT; Schema: warnings; Owner: postgres
--

COMMENT ON TABLE warnings.warnings_list IS 'Table holdings all warnings';


--
-- TOC entry 4610 (class 2604 OID 23470)
-- Name: calibrations id; Type: DEFAULT; Schema: calibrations; Owner: postgres
--

ALTER TABLE ONLY calibrations.calibrations ALTER COLUMN id SET DEFAULT nextval('calibrations.calibrations_id_seq'::regclass);


--
-- TOC entry 4611 (class 2604 OID 23472)
-- Name: daily_reports id; Type: DEFAULT; Schema: journal; Owner: postgres
--

ALTER TABLE ONLY journal.daily_reports ALTER COLUMN id SET DEFAULT nextval('journal.daily_reports_id_seq'::regclass);


--
-- TOC entry 4612 (class 2604 OID 23473)
-- Name: network_maintenances id; Type: DEFAULT; Schema: journal; Owner: postgres
--

ALTER TABLE ONLY journal.network_maintenances ALTER COLUMN id SET DEFAULT nextval('journal.network_maintenances_id_seq'::regclass);


--
-- TOC entry 4613 (class 2604 OID 23474)
-- Name: network_problems id; Type: DEFAULT; Schema: journal; Owner: postgres
--

ALTER TABLE ONLY journal.network_problems ALTER COLUMN id SET DEFAULT nextval('journal.network_problems_id_seq'::regclass);


--
-- TOC entry 4614 (class 2604 OID 23475)
-- Name: network_spare_parts id; Type: DEFAULT; Schema: journal; Owner: postgres
--

ALTER TABLE ONLY journal.network_spare_parts ALTER COLUMN id SET DEFAULT nextval('journal.network_spare_parts_id_seq'::regclass);


--
-- TOC entry 4616 (class 2604 OID 23476)
-- Name: network_users id; Type: DEFAULT; Schema: journal; Owner: postgres
--

ALTER TABLE ONLY journal.network_users ALTER COLUMN id SET DEFAULT nextval('journal.network_users_id_seq'::regclass);


--
-- TOC entry 4620 (class 2604 OID 23477)
-- Name: reports id; Type: DEFAULT; Schema: journal; Owner: postgres
--

ALTER TABLE ONLY journal.reports ALTER COLUMN id SET DEFAULT nextval('journal.reports_id_seq'::regclass);


--
-- TOC entry 4621 (class 2604 OID 23478)
-- Name: reports_pics id; Type: DEFAULT; Schema: journal; Owner: postgres
--

ALTER TABLE ONLY journal.reports_pics ALTER COLUMN id SET DEFAULT nextval('journal.reports_pics_id_seq'::regclass);


--
-- TOC entry 4628 (class 2604 OID 23479)
-- Name: _laboratory_analysis_parameters lab_pr_id; Type: DEFAULT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis._laboratory_analysis_parameters ALTER COLUMN lab_pr_id SET DEFAULT nextval('labanalysis._laboratory_analysis_parameters_lab_pr_id_seq'::regclass);


--
-- TOC entry 4630 (class 2604 OID 23480)
-- Name: _laboratory_filter fi_id; Type: DEFAULT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis._laboratory_filter ALTER COLUMN fi_id SET DEFAULT nextval('labanalysis._laboratory_filter_fi_id_seq'::regclass);


--
-- TOC entry 4631 (class 2604 OID 23481)
-- Name: deposimeters_input_data id; Type: DEFAULT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.deposimeters_input_data ALTER COLUMN id SET DEFAULT nextval('labanalysis.deposimeters_input_data_id_seq'::regclass);


--
-- TOC entry 4632 (class 2604 OID 23482)
-- Name: laboratory_data id; Type: DEFAULT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.laboratory_data ALTER COLUMN id SET DEFAULT nextval('labanalysis.laboratory_data_id_seq'::regclass);


--
-- TOC entry 4633 (class 2604 OID 23483)
-- Name: laboratory_data_white id; Type: DEFAULT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.laboratory_data_white ALTER COLUMN id SET DEFAULT nextval('labanalysis.laboratory_data_white_id_seq'::regclass);


--
-- TOC entry 4636 (class 2604 OID 23484)
-- Name: laboratory_samples id; Type: DEFAULT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.laboratory_samples ALTER COLUMN id SET DEFAULT nextval('labanalysis.laboratory_samples_id_seq'::regclass);


--
-- TOC entry 4637 (class 2604 OID 23485)
-- Name: laboratory_samples_white id; Type: DEFAULT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.laboratory_samples_white ALTER COLUMN id SET DEFAULT nextval('labanalysis.laboratory_samples_white_id_seq'::regclass);


--
-- TOC entry 4641 (class 2604 OID 23486)
-- Name: _groups_parameters gr_pr_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._groups_parameters ALTER COLUMN gr_pr_id SET DEFAULT nextval('public._groups_parameters_gr_pr_id_seq'::regclass);


--
-- TOC entry 4642 (class 2604 OID 23487)
-- Name: _instruments_parameters in_pr_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._instruments_parameters ALTER COLUMN in_pr_id SET DEFAULT nextval('public._instruments_parameters_in_pr_id_seq'::regclass);


--
-- TOC entry 4608 (class 2604 OID 23488)
-- Name: _stations_override id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._stations_override ALTER COLUMN id SET DEFAULT nextval('public._stations_override_id_seq'::regclass);


--
-- TOC entry 4605 (class 2604 OID 23489)
-- Name: _stations_parameters_master st_pr_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._stations_parameters_master ALTER COLUMN st_pr_id SET DEFAULT nextval('public._stations_parameters_st_pr_id_seq'::regclass);


--
-- TOC entry 4648 (class 2604 OID 23490)
-- Name: _users us_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._users ALTER COLUMN us_id SET DEFAULT nextval('public._users_us_id_seq'::regclass);


--
-- TOC entry 4649 (class 2604 OID 23491)
-- Name: _users_logins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._users_logins ALTER COLUMN id SET DEFAULT nextval('public._users_logins_id_seq'::regclass);


--
-- TOC entry 4652 (class 2604 OID 23492)
-- Name: codemanager id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.codemanager ALTER COLUMN id SET DEFAULT nextval('public.codemanager_id_seq'::regclass);


--
-- TOC entry 4672 (class 2604 OID 23530)
-- Name: calibration_methods me_id; Type: DEFAULT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.calibration_methods ALTER COLUMN me_id SET DEFAULT nextval('tool_netcom.calibration_methods_me_id_seq'::regclass);


--
-- TOC entry 4673 (class 2604 OID 23531)
-- Name: calibration_reasons re_id; Type: DEFAULT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.calibration_reasons ALTER COLUMN re_id SET DEFAULT nextval('tool_netcom.calibration_reasons_re_id_seq'::regclass);


--
-- TOC entry 4674 (class 2604 OID 23532)
-- Name: cylinders cy_id; Type: DEFAULT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.cylinders ALTER COLUMN cy_id SET DEFAULT nextval('tool_netcom.cylinders_cy_id_seq'::regclass);


--
-- TOC entry 4664 (class 2604 OID 23533)
-- Name: data_calibrations id; Type: DEFAULT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_calibrations ALTER COLUMN id SET DEFAULT nextval('tool_netcom.data_calibrations_id_seq'::regclass);


--
-- TOC entry 4675 (class 2604 OID 23534)
-- Name: data_documents id; Type: DEFAULT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_documents ALTER COLUMN id SET DEFAULT nextval('tool_netcom.data_documents_id_seq'::regclass);


--
-- TOC entry 4676 (class 2604 OID 23535)
-- Name: data_maintenances ma_id; Type: DEFAULT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_maintenances ALTER COLUMN ma_id SET DEFAULT nextval('tool_netcom.data_maintenances_ma_id_seq'::regclass);


--
-- TOC entry 4677 (class 2604 OID 23536)
-- Name: data_operations id; Type: DEFAULT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_operations ALTER COLUMN id SET DEFAULT nextval('tool_netcom.data_operations_id_seq'::regclass);


--
-- TOC entry 4678 (class 2604 OID 23537)
-- Name: data_spare_parts id; Type: DEFAULT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_spare_parts ALTER COLUMN id SET DEFAULT nextval('tool_netcom.data_spare_parts_id_seq'::regclass);


--
-- TOC entry 4679 (class 2604 OID 23538)
-- Name: equipments eq_id; Type: DEFAULT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.equipments ALTER COLUMN eq_id SET DEFAULT nextval('tool_netcom.equipments_eq_id_seq'::regclass);


--
-- TOC entry 4665 (class 2604 OID 23539)
-- Name: instruments in_id; Type: DEFAULT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments ALTER COLUMN in_id SET DEFAULT nextval('tool_netcom.instruments_in_id_seq'::regclass);


--
-- TOC entry 4680 (class 2604 OID 23540)
-- Name: instruments_categories_parameters id; Type: DEFAULT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments_categories_parameters ALTER COLUMN id SET DEFAULT nextval('tool_netcom.instruments_categories_parameters_id_seq'::regclass);


--
-- TOC entry 4682 (class 2604 OID 23541)
-- Name: instruments_operations id; Type: DEFAULT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments_operations ALTER COLUMN id SET DEFAULT nextval('tool_netcom.instruments_operations_id_seq'::regclass);


--
-- TOC entry 4683 (class 2604 OID 23542)
-- Name: instruments_spare_parts id; Type: DEFAULT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments_spare_parts ALTER COLUMN id SET DEFAULT nextval('tool_netcom.instruments_spare_parts_id_seq'::regclass);


--
-- TOC entry 4685 (class 2604 OID 23543)
-- Name: network_users id; Type: DEFAULT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.network_users ALTER COLUMN id SET DEFAULT nextval('tool_netcom.network_users_id_seq'::regclass);


--
-- TOC entry 4686 (class 2604 OID 23544)
-- Name: stations_calibrators st_ca_id; Type: DEFAULT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.stations_calibrators ALTER COLUMN st_ca_id SET DEFAULT nextval('tool_netcom.stations_calibrators_st_ca_id_seq'::regclass);


--
-- TOC entry 4687 (class 2604 OID 23545)
-- Name: stations_cylinders st_cy_id; Type: DEFAULT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.stations_cylinders ALTER COLUMN st_cy_id SET DEFAULT nextval('tool_netcom.stations_cylinders_st_cy_id_seq'::regclass);


--
-- TOC entry 4688 (class 2604 OID 23546)
-- Name: stations_equipments st_eq_id; Type: DEFAULT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.stations_equipments ALTER COLUMN st_eq_id SET DEFAULT nextval('tool_netcom.stations_equipments_st_eq_id_seq'::regclass);


--
-- TOC entry 4689 (class 2604 OID 23547)
-- Name: stations_instruments st_in_id; Type: DEFAULT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.stations_instruments ALTER COLUMN st_in_id SET DEFAULT nextval('tool_netcom.stations_instruments_st_in_id_seq'::regclass);


--
-- TOC entry 4700 (class 2604 OID 23555)
-- Name: pages pg_id; Type: DEFAULT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.pages ALTER COLUMN pg_id SET DEFAULT nextval('tool_visualizer_lily.pages_pg_id_seq'::regclass);


--
-- TOC entry 4704 (class 2604 OID 23556)
-- Name: pages_groups gr_id; Type: DEFAULT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.pages_groups ALTER COLUMN gr_id SET DEFAULT nextval('tool_visualizer_lily.pages_groups_gr_id_seq'::regclass);


--
-- TOC entry 4745 (class 2604 OID 23557)
-- Name: pages_windows wd_id; Type: DEFAULT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.pages_windows ALTER COLUMN wd_id SET DEFAULT nextval('tool_visualizer_lily.pages_windows_wd_id_seq'::regclass);


--
-- TOC entry 4751 (class 2604 OID 23559)
-- Name: group_stations gs_id; Type: DEFAULT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.group_stations ALTER COLUMN gs_id SET DEFAULT nextval('tool_web_lily.group_stations_gs_id_seq'::regclass);


--
-- TOC entry 4754 (class 2604 OID 23560)
-- Name: labanalysis_files file_id; Type: DEFAULT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.labanalysis_files ALTER COLUMN file_id SET DEFAULT nextval('tool_web_lily.labanalysis_files_file_id_seq'::regclass);


--
-- TOC entry 4755 (class 2604 OID 23561)
-- Name: memo_participants me_pa_id; Type: DEFAULT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.memo_participants ALTER COLUMN me_pa_id SET DEFAULT nextval('tool_web_lily.memo_participants_me_pa_id_seq'::regclass);


--
-- TOC entry 4757 (class 2604 OID 23562)
-- Name: memos me_id; Type: DEFAULT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.memos ALTER COLUMN me_id SET DEFAULT nextval('tool_web_lily.memos_me_id_seq'::regclass);


--
-- TOC entry 4761 (class 2604 OID 23563)
-- Name: participants pa_id; Type: DEFAULT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.participants ALTER COLUMN pa_id SET DEFAULT nextval('tool_web_lily.participants_pa_id_seq'::regclass);


--
-- TOC entry 4767 (class 2604 OID 23564)
-- Name: surveys_attachements attachement_id; Type: DEFAULT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.surveys_attachements ALTER COLUMN attachement_id SET DEFAULT nextval('tool_web_lily.surveys_attachements_attachement_id_seq'::regclass);


--
-- TOC entry 4769 (class 2604 OID 23565)
-- Name: tasks ta_id; Type: DEFAULT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.tasks ALTER COLUMN ta_id SET DEFAULT nextval('tool_web_lily.tasks_ta_id_seq'::regclass);


--
-- TOC entry 4771 (class 2604 OID 23566)
-- Name: tickets tk_id; Type: DEFAULT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.tickets ALTER COLUMN tk_id SET DEFAULT nextval('tool_web_lily.tickets_tk_id_seq'::regclass);


--
-- TOC entry 4774 (class 2604 OID 23567)
-- Name: user_menu id; Type: DEFAULT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.user_menu ALTER COLUMN id SET DEFAULT nextval('tool_web_lily.user_menu_id_seq'::regclass);


--
-- TOC entry 4668 (class 2604 OID 23568)
-- Name: users us_id; Type: DEFAULT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.users ALTER COLUMN us_id SET DEFAULT nextval('tool_web_lily.users_us_id_seq'::regclass);


--
-- TOC entry 4775 (class 2604 OID 23569)
-- Name: users_groups us_gr_id; Type: DEFAULT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.users_groups ALTER COLUMN us_gr_id SET DEFAULT nextval('tool_web_lily.users_groups_us_gr_id_seq'::regclass);


--
-- TOC entry 4777 (class 2604 OID 23570)
-- Name: users_logs id; Type: DEFAULT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.users_logs ALTER COLUMN id SET DEFAULT nextval('tool_web_lily.users_logs_id_seq'::regclass);


--
-- TOC entry 5518 (class 0 OID 17532)
-- Dependencies: 237
-- Data for Name: cal_methods; Type: TABLE DATA; Schema: calibrations; Owner: postgres
--



--
-- TOC entry 5519 (class 0 OID 17535)
-- Dependencies: 238
-- Data for Name: cal_reasons; Type: TABLE DATA; Schema: calibrations; Owner: postgres
--



--
-- TOC entry 5520 (class 0 OID 17538)
-- Dependencies: 239
-- Data for Name: calibrations; Type: TABLE DATA; Schema: calibrations; Owner: postgres
--



--
-- TOC entry 5522 (class 0 OID 17606)
-- Dependencies: 242
-- Data for Name: daily_reports; Type: TABLE DATA; Schema: journal; Owner: postgres
--



--
-- TOC entry 5524 (class 0 OID 17614)
-- Dependencies: 244
-- Data for Name: network_maintenances; Type: TABLE DATA; Schema: journal; Owner: postgres
--



--
-- TOC entry 5526 (class 0 OID 17619)
-- Dependencies: 246
-- Data for Name: network_problems; Type: TABLE DATA; Schema: journal; Owner: postgres
--



--
-- TOC entry 5528 (class 0 OID 17624)
-- Dependencies: 248
-- Data for Name: network_spare_parts; Type: TABLE DATA; Schema: journal; Owner: postgres
--



--
-- TOC entry 5530 (class 0 OID 17629)
-- Dependencies: 250
-- Data for Name: network_stations; Type: TABLE DATA; Schema: journal; Owner: postgres
--



--
-- TOC entry 5531 (class 0 OID 17632)
-- Dependencies: 251
-- Data for Name: network_users; Type: TABLE DATA; Schema: journal; Owner: postgres
--



--
-- TOC entry 5533 (class 0 OID 17638)
-- Dependencies: 253
-- Data for Name: reports; Type: TABLE DATA; Schema: journal; Owner: postgres
--



--
-- TOC entry 5534 (class 0 OID 17647)
-- Dependencies: 254
-- Data for Name: reports2; Type: TABLE DATA; Schema: journal; Owner: postgres
--



--
-- TOC entry 5536 (class 0 OID 17655)
-- Dependencies: 256
-- Data for Name: reports_pics; Type: TABLE DATA; Schema: journal; Owner: postgres
--



--
-- TOC entry 5540 (class 0 OID 17691)
-- Dependencies: 265
-- Data for Name: _laboratory_analysis; Type: TABLE DATA; Schema: labanalysis; Owner: postgres
--



--
-- TOC entry 5541 (class 0 OID 17698)
-- Dependencies: 266
-- Data for Name: _laboratory_analysis_parameters; Type: TABLE DATA; Schema: labanalysis; Owner: postgres
--



--
-- TOC entry 5543 (class 0 OID 17704)
-- Dependencies: 268
-- Data for Name: _laboratory_filter; Type: TABLE DATA; Schema: labanalysis; Owner: postgres
--



--
-- TOC entry 5545 (class 0 OID 17710)
-- Dependencies: 270
-- Data for Name: deposimeters_input_data; Type: TABLE DATA; Schema: labanalysis; Owner: postgres
--



--
-- TOC entry 5547 (class 0 OID 17718)
-- Dependencies: 272
-- Data for Name: laboratory_data; Type: TABLE DATA; Schema: labanalysis; Owner: postgres
--



--
-- TOC entry 5549 (class 0 OID 17723)
-- Dependencies: 274
-- Data for Name: laboratory_data_white; Type: TABLE DATA; Schema: labanalysis; Owner: postgres
--



--
-- TOC entry 5551 (class 0 OID 17728)
-- Dependencies: 276
-- Data for Name: laboratory_samples; Type: TABLE DATA; Schema: labanalysis; Owner: postgres
--



--
-- TOC entry 5553 (class 0 OID 17738)
-- Dependencies: 278
-- Data for Name: laboratory_samples_white; Type: TABLE DATA; Schema: labanalysis; Owner: postgres
--



--
-- TOC entry 5555 (class 0 OID 17746)
-- Dependencies: 280
-- Data for Name: users_laboratory_analysis; Type: TABLE DATA; Schema: labanalysis; Owner: postgres
--



--
-- TOC entry 5538 (class 0 OID 17669)
-- Dependencies: 260
-- Data for Name: station_networktype; Type: TABLE DATA; Schema: metadata; Owner: postgres
--



--
-- TOC entry 5556 (class 0 OID 17815)
-- Dependencies: 288
-- Data for Name: station_type; Type: TABLE DATA; Schema: metadata; Owner: postgres
--



--
-- TOC entry 5539 (class 0 OID 17672)
-- Dependencies: 261
-- Data for Name: station_typology; Type: TABLE DATA; Schema: metadata; Owner: postgres
--



--
-- TOC entry 5557 (class 0 OID 17821)
-- Dependencies: 289
-- Data for Name: station_zone; Type: TABLE DATA; Schema: metadata; Owner: postgres
--



--
-- TOC entry 5513 (class 0 OID 17390)
-- Dependencies: 232
-- Data for Name: stations_metadata; Type: TABLE DATA; Schema: metadata; Owner: postgres
--



--
-- TOC entry 5514 (class 0 OID 17418)
-- Dependencies: 233
-- Data for Name: stations_metadata_extended; Type: TABLE DATA; Schema: metadata; Owner: postgres
--



--
-- TOC entry 5558 (class 0 OID 17827)
-- Dependencies: 290
-- Data for Name: stations_metadata_info; Type: TABLE DATA; Schema: metadata; Owner: postgres
--



--
-- TOC entry 5559 (class 0 OID 17834)
-- Dependencies: 291
-- Data for Name: stations_metadata_instruments; Type: TABLE DATA; Schema: metadata; Owner: postgres
--



--
-- TOC entry 5560 (class 0 OID 17837)
-- Dependencies: 292
-- Data for Name: stations_metadata_pictures_maps; Type: TABLE DATA; Schema: metadata; Owner: postgres
--



--
-- TOC entry 5561 (class 0 OID 17844)
-- Dependencies: 293
-- Data for Name: cylinders; Type: TABLE DATA; Schema: operations; Owner: postgres
--



--
-- TOC entry 5562 (class 0 OID 17850)
-- Dependencies: 294
-- Data for Name: cylinders_parameters; Type: TABLE DATA; Schema: operations; Owner: postgres
--



--
-- TOC entry 5563 (class 0 OID 17856)
-- Dependencies: 295
-- Data for Name: instruments; Type: TABLE DATA; Schema: operations; Owner: postgres
--



--
-- TOC entry 5564 (class 0 OID 17863)
-- Dependencies: 296
-- Data for Name: instruments_has_ricambi; Type: TABLE DATA; Schema: operations; Owner: postgres
--



--
-- TOC entry 5565 (class 0 OID 17866)
-- Dependencies: 297
-- Data for Name: instruments_type; Type: TABLE DATA; Schema: operations; Owner: postgres
--



--
-- TOC entry 5566 (class 0 OID 17872)
-- Dependencies: 298
-- Data for Name: instruments_type_category; Type: TABLE DATA; Schema: operations; Owner: postgres
--



--
-- TOC entry 5567 (class 0 OID 17878)
-- Dependencies: 299
-- Data for Name: instruments_type_has_operations; Type: TABLE DATA; Schema: operations; Owner: postgres
--



--
-- TOC entry 5568 (class 0 OID 17881)
-- Dependencies: 300
-- Data for Name: instruments_type_has_parameters; Type: TABLE DATA; Schema: operations; Owner: postgres
--



--
-- TOC entry 5569 (class 0 OID 17884)
-- Dependencies: 301
-- Data for Name: operations; Type: TABLE DATA; Schema: operations; Owner: postgres
--



--
-- TOC entry 5570 (class 0 OID 17890)
-- Dependencies: 302
-- Data for Name: operations_data; Type: TABLE DATA; Schema: operations; Owner: postgres
--



--
-- TOC entry 5571 (class 0 OID 17896)
-- Dependencies: 303
-- Data for Name: operations_type; Type: TABLE DATA; Schema: operations; Owner: postgres
--



--
-- TOC entry 5572 (class 0 OID 17902)
-- Dependencies: 304
-- Data for Name: ricambi; Type: TABLE DATA; Schema: operations; Owner: postgres
--



--
-- TOC entry 5573 (class 0 OID 17908)
-- Dependencies: 305
-- Data for Name: ricambi_data; Type: TABLE DATA; Schema: operations; Owner: postgres
--



--
-- TOC entry 5574 (class 0 OID 17914)
-- Dependencies: 306
-- Data for Name: stations_has_instruments; Type: TABLE DATA; Schema: operations; Owner: postgres
--



--
-- TOC entry 5575 (class 0 OID 17935)
-- Dependencies: 310
-- Data for Name: __versions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5576 (class 0 OID 17938)
-- Dependencies: 311
-- Data for Name: _groups_list; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5577 (class 0 OID 17944)
-- Dependencies: 312
-- Data for Name: _groups_parameters; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5579 (class 0 OID 17949)
-- Dependencies: 314
-- Data for Name: _instruments_list; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5580 (class 0 OID 17955)
-- Dependencies: 315
-- Data for Name: _instruments_parameters; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5582 (class 0 OID 17960)
-- Dependencies: 317
-- Data for Name: _log_type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5583 (class 0 OID 17964)
-- Dependencies: 318
-- Data for Name: _logs; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5584 (class 0 OID 17971)
-- Dependencies: 319
-- Data for Name: _master; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5585 (class 0 OID 17974)
-- Dependencies: 320
-- Data for Name: _master_1; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5586 (class 0 OID 17977)
-- Dependencies: 321
-- Data for Name: _master_30; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5587 (class 0 OID 17984)
-- Dependencies: 323
-- Data for Name: _parameter_treatment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5588 (class 0 OID 17988)
-- Dependencies: 324
-- Data for Name: _parameters_formules; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5515 (class 0 OID 17421)
-- Dependencies: 234
-- Data for Name: _parameters_list_master; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5589 (class 0 OID 17991)
-- Dependencies: 325
-- Data for Name: _station_roaming_type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5512 (class 0 OID 17373)
-- Dependencies: 231
-- Data for Name: _stations; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5517 (class 0 OID 17514)
-- Dependencies: 236
-- Data for Name: _stations_override; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5516 (class 0 OID 17436)
-- Dependencies: 235
-- Data for Name: _stations_parameters_master; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5592 (class 0 OID 18023)
-- Dependencies: 328
-- Data for Name: _users; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5593 (class 0 OID 18027)
-- Dependencies: 329
-- Data for Name: _users_logins; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5595 (class 0 OID 18032)
-- Dependencies: 331
-- Data for Name: _users_parameters; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5596 (class 0 OID 18035)
-- Dependencies: 332
-- Data for Name: _users_stations; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5598 (class 0 OID 18040)
-- Dependencies: 334
-- Data for Name: codemanager; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5600 (class 0 OID 18047)
-- Dependencies: 336
-- Data for Name: data_import_tmp; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5601 (class 0 OID 18050)
-- Dependencies: 337
-- Data for Name: history_changes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5602 (class 0 OID 18271)
-- Dependencies: 345
-- Data for Name: data_plouves; Type: TABLE DATA; Schema: tables_ar; Owner: postgres
--



--
-- TOC entry 5698 (class 0 OID 27224)
-- Dependencies: 516
-- Data for Name: stations_alarms; Type: TABLE DATA; Schema: tool_builder; Owner: postgres
--



--
-- TOC entry 5700 (class 0 OID 27229)
-- Dependencies: 518
-- Data for Name: stations_polling; Type: TABLE DATA; Schema: tool_builder; Owner: postgres
--



--
-- TOC entry 5606 (class 0 OID 21639)
-- Dependencies: 377
-- Data for Name: calibration_methods; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5608 (class 0 OID 21647)
-- Dependencies: 379
-- Data for Name: calibration_reasons; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5610 (class 0 OID 21655)
-- Dependencies: 381
-- Data for Name: cylinders; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5603 (class 0 OID 18775)
-- Dependencies: 346
-- Data for Name: data_calibrations; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5612 (class 0 OID 21663)
-- Dependencies: 383
-- Data for Name: data_calibrations_2013_03_18; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5614 (class 0 OID 21671)
-- Dependencies: 385
-- Data for Name: data_documents; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5616 (class 0 OID 21679)
-- Dependencies: 387
-- Data for Name: data_maintenances; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5618 (class 0 OID 21687)
-- Dependencies: 389
-- Data for Name: data_operations; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5619 (class 0 OID 21693)
-- Dependencies: 390
-- Data for Name: data_operations_20180207; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5621 (class 0 OID 21701)
-- Dependencies: 392
-- Data for Name: data_spare_parts; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5623 (class 0 OID 21709)
-- Dependencies: 394
-- Data for Name: equipments; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5625 (class 0 OID 21717)
-- Dependencies: 396
-- Data for Name: instrument_categories; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5604 (class 0 OID 18781)
-- Dependencies: 347
-- Data for Name: instruments; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5626 (class 0 OID 21723)
-- Dependencies: 397
-- Data for Name: instruments_categories_parameters; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5629 (class 0 OID 21730)
-- Dependencies: 400
-- Data for Name: instruments_metadata; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5630 (class 0 OID 21737)
-- Dependencies: 401
-- Data for Name: instruments_operations; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5632 (class 0 OID 21742)
-- Dependencies: 403
-- Data for Name: instruments_spare_parts; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5634 (class 0 OID 21747)
-- Dependencies: 405
-- Data for Name: instruments_types; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5635 (class 0 OID 21753)
-- Dependencies: 406
-- Data for Name: network_users; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5637 (class 0 OID 21762)
-- Dependencies: 408
-- Data for Name: operation_category; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5638 (class 0 OID 21768)
-- Dependencies: 409
-- Data for Name: operation_frequency; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5639 (class 0 OID 21774)
-- Dependencies: 410
-- Data for Name: operations; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5640 (class 0 OID 21780)
-- Dependencies: 411
-- Data for Name: raw_data_calibrations; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5642 (class 0 OID 21788)
-- Dependencies: 413
-- Data for Name: result_data_calibrations; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5643 (class 0 OID 21794)
-- Dependencies: 414
-- Data for Name: spare_parts; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5644 (class 0 OID 21800)
-- Dependencies: 415
-- Data for Name: stations_calibrators; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5646 (class 0 OID 21808)
-- Dependencies: 417
-- Data for Name: stations_cylinders; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5648 (class 0 OID 21816)
-- Dependencies: 419
-- Data for Name: stations_equipments; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5650 (class 0 OID 21824)
-- Dependencies: 421
-- Data for Name: stations_instruments; Type: TABLE DATA; Schema: tool_netcom; Owner: postgres
--



--
-- TOC entry 5652 (class 0 OID 22172)
-- Dependencies: 449
-- Data for Name: page_autoscale; Type: TABLE DATA; Schema: tool_visualizer_lily; Owner: postgres
--



--
-- TOC entry 5653 (class 0 OID 22176)
-- Dependencies: 450
-- Data for Name: page_charttype; Type: TABLE DATA; Schema: tool_visualizer_lily; Owner: postgres
--



--
-- TOC entry 5654 (class 0 OID 22180)
-- Dependencies: 451
-- Data for Name: page_defaultview; Type: TABLE DATA; Schema: tool_visualizer_lily; Owner: postgres
--



--
-- TOC entry 5655 (class 0 OID 22184)
-- Dependencies: 452
-- Data for Name: page_integration; Type: TABLE DATA; Schema: tool_visualizer_lily; Owner: postgres
--



--
-- TOC entry 5656 (class 0 OID 22188)
-- Dependencies: 453
-- Data for Name: pages; Type: TABLE DATA; Schema: tool_visualizer_lily; Owner: postgres
--



--
-- TOC entry 5657 (class 0 OID 22197)
-- Dependencies: 454
-- Data for Name: pages_groups; Type: TABLE DATA; Schema: tool_visualizer_lily; Owner: postgres
--



--
-- TOC entry 5659 (class 0 OID 22205)
-- Dependencies: 456
-- Data for Name: pages_groups_users; Type: TABLE DATA; Schema: tool_visualizer_lily; Owner: postgres
--



--
-- TOC entry 5661 (class 0 OID 22210)
-- Dependencies: 458
-- Data for Name: pages_windows; Type: TABLE DATA; Schema: tool_visualizer_lily; Owner: postgres
--



--
-- TOC entry 5663 (class 0 OID 22268)
-- Dependencies: 461
-- Data for Name: users_settings; Type: TABLE DATA; Schema: tool_visualizer_lily; Owner: postgres
--



--
-- TOC entry 5664 (class 0 OID 22276)
-- Dependencies: 462
-- Data for Name: users_settings_colors; Type: TABLE DATA; Schema: tool_visualizer_lily; Owner: postgres
--



--
-- TOC entry 5665 (class 0 OID 22731)
-- Dependencies: 464
-- Data for Name: analysis_types; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--



--
-- TOC entry 5666 (class 0 OID 22737)
-- Dependencies: 465
-- Data for Name: group_stations; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--



--
-- TOC entry 5668 (class 0 OID 22742)
-- Dependencies: 467
-- Data for Name: groups; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--



--
-- TOC entry 5669 (class 0 OID 22748)
-- Dependencies: 468
-- Data for Name: labanalysis_files; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--



--
-- TOC entry 5671 (class 0 OID 22758)
-- Dependencies: 470
-- Data for Name: memo_participants; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--



--
-- TOC entry 5673 (class 0 OID 22763)
-- Dependencies: 472
-- Data for Name: memos; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--



--
-- TOC entry 5675 (class 0 OID 22772)
-- Dependencies: 474
-- Data for Name: menu; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--



--
-- TOC entry 5676 (class 0 OID 22781)
-- Dependencies: 475
-- Data for Name: participants; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--



--
-- TOC entry 5678 (class 0 OID 22791)
-- Dependencies: 477
-- Data for Name: surveys; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--



--
-- TOC entry 5679 (class 0 OID 22798)
-- Dependencies: 478
-- Data for Name: surveys_attachements; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--



--
-- TOC entry 5682 (class 0 OID 22810)
-- Dependencies: 481
-- Data for Name: task_types; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--



--
-- TOC entry 5683 (class 0 OID 22816)
-- Dependencies: 482
-- Data for Name: tasks; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--



--
-- TOC entry 5685 (class 0 OID 22825)
-- Dependencies: 484
-- Data for Name: ticket_categories; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--



--
-- TOC entry 5686 (class 0 OID 22831)
-- Dependencies: 485
-- Data for Name: ticket_types; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--



--
-- TOC entry 5687 (class 0 OID 22837)
-- Dependencies: 486
-- Data for Name: tickets; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--



--
-- TOC entry 5689 (class 0 OID 22847)
-- Dependencies: 488
-- Data for Name: user_menu; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--



--
-- TOC entry 5605 (class 0 OID 20311)
-- Dependencies: 376
-- Data for Name: users; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--

INSERT INTO tool_web_lily.users VALUES (1, 'User', 'User', '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, 'super-admin.png', true, NULL, '2022-07-22 12:35:20.740064', NULL);


--
-- TOC entry 5691 (class 0 OID 22856)
-- Dependencies: 490
-- Data for Name: users_groups; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--



--
-- TOC entry 5693 (class 0 OID 22861)
-- Dependencies: 492
-- Data for Name: users_logs; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--

INSERT INTO tool_web_lily.users_logs VALUES (1, '"usid"=>"1", "action"=>"Login"', '2022-07-22 12:43:35.837124');
INSERT INTO tool_web_lily.users_logs VALUES (2, '"usid"=>"1", "action"=>"Logout"', '2022-07-25 06:18:41.737462');
INSERT INTO tool_web_lily.users_logs VALUES (3, '"usid"=>"1", "action"=>"Login"', '2022-07-25 06:18:46.295676');
INSERT INTO tool_web_lily.users_logs VALUES (4, '"usid"=>"1", "action"=>"Logout"', '2022-07-25 06:20:22.442046');
INSERT INTO tool_web_lily.users_logs VALUES (5, '"usid"=>"1", "action"=>"Login"', '2022-07-25 06:21:13.89885');
INSERT INTO tool_web_lily.users_logs VALUES (6, '"usid"=>"1", "action"=>"Logout"', '2022-07-25 07:18:34.232953');
INSERT INTO tool_web_lily.users_logs VALUES (7, '"usid"=>"1", "action"=>"Login"', '2022-07-25 07:18:38.588387');
INSERT INTO tool_web_lily.users_logs VALUES (8, '"usid"=>"1", "action"=>"Logout"', '2022-07-25 07:59:53.779138');
INSERT INTO tool_web_lily.users_logs VALUES (9, '"usid"=>"1", "action"=>"Login"', '2022-07-25 08:00:03.418049');


--
-- TOC entry 5695 (class 0 OID 22870)
-- Dependencies: 494
-- Data for Name: users_settings; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--



--
-- TOC entry 5697 (class 0 OID 22878)
-- Dependencies: 496
-- Data for Name: val_codes; Type: TABLE DATA; Schema: tool_web_lily; Owner: postgres
--



--
-- TOC entry 5701 (class 0 OID 27254)
-- Dependencies: 519
-- Data for Name: warnings_list; Type: TABLE DATA; Schema: warnings; Owner: postgres
--



--
-- TOC entry 6199 (class 0 OID 0)
-- Dependencies: 240
-- Name: calibrations_id_seq; Type: SEQUENCE SET; Schema: calibrations; Owner: postgres
--

SELECT pg_catalog.setval('calibrations.calibrations_id_seq', 1, false);


--
-- TOC entry 6200 (class 0 OID 0)
-- Dependencies: 243
-- Name: daily_reports_id_seq; Type: SEQUENCE SET; Schema: journal; Owner: postgres
--

SELECT pg_catalog.setval('journal.daily_reports_id_seq', 1, false);


--
-- TOC entry 6201 (class 0 OID 0)
-- Dependencies: 245
-- Name: network_maintenances_id_seq; Type: SEQUENCE SET; Schema: journal; Owner: postgres
--

SELECT pg_catalog.setval('journal.network_maintenances_id_seq', 1, false);


--
-- TOC entry 6202 (class 0 OID 0)
-- Dependencies: 247
-- Name: network_problems_id_seq; Type: SEQUENCE SET; Schema: journal; Owner: postgres
--

SELECT pg_catalog.setval('journal.network_problems_id_seq', 1, false);


--
-- TOC entry 6203 (class 0 OID 0)
-- Dependencies: 249
-- Name: network_spare_parts_id_seq; Type: SEQUENCE SET; Schema: journal; Owner: postgres
--

SELECT pg_catalog.setval('journal.network_spare_parts_id_seq', 1, false);


--
-- TOC entry 6204 (class 0 OID 0)
-- Dependencies: 252
-- Name: network_users_id_seq; Type: SEQUENCE SET; Schema: journal; Owner: postgres
--

SELECT pg_catalog.setval('journal.network_users_id_seq', 1, false);


--
-- TOC entry 6205 (class 0 OID 0)
-- Dependencies: 255
-- Name: reports_id_seq; Type: SEQUENCE SET; Schema: journal; Owner: postgres
--

SELECT pg_catalog.setval('journal.reports_id_seq', 1, false);


--
-- TOC entry 6206 (class 0 OID 0)
-- Dependencies: 257
-- Name: reports_pics_id_seq; Type: SEQUENCE SET; Schema: journal; Owner: postgres
--

SELECT pg_catalog.setval('journal.reports_pics_id_seq', 1, false);


--
-- TOC entry 6207 (class 0 OID 0)
-- Dependencies: 267
-- Name: _laboratory_analysis_parameters_lab_pr_id_seq; Type: SEQUENCE SET; Schema: labanalysis; Owner: postgres
--

SELECT pg_catalog.setval('labanalysis._laboratory_analysis_parameters_lab_pr_id_seq', 1, false);


--
-- TOC entry 6208 (class 0 OID 0)
-- Dependencies: 269
-- Name: _laboratory_filter_fi_id_seq; Type: SEQUENCE SET; Schema: labanalysis; Owner: postgres
--

SELECT pg_catalog.setval('labanalysis._laboratory_filter_fi_id_seq', 1, false);


--
-- TOC entry 6209 (class 0 OID 0)
-- Dependencies: 271
-- Name: deposimeters_input_data_id_seq; Type: SEQUENCE SET; Schema: labanalysis; Owner: postgres
--

SELECT pg_catalog.setval('labanalysis.deposimeters_input_data_id_seq', 1, false);


--
-- TOC entry 6210 (class 0 OID 0)
-- Dependencies: 273
-- Name: laboratory_data_id_seq; Type: SEQUENCE SET; Schema: labanalysis; Owner: postgres
--

SELECT pg_catalog.setval('labanalysis.laboratory_data_id_seq', 1, false);


--
-- TOC entry 6211 (class 0 OID 0)
-- Dependencies: 275
-- Name: laboratory_data_white_id_seq; Type: SEQUENCE SET; Schema: labanalysis; Owner: postgres
--

SELECT pg_catalog.setval('labanalysis.laboratory_data_white_id_seq', 1, false);


--
-- TOC entry 6212 (class 0 OID 0)
-- Dependencies: 277
-- Name: laboratory_samples_id_seq; Type: SEQUENCE SET; Schema: labanalysis; Owner: postgres
--

SELECT pg_catalog.setval('labanalysis.laboratory_samples_id_seq', 1, false);


--
-- TOC entry 6213 (class 0 OID 0)
-- Dependencies: 279
-- Name: laboratory_samples_white_id_seq; Type: SEQUENCE SET; Schema: labanalysis; Owner: postgres
--

SELECT pg_catalog.setval('labanalysis.laboratory_samples_white_id_seq', 1, false);


--
-- TOC entry 6214 (class 0 OID 0)
-- Dependencies: 313
-- Name: _groups_parameters_gr_pr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public._groups_parameters_gr_pr_id_seq', 1, false);


--
-- TOC entry 6215 (class 0 OID 0)
-- Dependencies: 316
-- Name: _instruments_parameters_in_pr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public._instruments_parameters_in_pr_id_seq', 1, false);


--
-- TOC entry 6216 (class 0 OID 0)
-- Dependencies: 326
-- Name: _stations_override_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public._stations_override_id_seq', 1, false);


--
-- TOC entry 6217 (class 0 OID 0)
-- Dependencies: 327
-- Name: _stations_parameters_st_pr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public._stations_parameters_st_pr_id_seq', 1, false);


--
-- TOC entry 6218 (class 0 OID 0)
-- Dependencies: 330
-- Name: _users_logins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public._users_logins_id_seq', 1, false);


--
-- TOC entry 6219 (class 0 OID 0)
-- Dependencies: 333
-- Name: _users_us_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public._users_us_id_seq', 1, false);


--
-- TOC entry 6220 (class 0 OID 0)
-- Dependencies: 335
-- Name: codemanager_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.codemanager_id_seq', 1, false);


--
-- TOC entry 6221 (class 0 OID 0)
-- Dependencies: 517
-- Name: builder_stations_alarms_id_seq; Type: SEQUENCE SET; Schema: tool_builder; Owner: postgres
--

SELECT pg_catalog.setval('tool_builder.builder_stations_alarms_id_seq', 1, false);


--
-- TOC entry 6222 (class 0 OID 0)
-- Dependencies: 378
-- Name: calibration_methods_me_id_seq; Type: SEQUENCE SET; Schema: tool_netcom; Owner: postgres
--

SELECT pg_catalog.setval('tool_netcom.calibration_methods_me_id_seq', 1, false);


--
-- TOC entry 6223 (class 0 OID 0)
-- Dependencies: 380
-- Name: calibration_reasons_re_id_seq; Type: SEQUENCE SET; Schema: tool_netcom; Owner: postgres
--

SELECT pg_catalog.setval('tool_netcom.calibration_reasons_re_id_seq', 1, false);


--
-- TOC entry 6224 (class 0 OID 0)
-- Dependencies: 382
-- Name: cylinders_cy_id_seq; Type: SEQUENCE SET; Schema: tool_netcom; Owner: postgres
--

SELECT pg_catalog.setval('tool_netcom.cylinders_cy_id_seq', 1, false);


--
-- TOC entry 6225 (class 0 OID 0)
-- Dependencies: 384
-- Name: data_calibrations_id_seq; Type: SEQUENCE SET; Schema: tool_netcom; Owner: postgres
--

SELECT pg_catalog.setval('tool_netcom.data_calibrations_id_seq', 1, false);


--
-- TOC entry 6226 (class 0 OID 0)
-- Dependencies: 386
-- Name: data_documents_id_seq; Type: SEQUENCE SET; Schema: tool_netcom; Owner: postgres
--

SELECT pg_catalog.setval('tool_netcom.data_documents_id_seq', 1, false);


--
-- TOC entry 6227 (class 0 OID 0)
-- Dependencies: 388
-- Name: data_maintenances_ma_id_seq; Type: SEQUENCE SET; Schema: tool_netcom; Owner: postgres
--

SELECT pg_catalog.setval('tool_netcom.data_maintenances_ma_id_seq', 1, false);


--
-- TOC entry 6228 (class 0 OID 0)
-- Dependencies: 391
-- Name: data_operations_id_seq; Type: SEQUENCE SET; Schema: tool_netcom; Owner: postgres
--

SELECT pg_catalog.setval('tool_netcom.data_operations_id_seq', 1, false);


--
-- TOC entry 6229 (class 0 OID 0)
-- Dependencies: 393
-- Name: data_spare_parts_id_seq; Type: SEQUENCE SET; Schema: tool_netcom; Owner: postgres
--

SELECT pg_catalog.setval('tool_netcom.data_spare_parts_id_seq', 1, false);


--
-- TOC entry 6230 (class 0 OID 0)
-- Dependencies: 395
-- Name: equipments_eq_id_seq; Type: SEQUENCE SET; Schema: tool_netcom; Owner: postgres
--

SELECT pg_catalog.setval('tool_netcom.equipments_eq_id_seq', 1, false);


--
-- TOC entry 6231 (class 0 OID 0)
-- Dependencies: 398
-- Name: instruments_categories_parameters_id_seq; Type: SEQUENCE SET; Schema: tool_netcom; Owner: postgres
--

SELECT pg_catalog.setval('tool_netcom.instruments_categories_parameters_id_seq', 1, false);


--
-- TOC entry 6232 (class 0 OID 0)
-- Dependencies: 399
-- Name: instruments_in_id_seq; Type: SEQUENCE SET; Schema: tool_netcom; Owner: postgres
--

SELECT pg_catalog.setval('tool_netcom.instruments_in_id_seq', 1, false);


--
-- TOC entry 6233 (class 0 OID 0)
-- Dependencies: 402
-- Name: instruments_operations_id_seq; Type: SEQUENCE SET; Schema: tool_netcom; Owner: postgres
--

SELECT pg_catalog.setval('tool_netcom.instruments_operations_id_seq', 1, false);


--
-- TOC entry 6234 (class 0 OID 0)
-- Dependencies: 404
-- Name: instruments_spare_parts_id_seq; Type: SEQUENCE SET; Schema: tool_netcom; Owner: postgres
--

SELECT pg_catalog.setval('tool_netcom.instruments_spare_parts_id_seq', 1, false);


--
-- TOC entry 6235 (class 0 OID 0)
-- Dependencies: 407
-- Name: network_users_id_seq; Type: SEQUENCE SET; Schema: tool_netcom; Owner: postgres
--

SELECT pg_catalog.setval('tool_netcom.network_users_id_seq', 1, false);


--
-- TOC entry 6236 (class 0 OID 0)
-- Dependencies: 412
-- Name: raw_data_calibrations_calib_id_seq; Type: SEQUENCE SET; Schema: tool_netcom; Owner: postgres
--

SELECT pg_catalog.setval('tool_netcom.raw_data_calibrations_calib_id_seq', 1, false);


--
-- TOC entry 6237 (class 0 OID 0)
-- Dependencies: 416
-- Name: stations_calibrators_st_ca_id_seq; Type: SEQUENCE SET; Schema: tool_netcom; Owner: postgres
--

SELECT pg_catalog.setval('tool_netcom.stations_calibrators_st_ca_id_seq', 1, false);


--
-- TOC entry 6238 (class 0 OID 0)
-- Dependencies: 418
-- Name: stations_cylinders_st_cy_id_seq; Type: SEQUENCE SET; Schema: tool_netcom; Owner: postgres
--

SELECT pg_catalog.setval('tool_netcom.stations_cylinders_st_cy_id_seq', 1, false);


--
-- TOC entry 6239 (class 0 OID 0)
-- Dependencies: 420
-- Name: stations_equipments_st_eq_id_seq; Type: SEQUENCE SET; Schema: tool_netcom; Owner: postgres
--

SELECT pg_catalog.setval('tool_netcom.stations_equipments_st_eq_id_seq', 1, false);


--
-- TOC entry 6240 (class 0 OID 0)
-- Dependencies: 422
-- Name: stations_instruments_st_in_id_seq; Type: SEQUENCE SET; Schema: tool_netcom; Owner: postgres
--

SELECT pg_catalog.setval('tool_netcom.stations_instruments_st_in_id_seq', 1, false);


--
-- TOC entry 6241 (class 0 OID 0)
-- Dependencies: 455
-- Name: pages_groups_gr_id_seq; Type: SEQUENCE SET; Schema: tool_visualizer_lily; Owner: postgres
--

SELECT pg_catalog.setval('tool_visualizer_lily.pages_groups_gr_id_seq', 1, false);


--
-- TOC entry 6242 (class 0 OID 0)
-- Dependencies: 457
-- Name: pages_pg_id_seq; Type: SEQUENCE SET; Schema: tool_visualizer_lily; Owner: postgres
--

SELECT pg_catalog.setval('tool_visualizer_lily.pages_pg_id_seq', 1, false);


--
-- TOC entry 6243 (class 0 OID 0)
-- Dependencies: 459
-- Name: pages_windows_wd_id_seq; Type: SEQUENCE SET; Schema: tool_visualizer_lily; Owner: postgres
--

SELECT pg_catalog.setval('tool_visualizer_lily.pages_windows_wd_id_seq', 1, false);


--
-- TOC entry 6244 (class 0 OID 0)
-- Dependencies: 466
-- Name: group_stations_gs_id_seq; Type: SEQUENCE SET; Schema: tool_web_lily; Owner: postgres
--

SELECT pg_catalog.setval('tool_web_lily.group_stations_gs_id_seq', 1, false);


--
-- TOC entry 6245 (class 0 OID 0)
-- Dependencies: 469
-- Name: labanalysis_files_file_id_seq; Type: SEQUENCE SET; Schema: tool_web_lily; Owner: postgres
--

SELECT pg_catalog.setval('tool_web_lily.labanalysis_files_file_id_seq', 1, false);


--
-- TOC entry 6246 (class 0 OID 0)
-- Dependencies: 471
-- Name: memo_participants_me_pa_id_seq; Type: SEQUENCE SET; Schema: tool_web_lily; Owner: postgres
--

SELECT pg_catalog.setval('tool_web_lily.memo_participants_me_pa_id_seq', 1, false);


--
-- TOC entry 6247 (class 0 OID 0)
-- Dependencies: 473
-- Name: memos_me_id_seq; Type: SEQUENCE SET; Schema: tool_web_lily; Owner: postgres
--

SELECT pg_catalog.setval('tool_web_lily.memos_me_id_seq', 1, false);


--
-- TOC entry 6248 (class 0 OID 0)
-- Dependencies: 476
-- Name: participants_pa_id_seq; Type: SEQUENCE SET; Schema: tool_web_lily; Owner: postgres
--

SELECT pg_catalog.setval('tool_web_lily.participants_pa_id_seq', 1, false);


--
-- TOC entry 6249 (class 0 OID 0)
-- Dependencies: 479
-- Name: surveys_attachements_attachement_id_seq; Type: SEQUENCE SET; Schema: tool_web_lily; Owner: postgres
--

SELECT pg_catalog.setval('tool_web_lily.surveys_attachements_attachement_id_seq', 1, false);


--
-- TOC entry 6250 (class 0 OID 0)
-- Dependencies: 480
-- Name: surveys_su_id_seq; Type: SEQUENCE SET; Schema: tool_web_lily; Owner: postgres
--

SELECT pg_catalog.setval('tool_web_lily.surveys_su_id_seq', 1, false);


--
-- TOC entry 6251 (class 0 OID 0)
-- Dependencies: 483
-- Name: tasks_ta_id_seq; Type: SEQUENCE SET; Schema: tool_web_lily; Owner: postgres
--

SELECT pg_catalog.setval('tool_web_lily.tasks_ta_id_seq', 1, false);


--
-- TOC entry 6252 (class 0 OID 0)
-- Dependencies: 487
-- Name: tickets_tk_id_seq; Type: SEQUENCE SET; Schema: tool_web_lily; Owner: postgres
--

SELECT pg_catalog.setval('tool_web_lily.tickets_tk_id_seq', 1, false);


--
-- TOC entry 6253 (class 0 OID 0)
-- Dependencies: 489
-- Name: user_menu_id_seq; Type: SEQUENCE SET; Schema: tool_web_lily; Owner: postgres
--

SELECT pg_catalog.setval('tool_web_lily.user_menu_id_seq', 1, false);


--
-- TOC entry 6254 (class 0 OID 0)
-- Dependencies: 491
-- Name: users_groups_us_gr_id_seq; Type: SEQUENCE SET; Schema: tool_web_lily; Owner: postgres
--

SELECT pg_catalog.setval('tool_web_lily.users_groups_us_gr_id_seq', 1, false);


--
-- TOC entry 6255 (class 0 OID 0)
-- Dependencies: 493
-- Name: users_logs_id_seq; Type: SEQUENCE SET; Schema: tool_web_lily; Owner: postgres
--

SELECT pg_catalog.setval('tool_web_lily.users_logs_id_seq', 9, true);


--
-- TOC entry 6256 (class 0 OID 0)
-- Dependencies: 495
-- Name: users_us_id_seq; Type: SEQUENCE SET; Schema: tool_web_lily; Owner: postgres
--

SELECT pg_catalog.setval('tool_web_lily.users_us_id_seq', 1, true);


--
-- TOC entry 4818 (class 2606 OID 23613)
-- Name: cal_methods cal_methods_pkey; Type: CONSTRAINT; Schema: calibrations; Owner: postgres
--

ALTER TABLE ONLY calibrations.cal_methods
    ADD CONSTRAINT cal_methods_pkey PRIMARY KEY (me_id);


--
-- TOC entry 4820 (class 2606 OID 23615)
-- Name: cal_reasons cal_reasons_pkey; Type: CONSTRAINT; Schema: calibrations; Owner: postgres
--

ALTER TABLE ONLY calibrations.cal_reasons
    ADD CONSTRAINT cal_reasons_pkey PRIMARY KEY (re_id);


--
-- TOC entry 4822 (class 2606 OID 23617)
-- Name: calibrations calibrations_calibrations_pkey; Type: CONSTRAINT; Schema: calibrations; Owner: postgres
--

ALTER TABLE ONLY calibrations.calibrations
    ADD CONSTRAINT calibrations_calibrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4825 (class 2606 OID 23633)
-- Name: daily_reports journal_daily_reports_pkey; Type: CONSTRAINT; Schema: journal; Owner: postgres
--

ALTER TABLE ONLY journal.daily_reports
    ADD CONSTRAINT journal_daily_reports_pkey PRIMARY KEY (id);


--
-- TOC entry 4827 (class 2606 OID 23635)
-- Name: network_maintenances journal_network_maintenances_pkey; Type: CONSTRAINT; Schema: journal; Owner: postgres
--

ALTER TABLE ONLY journal.network_maintenances
    ADD CONSTRAINT journal_network_maintenances_pkey PRIMARY KEY (id);


--
-- TOC entry 4829 (class 2606 OID 23637)
-- Name: network_problems journal_network_problems_pkey; Type: CONSTRAINT; Schema: journal; Owner: postgres
--

ALTER TABLE ONLY journal.network_problems
    ADD CONSTRAINT journal_network_problems_pkey PRIMARY KEY (id);


--
-- TOC entry 4831 (class 2606 OID 23639)
-- Name: network_spare_parts journal_network_spare_parts_pkey; Type: CONSTRAINT; Schema: journal; Owner: postgres
--

ALTER TABLE ONLY journal.network_spare_parts
    ADD CONSTRAINT journal_network_spare_parts_pkey PRIMARY KEY (id);


--
-- TOC entry 4833 (class 2606 OID 23641)
-- Name: network_stations journal_network_stations_pkey; Type: CONSTRAINT; Schema: journal; Owner: postgres
--

ALTER TABLE ONLY journal.network_stations
    ADD CONSTRAINT journal_network_stations_pkey PRIMARY KEY (st_id);


--
-- TOC entry 4835 (class 2606 OID 23643)
-- Name: network_users journal_network_users_pkey; Type: CONSTRAINT; Schema: journal; Owner: postgres
--

ALTER TABLE ONLY journal.network_users
    ADD CONSTRAINT journal_network_users_pkey PRIMARY KEY (id);


--
-- TOC entry 4837 (class 2606 OID 23645)
-- Name: reports journal_reports_pkey; Type: CONSTRAINT; Schema: journal; Owner: postgres
--

ALTER TABLE ONLY journal.reports
    ADD CONSTRAINT journal_reports_pkey PRIMARY KEY (id);


--
-- TOC entry 4839 (class 2606 OID 23647)
-- Name: reports journal_reports_ukey1; Type: CONSTRAINT; Schema: journal; Owner: postgres
--

ALTER TABLE ONLY journal.reports
    ADD CONSTRAINT journal_reports_ukey1 UNIQUE (year, rp_id, us_id);


--
-- TOC entry 4841 (class 2606 OID 23649)
-- Name: reports_pics reports_pics_pkey; Type: CONSTRAINT; Schema: journal; Owner: postgres
--

ALTER TABLE ONLY journal.reports_pics
    ADD CONSTRAINT reports_pics_pkey PRIMARY KEY (id);


--
-- TOC entry 4850 (class 2606 OID 23651)
-- Name: _laboratory_analysis_parameters _laboratory_analysis_parameters_pkey; Type: CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis._laboratory_analysis_parameters
    ADD CONSTRAINT _laboratory_analysis_parameters_pkey PRIMARY KEY (lab_pr_id);

ALTER TABLE labanalysis._laboratory_analysis_parameters CLUSTER ON _laboratory_analysis_parameters_pkey;


--
-- TOC entry 4852 (class 2606 OID 23653)
-- Name: _laboratory_analysis_parameters _laboratory_analysis_parameters_ukey; Type: CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis._laboratory_analysis_parameters
    ADD CONSTRAINT _laboratory_analysis_parameters_ukey UNIQUE (an_id, pr_id);


--
-- TOC entry 4847 (class 2606 OID 23655)
-- Name: _laboratory_analysis _laboratory_analysis_pkey; Type: CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis._laboratory_analysis
    ADD CONSTRAINT _laboratory_analysis_pkey PRIMARY KEY (an_id);

ALTER TABLE labanalysis._laboratory_analysis CLUSTER ON _laboratory_analysis_pkey;


--
-- TOC entry 4854 (class 2606 OID 23657)
-- Name: _laboratory_filter _laboratory_filter_pkey; Type: CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis._laboratory_filter
    ADD CONSTRAINT _laboratory_filter_pkey PRIMARY KEY (fi_id);

ALTER TABLE labanalysis._laboratory_filter CLUSTER ON _laboratory_filter_pkey;


--
-- TOC entry 4856 (class 2606 OID 23659)
-- Name: deposimeters_input_data labanalysis_deposimeters_input_data_pkey; Type: CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.deposimeters_input_data
    ADD CONSTRAINT labanalysis_deposimeters_input_data_pkey PRIMARY KEY (sp_id, lab_pr_id);


--
-- TOC entry 4864 (class 2606 OID 23661)
-- Name: laboratory_data_white labanalysis_laboratory_data_white_pkey; Type: CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.laboratory_data_white
    ADD CONSTRAINT labanalysis_laboratory_data_white_pkey PRIMARY KEY (sp_id, lab_pr_id);


--
-- TOC entry 4874 (class 2606 OID 23663)
-- Name: laboratory_samples_white labanalysis_laboratory_samples_white_pkey; Type: CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.laboratory_samples_white
    ADD CONSTRAINT labanalysis_laboratory_samples_white_pkey PRIMARY KEY (sp_id);


--
-- TOC entry 4860 (class 2606 OID 23665)
-- Name: laboratory_data laboratory_data_pkey; Type: CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.laboratory_data
    ADD CONSTRAINT laboratory_data_pkey PRIMARY KEY (sp_id, lab_pr_id);

ALTER TABLE labanalysis.laboratory_data CLUSTER ON laboratory_data_pkey;


--
-- TOC entry 4869 (class 2606 OID 23667)
-- Name: laboratory_samples laboratory_samples_pkey; Type: CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.laboratory_samples
    ADD CONSTRAINT laboratory_samples_pkey PRIMARY KEY (sp_id);

ALTER TABLE labanalysis.laboratory_samples CLUSTER ON laboratory_samples_pkey;


--
-- TOC entry 4876 (class 2606 OID 23669)
-- Name: users_laboratory_analysis users_laboratory_analysis_pkey; Type: CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.users_laboratory_analysis
    ADD CONSTRAINT users_laboratory_analysis_pkey PRIMARY KEY (us_id, an_id);

ALTER TABLE labanalysis.users_laboratory_analysis CLUSTER ON users_laboratory_analysis_pkey;


--
-- TOC entry 4843 (class 2606 OID 23671)
-- Name: station_networktype _station_networktype_pkey; Type: CONSTRAINT; Schema: metadata; Owner: postgres
--

ALTER TABLE ONLY metadata.station_networktype
    ADD CONSTRAINT _station_networktype_pkey PRIMARY KEY (id);


--
-- TOC entry 4845 (class 2606 OID 23673)
-- Name: station_typology _station_typology_pkey; Type: CONSTRAINT; Schema: metadata; Owner: postgres
--

ALTER TABLE ONLY metadata.station_typology
    ADD CONSTRAINT _station_typology_pkey PRIMARY KEY (id);

ALTER TABLE metadata.station_typology CLUSTER ON _station_typology_pkey;


--
-- TOC entry 4800 (class 2606 OID 23675)
-- Name: stations_metadata _stations_metadata_pkey; Type: CONSTRAINT; Schema: metadata; Owner: postgres
--

ALTER TABLE ONLY metadata.stations_metadata
    ADD CONSTRAINT _stations_metadata_pkey PRIMARY KEY (st_id);

ALTER TABLE metadata.stations_metadata CLUSTER ON _stations_metadata_pkey;


--
-- TOC entry 4878 (class 2606 OID 23677)
-- Name: station_type station_type_pkey; Type: CONSTRAINT; Schema: metadata; Owner: postgres
--

ALTER TABLE ONLY metadata.station_type
    ADD CONSTRAINT station_type_pkey PRIMARY KEY (id);


--
-- TOC entry 4880 (class 2606 OID 23679)
-- Name: station_zone station_zone_pkey; Type: CONSTRAINT; Schema: metadata; Owner: postgres
--

ALTER TABLE ONLY metadata.station_zone
    ADD CONSTRAINT station_zone_pkey PRIMARY KEY (id);


--
-- TOC entry 4802 (class 2606 OID 23681)
-- Name: stations_metadata_extended stations_metadata_extended_pkey; Type: CONSTRAINT; Schema: metadata; Owner: postgres
--

ALTER TABLE ONLY metadata.stations_metadata_extended
    ADD CONSTRAINT stations_metadata_extended_pkey PRIMARY KEY (st_id);


--
-- TOC entry 4882 (class 2606 OID 23683)
-- Name: stations_metadata_info stations_metadata_info_pkey; Type: CONSTRAINT; Schema: metadata; Owner: postgres
--

ALTER TABLE ONLY metadata.stations_metadata_info
    ADD CONSTRAINT stations_metadata_info_pkey PRIMARY KEY (st_id);


--
-- TOC entry 4884 (class 2606 OID 23685)
-- Name: stations_metadata_instruments stations_metadata_instruments_pkey; Type: CONSTRAINT; Schema: metadata; Owner: postgres
--

ALTER TABLE ONLY metadata.stations_metadata_instruments
    ADD CONSTRAINT stations_metadata_instruments_pkey PRIMARY KEY (st_id);


--
-- TOC entry 4886 (class 2606 OID 23687)
-- Name: stations_metadata_pictures_maps stations_metadata_pictures_maps_pkey; Type: CONSTRAINT; Schema: metadata; Owner: postgres
--

ALTER TABLE ONLY metadata.stations_metadata_pictures_maps
    ADD CONSTRAINT stations_metadata_pictures_maps_pkey PRIMARY KEY (st_id);


--
-- TOC entry 4912 (class 2606 OID 23689)
-- Name: ricambi _Ricambi_pkey; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.ricambi
    ADD CONSTRAINT "_Ricambi_pkey" PRIMARY KEY (ri_id);

ALTER TABLE operations.ricambi CLUSTER ON "_Ricambi_pkey";


--
-- TOC entry 4890 (class 2606 OID 23691)
-- Name: cylinders_parameters _cylinders_parameters_pkey; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.cylinders_parameters
    ADD CONSTRAINT _cylinders_parameters_pkey PRIMARY KEY (cy_id, pr_id);


--
-- TOC entry 4888 (class 2606 OID 23693)
-- Name: cylinders _cylinders_pkey; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.cylinders
    ADD CONSTRAINT _cylinders_pkey PRIMARY KEY (cy_id);


--
-- TOC entry 4898 (class 2606 OID 23695)
-- Name: instruments_type_category _instruments_category_pkey; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.instruments_type_category
    ADD CONSTRAINT _instruments_category_pkey PRIMARY KEY (ct_id);


--
-- TOC entry 4892 (class 2606 OID 23697)
-- Name: instruments _instruments_pkey; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.instruments
    ADD CONSTRAINT _instruments_pkey PRIMARY KEY (arpa_id);

ALTER TABLE operations.instruments CLUSTER ON _instruments_pkey;


--
-- TOC entry 4894 (class 2606 OID 23699)
-- Name: instruments_has_ricambi _instruments_ricambi_pkey; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.instruments_has_ricambi
    ADD CONSTRAINT _instruments_ricambi_pkey PRIMARY KEY (arpa_id, ri_id);


--
-- TOC entry 4900 (class 2606 OID 23701)
-- Name: instruments_type_has_operations _instruments_type_has_operations_pkey; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.instruments_type_has_operations
    ADD CONSTRAINT _instruments_type_has_operations_pkey PRIMARY KEY (tp_in_id, op_id);

ALTER TABLE operations.instruments_type_has_operations CLUSTER ON _instruments_type_has_operations_pkey;


--
-- TOC entry 4902 (class 2606 OID 23703)
-- Name: instruments_type_has_parameters _instruments_type_has_parameters_pkey; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.instruments_type_has_parameters
    ADD CONSTRAINT _instruments_type_has_parameters_pkey PRIMARY KEY (pr_id);


--
-- TOC entry 4896 (class 2606 OID 23705)
-- Name: instruments_type _instruments_type_pkey; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.instruments_type
    ADD CONSTRAINT _instruments_type_pkey PRIMARY KEY (tp_in_id);


--
-- TOC entry 4904 (class 2606 OID 23707)
-- Name: operations _operations_pkey; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.operations
    ADD CONSTRAINT _operations_pkey PRIMARY KEY (op_id);

ALTER TABLE operations.operations CLUSTER ON _operations_pkey;


--
-- TOC entry 4910 (class 2606 OID 23709)
-- Name: operations_type _operations_type_pkey; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.operations_type
    ADD CONSTRAINT _operations_type_pkey PRIMARY KEY (tp_op_id);

ALTER TABLE operations.operations_type CLUSTER ON _operations_type_pkey;


--
-- TOC entry 4916 (class 2606 OID 23711)
-- Name: stations_has_instruments _stations_has__instruments_pkey; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.stations_has_instruments
    ADD CONSTRAINT _stations_has__instruments_pkey PRIMARY KEY (st_id, arpa_id, fl_utilizzo, d_dal);


--
-- TOC entry 4908 (class 2606 OID 23713)
-- Name: operations_data operations_data_pkey; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.operations_data
    ADD CONSTRAINT operations_data_pkey PRIMARY KEY (fulldate, st_id, pr_id, op_id, fl_utilizzo);


--
-- TOC entry 4914 (class 2606 OID 23715)
-- Name: ricambi_data ricambi_data_pkey; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.ricambi_data
    ADD CONSTRAINT ricambi_data_pkey PRIMARY KEY (fulldate, arpa_id, ri_id);


--
-- TOC entry 4906 (class 2606 OID 23717)
-- Name: operations unique_operations; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.operations
    ADD CONSTRAINT unique_operations UNIQUE (tp_op_id, descrizione);


--
-- TOC entry 4918 (class 2606 OID 23719)
-- Name: __versions __version_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.__versions
    ADD CONSTRAINT __version_pkey PRIMARY KEY (id);

ALTER TABLE public.__versions CLUSTER ON __version_pkey;


--
-- TOC entry 4920 (class 2606 OID 23721)
-- Name: _groups_list _groups_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._groups_list
    ADD CONSTRAINT _groups_list_pkey PRIMARY KEY (gr_id);


--
-- TOC entry 4922 (class 2606 OID 23723)
-- Name: _groups_list _groups_list_ukey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._groups_list
    ADD CONSTRAINT _groups_list_ukey UNIQUE (gr_name);


--
-- TOC entry 4924 (class 2606 OID 23725)
-- Name: _groups_parameters _groups_parameters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._groups_parameters
    ADD CONSTRAINT _groups_parameters_pkey PRIMARY KEY (gr_pr_id);


--
-- TOC entry 4926 (class 2606 OID 23727)
-- Name: _groups_parameters _groups_parameters_ukey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._groups_parameters
    ADD CONSTRAINT _groups_parameters_ukey UNIQUE (gr_id, pr_id);


--
-- TOC entry 4928 (class 2606 OID 23729)
-- Name: _instruments_list _instruments_list_instr_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._instruments_list
    ADD CONSTRAINT _instruments_list_instr_name_key UNIQUE (instr_name);


--
-- TOC entry 4930 (class 2606 OID 23731)
-- Name: _instruments_list _instruments_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._instruments_list
    ADD CONSTRAINT _instruments_list_pkey PRIMARY KEY (in_id);


--
-- TOC entry 4932 (class 2606 OID 23733)
-- Name: _instruments_parameters _instruments_parameters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._instruments_parameters
    ADD CONSTRAINT _instruments_parameters_pkey PRIMARY KEY (in_pr_id);


--
-- TOC entry 4934 (class 2606 OID 23735)
-- Name: _log_type _log_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._log_type
    ADD CONSTRAINT _log_type_pkey PRIMARY KEY (id);

ALTER TABLE public._log_type CLUSTER ON _log_type_pkey;


--
-- TOC entry 4941 (class 2606 OID 23737)
-- Name: _master_1 _master_1_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._master_1
    ADD CONSTRAINT _master_1_pkey PRIMARY KEY (fulldate);


--
-- TOC entry 4943 (class 2606 OID 23739)
-- Name: _master_30 _master_30_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._master_30
    ADD CONSTRAINT _master_30_pkey PRIMARY KEY (fulldate);


--
-- TOC entry 4939 (class 2606 OID 23741)
-- Name: _master _master_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._master
    ADD CONSTRAINT _master_pkey PRIMARY KEY (fulldate);

ALTER TABLE public._master CLUSTER ON _master_pkey;


--
-- TOC entry 4945 (class 2606 OID 23743)
-- Name: _parameter_treatment _parameter_treatment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._parameter_treatment
    ADD CONSTRAINT _parameter_treatment_pkey PRIMARY KEY (id);

ALTER TABLE public._parameter_treatment CLUSTER ON _parameter_treatment_pkey;


--
-- TOC entry 4947 (class 2606 OID 23745)
-- Name: _parameters_formules _parameters_formules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._parameters_formules
    ADD CONSTRAINT _parameters_formules_pkey PRIMARY KEY (st_pr_id);

ALTER TABLE public._parameters_formules CLUSTER ON _parameters_formules_pkey;


--
-- TOC entry 4805 (class 2606 OID 23747)
-- Name: _parameters_list_master _parameters_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._parameters_list_master
    ADD CONSTRAINT _parameters_list_pkey PRIMARY KEY (pr_id);

ALTER TABLE public._parameters_list_master CLUSTER ON _parameters_list_pkey;


--
-- TOC entry 4949 (class 2606 OID 23749)
-- Name: _station_roaming_type _station_roaming_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._station_roaming_type
    ADD CONSTRAINT _station_roaming_type_pkey PRIMARY KEY (id);

ALTER TABLE public._station_roaming_type CLUSTER ON _station_roaming_type_pkey;


--
-- TOC entry 4816 (class 2606 OID 23751)
-- Name: _stations_override _stations_override_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._stations_override
    ADD CONSTRAINT _stations_override_pkey PRIMARY KEY (st_id, datefrom);

ALTER TABLE public._stations_override CLUSTER ON _stations_override_pkey;


--
-- TOC entry 4809 (class 2606 OID 23753)
-- Name: _stations_parameters_master _stations_parameters_master_st_id_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._stations_parameters_master
    ADD CONSTRAINT _stations_parameters_master_st_id_id_unique UNIQUE (st_id, id);


--
-- TOC entry 4811 (class 2606 OID 23755)
-- Name: _stations_parameters_master _stations_parameters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._stations_parameters_master
    ADD CONSTRAINT _stations_parameters_pkey PRIMARY KEY (st_pr_id);

ALTER TABLE public._stations_parameters_master CLUSTER ON _stations_parameters_pkey;


--
-- TOC entry 4796 (class 2606 OID 23757)
-- Name: _stations _stations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._stations
    ADD CONSTRAINT _stations_pkey PRIMARY KEY (st_id);

ALTER TABLE public._stations CLUSTER ON _stations_pkey;


--
-- TOC entry 4954 (class 2606 OID 23759)
-- Name: _users_logins _users_logins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._users_logins
    ADD CONSTRAINT _users_logins_pkey PRIMARY KEY (id);

ALTER TABLE public._users_logins CLUSTER ON _users_logins_pkey;


--
-- TOC entry 4956 (class 2606 OID 23761)
-- Name: _users_parameters _users_parameters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._users_parameters
    ADD CONSTRAINT _users_parameters_pkey PRIMARY KEY (us_id, pr_id);

ALTER TABLE public._users_parameters CLUSTER ON _users_parameters_pkey;


--
-- TOC entry 4951 (class 2606 OID 23763)
-- Name: _users _users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._users
    ADD CONSTRAINT _users_pkey PRIMARY KEY (us_id);

ALTER TABLE public._users CLUSTER ON _users_pkey;


--
-- TOC entry 4958 (class 2606 OID 23765)
-- Name: _users_stations _users_stations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._users_stations
    ADD CONSTRAINT _users_stations_pkey PRIMARY KEY (us_id, st_id);

ALTER TABLE public._users_stations CLUSTER ON _users_stations_pkey;


--
-- TOC entry 4960 (class 2606 OID 23767)
-- Name: codemanager codemanager_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.codemanager
    ADD CONSTRAINT codemanager_pkey PRIMARY KEY (id);


--
-- TOC entry 4962 (class 2606 OID 23769)
-- Name: codemanager codemanager_ukey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.codemanager
    ADD CONSTRAINT codemanager_ukey UNIQUE (st_id, table_id);


--
-- TOC entry 4972 (class 2606 OID 23913)
-- Name: data_plouves data_plouves_pkey; Type: CONSTRAINT; Schema: tables_ar; Owner: postgres
--

ALTER TABLE ONLY tables_ar.data_plouves
    ADD CONSTRAINT data_plouves_pkey PRIMARY KEY (fulldate, id);


--
-- TOC entry 5036 (class 2606 OID 24587)
-- Name: result_data_calibrations result_data_calibrations_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.result_data_calibrations
    ADD CONSTRAINT result_data_calibrations_pkey PRIMARY KEY (calib_id, fulldate, st_id, id, type, step);


--
-- TOC entry 4974 (class 2606 OID 24589)
-- Name: data_calibrations tool_netcom_data_calibrations_ukey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_calibrations
    ADD CONSTRAINT tool_netcom_data_calibrations_ukey UNIQUE (st_id, arpa_id, fulldate);


--
-- TOC entry 4994 (class 2606 OID 24591)
-- Name: data_documents tool_netcom_data_documents_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_documents
    ADD CONSTRAINT tool_netcom_data_documents_pkey PRIMARY KEY (id);


--
-- TOC entry 4996 (class 2606 OID 24593)
-- Name: data_documents tool_netcom_data_documents_ukey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_documents
    ADD CONSTRAINT tool_netcom_data_documents_ukey UNIQUE (filename);


--
-- TOC entry 5004 (class 2606 OID 24595)
-- Name: equipments tool_netcom_equipments_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.equipments
    ADD CONSTRAINT tool_netcom_equipments_pkey PRIMARY KEY (eq_id);


--
-- TOC entry 5006 (class 2606 OID 24597)
-- Name: equipments tool_netcom_equipments_ukey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.equipments
    ADD CONSTRAINT tool_netcom_equipments_ukey UNIQUE (arpa_id);


--
-- TOC entry 5024 (class 2606 OID 24599)
-- Name: network_users tool_netcom_network_users_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.network_users
    ADD CONSTRAINT tool_netcom_network_users_pkey PRIMARY KEY (id);


--
-- TOC entry 5034 (class 2606 OID 24601)
-- Name: raw_data_calibrations tool_netcom_raw_data_calibrations_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.raw_data_calibrations
    ADD CONSTRAINT tool_netcom_raw_data_calibrations_pkey PRIMARY KEY (calib_id, fulldate, st_id, id);


--
-- TOC entry 5040 (class 2606 OID 24603)
-- Name: stations_calibrators tool_netcom_stations_calibrators_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.stations_calibrators
    ADD CONSTRAINT tool_netcom_stations_calibrators_pkey PRIMARY KEY (arpa_id, st_id);


--
-- TOC entry 5042 (class 2606 OID 24605)
-- Name: stations_cylinders tool_netcom_stations_cylinders_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.stations_cylinders
    ADD CONSTRAINT tool_netcom_stations_cylinders_pkey PRIMARY KEY (arpa_id, st_id);


--
-- TOC entry 5044 (class 2606 OID 24607)
-- Name: stations_equipments tool_netcom_stations_equipments_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.stations_equipments
    ADD CONSTRAINT tool_netcom_stations_equipments_pkey PRIMARY KEY (st_eq_id);


--
-- TOC entry 5046 (class 2606 OID 24609)
-- Name: stations_equipments tool_netcom_stations_equipments_ukey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.stations_equipments
    ADD CONSTRAINT tool_netcom_stations_equipments_ukey UNIQUE (st_id, eq_id);


--
-- TOC entry 4986 (class 2606 OID 24611)
-- Name: calibration_methods tool_netcom_v2_calibration_methods_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.calibration_methods
    ADD CONSTRAINT tool_netcom_v2_calibration_methods_pkey PRIMARY KEY (me_id);


--
-- TOC entry 4988 (class 2606 OID 24613)
-- Name: calibration_reasons tool_netcom_v2_calibration_reasons_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.calibration_reasons
    ADD CONSTRAINT tool_netcom_v2_calibration_reasons_pkey PRIMARY KEY (re_id);


--
-- TOC entry 4990 (class 2606 OID 24615)
-- Name: cylinders tool_netcom_v2_cylinders_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.cylinders
    ADD CONSTRAINT tool_netcom_v2_cylinders_pkey PRIMARY KEY (cy_id);


--
-- TOC entry 4992 (class 2606 OID 24617)
-- Name: cylinders tool_netcom_v2_cylinders_ukey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.cylinders
    ADD CONSTRAINT tool_netcom_v2_cylinders_ukey UNIQUE (arpa_id);


--
-- TOC entry 4976 (class 2606 OID 24619)
-- Name: data_calibrations tool_netcom_v2_data_calibrations_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_calibrations
    ADD CONSTRAINT tool_netcom_v2_data_calibrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4998 (class 2606 OID 24621)
-- Name: data_maintenances tool_netcom_v2_data_maintenances_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_maintenances
    ADD CONSTRAINT tool_netcom_v2_data_maintenances_pkey PRIMARY KEY (ma_id);


--
-- TOC entry 5000 (class 2606 OID 24623)
-- Name: data_operations tool_netcom_v2_data_operations_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_operations
    ADD CONSTRAINT tool_netcom_v2_data_operations_pkey PRIMARY KEY (id);


--
-- TOC entry 5002 (class 2606 OID 24625)
-- Name: data_spare_parts tool_netcom_v2_data_spare_parts_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_spare_parts
    ADD CONSTRAINT tool_netcom_v2_data_spare_parts_pkey PRIMARY KEY (id);


--
-- TOC entry 5008 (class 2606 OID 24627)
-- Name: instrument_categories tool_netcom_v2_instrument_categories_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instrument_categories
    ADD CONSTRAINT tool_netcom_v2_instrument_categories_pkey PRIMARY KEY (in_ca_id);


--
-- TOC entry 5010 (class 2606 OID 24629)
-- Name: instruments_categories_parameters tool_netcom_v2_instruments_categories_parameters_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments_categories_parameters
    ADD CONSTRAINT tool_netcom_v2_instruments_categories_parameters_pkey PRIMARY KEY (id);


--
-- TOC entry 5012 (class 2606 OID 24631)
-- Name: instruments_categories_parameters tool_netcom_v2_instruments_categories_parameters_ukey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments_categories_parameters
    ADD CONSTRAINT tool_netcom_v2_instruments_categories_parameters_ukey UNIQUE (in_ca_id, pr_id);


--
-- TOC entry 5014 (class 2606 OID 24633)
-- Name: instruments_metadata tool_netcom_v2_instruments_metadata_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments_metadata
    ADD CONSTRAINT tool_netcom_v2_instruments_metadata_pkey PRIMARY KEY (arpa_id);


--
-- TOC entry 5016 (class 2606 OID 24635)
-- Name: instruments_operations tool_netcom_v2_instruments_operations_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments_operations
    ADD CONSTRAINT tool_netcom_v2_instruments_operations_pkey PRIMARY KEY (id);


--
-- TOC entry 5018 (class 2606 OID 24637)
-- Name: instruments_operations tool_netcom_v2_instruments_operations_ukey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments_operations
    ADD CONSTRAINT tool_netcom_v2_instruments_operations_ukey UNIQUE (in_ty_id, op_id);


--
-- TOC entry 4978 (class 2606 OID 24639)
-- Name: instruments tool_netcom_v2_instruments_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments
    ADD CONSTRAINT tool_netcom_v2_instruments_pkey PRIMARY KEY (in_id);


--
-- TOC entry 5020 (class 2606 OID 24641)
-- Name: instruments_spare_parts tool_netcom_v2_instruments_spare_parts_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments_spare_parts
    ADD CONSTRAINT tool_netcom_v2_instruments_spare_parts_pkey PRIMARY KEY (id);


--
-- TOC entry 5022 (class 2606 OID 24643)
-- Name: instruments_types tool_netcom_v2_instruments_types_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments_types
    ADD CONSTRAINT tool_netcom_v2_instruments_types_pkey PRIMARY KEY (in_ty_id);


--
-- TOC entry 4980 (class 2606 OID 24645)
-- Name: instruments tool_netcom_v2_instruments_ukey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments
    ADD CONSTRAINT tool_netcom_v2_instruments_ukey UNIQUE (arpa_id);


--
-- TOC entry 5026 (class 2606 OID 24647)
-- Name: operation_category tool_netcom_v2_operation_category_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.operation_category
    ADD CONSTRAINT tool_netcom_v2_operation_category_pkey PRIMARY KEY (op_ca_id);


--
-- TOC entry 5028 (class 2606 OID 24649)
-- Name: operation_frequency tool_netcom_v2_operation_frequency_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.operation_frequency
    ADD CONSTRAINT tool_netcom_v2_operation_frequency_pkey PRIMARY KEY (op_fr_id);


--
-- TOC entry 5030 (class 2606 OID 24651)
-- Name: operations tool_netcom_v2_operations_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.operations
    ADD CONSTRAINT tool_netcom_v2_operations_pkey PRIMARY KEY (op_id);


--
-- TOC entry 5032 (class 2606 OID 24653)
-- Name: operations tool_netcom_v2_operations_ukey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.operations
    ADD CONSTRAINT tool_netcom_v2_operations_ukey UNIQUE (op_ca_id, op_fr_id, description);


--
-- TOC entry 5038 (class 2606 OID 24655)
-- Name: spare_parts tool_netcom_v2_spare_parts_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.spare_parts
    ADD CONSTRAINT tool_netcom_v2_spare_parts_pkey PRIMARY KEY (sp_id);


--
-- TOC entry 5048 (class 2606 OID 24657)
-- Name: stations_instruments tool_netcom_v2_stations_instruments_pkey; Type: CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.stations_instruments
    ADD CONSTRAINT tool_netcom_v2_stations_instruments_pkey PRIMARY KEY (arpa_id, st_id, date_start, date_end);


--
-- TOC entry 5050 (class 2606 OID 24701)
-- Name: page_autoscale page_autoscale_pkey; Type: CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.page_autoscale
    ADD CONSTRAINT page_autoscale_pkey PRIMARY KEY (id);


--
-- TOC entry 5052 (class 2606 OID 24703)
-- Name: page_charttype page_charttype_pkey; Type: CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.page_charttype
    ADD CONSTRAINT page_charttype_pkey PRIMARY KEY (id);


--
-- TOC entry 5054 (class 2606 OID 24705)
-- Name: page_defaultview page_defaultview_pkey; Type: CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.page_defaultview
    ADD CONSTRAINT page_defaultview_pkey PRIMARY KEY (id);


--
-- TOC entry 5056 (class 2606 OID 24707)
-- Name: page_integration page_integration_pkey; Type: CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.page_integration
    ADD CONSTRAINT page_integration_pkey PRIMARY KEY (id);


--
-- TOC entry 5061 (class 2606 OID 24709)
-- Name: pages_groups pages_groups_pkey; Type: CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.pages_groups
    ADD CONSTRAINT pages_groups_pkey PRIMARY KEY (gr_id);


--
-- TOC entry 5063 (class 2606 OID 24711)
-- Name: pages_groups_users pages_groups_users_pkey; Type: CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.pages_groups_users
    ADD CONSTRAINT pages_groups_users_pkey PRIMARY KEY (us_id, gr_id);


--
-- TOC entry 5065 (class 2606 OID 24713)
-- Name: pages_groups_users pages_groups_users_ukey; Type: CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.pages_groups_users
    ADD CONSTRAINT pages_groups_users_ukey UNIQUE (gr_id);


--
-- TOC entry 5059 (class 2606 OID 24715)
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (pg_id);


--
-- TOC entry 5068 (class 2606 OID 24717)
-- Name: pages_windows pages_windows_pkey; Type: CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.pages_windows
    ADD CONSTRAINT pages_windows_pkey PRIMARY KEY (wd_id);


--
-- TOC entry 5073 (class 2606 OID 24719)
-- Name: users_settings_colors tool_analyser_lily_users_settings_colors_pkey; Type: CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.users_settings_colors
    ADD CONSTRAINT tool_analyser_lily_users_settings_colors_pkey PRIMARY KEY (us_id);


--
-- TOC entry 5071 (class 2606 OID 24721)
-- Name: users_settings users_settings_pkey; Type: CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.users_settings
    ADD CONSTRAINT users_settings_pkey PRIMARY KEY (us_id);


--
-- TOC entry 5075 (class 2606 OID 24767)
-- Name: analysis_types tool_web_lily_analysis_types_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.analysis_types
    ADD CONSTRAINT tool_web_lily_analysis_types_pkey PRIMARY KEY (type_id);


--
-- TOC entry 5077 (class 2606 OID 24769)
-- Name: analysis_types tool_web_lily_analysis_types_ukey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.analysis_types
    ADD CONSTRAINT tool_web_lily_analysis_types_ukey UNIQUE (analysis);


--
-- TOC entry 5079 (class 2606 OID 24771)
-- Name: group_stations tool_web_lily_group_stations_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.group_stations
    ADD CONSTRAINT tool_web_lily_group_stations_pkey PRIMARY KEY (gs_id);


--
-- TOC entry 5081 (class 2606 OID 24773)
-- Name: groups tool_web_lily_groups_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.groups
    ADD CONSTRAINT tool_web_lily_groups_pkey PRIMARY KEY (gr_id);


--
-- TOC entry 5083 (class 2606 OID 24775)
-- Name: groups tool_web_lily_groups_ukey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.groups
    ADD CONSTRAINT tool_web_lily_groups_ukey UNIQUE (group_name);


--
-- TOC entry 5085 (class 2606 OID 24777)
-- Name: labanalysis_files tool_web_lily_labanalysis_files_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.labanalysis_files
    ADD CONSTRAINT tool_web_lily_labanalysis_files_pkey PRIMARY KEY (file_id);


--
-- TOC entry 5087 (class 2606 OID 24779)
-- Name: labanalysis_files tool_web_lily_labanalysis_files_ukey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.labanalysis_files
    ADD CONSTRAINT tool_web_lily_labanalysis_files_ukey UNIQUE (source_filename);


--
-- TOC entry 5095 (class 2606 OID 24781)
-- Name: menu tool_web_lily_main_menu_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.menu
    ADD CONSTRAINT tool_web_lily_main_menu_pkey PRIMARY KEY (id);


--
-- TOC entry 5097 (class 2606 OID 24783)
-- Name: menu tool_web_lily_main_menu_ukey2; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.menu
    ADD CONSTRAINT tool_web_lily_main_menu_ukey2 UNIQUE (menu_href);


--
-- TOC entry 5119 (class 2606 OID 24785)
-- Name: user_menu tool_web_lily_main_user_menu_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.user_menu
    ADD CONSTRAINT tool_web_lily_main_user_menu_pkey PRIMARY KEY (us_id, menu_id, menu_level);


--
-- TOC entry 5089 (class 2606 OID 24787)
-- Name: memo_participants tool_web_lily_memo_participants_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.memo_participants
    ADD CONSTRAINT tool_web_lily_memo_participants_pkey PRIMARY KEY (me_pa_id);


--
-- TOC entry 5091 (class 2606 OID 24789)
-- Name: memo_participants tool_web_lily_memo_participants_ukey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.memo_participants
    ADD CONSTRAINT tool_web_lily_memo_participants_ukey UNIQUE (me_id, pa_id);


--
-- TOC entry 5093 (class 2606 OID 24791)
-- Name: memos tool_web_lily_memos_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.memos
    ADD CONSTRAINT tool_web_lily_memos_pkey PRIMARY KEY (me_id);


--
-- TOC entry 5099 (class 2606 OID 24793)
-- Name: participants tool_web_lily_participants_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.participants
    ADD CONSTRAINT tool_web_lily_participants_pkey PRIMARY KEY (pa_id);


--
-- TOC entry 5103 (class 2606 OID 24795)
-- Name: surveys_attachements tool_web_lily_surveys_attachements_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.surveys_attachements
    ADD CONSTRAINT tool_web_lily_surveys_attachements_pkey PRIMARY KEY (attachement_id);


--
-- TOC entry 5105 (class 2606 OID 24797)
-- Name: surveys_attachements tool_web_lily_surveys_attachements_ukey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.surveys_attachements
    ADD CONSTRAINT tool_web_lily_surveys_attachements_ukey UNIQUE (su_id, source_filename);


--
-- TOC entry 5101 (class 2606 OID 24799)
-- Name: surveys tool_web_lily_surveys_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.surveys
    ADD CONSTRAINT tool_web_lily_surveys_pkey PRIMARY KEY (su_id);


--
-- TOC entry 5107 (class 2606 OID 24801)
-- Name: task_types tool_web_lily_task_types_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.task_types
    ADD CONSTRAINT tool_web_lily_task_types_pkey PRIMARY KEY (ty_id);


--
-- TOC entry 5109 (class 2606 OID 24803)
-- Name: tasks tool_web_lily_tasks_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.tasks
    ADD CONSTRAINT tool_web_lily_tasks_pkey PRIMARY KEY (ta_id);


--
-- TOC entry 5111 (class 2606 OID 24805)
-- Name: tasks tool_web_lily_tasks_ukey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.tasks
    ADD CONSTRAINT tool_web_lily_tasks_ukey UNIQUE (task_name, task_assignee);


--
-- TOC entry 5113 (class 2606 OID 24807)
-- Name: ticket_categories tool_web_lily_ticket_categories_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.ticket_categories
    ADD CONSTRAINT tool_web_lily_ticket_categories_pkey PRIMARY KEY (tc_id);


--
-- TOC entry 5115 (class 2606 OID 24809)
-- Name: ticket_types tool_web_lily_ticket_types_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.ticket_types
    ADD CONSTRAINT tool_web_lily_ticket_types_pkey PRIMARY KEY (tt_id);


--
-- TOC entry 5117 (class 2606 OID 24811)
-- Name: tickets tool_web_lily_tickets_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.tickets
    ADD CONSTRAINT tool_web_lily_tickets_pkey PRIMARY KEY (tk_id);


--
-- TOC entry 5121 (class 2606 OID 24813)
-- Name: users_groups tool_web_lily_users_groups_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.users_groups
    ADD CONSTRAINT tool_web_lily_users_groups_pkey PRIMARY KEY (us_gr_id);


--
-- TOC entry 5123 (class 2606 OID 24815)
-- Name: users_groups tool_web_lily_users_groups_ukey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.users_groups
    ADD CONSTRAINT tool_web_lily_users_groups_ukey UNIQUE (us_id, gr_id);


--
-- TOC entry 5125 (class 2606 OID 24817)
-- Name: users_logs tool_web_lily_users_logs_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.users_logs
    ADD CONSTRAINT tool_web_lily_users_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 4982 (class 2606 OID 24819)
-- Name: users tool_web_lily_users_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.users
    ADD CONSTRAINT tool_web_lily_users_pkey PRIMARY KEY (us_id);


--
-- TOC entry 5127 (class 2606 OID 24821)
-- Name: users_settings tool_web_lily_users_settings_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.users_settings
    ADD CONSTRAINT tool_web_lily_users_settings_pkey PRIMARY KEY (us_id);


--
-- TOC entry 4984 (class 2606 OID 24823)
-- Name: users tool_web_lily_users_ukey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.users
    ADD CONSTRAINT tool_web_lily_users_ukey UNIQUE (user_name, user_surname);


--
-- TOC entry 5129 (class 2606 OID 24825)
-- Name: val_codes tool_web_lily_val_codes_pkey; Type: CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.val_codes
    ADD CONSTRAINT tool_web_lily_val_codes_pkey PRIMARY KEY (val_code_id);


--
-- TOC entry 4823 (class 1259 OID 24934)
-- Name: calibrations_calibrawtions_fkey6; Type: INDEX; Schema: calibrations; Owner: postgres
--

CREATE INDEX calibrations_calibrawtions_fkey6 ON calibrations.calibrations USING btree (arpa_id);


--
-- TOC entry 4848 (class 1259 OID 24938)
-- Name: _laboratory_analysis_parameters_idx1; Type: INDEX; Schema: labanalysis; Owner: postgres
--

CREATE INDEX _laboratory_analysis_parameters_idx1 ON labanalysis._laboratory_analysis_parameters USING btree (lab_pr_id, pr_id);


--
-- TOC entry 4861 (class 1259 OID 24939)
-- Name: labanalysis_laboratory_data_white_idx1; Type: INDEX; Schema: labanalysis; Owner: postgres
--

CREATE INDEX labanalysis_laboratory_data_white_idx1 ON labanalysis.laboratory_data_white USING btree (sp_id, lab_pr_id);


--
-- TOC entry 4862 (class 1259 OID 24940)
-- Name: labanalysis_laboratory_data_white_idx2; Type: INDEX; Schema: labanalysis; Owner: postgres
--

CREATE INDEX labanalysis_laboratory_data_white_idx2 ON labanalysis.laboratory_data_white USING btree (sp_id, lab_pr_id, conc);


--
-- TOC entry 4870 (class 1259 OID 24941)
-- Name: labanalysis_laboratory_samples_white_idx1; Type: INDEX; Schema: labanalysis; Owner: postgres
--

CREATE INDEX labanalysis_laboratory_samples_white_idx1 ON labanalysis.laboratory_samples_white USING btree (sp_id, date_start);


--
-- TOC entry 4871 (class 1259 OID 24942)
-- Name: labanalysis_laboratory_samples_white_idx2; Type: INDEX; Schema: labanalysis; Owner: postgres
--

CREATE INDEX labanalysis_laboratory_samples_white_idx2 ON labanalysis.laboratory_samples_white USING btree (sp_id, st_id, date_start);


--
-- TOC entry 4872 (class 1259 OID 24943)
-- Name: labanalysis_laboratory_samples_white_idx3; Type: INDEX; Schema: labanalysis; Owner: postgres
--

CREATE UNIQUE INDEX labanalysis_laboratory_samples_white_idx3 ON labanalysis.laboratory_samples_white USING btree (st_id, an_id, date_start);


--
-- TOC entry 4857 (class 1259 OID 24944)
-- Name: laboratory_data_idx1; Type: INDEX; Schema: labanalysis; Owner: postgres
--

CREATE INDEX laboratory_data_idx1 ON labanalysis.laboratory_data USING btree (sp_id, lab_pr_id);


--
-- TOC entry 4858 (class 1259 OID 24945)
-- Name: laboratory_data_idx2; Type: INDEX; Schema: labanalysis; Owner: postgres
--

CREATE INDEX laboratory_data_idx2 ON labanalysis.laboratory_data USING btree (sp_id, lab_pr_id, conc);


--
-- TOC entry 4865 (class 1259 OID 24946)
-- Name: laboratory_samples_idx1; Type: INDEX; Schema: labanalysis; Owner: postgres
--

CREATE INDEX laboratory_samples_idx1 ON labanalysis.laboratory_samples USING btree (sp_id, date_start);


--
-- TOC entry 4866 (class 1259 OID 24947)
-- Name: laboratory_samples_idx2; Type: INDEX; Schema: labanalysis; Owner: postgres
--

CREATE INDEX laboratory_samples_idx2 ON labanalysis.laboratory_samples USING btree (sp_id, st_id, date_start);


--
-- TOC entry 4867 (class 1259 OID 24948)
-- Name: laboratory_samples_idx3; Type: INDEX; Schema: labanalysis; Owner: postgres
--

CREATE UNIQUE INDEX laboratory_samples_idx3 ON labanalysis.laboratory_samples USING btree (st_id, an_id, date_start);


--
-- TOC entry 4935 (class 1259 OID 24949)
-- Name: _fulldate_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX _fulldate_idx ON public._logs USING btree (fulldate);

ALTER TABLE public._logs CLUSTER ON _fulldate_idx;


--
-- TOC entry 4936 (class 1259 OID 24950)
-- Name: _logs_logstype_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX _logs_logstype_idx ON public._logs USING btree (type);


--
-- TOC entry 4937 (class 1259 OID 24951)
-- Name: _master_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX _master_idx1 ON public._master USING btree (fulldate);


--
-- TOC entry 4803 (class 1259 OID 24952)
-- Name: _parameters_list_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX _parameters_list_name_idx ON public._parameters_list_master USING btree (pr_id, name);


--
-- TOC entry 4806 (class 1259 OID 24953)
-- Name: _parameters_list_shortname_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX _parameters_list_shortname_idx ON public._parameters_list_master USING btree (pr_id, shortname);


--
-- TOC entry 4814 (class 1259 OID 24954)
-- Name: _stations_override_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX _stations_override_idx1 ON public._stations_override USING btree (st_id_override);


--
-- TOC entry 4807 (class 1259 OID 24955)
-- Name: _stations_parameters_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX _stations_parameters_id_idx ON public._stations_parameters_master USING btree (st_id, id);


--
-- TOC entry 4812 (class 1259 OID 24956)
-- Name: _stations_parameters_prid_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX _stations_parameters_prid_idx ON public._stations_parameters_master USING btree (pr_id);


--
-- TOC entry 4813 (class 1259 OID 24957)
-- Name: _stations_parameters_stid_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX _stations_parameters_stid_idx ON public._stations_parameters_master USING btree (st_id);


--
-- TOC entry 4797 (class 1259 OID 24958)
-- Name: _stations_st_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX _stations_st_id_idx ON public._stations USING btree (st_id);


--
-- TOC entry 4798 (class 1259 OID 24959)
-- Name: _stations_tableid_schema_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX _stations_tableid_schema_idx ON public._stations USING btree (tableid, schema);


--
-- TOC entry 4952 (class 1259 OID 24960)
-- Name: _users_username_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX _users_username_idx ON public._users USING btree (username);


--
-- TOC entry 4963 (class 1259 OID 24961)
-- Name: history_changes_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX history_changes_idx ON public.history_changes USING btree (date_update);


--
-- TOC entry 4964 (class 1259 OID 24985)
-- Name: Idx_id_fulldate; Type: INDEX; Schema: tables_ar; Owner: postgres
--

CREATE UNIQUE INDEX "Idx_id_fulldate" ON tables_ar.data_plouves USING btree (id, fulldate);


--
-- TOC entry 4965 (class 1259 OID 24986)
-- Name: Idx_timestamp; Type: INDEX; Schema: tables_ar; Owner: postgres
--

CREATE INDEX "Idx_timestamp" ON tables_ar.data_plouves USING btree (time_stamp);


--
-- TOC entry 4966 (class 1259 OID 25047)
-- Name: data_ar_plouves_idx_day; Type: INDEX; Schema: tables_ar; Owner: postgres
--

CREATE INDEX data_ar_plouves_idx_day ON tables_ar.data_plouves USING btree (id, date_trunc('day'::text, fulldate));


--
-- TOC entry 4967 (class 1259 OID 25048)
-- Name: data_ar_plouves_idx_id_fulldate; Type: INDEX; Schema: tables_ar; Owner: postgres
--

CREATE UNIQUE INDEX data_ar_plouves_idx_id_fulldate ON tables_ar.data_plouves USING btree (id, fulldate);


--
-- TOC entry 4968 (class 1259 OID 25049)
-- Name: data_ar_plouves_idx_timestamp; Type: INDEX; Schema: tables_ar; Owner: postgres
--

CREATE INDEX data_ar_plouves_idx_timestamp ON tables_ar.data_plouves USING btree (time_stamp);


--
-- TOC entry 4969 (class 1259 OID 25050)
-- Name: data_ar_plouves_idx_year; Type: INDEX; Schema: tables_ar; Owner: postgres
--

CREATE INDEX data_ar_plouves_idx_year ON tables_ar.data_plouves USING btree (id, date_trunc('year'::text, fulldate));


--
-- TOC entry 4970 (class 1259 OID 25051)
-- Name: data_ar_plouves_idx_yearmonth; Type: INDEX; Schema: tables_ar; Owner: postgres
--

CREATE INDEX data_ar_plouves_idx_yearmonth ON tables_ar.data_plouves USING btree (id, date_trunc('month'::text, fulldate));


--
-- TOC entry 5057 (class 1259 OID 25073)
-- Name: pages_grid_idx; Type: INDEX; Schema: tool_visualizer_lily; Owner: postgres
--

CREATE INDEX pages_grid_idx ON tool_visualizer_lily.pages USING btree (gr_id);


--
-- TOC entry 5066 (class 1259 OID 25074)
-- Name: pages_windows_pgid_idx; Type: INDEX; Schema: tool_visualizer_lily; Owner: postgres
--

CREATE INDEX pages_windows_pgid_idx ON tool_visualizer_lily.pages_windows USING btree (pg_id);


--
-- TOC entry 5069 (class 1259 OID 25075)
-- Name: pages_windows_stprid_idx; Type: INDEX; Schema: tool_visualizer_lily; Owner: postgres
--

CREATE INDEX pages_windows_stprid_idx ON tool_visualizer_lily.pages_windows USING btree (st_pr_id);


--
-- TOC entry 5274 (class 2620 OID 25096)
-- Name: laboratory_data laboratory_data_aiu; Type: TRIGGER; Schema: labanalysis; Owner: postgres
--

CREATE TRIGGER laboratory_data_aiu AFTER INSERT OR UPDATE ON labanalysis.laboratory_data FOR EACH ROW EXECUTE FUNCTION labanalysis.laboratory_calc();


--
-- TOC entry 5275 (class 2620 OID 25097)
-- Name: operations_data check_stid_pr_id_fl_utilizzo; Type: TRIGGER; Schema: operations; Owner: postgres
--

CREATE TRIGGER check_stid_pr_id_fl_utilizzo BEFORE INSERT OR UPDATE ON operations.operations_data FOR EACH ROW EXECUTE FUNCTION operations.check_st_id_pr_id_fl_utilizzo();


--
-- TOC entry 5277 (class 2620 OID 25098)
-- Name: _users_parameters chech_pr_id_in_param_list; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER chech_pr_id_in_param_list BEFORE INSERT OR UPDATE ON public._users_parameters FOR EACH ROW EXECUTE FUNCTION public.check_pr_id();


--
-- TOC entry 5276 (class 2620 OID 25099)
-- Name: _users users_logins_bu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER users_logins_bu BEFORE UPDATE ON public._users FOR EACH ROW EXECUTE FUNCTION public.users_logins();


--
-- TOC entry 5278 (class 2620 OID 25223)
-- Name: data_plouves data_ar_plouves_calc_sliding_mean_aiau; Type: TRIGGER; Schema: tables_ar; Owner: postgres
--

CREATE TRIGGER data_ar_plouves_calc_sliding_mean_aiau AFTER INSERT OR UPDATE ON tables_ar.data_plouves FOR EACH ROW EXECUTE FUNCTION public.calc_sliding_mean('4000');


--
-- TOC entry 5279 (class 2620 OID 25224)
-- Name: data_plouves data_ar_plouves_calccode_bi; Type: TRIGGER; Schema: tables_ar; Owner: postgres
--

CREATE TRIGGER data_ar_plouves_calccode_bi BEFORE INSERT ON tables_ar.data_plouves FOR EACH ROW EXECUTE FUNCTION public.calccode('4000');


--
-- TOC entry 5280 (class 2620 OID 25226)
-- Name: data_plouves data_ar_plouves_history_bu; Type: TRIGGER; Schema: tables_ar; Owner: postgres
--

CREATE TRIGGER data_ar_plouves_history_bu BEFORE UPDATE ON tables_ar.data_plouves FOR EACH ROW EXECUTE FUNCTION public.history('4000');


--
-- TOC entry 5281 (class 2620 OID 25231)
-- Name: data_plouves data_ar_plouves_v2h_aiau; Type: TRIGGER; Schema: tables_ar; Owner: postgres
--

CREATE TRIGGER data_ar_plouves_v2h_aiau AFTER INSERT OR UPDATE ON tables_ar.data_plouves FOR EACH ROW EXECUTE FUNCTION public.v2h_stations_minmax_v150('4000');


--
-- TOC entry 5282 (class 2620 OID 25312)
-- Name: data_plouves tables_ar_data_plouves_handle_timestamp_bu; Type: TRIGGER; Schema: tables_ar; Owner: postgres
--

CREATE TRIGGER tables_ar_data_plouves_handle_timestamp_bu BEFORE UPDATE ON tables_ar.data_plouves FOR EACH ROW EXECUTE FUNCTION public.trg_handle_timestamp();


--
-- TOC entry 5143 (class 2606 OID 25607)
-- Name: calibrations calibrations_calibrations_fkey1; Type: FK CONSTRAINT; Schema: calibrations; Owner: postgres
--

ALTER TABLE ONLY calibrations.calibrations
    ADD CONSTRAINT calibrations_calibrations_fkey1 FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5144 (class 2606 OID 25612)
-- Name: calibrations calibrations_calibrations_fkey2; Type: FK CONSTRAINT; Schema: calibrations; Owner: postgres
--

ALTER TABLE ONLY calibrations.calibrations
    ADD CONSTRAINT calibrations_calibrations_fkey2 FOREIGN KEY (pr_id) REFERENCES public._parameters_list_master(pr_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5145 (class 2606 OID 25617)
-- Name: calibrations calibrations_calibrations_fkey3; Type: FK CONSTRAINT; Schema: calibrations; Owner: postgres
--

ALTER TABLE ONLY calibrations.calibrations
    ADD CONSTRAINT calibrations_calibrations_fkey3 FOREIGN KEY (zero_method) REFERENCES calibrations.cal_methods(me_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5146 (class 2606 OID 25622)
-- Name: calibrations calibrations_calibrations_fkey4; Type: FK CONSTRAINT; Schema: calibrations; Owner: postgres
--

ALTER TABLE ONLY calibrations.calibrations
    ADD CONSTRAINT calibrations_calibrations_fkey4 FOREIGN KEY (span_method) REFERENCES calibrations.cal_methods(me_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5147 (class 2606 OID 25627)
-- Name: calibrations calibrations_calibrations_fkey5; Type: FK CONSTRAINT; Schema: calibrations; Owner: postgres
--

ALTER TABLE ONLY calibrations.calibrations
    ADD CONSTRAINT calibrations_calibrations_fkey5 FOREIGN KEY (reason) REFERENCES calibrations.cal_reasons(re_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5148 (class 2606 OID 25667)
-- Name: reports journal_reports_fkey1; Type: FK CONSTRAINT; Schema: journal; Owner: postgres
--

ALTER TABLE ONLY journal.reports
    ADD CONSTRAINT journal_reports_fkey1 FOREIGN KEY (st_id) REFERENCES journal.network_stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5149 (class 2606 OID 25672)
-- Name: reports_pics reports_pics_rp_id_fkey; Type: FK CONSTRAINT; Schema: journal; Owner: postgres
--

ALTER TABLE ONLY journal.reports_pics
    ADD CONSTRAINT reports_pics_rp_id_fkey FOREIGN KEY (rp_id) REFERENCES journal.reports(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5150 (class 2606 OID 25677)
-- Name: _laboratory_analysis_parameters _laboratory_analysis_fkey; Type: FK CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis._laboratory_analysis_parameters
    ADD CONSTRAINT _laboratory_analysis_fkey FOREIGN KEY (an_id) REFERENCES labanalysis._laboratory_analysis(an_id);


--
-- TOC entry 5151 (class 2606 OID 25682)
-- Name: _laboratory_analysis_parameters _laboratory_analysis_parameters_pr_id_fkey; Type: FK CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis._laboratory_analysis_parameters
    ADD CONSTRAINT _laboratory_analysis_parameters_pr_id_fkey FOREIGN KEY (pr_id) REFERENCES public._parameters_list_master(pr_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5152 (class 2606 OID 25687)
-- Name: deposimeters_input_data labanalysis_deposimeters_input_data_fkey1; Type: FK CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.deposimeters_input_data
    ADD CONSTRAINT labanalysis_deposimeters_input_data_fkey1 FOREIGN KEY (lab_pr_id) REFERENCES labanalysis._laboratory_analysis_parameters(lab_pr_id) ON DELETE RESTRICT;


--
-- TOC entry 5153 (class 2606 OID 25692)
-- Name: deposimeters_input_data labanalysis_deposimeters_input_data_fkey2; Type: FK CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.deposimeters_input_data
    ADD CONSTRAINT labanalysis_deposimeters_input_data_fkey2 FOREIGN KEY (sp_id) REFERENCES labanalysis.laboratory_samples(sp_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5156 (class 2606 OID 25697)
-- Name: laboratory_data_white labanalysis_laboratory_data_white_pr_id_fkey; Type: FK CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.laboratory_data_white
    ADD CONSTRAINT labanalysis_laboratory_data_white_pr_id_fkey FOREIGN KEY (lab_pr_id) REFERENCES labanalysis._laboratory_analysis_parameters(lab_pr_id) ON DELETE RESTRICT;


--
-- TOC entry 5157 (class 2606 OID 25702)
-- Name: laboratory_data_white labanalysis_laboratory_data_white_sp_id_fkey; Type: FK CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.laboratory_data_white
    ADD CONSTRAINT labanalysis_laboratory_data_white_sp_id_fkey FOREIGN KEY (sp_id) REFERENCES labanalysis.laboratory_samples_white(sp_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5161 (class 2606 OID 25707)
-- Name: laboratory_samples_white labanalysis_laboratory_samples_white_an_id_fkey; Type: FK CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.laboratory_samples_white
    ADD CONSTRAINT labanalysis_laboratory_samples_white_an_id_fkey FOREIGN KEY (an_id) REFERENCES labanalysis._laboratory_analysis(an_id) ON DELETE RESTRICT;


--
-- TOC entry 5162 (class 2606 OID 25712)
-- Name: laboratory_samples_white labanalysis_laboratory_samples_white_fi_id_fkey; Type: FK CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.laboratory_samples_white
    ADD CONSTRAINT labanalysis_laboratory_samples_white_fi_id_fkey FOREIGN KEY (fi_id) REFERENCES labanalysis._laboratory_filter(fi_id) ON DELETE RESTRICT;


--
-- TOC entry 5163 (class 2606 OID 25717)
-- Name: laboratory_samples_white labanalysis_laboratory_samples_white_st_id_fkey; Type: FK CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.laboratory_samples_white
    ADD CONSTRAINT labanalysis_laboratory_samples_white_st_id_fkey FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5154 (class 2606 OID 25722)
-- Name: laboratory_data laboratory_data_pr_id_fkey; Type: FK CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.laboratory_data
    ADD CONSTRAINT laboratory_data_pr_id_fkey FOREIGN KEY (lab_pr_id) REFERENCES labanalysis._laboratory_analysis_parameters(lab_pr_id) ON DELETE RESTRICT;


--
-- TOC entry 5155 (class 2606 OID 25727)
-- Name: laboratory_data laboratory_data_sp_id_fkey; Type: FK CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.laboratory_data
    ADD CONSTRAINT laboratory_data_sp_id_fkey FOREIGN KEY (sp_id) REFERENCES labanalysis.laboratory_samples(sp_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5158 (class 2606 OID 25732)
-- Name: laboratory_samples laboratory_samples_an_id_fkey; Type: FK CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.laboratory_samples
    ADD CONSTRAINT laboratory_samples_an_id_fkey FOREIGN KEY (an_id) REFERENCES labanalysis._laboratory_analysis(an_id) ON DELETE RESTRICT;


--
-- TOC entry 5159 (class 2606 OID 25737)
-- Name: laboratory_samples laboratory_samples_fi_id_fkey; Type: FK CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.laboratory_samples
    ADD CONSTRAINT laboratory_samples_fi_id_fkey FOREIGN KEY (fi_id) REFERENCES labanalysis._laboratory_filter(fi_id) ON DELETE RESTRICT;


--
-- TOC entry 5160 (class 2606 OID 25742)
-- Name: laboratory_samples laboratory_samples_st_id_fkey; Type: FK CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.laboratory_samples
    ADD CONSTRAINT laboratory_samples_st_id_fkey FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5164 (class 2606 OID 25747)
-- Name: users_laboratory_analysis users_laboratory_analysis_an_id_fkey; Type: FK CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.users_laboratory_analysis
    ADD CONSTRAINT users_laboratory_analysis_an_id_fkey FOREIGN KEY (an_id) REFERENCES labanalysis._laboratory_analysis(an_id) ON DELETE RESTRICT;


--
-- TOC entry 5165 (class 2606 OID 25752)
-- Name: users_laboratory_analysis users_laboratory_analysis_us_id_fkey; Type: FK CONSTRAINT; Schema: labanalysis; Owner: postgres
--

ALTER TABLE ONLY labanalysis.users_laboratory_analysis
    ADD CONSTRAINT users_laboratory_analysis_us_id_fkey FOREIGN KEY (us_id) REFERENCES public._users(us_id) ON DELETE RESTRICT;


--
-- TOC entry 5131 (class 2606 OID 25757)
-- Name: stations_metadata _stations_metadata_st_id_fkey; Type: FK CONSTRAINT; Schema: metadata; Owner: postgres
--

ALTER TABLE ONLY metadata.stations_metadata
    ADD CONSTRAINT _stations_metadata_st_id_fkey FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5132 (class 2606 OID 25762)
-- Name: stations_metadata _stations_metadata_typology_fkey; Type: FK CONSTRAINT; Schema: metadata; Owner: postgres
--

ALTER TABLE ONLY metadata.stations_metadata
    ADD CONSTRAINT _stations_metadata_typology_fkey FOREIGN KEY (typology) REFERENCES metadata.station_typology(id);


--
-- TOC entry 5136 (class 2606 OID 25767)
-- Name: stations_metadata_extended stations_metadata_extended_st_id_fkey; Type: FK CONSTRAINT; Schema: metadata; Owner: postgres
--

ALTER TABLE ONLY metadata.stations_metadata_extended
    ADD CONSTRAINT stations_metadata_extended_st_id_fkey FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5166 (class 2606 OID 25772)
-- Name: stations_metadata_info stations_metadata_info_st_id_fkey; Type: FK CONSTRAINT; Schema: metadata; Owner: postgres
--

ALTER TABLE ONLY metadata.stations_metadata_info
    ADD CONSTRAINT stations_metadata_info_st_id_fkey FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5167 (class 2606 OID 25777)
-- Name: stations_metadata_instruments stations_metadata_instruments_st_id_fkey; Type: FK CONSTRAINT; Schema: metadata; Owner: postgres
--

ALTER TABLE ONLY metadata.stations_metadata_instruments
    ADD CONSTRAINT stations_metadata_instruments_st_id_fkey FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5133 (class 2606 OID 25782)
-- Name: stations_metadata stations_metadata_networktype_fkey; Type: FK CONSTRAINT; Schema: metadata; Owner: postgres
--

ALTER TABLE ONLY metadata.stations_metadata
    ADD CONSTRAINT stations_metadata_networktype_fkey FOREIGN KEY (networktype) REFERENCES metadata.station_networktype(id);


--
-- TOC entry 5168 (class 2606 OID 25787)
-- Name: stations_metadata_pictures_maps stations_metadata_pictures_maps_st_id_fkey; Type: FK CONSTRAINT; Schema: metadata; Owner: postgres
--

ALTER TABLE ONLY metadata.stations_metadata_pictures_maps
    ADD CONSTRAINT stations_metadata_pictures_maps_st_id_fkey FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5134 (class 2606 OID 25792)
-- Name: stations_metadata stations_metadata_station_type_fkey; Type: FK CONSTRAINT; Schema: metadata; Owner: postgres
--

ALTER TABLE ONLY metadata.stations_metadata
    ADD CONSTRAINT stations_metadata_station_type_fkey FOREIGN KEY (station_type) REFERENCES metadata.station_type(id);


--
-- TOC entry 5135 (class 2606 OID 25797)
-- Name: stations_metadata stations_metadata_type_zone_fkey; Type: FK CONSTRAINT; Schema: metadata; Owner: postgres
--

ALTER TABLE ONLY metadata.stations_metadata
    ADD CONSTRAINT stations_metadata_type_zone_fkey FOREIGN KEY (type_zone) REFERENCES metadata.station_zone(id);


--
-- TOC entry 5171 (class 2606 OID 25802)
-- Name: instruments_has_ricambi Ref_10; Type: FK CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.instruments_has_ricambi
    ADD CONSTRAINT "Ref_10" FOREIGN KEY (arpa_id) REFERENCES operations.instruments(arpa_id) MATCH FULL ON DELETE RESTRICT;


--
-- TOC entry 5172 (class 2606 OID 25807)
-- Name: instruments_has_ricambi Ref_11; Type: FK CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.instruments_has_ricambi
    ADD CONSTRAINT "Ref_11" FOREIGN KEY (ri_id) REFERENCES operations.ricambi(ri_id) MATCH FULL ON DELETE RESTRICT;


--
-- TOC entry 5173 (class 2606 OID 25812)
-- Name: instruments_type_has_operations Ref_15; Type: FK CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.instruments_type_has_operations
    ADD CONSTRAINT "Ref_15" FOREIGN KEY (tp_in_id) REFERENCES operations.instruments_type(tp_in_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 5175 (class 2606 OID 25817)
-- Name: instruments_type_has_parameters Ref_15; Type: FK CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.instruments_type_has_parameters
    ADD CONSTRAINT "Ref_15" FOREIGN KEY (tp_in_id) REFERENCES operations.instruments_type(tp_in_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 5174 (class 2606 OID 25822)
-- Name: instruments_type_has_operations Ref_16; Type: FK CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.instruments_type_has_operations
    ADD CONSTRAINT "Ref_16" FOREIGN KEY (op_id) REFERENCES operations.operations(op_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 5183 (class 2606 OID 25827)
-- Name: stations_has_instruments Ref_16; Type: FK CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.stations_has_instruments
    ADD CONSTRAINT "Ref_16" FOREIGN KEY (st_id) REFERENCES public._stations(st_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5176 (class 2606 OID 25832)
-- Name: instruments_type_has_parameters Ref_16; Type: FK CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.instruments_type_has_parameters
    ADD CONSTRAINT "Ref_16" FOREIGN KEY (pr_id) REFERENCES public._parameters_list_master(pr_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 5184 (class 2606 OID 25837)
-- Name: stations_has_instruments Ref_17; Type: FK CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.stations_has_instruments
    ADD CONSTRAINT "Ref_17" FOREIGN KEY (arpa_id) REFERENCES operations.instruments(arpa_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 5177 (class 2606 OID 25842)
-- Name: operations Ref_20; Type: FK CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.operations
    ADD CONSTRAINT "Ref_20" FOREIGN KEY (tp_op_id) REFERENCES operations.operations_type(tp_op_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 5169 (class 2606 OID 25847)
-- Name: cylinders_parameters _cylinders_parameters_fkey; Type: FK CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.cylinders_parameters
    ADD CONSTRAINT _cylinders_parameters_fkey FOREIGN KEY (pr_id) REFERENCES public._parameters_list_master(pr_id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 5170 (class 2606 OID 25852)
-- Name: instruments _instruments_tp_in_id_fkey; Type: FK CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.instruments
    ADD CONSTRAINT _instruments_tp_in_id_fkey FOREIGN KEY (tp_in_id) REFERENCES operations.instruments_type(tp_in_id) MATCH FULL;


--
-- TOC entry 5181 (class 2606 OID 25857)
-- Name: ricambi_data operations_data__fkey; Type: FK CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.ricambi_data
    ADD CONSTRAINT operations_data__fkey FOREIGN KEY (ri_id) REFERENCES operations.ricambi(ri_id) MATCH FULL;


--
-- TOC entry 5178 (class 2606 OID 25862)
-- Name: operations_data operations_data_operations_fkey; Type: FK CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.operations_data
    ADD CONSTRAINT operations_data_operations_fkey FOREIGN KEY (op_id) REFERENCES operations.operations(op_id) MATCH FULL;


--
-- TOC entry 5179 (class 2606 OID 25867)
-- Name: operations_data operations_data_parameters_fkey; Type: FK CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.operations_data
    ADD CONSTRAINT operations_data_parameters_fkey FOREIGN KEY (pr_id) REFERENCES public._parameters_list_master(pr_id) MATCH FULL;


--
-- TOC entry 5180 (class 2606 OID 25872)
-- Name: operations_data operations_data_stations_fkey; Type: FK CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.operations_data
    ADD CONSTRAINT operations_data_stations_fkey FOREIGN KEY (st_id) REFERENCES public._stations(st_id) MATCH FULL;


--
-- TOC entry 5182 (class 2606 OID 25877)
-- Name: ricambi_data ricambi_data_instruments_fkey; Type: FK CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.ricambi_data
    ADD CONSTRAINT ricambi_data_instruments_fkey FOREIGN KEY (arpa_id) REFERENCES operations.instruments(arpa_id) MATCH FULL;


--
-- TOC entry 5185 (class 2606 OID 25882)
-- Name: _groups_parameters _groups_parameters_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._groups_parameters
    ADD CONSTRAINT _groups_parameters_fkey1 FOREIGN KEY (gr_id) REFERENCES public._groups_list(gr_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5186 (class 2606 OID 25887)
-- Name: _groups_parameters _groups_parameters_fkey2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._groups_parameters
    ADD CONSTRAINT _groups_parameters_fkey2 FOREIGN KEY (pr_id) REFERENCES public._parameters_list_master(pr_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5187 (class 2606 OID 25892)
-- Name: _instruments_parameters _instruments_parameters_in_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._instruments_parameters
    ADD CONSTRAINT _instruments_parameters_in_id_fkey FOREIGN KEY (in_id) REFERENCES public._instruments_list(in_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5188 (class 2606 OID 25897)
-- Name: _instruments_parameters _instruments_parameters_pr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._instruments_parameters
    ADD CONSTRAINT _instruments_parameters_pr_id_fkey FOREIGN KEY (pr_id) REFERENCES public._parameters_list_master(pr_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5189 (class 2606 OID 25902)
-- Name: _logs _logs_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._logs
    ADD CONSTRAINT _logs_type_fkey FOREIGN KEY (type) REFERENCES public._log_type(id);


--
-- TOC entry 5190 (class 2606 OID 25907)
-- Name: _parameters_formules _parameters_formules_st_pr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._parameters_formules
    ADD CONSTRAINT _parameters_formules_st_pr_id_fkey FOREIGN KEY (st_pr_id) REFERENCES public._stations_parameters_master(st_pr_id) ON DELETE RESTRICT;


--
-- TOC entry 5137 (class 2606 OID 25912)
-- Name: _parameters_list_master _parameters_list_root_pr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._parameters_list_master
    ADD CONSTRAINT _parameters_list_root_pr_id_fkey FOREIGN KEY (root_pr_id) REFERENCES public._parameters_list_master(pr_id) ON DELETE RESTRICT;


--
-- TOC entry 5138 (class 2606 OID 25917)
-- Name: _parameters_list_master _parameters_list_treatment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._parameters_list_master
    ADD CONSTRAINT _parameters_list_treatment_fkey FOREIGN KEY (treatment) REFERENCES public._parameter_treatment(id);


--
-- TOC entry 5141 (class 2606 OID 25922)
-- Name: _stations_override _stations_override_st_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._stations_override
    ADD CONSTRAINT _stations_override_st_id_fkey FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5142 (class 2606 OID 25927)
-- Name: _stations_override _stations_override_st_id_override_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._stations_override
    ADD CONSTRAINT _stations_override_st_id_override_fkey FOREIGN KEY (st_id_override) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5139 (class 2606 OID 25932)
-- Name: _stations_parameters_master _stations_parameters_pr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._stations_parameters_master
    ADD CONSTRAINT _stations_parameters_pr_id_fkey FOREIGN KEY (pr_id) REFERENCES public._parameters_list_master(pr_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5140 (class 2606 OID 25937)
-- Name: _stations_parameters_master _stations_parameters_st_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._stations_parameters_master
    ADD CONSTRAINT _stations_parameters_st_id_fkey FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5130 (class 2606 OID 25942)
-- Name: _stations _stations_stationtype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._stations
    ADD CONSTRAINT _stations_stationtype_fkey FOREIGN KEY (station_roaming_type) REFERENCES public._station_roaming_type(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5191 (class 2606 OID 25947)
-- Name: _users_logins _users_logins_us_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._users_logins
    ADD CONSTRAINT _users_logins_us_id_fkey FOREIGN KEY (us_id) REFERENCES public._users(us_id) ON DELETE RESTRICT;


--
-- TOC entry 5192 (class 2606 OID 25952)
-- Name: _users_parameters _users_parameters_us_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._users_parameters
    ADD CONSTRAINT _users_parameters_us_id_fkey FOREIGN KEY (us_id) REFERENCES public._users(us_id) ON DELETE RESTRICT;


--
-- TOC entry 5193 (class 2606 OID 25957)
-- Name: _users_stations _users_stations_st_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._users_stations
    ADD CONSTRAINT _users_stations_st_id_fkey FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5194 (class 2606 OID 25962)
-- Name: _users_stations _users_stations_us_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._users_stations
    ADD CONSTRAINT _users_stations_us_id_fkey FOREIGN KEY (us_id) REFERENCES public._users(us_id) ON DELETE RESTRICT;


--
-- TOC entry 5195 (class 2606 OID 25967)
-- Name: codemanager codemanager_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.codemanager
    ADD CONSTRAINT codemanager_fkey1 FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5227 (class 2606 OID 26382)
-- Name: result_data_calibrations result_data_calibrations_fkey; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.result_data_calibrations
    ADD CONSTRAINT result_data_calibrations_fkey FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5208 (class 2606 OID 26387)
-- Name: data_documents tool_netcom_data_documents_fkey; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_documents
    ADD CONSTRAINT tool_netcom_data_documents_fkey FOREIGN KEY (ma_id) REFERENCES tool_netcom.data_maintenances(ma_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5226 (class 2606 OID 26392)
-- Name: raw_data_calibrations tool_netcom_raw_data_calibrations_fkey; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.raw_data_calibrations
    ADD CONSTRAINT tool_netcom_raw_data_calibrations_fkey FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5228 (class 2606 OID 26397)
-- Name: stations_calibrators tool_netcom_stations_calibrators_fkey1; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.stations_calibrators
    ADD CONSTRAINT tool_netcom_stations_calibrators_fkey1 FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5229 (class 2606 OID 26402)
-- Name: stations_calibrators tool_netcom_stations_calibrators_fkey2; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.stations_calibrators
    ADD CONSTRAINT tool_netcom_stations_calibrators_fkey2 FOREIGN KEY (arpa_id) REFERENCES tool_netcom.instruments(arpa_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5230 (class 2606 OID 26407)
-- Name: stations_cylinders tool_netcom_stations_cylinders_fkey2; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.stations_cylinders
    ADD CONSTRAINT tool_netcom_stations_cylinders_fkey2 FOREIGN KEY (arpa_id) REFERENCES tool_netcom.cylinders(arpa_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5231 (class 2606 OID 26412)
-- Name: stations_cylinders tool_netcom_stations_cylinderss_fkey1; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.stations_cylinders
    ADD CONSTRAINT tool_netcom_stations_cylinderss_fkey1 FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5232 (class 2606 OID 26417)
-- Name: stations_equipments tool_netcom_stations_equipments_fkey1; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.stations_equipments
    ADD CONSTRAINT tool_netcom_stations_equipments_fkey1 FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5233 (class 2606 OID 26422)
-- Name: stations_equipments tool_netcom_stations_equipments_fkey2; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.stations_equipments
    ADD CONSTRAINT tool_netcom_stations_equipments_fkey2 FOREIGN KEY (eq_id) REFERENCES tool_netcom.equipments(eq_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5207 (class 2606 OID 26427)
-- Name: cylinders tool_netcom_v2_cylinders_fkey; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.cylinders
    ADD CONSTRAINT tool_netcom_v2_cylinders_fkey FOREIGN KEY (in_ca_id) REFERENCES tool_netcom.instrument_categories(in_ca_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5196 (class 2606 OID 26432)
-- Name: data_calibrations tool_netcom_v2_data_calibrations_fkey1; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_calibrations
    ADD CONSTRAINT tool_netcom_v2_data_calibrations_fkey1 FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5197 (class 2606 OID 26437)
-- Name: data_calibrations tool_netcom_v2_data_calibrations_fkey2; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_calibrations
    ADD CONSTRAINT tool_netcom_v2_data_calibrations_fkey2 FOREIGN KEY (us_id) REFERENCES public._users(us_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5198 (class 2606 OID 26442)
-- Name: data_calibrations tool_netcom_v2_data_calibrations_fkey3; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_calibrations
    ADD CONSTRAINT tool_netcom_v2_data_calibrations_fkey3 FOREIGN KEY (arpa_id) REFERENCES tool_netcom.instruments(arpa_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5199 (class 2606 OID 26447)
-- Name: data_calibrations tool_netcom_v2_data_calibrations_fkey4; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_calibrations
    ADD CONSTRAINT tool_netcom_v2_data_calibrations_fkey4 FOREIGN KEY (re_id) REFERENCES tool_netcom.calibration_reasons(re_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5200 (class 2606 OID 26452)
-- Name: data_calibrations tool_netcom_v2_data_calibrations_fkey5; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_calibrations
    ADD CONSTRAINT tool_netcom_v2_data_calibrations_fkey5 FOREIGN KEY (zero_me_id) REFERENCES tool_netcom.calibration_methods(me_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5201 (class 2606 OID 26457)
-- Name: data_calibrations tool_netcom_v2_data_calibrations_fkey6; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_calibrations
    ADD CONSTRAINT tool_netcom_v2_data_calibrations_fkey6 FOREIGN KEY (span_me_id) REFERENCES tool_netcom.calibration_methods(me_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5202 (class 2606 OID 26462)
-- Name: data_calibrations tool_netcom_v2_data_calibrations_fkey7; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_calibrations
    ADD CONSTRAINT tool_netcom_v2_data_calibrations_fkey7 FOREIGN KEY (zero_cyl_arpa_id) REFERENCES tool_netcom.cylinders(arpa_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5203 (class 2606 OID 26467)
-- Name: data_calibrations tool_netcom_v2_data_calibrations_fkey8; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_calibrations
    ADD CONSTRAINT tool_netcom_v2_data_calibrations_fkey8 FOREIGN KEY (span_cyl_arpa_id) REFERENCES tool_netcom.cylinders(arpa_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5204 (class 2606 OID 26472)
-- Name: data_calibrations tool_netcom_v2_data_calibrations_fkey9; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_calibrations
    ADD CONSTRAINT tool_netcom_v2_data_calibrations_fkey9 FOREIGN KEY (cal_arpa_id) REFERENCES tool_netcom.instruments(arpa_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5209 (class 2606 OID 26477)
-- Name: data_maintenances tool_netcom_v2_data_maintenances_fkey1; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_maintenances
    ADD CONSTRAINT tool_netcom_v2_data_maintenances_fkey1 FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5210 (class 2606 OID 26482)
-- Name: data_maintenances tool_netcom_v2_data_maintenances_fkey2; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_maintenances
    ADD CONSTRAINT tool_netcom_v2_data_maintenances_fkey2 FOREIGN KEY (us_id) REFERENCES public._users(us_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5211 (class 2606 OID 26487)
-- Name: data_operations tool_netcom_v2_data_operations_fkey1; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_operations
    ADD CONSTRAINT tool_netcom_v2_data_operations_fkey1 FOREIGN KEY (ma_id) REFERENCES tool_netcom.data_maintenances(ma_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5212 (class 2606 OID 26492)
-- Name: data_operations tool_netcom_v2_data_operations_fkey2; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_operations
    ADD CONSTRAINT tool_netcom_v2_data_operations_fkey2 FOREIGN KEY (op_id) REFERENCES tool_netcom.operations(op_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5213 (class 2606 OID 26497)
-- Name: data_spare_parts tool_netcom_v2_data_spare_parts_fkey1; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_spare_parts
    ADD CONSTRAINT tool_netcom_v2_data_spare_parts_fkey1 FOREIGN KEY (ma_id) REFERENCES tool_netcom.data_maintenances(ma_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5214 (class 2606 OID 26502)
-- Name: data_spare_parts tool_netcom_v2_data_spare_parts_fkey2; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.data_spare_parts
    ADD CONSTRAINT tool_netcom_v2_data_spare_parts_fkey2 FOREIGN KEY (sp_id) REFERENCES tool_netcom.spare_parts(sp_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5215 (class 2606 OID 26507)
-- Name: instruments_categories_parameters tool_netcom_v2_instruments_categories_parameters_fkey1; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments_categories_parameters
    ADD CONSTRAINT tool_netcom_v2_instruments_categories_parameters_fkey1 FOREIGN KEY (in_ca_id) REFERENCES tool_netcom.instrument_categories(in_ca_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5216 (class 2606 OID 26512)
-- Name: instruments_categories_parameters tool_netcom_v2_instruments_categories_parameters_fkey2; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments_categories_parameters
    ADD CONSTRAINT tool_netcom_v2_instruments_categories_parameters_fkey2 FOREIGN KEY (pr_id) REFERENCES public._parameters_list_master(pr_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5205 (class 2606 OID 26517)
-- Name: instruments tool_netcom_v2_instruments_fkey; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments
    ADD CONSTRAINT tool_netcom_v2_instruments_fkey FOREIGN KEY (in_ty_id) REFERENCES tool_netcom.instruments_types(in_ty_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5217 (class 2606 OID 26522)
-- Name: instruments_metadata tool_netcom_v2_instruments_metadata_fkey2; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments_metadata
    ADD CONSTRAINT tool_netcom_v2_instruments_metadata_fkey2 FOREIGN KEY (in_ty_id) REFERENCES tool_netcom.instruments_types(in_ty_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5219 (class 2606 OID 26527)
-- Name: instruments_operations tool_netcom_v2_instruments_operations_fkey1; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments_operations
    ADD CONSTRAINT tool_netcom_v2_instruments_operations_fkey1 FOREIGN KEY (in_ty_id) REFERENCES tool_netcom.instruments_types(in_ty_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5220 (class 2606 OID 26532)
-- Name: instruments_operations tool_netcom_v2_instruments_operations_fkey2; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments_operations
    ADD CONSTRAINT tool_netcom_v2_instruments_operations_fkey2 FOREIGN KEY (op_id) REFERENCES tool_netcom.operations(op_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5221 (class 2606 OID 26537)
-- Name: instruments_spare_parts tool_netcom_v2_instruments_spare_parts_fkey1; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments_spare_parts
    ADD CONSTRAINT tool_netcom_v2_instruments_spare_parts_fkey1 FOREIGN KEY (in_ty_id) REFERENCES tool_netcom.instruments_types(in_ty_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5222 (class 2606 OID 26542)
-- Name: instruments_spare_parts tool_netcom_v2_instruments_spare_parts_fkey2; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments_spare_parts
    ADD CONSTRAINT tool_netcom_v2_instruments_spare_parts_fkey2 FOREIGN KEY (sp_id) REFERENCES tool_netcom.spare_parts(sp_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5223 (class 2606 OID 26547)
-- Name: instruments_types tool_netcom_v2_instruments_types_fkey1; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments_types
    ADD CONSTRAINT tool_netcom_v2_instruments_types_fkey1 FOREIGN KEY (in_ca_id) REFERENCES tool_netcom.instrument_categories(in_ca_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5224 (class 2606 OID 26552)
-- Name: operations tool_netcom_v2_operations_fkey1; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.operations
    ADD CONSTRAINT tool_netcom_v2_operations_fkey1 FOREIGN KEY (op_ca_id) REFERENCES tool_netcom.operation_category(op_ca_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5225 (class 2606 OID 26557)
-- Name: operations tool_netcom_v2_operations_fkey2; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.operations
    ADD CONSTRAINT tool_netcom_v2_operations_fkey2 FOREIGN KEY (op_fr_id) REFERENCES tool_netcom.operation_frequency(op_fr_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5234 (class 2606 OID 26562)
-- Name: stations_instruments tool_netcom_v2_stations_instruments_fkey1; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.stations_instruments
    ADD CONSTRAINT tool_netcom_v2_stations_instruments_fkey1 FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5218 (class 2606 OID 26567)
-- Name: instruments_metadata tool_netcom_v2_stations_instruments_fkey1; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.instruments_metadata
    ADD CONSTRAINT tool_netcom_v2_stations_instruments_fkey1 FOREIGN KEY (arpa_id) REFERENCES tool_netcom.instruments(arpa_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5235 (class 2606 OID 26572)
-- Name: stations_instruments tool_netcom_v2_stations_instruments_fkey2; Type: FK CONSTRAINT; Schema: tool_netcom; Owner: postgres
--

ALTER TABLE ONLY tool_netcom.stations_instruments
    ADD CONSTRAINT tool_netcom_v2_stations_instruments_fkey2 FOREIGN KEY (arpa_id) REFERENCES tool_netcom.instruments(arpa_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5236 (class 2606 OID 26717)
-- Name: pages pages_gr_id_fkey; Type: FK CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.pages
    ADD CONSTRAINT pages_gr_id_fkey FOREIGN KEY (gr_id) REFERENCES tool_visualizer_lily.pages_groups(gr_id) ON DELETE CASCADE;


--
-- TOC entry 5238 (class 2606 OID 26722)
-- Name: pages_groups_users pages_groups_users_gr_id_fkey; Type: FK CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.pages_groups_users
    ADD CONSTRAINT pages_groups_users_gr_id_fkey FOREIGN KEY (gr_id) REFERENCES tool_visualizer_lily.pages_groups(gr_id) ON DELETE CASCADE;


--
-- TOC entry 5239 (class 2606 OID 26727)
-- Name: pages_groups_users pages_groups_users_us_id_fkey; Type: FK CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.pages_groups_users
    ADD CONSTRAINT pages_groups_users_us_id_fkey FOREIGN KEY (us_id) REFERENCES public._users(us_id) ON DELETE CASCADE;


--
-- TOC entry 5237 (class 2606 OID 26732)
-- Name: pages pages_st_id_fkey; Type: FK CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.pages
    ADD CONSTRAINT pages_st_id_fkey FOREIGN KEY (st_id_fk) REFERENCES public._stations(st_id) ON DELETE CASCADE;


--
-- TOC entry 5240 (class 2606 OID 26737)
-- Name: pages_windows pages_windows_autoscale_fkey; Type: FK CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.pages_windows
    ADD CONSTRAINT pages_windows_autoscale_fkey FOREIGN KEY (autoscale) REFERENCES tool_visualizer_lily.page_autoscale(id);


--
-- TOC entry 5241 (class 2606 OID 26742)
-- Name: pages_windows pages_windows_charttype_fkey; Type: FK CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.pages_windows
    ADD CONSTRAINT pages_windows_charttype_fkey FOREIGN KEY (charttype) REFERENCES tool_visualizer_lily.page_charttype(id);


--
-- TOC entry 5242 (class 2606 OID 26747)
-- Name: pages_windows pages_windows_defaultview_fkey; Type: FK CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.pages_windows
    ADD CONSTRAINT pages_windows_defaultview_fkey FOREIGN KEY (defaultview) REFERENCES tool_visualizer_lily.page_defaultview(id);


--
-- TOC entry 5243 (class 2606 OID 26752)
-- Name: pages_windows pages_windows_inttime_fkey; Type: FK CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.pages_windows
    ADD CONSTRAINT pages_windows_inttime_fkey FOREIGN KEY (inttime) REFERENCES tool_visualizer_lily.page_integration(id);


--
-- TOC entry 5244 (class 2606 OID 26757)
-- Name: pages_windows pages_windows_pg_id_fkey; Type: FK CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.pages_windows
    ADD CONSTRAINT pages_windows_pg_id_fkey FOREIGN KEY (pg_id) REFERENCES tool_visualizer_lily.pages(pg_id) ON DELETE CASCADE;


--
-- TOC entry 5245 (class 2606 OID 26762)
-- Name: pages_windows pages_windows_st_pr_id_fkey; Type: FK CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.pages_windows
    ADD CONSTRAINT pages_windows_st_pr_id_fkey FOREIGN KEY (st_pr_id) REFERENCES public._stations_parameters_master(st_pr_id) ON DELETE CASCADE;


--
-- TOC entry 5247 (class 2606 OID 26767)
-- Name: users_settings_colors tool_analyser_lily_users_settings_colors_us_id_fkey; Type: FK CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.users_settings_colors
    ADD CONSTRAINT tool_analyser_lily_users_settings_colors_us_id_fkey FOREIGN KEY (us_id) REFERENCES public._users(us_id) ON DELETE RESTRICT;


--
-- TOC entry 5246 (class 2606 OID 26772)
-- Name: users_settings users_settings_us_id_fkey; Type: FK CONSTRAINT; Schema: tool_visualizer_lily; Owner: postgres
--

ALTER TABLE ONLY tool_visualizer_lily.users_settings
    ADD CONSTRAINT users_settings_us_id_fkey FOREIGN KEY (us_id) REFERENCES public._users(us_id) ON DELETE RESTRICT;


--
-- TOC entry 5248 (class 2606 OID 26887)
-- Name: group_stations tool_web_lily_group_stations_fk1; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.group_stations
    ADD CONSTRAINT tool_web_lily_group_stations_fk1 FOREIGN KEY (gr_id) REFERENCES tool_web_lily.groups(gr_id) ON UPDATE CASCADE;


--
-- TOC entry 5249 (class 2606 OID 26892)
-- Name: group_stations tool_web_lily_group_stations_fk2; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.group_stations
    ADD CONSTRAINT tool_web_lily_group_stations_fk2 FOREIGN KEY (st_id) REFERENCES public._stations(st_id) ON UPDATE CASCADE;


--
-- TOC entry 5250 (class 2606 OID 26897)
-- Name: labanalysis_files tool_web_lily_labanalysis_files_fkey; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.labanalysis_files
    ADD CONSTRAINT tool_web_lily_labanalysis_files_fkey FOREIGN KEY (analysis_type_fk) REFERENCES tool_web_lily.analysis_types(type_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5270 (class 2606 OID 26902)
-- Name: user_menu tool_web_lily_main_user_menu_fkey; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.user_menu
    ADD CONSTRAINT tool_web_lily_main_user_menu_fkey FOREIGN KEY (menu_id) REFERENCES tool_web_lily.menu(id) ON DELETE RESTRICT;


--
-- TOC entry 5251 (class 2606 OID 26907)
-- Name: memo_participants tool_web_lily_memo_participants_fkey1; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.memo_participants
    ADD CONSTRAINT tool_web_lily_memo_participants_fkey1 FOREIGN KEY (me_id) REFERENCES tool_web_lily.memos(me_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5252 (class 2606 OID 26912)
-- Name: memo_participants tool_web_lily_memo_participants_fkey2; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.memo_participants
    ADD CONSTRAINT tool_web_lily_memo_participants_fkey2 FOREIGN KEY (pa_id) REFERENCES tool_web_lily.participants(pa_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5253 (class 2606 OID 26917)
-- Name: memos tool_web_lily_memos_fkey; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.memos
    ADD CONSTRAINT tool_web_lily_memos_fkey FOREIGN KEY (us_id) REFERENCES tool_web_lily.users(us_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5254 (class 2606 OID 26922)
-- Name: surveys tool_web_lily_surveys_fkey; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.surveys
    ADD CONSTRAINT tool_web_lily_surveys_fkey FOREIGN KEY (us_id) REFERENCES tool_web_lily.users(us_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5255 (class 2606 OID 26927)
-- Name: tasks tool_web_lily_tasks_fkey1; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.tasks
    ADD CONSTRAINT tool_web_lily_tasks_fkey1 FOREIGN KEY (us_id) REFERENCES tool_web_lily.users(us_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5256 (class 2606 OID 26932)
-- Name: tasks tool_web_lily_tasks_fkey2; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.tasks
    ADD CONSTRAINT tool_web_lily_tasks_fkey2 FOREIGN KEY (task_type) REFERENCES tool_web_lily.task_types(ty_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5257 (class 2606 OID 26937)
-- Name: tasks tool_web_lily_tasks_fkey3; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.tasks
    ADD CONSTRAINT tool_web_lily_tasks_fkey3 FOREIGN KEY (us_id_close) REFERENCES tool_web_lily.users(us_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5258 (class 2606 OID 26942)
-- Name: tasks tool_web_lily_tasks_fkey4; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.tasks
    ADD CONSTRAINT tool_web_lily_tasks_fkey4 FOREIGN KEY (task_stid) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5259 (class 2606 OID 26947)
-- Name: tickets tool_web_lily_tickets_fkey; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.tickets
    ADD CONSTRAINT tool_web_lily_tickets_fkey FOREIGN KEY (tk_opening_operator_fk) REFERENCES tool_web_lily.users(us_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5260 (class 2606 OID 26952)
-- Name: tickets tool_web_lily_tickets_fkey10; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.tickets
    ADD CONSTRAINT tool_web_lily_tickets_fkey10 FOREIGN KEY (tk_freq_fk) REFERENCES tool_netcom.operation_frequency(op_fr_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5261 (class 2606 OID 26957)
-- Name: tickets tool_web_lily_tickets_fkey11; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.tickets
    ADD CONSTRAINT tool_web_lily_tickets_fkey11 FOREIGN KEY (tk_parent_id_fk) REFERENCES tool_web_lily.tickets(tk_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5262 (class 2606 OID 26962)
-- Name: tickets tool_web_lily_tickets_fkey2; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.tickets
    ADD CONSTRAINT tool_web_lily_tickets_fkey2 FOREIGN KEY (tk_recipient_group_fk) REFERENCES tool_web_lily.groups(gr_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5263 (class 2606 OID 26967)
-- Name: tickets tool_web_lily_tickets_fkey3; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.tickets
    ADD CONSTRAINT tool_web_lily_tickets_fkey3 FOREIGN KEY (tk_closure_operator_fk) REFERENCES tool_web_lily.users(us_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5264 (class 2606 OID 26972)
-- Name: tickets tool_web_lily_tickets_fkey4; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.tickets
    ADD CONSTRAINT tool_web_lily_tickets_fkey4 FOREIGN KEY (st_id_fk) REFERENCES public._stations(st_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5265 (class 2606 OID 26977)
-- Name: tickets tool_web_lily_tickets_fkey5; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.tickets
    ADD CONSTRAINT tool_web_lily_tickets_fkey5 FOREIGN KEY (in_id_fk) REFERENCES tool_netcom.instruments(in_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5266 (class 2606 OID 26982)
-- Name: tickets tool_web_lily_tickets_fkey6; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.tickets
    ADD CONSTRAINT tool_web_lily_tickets_fkey6 FOREIGN KEY (cy_id_fk) REFERENCES tool_netcom.cylinders(cy_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5267 (class 2606 OID 26987)
-- Name: tickets tool_web_lily_tickets_fkey7; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.tickets
    ADD CONSTRAINT tool_web_lily_tickets_fkey7 FOREIGN KEY (eq_id_fk) REFERENCES tool_netcom.equipments(eq_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5268 (class 2606 OID 26992)
-- Name: tickets tool_web_lily_tickets_fkey8; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.tickets
    ADD CONSTRAINT tool_web_lily_tickets_fkey8 FOREIGN KEY (tt_id_fk) REFERENCES tool_web_lily.ticket_types(tt_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5269 (class 2606 OID 26997)
-- Name: tickets tool_web_lily_tickets_fkey9; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.tickets
    ADD CONSTRAINT tool_web_lily_tickets_fkey9 FOREIGN KEY (tc_id_fk) REFERENCES tool_web_lily.ticket_categories(tc_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5271 (class 2606 OID 27002)
-- Name: users_groups tool_web_lily_users_groups_fkey1; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.users_groups
    ADD CONSTRAINT tool_web_lily_users_groups_fkey1 FOREIGN KEY (us_id) REFERENCES tool_web_lily.users(us_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5272 (class 2606 OID 27007)
-- Name: users_groups tool_web_lily_users_groups_fkey2; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.users_groups
    ADD CONSTRAINT tool_web_lily_users_groups_fkey2 FOREIGN KEY (gr_id) REFERENCES tool_web_lily.groups(gr_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 5273 (class 2606 OID 27012)
-- Name: users_settings tool_web_lily_users_settings_users_settings_fkey1; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.users_settings
    ADD CONSTRAINT tool_web_lily_users_settings_users_settings_fkey1 FOREIGN KEY (us_id) REFERENCES tool_web_lily.users(us_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 5206 (class 2606 OID 27017)
-- Name: users tool_web_lily_users_users_fkey1; Type: FK CONSTRAINT; Schema: tool_web_lily; Owner: postgres
--

ALTER TABLE ONLY tool_web_lily.users
    ADD CONSTRAINT tool_web_lily_users_users_fkey1 FOREIGN KEY (user_main_id) REFERENCES public._users(us_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


-- Completed on 2022-07-25 10:24:41

--
-- PostgreSQL database dump complete
--


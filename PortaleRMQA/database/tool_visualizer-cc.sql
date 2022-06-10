CREATE SCHEMA tool_visualizer_lily;
GRANT USAGE ON SCHEMA tool_visualizer_lily TO lily_admin;
GRANT USAGE ON SCHEMA tool_visualizer_lily TO lily_admin;

CREATE TABLE tool_visualizer_lily.page_defaultview (
  id smallint,
  defaultview varchar(25) default '',
  CONSTRAINT page_defaultview_pkey PRIMARY KEY (id)
) WITHOUT OIDS;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.page_defaultview TO lily_admin;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.page_defaultview TO lily_admin;

CREATE TABLE tool_visualizer_lily.page_charttype (
  id smallint,
  charttype varchar(25) default '',
  CONSTRAINT page_charttype_pkey PRIMARY KEY (id)
) WITHOUT OIDS;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.page_charttype TO lily_admin;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.page_charttype TO lily_admin;

CREATE TABLE tool_visualizer_lily.page_integration (
  id smallint,
  integration varchar(25) default '',
  CONSTRAINT page_integration_pkey PRIMARY KEY (id)
) WITHOUT OIDS;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.page_integration TO lily_admin;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.page_integration TO lily_admin;

CREATE TABLE tool_visualizer_lily.page_autoscale (
  id smallint,
  autoscale varchar(25) default '',
  CONSTRAINT page_autoscale_pkey PRIMARY KEY (id)
) WITHOUT OIDS;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.page_autoscale TO lily_admin;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.page_autoscale TO lily_admin;

CREATE TABLE tool_visualizer_lily.pages_groups (
  gr_id serial,
  name varchar(25) default '',
  po_id smallint default 0,
  CONSTRAINT pages_groups_pkey PRIMARY KEY (gr_id)
) WITHOUT OIDS;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.pages_groups TO lily_admin;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.pages_groups TO lily_admin;

CREATE TABLE tool_visualizer_lily.pages_groups_users (
  us_id smallint,
  gr_id smallint,
  CONSTRAINT pages_groups_users_pkey PRIMARY KEY (us_id, gr_id),
  CONSTRAINT pages_groups_users_ukey UNIQUE (gr_id),
  CONSTRAINT pages_groups_users_us_id_fkey FOREIGN KEY (us_id) REFERENCES _users(us_id) ON DELETE CASCADE,
  CONSTRAINT pages_groups_users_gr_id_fkey FOREIGN KEY (gr_id) REFERENCES tool_visualizer_lily.pages_groups(gr_id) ON DELETE CASCADE
) WITHOUT OIDS;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.pages_groups_users TO lily_admin;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.pages_groups_users TO lily_admin;

CREATE TABLE tool_visualizer_lily.pages (
  pg_id serial,
  gr_id smallint,
  po_id smallint default 0,
  name varchar(100) default '',
  description varchar(100) default '',
  backgroundimage varchar(250) default null,
  defaultview smallint NOT NULL DEFAULT 0,
  CONSTRAINT pages_pkey PRIMARY KEY (pg_id),
  CONSTRAINT pages_gr_id_fkey FOREIGN KEY (gr_id) REFERENCES tool_visualizer_lily.pages_groups(gr_id) ON DELETE CASCADE
) WITHOUT OIDS;
CREATE INDEX pages_grid_idx ON tool_visualizer_lily.pages USING btree (gr_id);
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.pages TO lily_admin;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.pages TO lily_admin;

CREATE TABLE tool_visualizer_lily.pages_windows (
  wd_id serial,
  pg_id smallint,
  st_pr_id smallint,
  useview boolean default false,
  view_id smallint default null,
  name varchar(250) not null,
  defaultview smallint default 0,
  charttype smallint default 0,
  stationname varchar(250) default null,
  parametername varchar(250) default null,
  decimals smallint default 2,
  nodays smallint default 2,
  inttime smallint  default 4,
  useformule boolean default false,
  color integer default '16711680',
  thick smallint default 0,
  points boolean default false,
  marks boolean default false,
  marksdrawevery smallint default 2,
  autoscale smallint default 0,
  scalemin real default 0,
  scalemax real default 1,
  scaleminoffset real default 5,
  scalemaxoffset real default 5,
  linered real default null,
  lineorange real default null,
  linegreen real default null,
  alertmin real default null,
  alertmax real default null,
  chartfunction integer default null,
  showmaxvalues boolean default false,
  showminvalues boolean default false,
  showstddevvalues boolean default false,
  showsgridband boolean default false,
  fontsize smallint default 0,
  fontbold boolean default false,
  fontcolor integer default '16711680',
  wtop integer default 0,
  wleft integer default 0,
  wwidth integer default 0,
  wheight integer default 0,
  wpretop integer default 0,
  wpreleft integer default 0,
  wprewidth integer default 0,
  wpreheight integer default 0,
  wnumtop integer default 0,
  wnumleft integer default 0,
  wnumwidth integer default 0,
  wnumheight integer default 0,
  po_id smallint default 0,
  CONSTRAINT pages_windows_pkey PRIMARY KEY (wd_id),
  CONSTRAINT pages_windows_pg_id_fkey FOREIGN KEY (pg_id) REFERENCES tool_visualizer_lily.pages(pg_id) ON DELETE CASCADE,
  CONSTRAINT pages_windows_st_pr_id_fkey FOREIGN KEY (st_pr_id) REFERENCES _stations_parameters(st_pr_id) ON DELETE CASCADE,
  CONSTRAINT pages_windows_defaultview_fkey FOREIGN KEY (defaultview) REFERENCES tool_visualizer_lily.page_defaultview(id),
  CONSTRAINT pages_windows_charttype_fkey FOREIGN KEY (charttype) REFERENCES tool_visualizer_lily.page_charttype(id),
  CONSTRAINT pages_windows_inttime_fkey FOREIGN KEY (inttime) REFERENCES tool_visualizer_lily.page_integration(id),
  CONSTRAINT pages_windows_autoscale_fkey FOREIGN KEY (autoscale) REFERENCES tool_visualizer_lily.page_autoscale(id)
) WITHOUT OIDS;
CREATE INDEX pages_windows_pgid_idx ON tool_visualizer_lily.pages_windows USING btree (pg_id);
CREATE INDEX pages_windows_stprid_idx ON tool_visualizer_lily.pages_windows USING btree (st_pr_id);
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.pages_windows TO lily_admin;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.pages_windows TO lily_admin;

CREATE TABLE tool_visualizer_lily.users_settings (
  us_id smallint,
  theme_01 smallint default 0,
  theme_02 smallint default 0,
  theme_03 smallint default 0,
  theme_04 smallint default 0,
  theme_05 smallint default 0,
  CONSTRAINT users_settings_pkey PRIMARY KEY (us_id),
  CONSTRAINT users_settings_us_id_fkey FOREIGN KEY (us_id) REFERENCES _users(us_id) ON DELETE RESTRICT
) WITHOUT OIDS;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.users_settings TO lily_admin;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.users_settings TO lily_admin;

CREATE TABLE tool_visualizer_lily.users_settings_colors (
  us_id     smallint,
  color_01  integer not null,
  color_02  integer not null,
  color_03  integer not null,
  color_04  integer not null,
  color_05  integer not null,
  color_06  integer not null,
  color_07  integer not null,
  color_08  integer not null,
  color_09  integer not null,
  color_10  integer not null,
  color_11  integer not null,
  color_12  integer not null,
  color_13  integer not null,
  color_14  integer not null,
  color_15  integer not null,
  color_16  integer not null,
  color_17  integer not null,
  color_18  integer not null,
  color_19  integer not null,
  color_20  integer not null,
  color_21  integer not null,
  color_22  integer not null,
  color_23  integer not null,
  color_24  integer not null,
  color_25  integer not null,
  color_26  integer not null,
  color_27  integer not null,
  color_28  integer not null,
  color_29  integer not null,
  color_30  integer not null,
  CONSTRAINT tool_analyser_lily_users_settings_colors_pkey PRIMARY KEY (us_id),
  CONSTRAINT tool_analyser_lily_users_settings_colors_us_id_fkey FOREIGN KEY (us_id) REFERENCES _users(us_id) ON DELETE RESTRICT
) WITHOUT OIDS;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.users_settings_colors TO lily_admin;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.users_settings_colors TO lily_admin;

CREATE OR REPLACE VIEW tool_visualizer_lily.stations_parameters_properties AS
SELECT _stations.stationname, _stations.schema, _stations.tableid, _stations.po_id,
  _stations_parameters.st_pr_id, _stations_parameters.st_id,
  _stations_parameters.pr_id, _stations_parameters.id, _stations_parameters.hidden,
  _stations_parameters.description, _parameters_list.name, _parameters_list.shortname,
  _parameters_list.unit, _parameters_list.unitconv, _parameters_list.decimals,
  _parameter_treatment.treatment, _parameters_list.chartstyle, _parameters_list.color,
  _parameters_list.formule,
  CASE _parameters_formules.formuleoverride::text <> ''::text
      WHEN true THEN _parameters_formules.formuleoverride::text
      ELSE _parameters_list.formule::text
  END AS formuleoverride, _parameters_list.treatment AS treatment_id, _parameters_list.root_pr_id, _users_parameters.us_id
FROM _stations
  JOIN _stations_parameters USING (st_id)
  JOIN _parameters_list USING (pr_id)
  JOIN _users_parameters USING (pr_id)
  JOIN _parameter_treatment ON _parameters_list.treatment = _parameter_treatment.id
  LEFT JOIN _parameters_formules ON _stations_parameters.st_pr_id = _parameters_formules.st_pr_id;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.stations_parameters_properties TO lily_admin;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.stations_parameters_properties TO lily_admin;

CREATE OR REPLACE VIEW tool_visualizer_lily.stations_properties AS
SELECT
    _stations.st_id, _stations.stationname, _stations.schema, _stations.tableid,
    _stations.po_id, station_typology.typology, stations_metadata.locality,
    stations_metadata.commune, stations_metadata.province, stations_metadata.region,
    stations_metadata.longitude, stations_metadata.latitude,
    stations_metadata.east, stations_metadata.north,
    stations_metadata.altitude, stations_metadata.note, _users_stations.us_id
FROM _stations
JOIN _users_stations USING (st_id)
LEFT JOIN metadata.stations_metadata USING (st_id)
LEFT JOIN metadata.station_typology ON stations_metadata.typology = station_typology.id
ORDER BY _stations.po_id;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.stations_properties TO lily_admin;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.stations_properties TO lily_admin;

CREATE OR REPLACE FUNCTION tool_visualizer_lily.clone_user_pages(user_id integer, new_user_id integer)
  RETURNS boolean AS
$BODY$
DECLARE
  view_pages        RECORD;
  rec_pages_groups  RECORD;
  rec_pages_windows RECORD;
  mygrid            INTEGER;
  mypgid            INTEGER;
  ret               INTEGER;
BEGIN
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
    FOR view_pages IN SELECT * FROM tool_visualizer_lily.pages_groups_users
            JOIN tool_visualizer_lily.pages_groups USING(gr_id)
            WHERE us_id = user_id ORDER BY gr_id LOOP

        INSERT INTO tool_visualizer_lily.pages_groups(name, po_id)
                VALUES (view_pages.name, view_pages.po_id) RETURNING gr_id INTO mygrid;

        INSERT INTO tool_visualizer_lily.pages_groups_users(us_id, gr_id) VALUES (new_user_id, mygrid);

        FOR rec_pages_groups IN SELECT * FROM tool_visualizer_lily.pages WHERE gr_id = view_pages.gr_id ORDER BY pg_id LOOP

            INSERT INTO tool_visualizer_lily.pages(gr_id, name, description, backgroundimage, po_id, defaultview)
                VALUES (mygrid, rec_pages_groups.name, rec_pages_groups.description,
                        rec_pages_groups.backgroundimage, rec_pages_groups.po_id, rec_pages_groups.defaultview)
            RETURNING pg_id INTO mypgid;

            FOR rec_pages_windows IN SELECT * FROM tool_visualizer_lily.pages_windows WHERE pg_id = rec_pages_groups.pg_id ORDER BY wd_id LOOP

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

EXCEPTION
  WHEN OTHERS THEN
    RAISE NOTICE 'ERROR IN tool_visualizer_lily.clone_user_pages : %', SQLERRM ;
    RETURN false;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE;
ALTER FUNCTION tool_visualizer_lily.clone_user_pages(integer, integer) OWNER TO postgres;

CREATE OR REPLACE FUNCTION tool_visualizer_lily.clone_user_settings(user_id integer, new_user_id integer)
  RETURNS boolean AS
$BODY$
DECLARE
  rec_us    RECORD;
BEGIN

    BEGIN
        RAISE NOTICE 'Deleting from table tool_visualizer_lily.users_settings ...';
        DELETE FROM tool_visualizer_lily.users_settings WHERE us_id = new_user_id;
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'ERROR in tool_visualizer_lily.users_settings : %', SQLERRM;
    END;

    FOR rec_us IN SELECT * FROM tool_visualizer_lily.users_settings WHERE us_id = user_id LOOP

        INSERT INTO tool_visualizer_lily.users_settings( us_id,
                    theme_01, theme_02, theme_03, theme_04, theme_05)
        VALUES (new_user_id,
                    rec_us.theme_01, rec_us.theme_02, rec_us.theme_03,
                    rec_us.theme_04, rec_us.theme_05
        );

    END LOOP;

    RETURN true;

EXCEPTION

  WHEN OTHERS THEN
    RAISE NOTICE 'ERROR IN tool_visualizer_lily.clone_user_settings : %', SQLERRM ;
    RETURN false;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE;
ALTER FUNCTION tool_visualizer_lily.clone_user_settings(integer, integer) OWNER TO postgres;

DROP VIEW IF EXISTS tool_visualizer_lily.visualizer;
CREATE OR REPLACE VIEW tool_visualizer_lily.visualizer AS
SELECT
  u.username as user_name,
  pw.wd_id, pg_id, pw.st_pr_id, pw.name AS window_name,
  pw.defaultview AS window_defaultview, pw.charttype, pw.stationname,
  pw.parametername, pw.decimals, pw.nodays, pw.inttime, pw.useformule,
  pw.color, pw.thick, pw.points, pw.marks, pw.autoscale, pw.scalemin,
  pw.scalemax, pw.linered, pw.linegreen, pw.alertmin, pw.alertmax,
  pw.chartfunction, pw.showmaxvalues, pw.showminvalues, pw.wtop, pw.wleft,
  pw.wwidth, pw.wheight, pw.po_id, pw.showstddevvalues, pw.wpretop,
  pw.wpreleft, pw.wprewidth, pw.wpreheight, pw.useview, pw.wnumtop,
  pw.wnumleft, pw.wnumwidth, pw.wnumheight, pw.view_id, pw.scaleminoffset,
  pw.scalemaxoffset, pw.showsgridband, pw.fontsize, pw.fontbold, pw.fontcolor,
  pw.marksdrawevery,
  p.name AS page_name, p.description, p.backgroundimage, p.po_id AS page_po,
  p.defaultview AS page_defaultview,
  pg.name, pg.po_id AS group_po,
  gu.us_id, gr_id
FROM
  tool_visualizer_lily.pages_windows pw
  LEFT JOIN tool_visualizer_lily.pages p USING (pg_id)
  LEFT JOIN tool_visualizer_lily.pages_groups pg USING (gr_id)
  LEFT JOIN tool_visualizer_lily.pages_groups_users gu USING (gr_id)
  LEFT JOIN _users u USING (us_id)
ORDER BY gu.us_id, gr_id, pg_id, pw.wd_id;

DROP VIEW IF EXISTS tool_web_lily.view_visualizer_map_stations;
CREATE OR REPLACE VIEW tool_web_lily.view_visualizer_map_stations AS
SELECT
    DISTINCT ON (st_id)
    st_id         AS st_id,
    pg.pg_id      AS pg_id,
    stationname   AS station_name,
    m.networktype AS network_id,
    n.networktype AS network_type,
    m.zone        AS zone, 
    m.basin       AS basin, 
    m.locality    AS locality, 
    m.commune     AS commune, 
    m.community   AS community, 
    m.province    AS province, 
    m.region      AS region, 
    m.note        AS note, 
    m.altitude    AS altitude, 
    m.lat_wgs84   AS lat_wgs84, 
    m.lon_wgs84   AS lon_wgs84  
FROM
    _stations s
    LEFT JOIN _stations_parameters p USING(st_id)
    LEFT JOIN metadata.stations_metadata m USING(st_id)
    LEFT JOIN metadata.station_networktype n ON m.networktype = n.id
    LEFT JOIN tool_visualizer_lily.pages pg ON pg.description::smallint = s.st_id
WHERE
    pg.gr_id=2
    AND m.lat_wgs84 IS NOT null
    AND m.lon_wgs84 IS NOT null
ORDER BY st_id;
GRANT SELECT ON TABLE tool_web_lily.view_visualizer_map_stations TO lily_admin;

EXCEPTION

   WHEN OTHERS THEN RAISE NOTICE 'ERROR in update_calccode_stprid_fulldate: %', SQLERRM;
   RETURN false;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION update_calccode_stprid_fulldate(smallint, timestamp without time zone, smallint)
  OWNER TO postgres;

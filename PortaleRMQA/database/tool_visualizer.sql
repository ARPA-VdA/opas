GRANT SELECT ON TABLE tables_ar.data_plouves_calibrations TO lily_admin;
GRANT SELECT ON TABLE tables_ar.data_liconi_calibrations TO lily_admin;
GRANT SELECT ON TABLE tables_ar.data_pepiniere_calibrations TO lily_admin;
GRANT SELECT ON TABLE tables_ar.data_mt_fleury_calibrations TO lily_admin;
GRANT SELECT ON TABLE tables_ar.data_la_thuile_calibrations TO lily_admin;
GRANT SELECT ON TABLE tables_ar.data_donnas_calibrations TO lily_admin;
GRANT SELECT ON TABLE tables_ar.data_lab02_calibrations TO lily_admin;

CREATE SCHEMA tool_visualizer_lily;
GRANT USAGE ON SCHEMA tool_visualizer_lily TO read_only_sdms;
GRANT USAGE ON SCHEMA tool_visualizer_lily TO read_only;

CREATE TABLE tool_visualizer_lily.page_defaultview (
  id smallint,
  defaultview varchar(25) default '',
  CONSTRAINT page_defaultview_pkey PRIMARY KEY (id)
) WITHOUT OIDS;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.page_defaultview TO read_only_sdms;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.page_defaultview TO read_only;

CREATE TABLE tool_visualizer_lily.page_charttype (
  id smallint,
  charttype varchar(25) default '',
  CONSTRAINT page_charttype_pkey PRIMARY KEY (id)
) WITHOUT OIDS;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.page_charttype TO read_only_sdms;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.page_charttype TO read_only;

CREATE TABLE tool_visualizer_lily.page_integration (
  id smallint,
  integration varchar(25) default '',
  CONSTRAINT page_integration_pkey PRIMARY KEY (id)
) WITHOUT OIDS;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.page_integration TO read_only_sdms;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.page_integration TO read_only;

CREATE TABLE tool_visualizer_lily.page_autoscale (
  id smallint,
  autoscale varchar(25) default '',
  CONSTRAINT page_autoscale_pkey PRIMARY KEY (id)
) WITHOUT OIDS;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.page_autoscale TO read_only_sdms;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.page_autoscale TO read_only;

CREATE TABLE tool_visualizer_lily.pages_groups (
  gr_id serial,
  name varchar(25) default '',
  po_id smallint default 0,
  CONSTRAINT pages_groups_pkey PRIMARY KEY (gr_id)
) WITHOUT OIDS;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.pages_groups TO read_only_sdms;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.pages_groups TO read_only;

CREATE TABLE tool_visualizer_lily.pages_groups_users (
  us_id smallint,
  gr_id smallint,
  CONSTRAINT pages_groups_users_pkey PRIMARY KEY (us_id, gr_id),
  CONSTRAINT pages_groups_users_ukey UNIQUE (gr_id),
  CONSTRAINT pages_groups_users_us_id_fkey FOREIGN KEY (us_id) REFERENCES _users(us_id) ON DELETE CASCADE,
  CONSTRAINT pages_groups_users_gr_id_fkey FOREIGN KEY (gr_id) REFERENCES tool_visualizer_lily.pages_groups(gr_id) ON DELETE CASCADE
) WITHOUT OIDS;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.pages_groups_users TO read_only_sdms;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.pages_groups_users TO read_only;

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
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.pages TO read_only_sdms;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.pages TO read_only;

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
  CONSTRAINT pages_windows_st_pr_id_fkey FOREIGN KEY (st_pr_id) REFERENCES _stations_parameters_master(st_pr_id) ON DELETE CASCADE,
  CONSTRAINT pages_windows_defaultview_fkey FOREIGN KEY (defaultview) REFERENCES tool_visualizer_lily.page_defaultview(id),
  CONSTRAINT pages_windows_charttype_fkey FOREIGN KEY (charttype) REFERENCES tool_visualizer_lily.page_charttype(id),
  CONSTRAINT pages_windows_inttime_fkey FOREIGN KEY (inttime) REFERENCES tool_visualizer_lily.page_integration(id),
  CONSTRAINT pages_windows_autoscale_fkey FOREIGN KEY (autoscale) REFERENCES tool_visualizer_lily.page_autoscale(id)
) WITHOUT OIDS;
CREATE INDEX pages_windows_pgid_idx ON tool_visualizer_lily.pages_windows USING btree (pg_id);
CREATE INDEX pages_windows_stprid_idx ON tool_visualizer_lily.pages_windows USING btree (st_pr_id);
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.pages_windows TO read_only_sdms;
GRANT SELECT, UPDATE ON TABLE tool_visualizer_lily.pages_windows TO read_only;

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
  rec_us	RECORD;
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

EXCEPTION

   WHEN OTHERS THEN RAISE NOTICE 'ERROR in update_calccode_stprid_fulldate: %', SQLERRM;
   RETURN false;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION update_calccode_stprid_fulldate(smallint, timestamp without time zone, smallint)
  OWNER TO postgres;

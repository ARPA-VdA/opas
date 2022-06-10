DROP SCHEMA IF EXISTS tool_web_lily CASCADE;
CREATE SCHEMA tool_web_lily AUTHORIZATION lily;
GRANT ALL ON SCHEMA tool_web_lily TO lily;

DROP TABLE IF EXISTS tool_web_lily.users;
CREATE TABLE tool_web_lily.users (
    us_id             serial  not null,
    user_name         text    not null check (user_name <> ''),
    user_surname      text    not null check (user_surname <> ''),
    user_password     text    not null check (user_password <> ''),
    user_telephone    text,
    user_email        text,
    user_avatar       text,
    user_active       boolean default true,
    user_main_id      integer default null,
    user_last_online  timestamp default null,
    user_insert_time  timestamp default current_timestamp,
    CONSTRAINT tool_web_lily_users_pkey PRIMARY KEY (us_id),
    CONSTRAINT tool_web_lily_users_ukey UNIQUE (user_name, user_surname),
    CONSTRAINT tool_web_lily_users_users_fkey1 FOREIGN KEY (user_main_id)
        REFERENCES _users (us_id) MATCH SIMPLE ON UPDATE RESTRICT ON DELETE RESTRICT
);
GRANT SELECT ON TABLE tool_web_lily.users TO read_only_sdms;

DROP TABLE IF EXISTS tool_web_lily.users_settings;
CREATE TABLE tool_web_lily.users_settings (
    us_id             integer not null,
    homepage          hstore  not null,
    CONSTRAINT tool_web_lily_users_settings_pkey PRIMARY KEY (us_id),
    CONSTRAINT tool_web_lily_users_settings_ukey UNIQUE (us_id),
    CONSTRAINT tool_web_lily_users_settings_users_settings_fkey1 FOREIGN KEY (us_id)
        REFERENCES tool_web_lily.users (us_id) MATCH SIMPLE ON UPDATE RESTRICT ON DELETE RESTRICT
);
GRANT SELECT ON TABLE tool_web_lily.users_settings TO read_only_sdms;

DROP TABLE IF EXISTS tool_web_lily.groups;
CREATE TABLE tool_web_lily.groups (
    gr_id       smallint not null,
    group_name  text     not null,
    CONSTRAINT tool_web_lily_groups_pkey PRIMARY KEY (gr_id),
    CONSTRAINT tool_web_lily_groups_ukey UNIQUE (group_name)
);
GRANT SELECT ON TABLE tool_web_lily.groups TO read_only_sdms;

DROP TABLE IF EXISTS tool_web_lily.users_groups;
CREATE TABLE tool_web_lily.users_groups (
    us_gr_id            serial not null,
    us_id               integer not null,
    gr_id               integer not null,
    CONSTRAINT tool_web_lily_users_groups_pkey PRIMARY KEY (us_gr_id),
    CONSTRAINT tool_web_lily_users_groups_ukey UNIQUE (us_id, gr_id),
    CONSTRAINT tool_web_lily_users_groups_fkey1 FOREIGN KEY (us_id)
        REFERENCES tool_web_lily.users (us_id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT tool_web_lily_users_groups_fkey2 FOREIGN KEY (gr_id)
        REFERENCES tool_web_lily.groups (gr_id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
);
GRANT SELECT ON TABLE tool_web_lily.users_groups TO read_only_sdms;

DROP TABLE IF EXISTS tool_web_lily.users_logs;
CREATE TABLE tool_web_lily.users_logs (
    id          serial,
    log_info    hstore not null,
    log_date    timestamp default current_timestamp,
    CONSTRAINT tool_web_lily_users_logs_pkey PRIMARY KEY (id)
);
GRANT SELECT ON TABLE tool_web_lily.users_logs TO read_only_sdms;

DROP VIEW IF EXISTS tool_web_lily.view_users;
CREATE OR REPLACE VIEW tool_web_lily.view_users AS
SELECT
    us_id,
    user_name,
    user_surname,
    user_name || ' ' || user_surname AS user_fullname,
    user_password,
    user_telephone,
    user_email,
    user_active,
    user_insert_time,
    COALESCE(user_avatar, 'default.png') AS user_avatar,
    user_main_id,
    gr_id,
    group_name
FROM
    tool_web_lily.users u
    LEFT JOIN tool_web_lily.users_groups ug USING(us_id)
    LEFT JOIN tool_web_lily.groups g USING(gr_id)
ORDER BY us_id;
GRANT SELECT ON TABLE tool_web_lily.view_users TO read_only_sdms;

DROP VIEW IF EXISTS tool_web_lily.view_users_logs;
CREATE OR REPLACE VIEW tool_web_lily.view_users_logs AS
SELECT
    log_date,
    u.us_id,
    u.user_name || ' ' || u.user_surname AS user_fullname,
    log_info->'action' AS action
FROM
    tool_web_lily.users_logs l
    LEFT JOIN tool_web_lily.users u ON (l.log_info->'usid')::integer = u.us_id
ORDER BY 1;
GRANT SELECT ON TABLE tool_web_lily.view_users_logs TO read_only_sdms;

CREATE OR REPLACE FUNCTION tool_web_lily.get_user_last_login(integer)
  RETURNS timestamp AS
$BODY$
declare
    usid        integer;
    lastonline  timestamp;
BEGIN

    usid := $1;

    SELECT user_last_online AT TIME ZONE('Europe/Rome')
    INTO lastonline
    FROM tool_web_lily.users
    WHERE us_id = usid;

    RETURN lastonline;

EXCEPTION
   WHEN OTHERS THEN RAISE NOTICE 'ERROR in tool_web_lily.get_user_last_login : %', SQLERRM;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
GRANT EXECUTE ON FUNCTION tool_web_lily.get_user_last_login(integer) TO GROUP read_only_sdms;

DROP TABLE IF EXISTS tool_web_lily.menu CASCADE;
CREATE TABLE tool_web_lily.menu
(
    id              smallint NOT NULL,
    menu_name       text     NOT NULL CHECK (menu_name <> ''),
    menu_href       text     NOT NULL,
    menu_desc       text     NOT NULL CHECK (menu_desc <> ''),
    menu_css        text     ,
    badge_css       text     ,
    isdropdown      boolean  NOT NULL,
    isvisible       boolean  NOT NULL DEFAULT true,
    CONSTRAINT tool_web_lily_main_menu_pkey PRIMARY KEY (id),
    CONSTRAINT tool_web_lily_main_menu_ukey2 UNIQUE (menu_href)
)
WITH (OIDS=FALSE);
GRANT SELECT ON TABLE tool_web_lily.menu TO read_only_sdms;

DROP TABLE IF EXISTS tool_web_lily.user_menu CASCADE;
CREATE TABLE tool_web_lily.user_menu
(
    id             serial   NOT NULL,
    us_id          smallint NOT NULL,
    menu_id        smallint NOT NULL,
    menu_level     smallint NOT NULL,
    menu_order     smallint NOT NULL,
    menu_published boolean NOT NULL DEFAULT true,
    user_grants    hstore,
    CONSTRAINT tool_web_lily_main_user_menu_pkey PRIMARY KEY (us_id, menu_id, menu_level),
    CONSTRAINT tool_web_lily_main_user_menu_fkey FOREIGN KEY (menu_id)
        REFERENCES tool_web_lily.menu (id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE RESTRICT
)
WITH (OIDS=FALSE);
GRANT SELECT ON TABLE tool_web_lily.user_menu TO read_only_sdms;

DROP VIEW IF EXISTS tool_web_lily.view_user_menu;
CREATE VIEW tool_web_lily.view_user_menu AS
SELECT
    us.us_id,
    me.menu_name, me.menu_href, me.menu_desc, me.menu_css,
    me.badge_css, me.isdropdown, isvisible,
    um.menu_id, um.menu_level, um.menu_order, um.menu_published, um.user_grants
FROM
    tool_web_lily.user_menu um
    LEFT JOIN tool_web_lily.menu me ON me.id = um.menu_id
    LEFT JOIN tool_web_lily.users us USING(us_id)
ORDER BY um.us_id, um.menu_order;
GRANT SELECT ON TABLE tool_web_lily.view_user_menu TO read_only_sdms;

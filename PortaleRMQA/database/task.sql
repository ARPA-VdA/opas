DROP TABLE IF EXISTS tool_web_lily.task_types;
CREATE TABLE tool_web_lily.task_types (
    ty_id      integer not null,
    ty_desc    text not null,
    CONSTRAINT tool_web_lily_task_types_pkey PRIMARY KEY (ty_id)
);
GRANT SELECT ON TABLE tool_web_lily.task_types TO read_only_sdms;

CREATE TYPE tool_web_lily.enum_task_assignee AS ENUM ('Arpa', 'Ecometer');
DROP TABLE IF EXISTS tool_web_lily.tasks;
CREATE TABLE tool_web_lily.tasks (
    ta_id                    serial  not null,
    us_id                    integer not null,
    task_name                text,
    task_done                boolean,
    task_type                integer not null,
    task_stid                smallint,
    task_assignee            tool_web_lily.enum_task_assignee not null,
    task_insert_time         timestamp default current_timestamp,
    us_id_close              integer default null,
    task_close_time          timestamp default null,
    CONSTRAINT tool_web_lily_tasks_pkey PRIMARY KEY (ta_id),
    CONSTRAINT tool_web_lily_tasks_ukey UNIQUE (task_name, task_assignee),
    CONSTRAINT tool_web_lily_tasks_fkey1 FOREIGN KEY (us_id)
        REFERENCES tool_web_lily.users (us_id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT tool_web_lily_tasks_fkey2 FOREIGN KEY (task_type)
        REFERENCES tool_web_lily.task_types (ty_id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT tool_web_lily_tasks_fkey3 FOREIGN KEY (us_id_close)
        REFERENCES tool_web_lily.users (us_id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT tool_web_lily_tasks_fkey4 FOREIGN KEY (task_stid)
        REFERENCES _stations (st_id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
);
GRANT SELECT ON TABLE tool_web_lily.tasks TO read_only_sdms;

DROP VIEW IF EXISTS tool_web_lily.view_tasks;
CREATE OR REPLACE VIEW tool_web_lily.view_tasks AS
SELECT
    t.ta_id,
    t.task_name,
    t.task_done,
    t.task_type,
    t.task_stid,
    t.task_assignee,
    t.task_insert_time,
    tt.ty_desc,
    ss.stationname AS task_station,
    u1.user_name || ' ' || u1.user_surname AS user_fullname,
    t.task_close_time,
    u2.user_name || ' ' || u2.user_surname AS user_fullname_close
FROM
    tool_web_lily.tasks t
    LEFT JOIN tool_web_lily.task_types tt ON t.task_type = tt.ty_id
    LEFT JOIN tool_web_lily.users u1 ON t.us_id = u1.us_id
    LEFT JOIN tool_web_lily.users u2 ON t.us_id_close = u2.us_id
    LEFT JOIN _stations ss ON t.task_stid = ss.st_id
ORDER BY ta_id;
GRANT SELECT ON TABLE tool_web_lily.view_tasks TO read_only_sdms;

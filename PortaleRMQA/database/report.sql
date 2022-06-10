DROP VIEW IF EXISTS tool_web_lily.view_main_stations CASCADE;
CREATE OR REPLACE VIEW tool_web_lily.view_main_stations AS
SELECT
    s.st_id,
    s.stationname,
    s.schema,
    s.tableid,
    s.schema || '.' || s.tableid AS tablename,
    s.station_roaming_type,
    st.roaming_type,
    s.po_id,
    s.active,
    pos
FROM
    _stations s
    LEFT JOIN _station_roaming_type st ON st.id = s.station_roaming_type
    LEFT JOIN (VALUES
        (4000,  1), 
        (4160,  2), 
        (4140,  3), 
        (4020,  4), 
        (4050,  5), 
        (4070,  6), 
        (4080,  7), 
        (4180,  8), 
        (4110,  9), 
        (4100, 10), 
        (4510, 11), 
        (4040, 12), 
        (4570, 13), 
        (4580, 14), 
        (4590, 15), 
        (4620, 16), 
        (4150, 17), 
        (4130, 21), 
        (4030, 22), 
        (4090, 23), 
        (4999, 24), 
        (9000, 25), 
        (4990, 26), 
        (4991, 27), 
        (4992, 28)  
    ) AS t (st_id, pos) ON t.st_id = s.st_id
WHERE
    s.st_id IN(
        4000, 4020, 4030, 4040, 4050,
        4070, 4080, 4090, 4100, 4110,
        4140, 4160, 4510, 4570, 4580,
        4590, 4620, 4999, 9000, 4180, 4150,
        4990, 4991, 4992
    )
    AND active IS true
ORDER BY t.pos;
GRANT SELECT ON TABLE tool_web_lily.view_main_stations TO read_only_sdms;

DROP TABLE IF EXISTS tool_web_lily.surveys CASCADE;
CREATE TABLE tool_web_lily.surveys (
    su_id               integer   NOT NULL,
    us_id               integer   NOT NULL,
    survey_place        text      NOT NULL,
    survey_date         timestamp NOT NULL,
    survey_start_time   time      NOT NULL,
    survey_end_time     time      NOT NULL,
    survey_desc         text      NOT NULL,
    user_insert_time    timestamp default current_timestamp,

    CONSTRAINT tool_web_lily_surveys_pkey PRIMARY KEY (su_id),

    CONSTRAINT tool_web_lily_surveys_fkey FOREIGN KEY (us_id)
        REFERENCES tool_web_lily.users (us_id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
);
GRANT SELECT ON TABLE tool_web_lily.surveys TO read_only_sdms;

DROP SEQUENCE IF EXISTS tool_web_lily.surveys_su_id_seq;
CREATE SEQUENCE tool_web_lily.surveys_su_id_seq
    INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

DROP TABLE IF EXISTS tool_web_lily.surveys_attachements;
CREATE TABLE tool_web_lily.surveys_attachements
(
    attachement_id    serial  NOT NULL,
    su_id             integer NOT NULL,
    source_filename   text    NOT NULL,
    stored_filename   text    NOT NULL,
    is_image          boolean NOT NULL DEFAULT false,
    upload_date       timestamp without time zone DEFAULT now(),
    CONSTRAINT tool_web_lily_surveys_attachements_pkey PRIMARY KEY (attachement_id),
    CONSTRAINT tool_web_lily_surveys_attachements_ukey UNIQUE (su_id, source_filename)
)
WITH (OIDS=FALSE);
GRANT SELECT ON TABLE tool_web_lily.surveys_attachements TO read_only_sdms;

DROP VIEW IF EXISTS tool_web_lily.view_surveys;
CREATE VIEW tool_web_lily.view_surveys AS
SELECT
    s.su_id                                    AS su_id                   ,
    s.us_id                                    AS us_id                   ,
    u.user_name || ' ' || u.user_surname       AS user_fullname           ,
    s.survey_place                             AS survey_place            ,
    s.survey_date                              AS survey_date             ,
    to_char(s.survey_date, 'DD/MM/YYYY')       AS survey_date_format      ,
    s.survey_start_time                        AS survey_start_time       ,
    to_char(s.survey_start_time, 'HH24:MI')    AS survey_start_time_format,
    s.survey_end_time                          AS survey_end_time         ,
    to_char(s.survey_end_time, 'HH24:MI')      AS survey_end_time_format  ,
    s.survey_desc                              AS survey_desc             ,
    array_to_string(array(
        SELECT stored_filename
        FROM tool_web_lily.surveys_attachements a
        WHERE a.su_id = s.su_id
        ORDER BY a.attachement_id
    )::text[], ', ') AS stored_attachments,
    array_to_string(array(
        SELECT source_filename
        FROM tool_web_lily.surveys_attachements a
        WHERE a.su_id = s.su_id
        ORDER BY a.attachement_id
    )::text[], ', ') AS attachments
FROM
    tool_web_lily.surveys s
    LEFT JOIN tool_web_lily.users u ON s.us_id = u.us_id
ORDER BY 1;
GRANT SELECT ON TABLE tool_web_lily.view_surveys TO read_only_sdms;

DROP VIEW IF EXISTS tool_web_lily.view_data_calibrations_master;
CREATE VIEW tool_web_lily.view_data_calibrations_master AS
SELECT
    c.id                                         AS ca_id,
    c.fulldate                                   AS fulldate,
    c.st_id                                      AS st_id,
    s.stationname                                AS station_name,
    g.gr_id                                      AS gr_id,
    u.us_id                                      AS us_id,
    u.user_name || ' ' || u.user_surname         AS user_fullname,
    COALESCE(u.user_avatar, 'default.png'::text) AS user_avatar,
    i1.in_id                                     AS instrument_in_id,
    ic.in_ca_id                                  AS instrument_ca_id,
    i1.name                                      AS instrument,
    array_to_string(ARRAY[c.zero_found, c.zero_found2, c.zero_found3], ',') AS zero_info,
    c.zero_changed      AS zero_changed,
    array_to_string(ARRAY[c.span_found, c.span_found2, c.span_found3], ',') AS span_info,
    c.span_changed      AS span_changed,
    c.note              AS note,
    cyz.description     AS tank_zero,
    cys.description     AS tank_span,
    i2.in_id            AS calibrator_in_id,
    i2.name             AS calibrator
FROM
    tool_netcom.data_calibrations c
    LEFT JOIN _stations                         s   ON s.st_id = c.st_id
    LEFT JOIN tool_web_lily.users               u   ON c.us_id = u.user_main_id
    LEFT JOIN tool_web_lily.users_groups        ug  ON u.us_id = ug.us_id
    LEFT JOIN tool_web_lily.groups              g   ON g.gr_id = ug.gr_id
    LEFT JOIN tool_netcom.instruments           i1  ON c.arpa_id = i1.arpa_id
    LEFT JOIN tool_netcom.instruments           i2  ON c.cal_arpa_id = i2.arpa_id
    LEFT JOIN tool_netcom.calibration_reasons   r   ON c.re_id = r.re_id
    LEFT JOIN tool_netcom.calibration_methods   cm1 ON c.zero_me_id = cm1.me_id
    LEFT JOIN tool_netcom.calibration_methods   cm2 ON c.span_me_id = cm2.me_id
    LEFT JOIN tool_netcom.cylinders             cyz ON c.zero_cyl_arpa_id = cyz.arpa_id
    LEFT JOIN tool_netcom.cylinders             cys ON c.span_cyl_arpa_id = cys.arpa_id
    LEFT JOIN tool_netcom.instruments_types     it  ON i1.in_ty_id = it.in_ty_id
    LEFT JOIN tool_netcom.instrument_categories ic  ON it.in_ca_id = ic.in_ca_id
ORDER BY fulldate DESC, st_id ASC;
GRANT SELECT ON TABLE tool_web_lily.view_data_calibrations_master TO read_only_sdms;

DROP VIEW IF EXISTS tool_web_lily.view_data_calibrations_details;
CREATE VIEW tool_web_lily.view_data_calibrations_details AS
SELECT
    c.id                     AS ca_id,
    c.fulldate               AS fulldate,
    c.st_id                  AS st_id,
    s.stationname            AS station_name,
    c.us_id                  AS us_id,
    u.user_name || ' '
    || u.user_surname        AS user_fullname,
    COALESCE(u.user_avatar,
        'default.png'::text) AS user_avatar,
    c.arpa_id                AS instrument_arpa_id,
    i1.name                  AS instrument_name,
    si1.fl_active            AS instrument_active,
    it1.brand                AS instrument_brand,
    it1.model                AS instrument_model,
    it1.constructor          AS instrument_constructor,
    ic1.instrument_category  AS instrument_category,
    i1.in_ty_id              AS instrument_in_ty_id,
    it1.in_ca_id             AS instrument_in_ca_id,
    c.zero_found             AS zero_found,
    c.zero_set               AS zero_set,
    c.zero_found2            AS zero_found2,
    c.zero_set2              AS zero_set2,
    c.zero_found3            AS zero_found3,
    c.zero_set3              AS zero_set3,
    c.zero_changed           AS zero_changed,
    c.zero_me_id             AS zero_me_id,
    cm1.method_desc          AS zero_method_description,
    c.span_found             AS span_found,
    c.span_set               AS span_set,
    c.span_found2            AS span_found2,
    c.span_set2              AS span_set2,
    c.span_found3            AS span_found3,
    c.span_set3              AS span_set3,
    c.span_changed           AS span_changed,
    c.span_me_id             AS span_me_id,
    cm2.method_desc          AS span_method_description,
    c.flux                   AS flux,
    c.flux2                  AS flux2,
    c.flux3                  AS flux3,
    c.temperature            AS temperature,
    c.presssure              AS presssure,
    c.flux_changed           AS flux_changed,
    c.note                   AS note,
    c.re_id                  AS re_id,
    r.reason_desc            AS reason_description,
    c.zero_cyl_arpa_id       AS tank_zero_cyl_arpa_id,
    cyz.is_zero              AS tank_zero_is_zero,
    cyz.date_expiry          AS tank_zero_date_expiry,
    cyz.description          AS tank_zero_description,
    cyz.ch1_value            AS tank_zero_ch1,
    cyz.ch2_value            AS tank_zero_ch2,
    cyz.ch3_value            AS tank_zero_ch3,
    c.span_cyl_arpa_id       AS tank_span_cyl_arpa_id,
    cys.is_zero              AS tank_span_is_zero,
    cys.date_expiry          AS tank_span_date_expiry,
    cys.description          AS tank_span_description,
    cys.ch1_value            AS tank_span_ch1,
    cys.ch2_value            AS tank_span_ch2,
    cys.ch3_value            AS tank_span_ch3,
    c.cal_arpa_id            AS calibrator_arpa_id,
    i2.name                  AS calibrator_name,
    si2.fl_active            AS calibrator_active,
    it2.brand                AS calibrator_brand,
    it2.model                AS calibrator_model,
    it2.constructor          AS calibrator_constructor,
    ic2.instrument_category  AS calibrator_category,
    i2.in_ty_id              AS calibrator_in_ty_id,
    it2.in_ca_id             AS calibrator_in_ca_id
FROM
    tool_netcom.data_calibrations c
    LEFT JOIN _stations                         s   ON s.st_id = c.st_id
    LEFT JOIN tool_web_lily.users               u   ON c.us_id = u.user_main_id
    LEFT JOIN tool_netcom.instruments           i1  ON c.arpa_id = i1.arpa_id
    LEFT JOIN tool_netcom.instruments_types     it1 ON i1.in_ty_id = it1.in_ty_id
    LEFT JOIN tool_netcom.instrument_categories ic1 ON it1.in_ca_id = ic1.in_ca_id
    LEFT JOIN tool_netcom.stations_instruments  si1 ON c.arpa_id = (
        SELECT arpa_id FROM tool_netcom.stations_instruments WHERE si1.arpa_id = c.arpa_id LIMIT 1
    )
    LEFT JOIN tool_netcom.instruments           i2  ON c.cal_arpa_id = i2.arpa_id
    LEFT JOIN tool_netcom.instruments_types     it2 ON i2.in_ty_id = it2.in_ty_id
    LEFT JOIN tool_netcom.instrument_categories ic2 ON it2.in_ca_id = ic2.in_ca_id
    LEFT JOIN tool_netcom.stations_instruments  si2 ON c.arpa_id = (
        SELECT arpa_id FROM tool_netcom.stations_instruments WHERE si2.arpa_id = c.arpa_id LIMIT 1
    )
    LEFT JOIN tool_netcom.calibration_reasons   r   ON c.re_id = r.re_id
    LEFT JOIN tool_netcom.calibration_methods   cm1 ON c.zero_me_id = cm1.me_id
    LEFT JOIN tool_netcom.calibration_methods   cm2 ON c.span_me_id = cm2.me_id
    LEFT JOIN tool_netcom.cylinders cyz             ON c.zero_cyl_arpa_id = cyz.arpa_id
    LEFT JOIN tool_netcom.cylinders cys             ON c.span_cyl_arpa_id = cys.arpa_id
ORDER BY fulldate DESC, st_id ASC;
GRANT SELECT ON TABLE tool_web_lily.view_data_calibrations_details TO read_only_sdms;

DROP VIEW IF EXISTS tool_web_lily.view_data_maintenances;
CREATE VIEW tool_web_lily.view_data_maintenances AS
SELECT
    m.ma_id      ,
    m.st_id      ,
    m.fulldate   ,
    u.username   ,
    s.stationname,
    m.note
FROM
    tool_netcom.data_maintenances m
    LEFT JOIN _users u USING(us_id)
    LEFT JOIN _stations s ON s.st_id = m.st_id
ORDER BY ma_id;
GRANT SELECT ON TABLE tool_web_lily.view_data_maintenances TO read_only_sdms;

DROP VIEW IF EXISTS tool_web_lily.view_data_spare_parts;
CREATE VIEW tool_web_lily.view_data_spare_parts AS
SELECT
  i.name          AS "Strumento",
  vps.descrizione AS "Descrizione",
  sp.quantity     AS "Quantità",
  sp.arpa_id      AS "ArpaId",
  sp.ma_id        AS "MaId",
  sp.sp_id        AS "SpId",
  sp.id           AS "ID"  
FROM
  tool_netcom.data_spare_parts sp
  LEFT JOIN tool_netcom.view_spare_parts vps USING(sp_id)
  LEFT JOIN tool_netcom.stations_instruments si ON sp.arpa_id = si.arpa_id
  LEFT JOIN tool_netcom.instruments i ON i.arpa_id = si.arpa_id
ORDER BY sp.id;
GRANT SELECT ON TABLE tool_web_lily.view_data_spare_parts TO read_only_sdms;

DROP VIEW IF EXISTS tool_web_lily.view_data_operations;
CREATE VIEW tool_web_lily.view_data_operations AS
SELECT distinct o.id,
  i.name            AS "Strumento",
  o.note            AS "Note",
  o.filters_expdate AS "Scadenza",
  o.ca_id           AS "Taratura Id",
  vo.descrizione    AS "Descrizione",
  vo.frequenza      AS "Frequenza",
  vo.categoria      AS "Categoria",
  o.arpa_id         AS "ArpaId",
  o.ma_id           AS "MaId",
  o.op_id           AS "OpId",
  o.id              AS "ID"  
FROM
  tool_netcom.data_operations o
  LEFT JOIN tool_netcom.view_operations vo USING(op_id)
  LEFT JOIN tool_netcom.stations_instruments si ON o.arpa_id = si.arpa_id
  LEFT JOIN tool_netcom.instruments i ON i.arpa_id = si.arpa_id
ORDER BY o.id;
GRANT SELECT ON TABLE tool_web_lily.view_data_operations TO read_only_sdms;

DROP VIEW IF EXISTS tool_web_lily.view_operations_filters;
CREATE VIEW tool_web_lily.view_operations_filters AS
SELECT
    o.id                                   AS oper_id,
    o.ma_id                                AS oper_ma_id,
    o.arpa_id                              AS oper_arpa_id,
    o.op_id                                AS oper_op_id,
    o.note                                 AS oper_op_note,
    o.ca_id                                AS oper_ca_id,
    o.filters_expdate::date                AS oper_filter_expdate,
    o.filters_expdate::date - current_date AS oper_filter_time_left,
    m.st_id                                AS main_st_id,
    m.us_id                                AS main_us_id,
    m.fulldate                             AS main_fulldate,
    m.note                                 AS main_note,
    i.name                                 AS instr_name,
    t.brand                                AS instr_brand,
    t.model                                AS instr_model,
    t.constructor                          AS instr_constructor,
    c.instrument_category                  AS instr_category,
    s.stationname                          AS station_name,
    initcap(u.username)                    AS user_name,
    u.userremark                           AS user_remark
FROM
    tool_netcom.data_operations o
    LEFT JOIN tool_netcom.data_maintenances m using(ma_id)
    LEFT JOIN tool_netcom.instruments i USING(arpa_id)
    LEFT JOIN tool_netcom.instruments_types t USING(in_ty_id)
    LEFT JOIN tool_netcom.instrument_categories c USING(in_ca_id)
    LEFT JOIN _stations s USING(st_id)
    LEFT JOIN _users u USING(us_id)
where
    filters_expdate IS NOT NULL
ORDER BY oper_filter_time_left;
GRANT SELECT ON TABLE tool_web_lily.view_operations_filters TO read_only_sdms;

DROP VIEW IF EXISTS tool_web_lily.view_cylinders;
CREATE VIEW tool_web_lily.view_cylinders AS
SELECT
    c.cy_id                                             AS cy_id,
    c.arpa_id                                           AS arpa_id,
    c.is_zero                                           AS is_zero,
    c.in_ca_id                                          AS in_ca_id,
    c.date_built                                        AS date_built,
    c.date_expiry                                       AS date_expiry,
    date_expiry - current_date                          AS time_left,
    c.description                                       AS description,
    c.ch1_value                                         AS ch1_value,
    c.ch2_value                                         AS ch2_value,
    c.ch3_value                                         AS ch3_value,
    c.exhausted                                         AS exhausted,
    c.returned                                          AS returned,
    CASE WHEN exhausted IS true THEN 'Sì' ELSE 'No' END AS exhausted_format,
    CASE WHEN returned  IS true THEN 'Sì' ELSE 'No' END AS returned_format,
    ic.instrument_category                              AS category,
    ss.st_id                                            AS st_id,
    ss.stationname                                      AS station_name
FROM
    tool_netcom.cylinders c
    LEFT JOIN tool_netcom.instrument_categories ic USING (in_ca_id)
    LEFT JOIN tool_netcom.stations_cylinders sc ON c.arpa_id = sc.arpa_id AND sc.date_end > current_date
    LEFT JOIN _stations ss USING(st_id)
ORDER BY date_expiry - current_date DESC;
GRANT SELECT ON TABLE tool_web_lily.view_cylinders TO read_only_sdms;

DROP TABLE IF EXISTS tool_web_lily.memos CASCADE;
CREATE TABLE tool_web_lily.memos (
    me_id               serial    NOT NULL,
    us_id               integer   NOT NULL,
    memo_place          text      NOT NULL,
    memo_date           date      NOT NULL,
    memo_start_time     time      NOT NULL,
    memo_end_time       time      NOT NULL,
    memo_title          text      NOT NULL,
    memo_body           text      NOT NULL,
    memo_insert_time    timestamp default current_timestamp,

    CONSTRAINT tool_web_lily_memos_pkey PRIMARY KEY (me_id),

    CONSTRAINT tool_web_lily_memos_fkey FOREIGN KEY (us_id)
        REFERENCES tool_web_lily.users (us_id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
);
GRANT SELECT ON TABLE tool_web_lily.memos TO read_only_sdms;

DROP TABLE IF EXISTS tool_web_lily.participants;
CREATE TABLE tool_web_lily.participants (
    pa_id               serial  not null,
    name                text    not null check (name <> ''),
    surname             text    not null check (name <> ''),
    CONSTRAINT tool_web_lily_participants_pkey PRIMARY KEY (pa_id)
);
GRANT SELECT ON TABLE tool_web_lily.participants TO read_only_sdms;

DROP TABLE IF EXISTS tool_web_lily.memo_participants;
CREATE TABLE tool_web_lily.memo_participants (
    me_pa_id                    serial   NOT NULL,
    me_id                       integer  NOT NULL,
    pa_id                       integer  NOT NULL,
    CONSTRAINT tool_web_lily_memo_participants_pkey PRIMARY KEY (me_pa_id),
    CONSTRAINT tool_web_lily_memo_participants_ukey UNIQUE (me_id, pa_id),
    CONSTRAINT tool_web_lily_memo_participants_fkey1 FOREIGN KEY (me_id)
        REFERENCES tool_web_lily.memos (me_id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT tool_web_lily_memo_participants_fkey2 FOREIGN KEY (pa_id)
        REFERENCES tool_web_lily.participants (pa_id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT
);
GRANT SELECT ON TABLE tool_web_lily.memo_participants TO read_only_sdms;

DROP VIEW IF EXISTS tool_web_lily.view_memos;
CREATE VIEW tool_web_lily.view_memos AS
SELECT
    m.me_id,
    m.us_id,
    m.memo_place,
    m.memo_date,
    m.memo_start_time,
    m.memo_end_time,
    m.memo_title,
    m.memo_body,
    m.memo_insert_time,
    u.user_name || ' ' || u.user_surname AS memo_username,
    array_to_string(array(
        SELECT
            mp.pa_id
        FROM
            tool_web_lily.memo_participants mp
            LEFT JOIN tool_web_lily.participants p ON mp.pa_id = p.pa_id
        WHERE
            mp.me_id = m.me_id
        ORDER BY 1
    )::text[], ', ') AS participant_ids,
    array_to_string(array(
        SELECT
            p.name || ' ' || p.surname
        FROM
            tool_web_lily.memo_participants mp
            LEFT JOIN tool_web_lily.participants p ON mp.pa_id = p.pa_id
        WHERE
            mp.me_id = m.me_id
        ORDER BY 1
    )::text[], ', ') AS participant_names
FROM
    tool_web_lily.memos m
    LEFT JOIN tool_web_lily.users u USING(us_id)
ORDER BY
    m.me_id;
GRANT SELECT ON TABLE tool_web_lily.view_memos TO read_only_sdms;

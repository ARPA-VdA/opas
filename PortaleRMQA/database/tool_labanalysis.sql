CREATE OR REPLACE VIEW labanalysis.view_analysis_samples_lily AS
SELECT
    ls.id,
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
FROM
    labanalysis.laboratory_samples AS ls
    JOIN _stations ss USING(st_id)
    JOIN labanalysis._laboratory_analysis la USING(an_id)
    JOIN labanalysis._laboratory_filter lf USING(fi_id)
    JOIN labanalysis.users_laboratory_analysis ula USING(an_id);
GRANT SELECT ON TABLE labanalysis.view_analysis_samples_lily TO lily_admin;

DROP TABLE IF EXISTS tool_web_lily.analysis_types;
CREATE TABLE tool_web_lily.analysis_types
(
    type_id     smallint NOT NULL,
    analysis    text     NOT NULL,
    CONSTRAINT tool_web_lily_analysis_types_pkey PRIMARY KEY (type_id),
    CONSTRAINT tool_web_lily_analysis_types_ukey UNIQUE (analysis)
)
WITH (OIDS=FALSE);
GRANT SELECT ON TABLE tool_web_lily.analysis_types TO read_only_sdms;

DROP TABLE IF EXISTS tool_web_lily.labanalysis_files;
CREATE TABLE tool_web_lily.labanalysis_files
(
    file_id           serial   NOT NULL,
    analysis_type_fk  smallint NOT NULL,
    source_filename   text     NOT NULL,
    stored_filename   text     NOT NULL,
    processed         boolean  DEFAULT false,
    result            boolean  DEFAULT NULL,
    upload_date       timestamp without time zone DEFAULT current_timestamp,
    CONSTRAINT tool_web_lily_labanalysis_files_pkey PRIMARY KEY (file_id),
    CONSTRAINT tool_web_lily_labanalysis_files_ukey UNIQUE (source_filename),
    CONSTRAINT tool_web_lily_labanalysis_files_fkey FOREIGN KEY (analysis_type_fk)
        REFERENCES tool_web_lily.analysis_types (type_id) MATCH SIMPLE
        ON UPDATE CASCADE ON DELETE RESTRICT
)
WITH (OIDS=FALSE);
GRANT SELECT ON TABLE tool_web_lily.labanalysis_files TO read_only_sdms;

CREATE OR REPLACE VIEW tool_web_lily.view_stations_warnings AS
SELECT
    wl.fulldate     AS fulldate,
    ss.stationname  AS station,
    pl.name         AS parameter,
    wl.value        AS measure,
    CASE
        WHEN wl.warning_type = 0 THEN
            coalesce((select chk_min_value FROM warnings.stations_parameters_override WHERE
            st_pr_id = (select st_pr_id FROM _stations_parameters WHERE st_id = sp.st_id AND id = sp.id)),
            plw.chk_min_value)

        WHEN wl.warning_type = 1 THEN
            coalesce((select chk_max_value FROM warnings.stations_parameters_override WHERE
            st_pr_id = (select st_pr_id FROM _stations_parameters WHERE st_id = sp.st_id AND id = sp.id)),
            plw.chk_max_value)

        WHEN wl.warning_type = 3 THEN
            coalesce((select chk_consec_values_no FROM warnings.stations_parameters_override WHERE
            st_pr_id = (select st_pr_id FROM _stations_parameters WHERE st_id = sp.st_id AND id = sp.id)),
            plw.chk_consec_values_no)

        WHEN wl.warning_type = 4 THEN
            coalesce((SELECT chk_max_variation FROM warnings.stations_parameters_override WHERE
            st_pr_id = (SELECT st_pr_id FROM _stations_parameters WHERE st_id = sp.st_id AND id = sp.id)),
            plw.chk_max_variation)

        ELSE NULL::real
    END             AS measure_limit,
    wt.warning_type AS warning,
    wl.warning_type AS wa_ty,
    ss.st_id        AS st_id,
    pl.pr_id        AS pr_id,
    sp.st_pr_id     AS st_pr_id
FROM
    _stations ss
    JOIN _stations_parameters sp USING (st_id)
    JOIN _parameters_list pl USING (pr_id)
    JOIN warnings.parameters_list_warnings plw USING (pr_id)
    JOIN warnings.warnings_list wl USING (st_pr_id)
    JOIN warnings.warnings_type wt ON wl.warning_type = wt.id
ORDER BY
    wl.fulldate,
    ss.stationname
;
GRANT SELECT ON TABLE tool_web_lily.view_stations_warnings TO lily_admin;

GRANT USAGE ON SCHEMA tool_web_lily TO read_only_sdms;

CREATE OR REPLACE VIEW tool_web_lily.view_plouves_rcsv AS
SELECT
    m.fulldate AS date
    ,case when (tables_ar.tbl_plouves.id_50_cod <= 2 ) then round(cast( tables_ar.tbl_plouves.id_50*2.6609  AS numeric), 2) end AS so2
    ,case when (tables_ar.tbl_plouves.id_51_cod <= 2 ) then round(cast( tables_ar.tbl_plouves.id_51*1.9125  AS numeric), 2) end AS nox
    ,case when (tables_ar.tbl_plouves.id_52_cod <= 2 ) then round(cast( tables_ar.tbl_plouves.id_52*1.2473  AS numeric), 2) end AS no
    ,case when (tables_ar.tbl_plouves.id_53_cod <= 2 ) then round(cast( tables_ar.tbl_plouves.id_53*1.9125  AS numeric), 2) end AS no2
    ,case when (tables_ar.tbl_plouves.id_54_cod <= 2 ) then round(cast( tables_ar.tbl_plouves.id_54*1.1642  AS numeric), 2) end AS co
    ,case when (tables_ar.tbl_plouves.id_55_cod <= 2 ) then round(cast( tables_ar.tbl_plouves.id_55*1.9957  AS numeric), 2) end AS o3
    ,case when (tables_ar.tbl_plouves.id_59_cod <= 2 ) then round(cast( tables_ar.tbl_plouves.id_59         AS numeric), 1) end AS pm10
    ,case when (tables_ar.tbl_plouves.id_9_cod  <= 2 ) then round(cast( tables_ar.tbl_plouves.id_9          AS numeric), 1) end AS ww
    ,case when (tables_ar.tbl_plouves.id_10_cod <= 2 ) then round(cast( tables_ar.tbl_plouves.id_10         AS numeric), 1) end AS wd
FROM
    _master m
    LEFT JOIN tables_ar.tbl_plouves USING(fulldate )
ORDER BY date;
GRANT SELECT ON TABLE tool_web_lily.view_plouves_rcsv TO read_only_sdms;

CREATE OR REPLACE VIEW tool_web_lily.view_pepiniere_rcsv AS
SELECT
    m.fulldate AS date
    ,case when (tables_ar.tbl_pepiniere.id_51_cod <= 2 ) then round(cast( tables_ar.tbl_pepiniere.id_51*1.9125  AS numeric), 2) end AS nox
    ,case when (tables_ar.tbl_pepiniere.id_52_cod <= 2 ) then round(cast( tables_ar.tbl_pepiniere.id_52*1.2473  AS numeric), 2) end AS no
    ,case when (tables_ar.tbl_pepiniere.id_53_cod <= 2 ) then round(cast( tables_ar.tbl_pepiniere.id_53*1.9125  AS numeric), 2) end AS no2
    ,case when (tables_ar.tbl_pepiniere.id_54_cod <= 2 ) then round(cast( tables_ar.tbl_pepiniere.id_54*1.1642  AS numeric), 2) end AS co
    ,case when (tables_ar.tbl_pepiniere.id_7_cod  <= 2 ) then round(cast( tables_ar.tbl_pepiniere.id_7          AS numeric), 1) end AS ww
    ,case when (tables_ar.tbl_pepiniere.id_8_cod  <= 2 ) then round(cast( tables_ar.tbl_pepiniere.id_8          AS numeric), 1) end AS wd
FROM
    _master m
    LEFT JOIN tables_ar.tbl_pepiniere USING(fulldate )
ORDER BY date;
GRANT SELECT ON TABLE tool_web_lily.view_pepiniere_rcsv TO read_only_sdms;

CREATE OR REPLACE VIEW tool_web_lily.view_mt_fleury_rcsv AS
SELECT
    m.fulldate AS date
    ,case when (tables_ar.tbl_mt_fleury.id_50_cod <= 2 ) then round(cast( tables_ar.tbl_mt_fleury.id_50*1.9125  AS numeric), 2) end AS nox
    ,case when (tables_ar.tbl_mt_fleury.id_51_cod <= 2 ) then round(cast( tables_ar.tbl_mt_fleury.id_51*1.2473  AS numeric), 2) end AS no
    ,case when (tables_ar.tbl_mt_fleury.id_52_cod <= 2 ) then round(cast( tables_ar.tbl_mt_fleury.id_52*1.9125  AS numeric), 2) end AS no2
    ,case when (tables_ar.tbl_mt_fleury.id_53_cod <= 2 ) then round(cast( tables_ar.tbl_mt_fleury.id_53*1.9957  AS numeric), 2) end AS o3
    ,case when (tables_ar.tbl_mt_fleury.id_5_cod  <= 2 ) then round(cast( tables_ar.tbl_mt_fleury.id_5          AS numeric), 1) end AS ww
    ,case when (tables_ar.tbl_mt_fleury.id_6_cod  <= 2 ) then round(cast( tables_ar.tbl_mt_fleury.id_6          AS numeric), 1) end AS wd
FROM
    _master m
    LEFT JOIN tables_ar.tbl_mt_fleury USING(fulldate )
ORDER BY date;
GRANT SELECT ON TABLE tool_web_lily.view_mt_fleury_rcsv TO read_only_sdms;

CREATE OR REPLACE VIEW tool_web_lily.view_tunnel_mb_rcsv AS
SELECT
    m.fulldate AS date
    ,case when (tables_ar.tbl_tunnel_mb.id_50_cod <= 2 ) then round(cast( tables_ar.tbl_tunnel_mb.id_50*1.9125  AS numeric), 2) end AS nox
    ,case when (tables_ar.tbl_tunnel_mb.id_51_cod <= 2 ) then round(cast( tables_ar.tbl_tunnel_mb.id_51*1.2473  AS numeric), 2) end AS no
    ,case when (tables_ar.tbl_tunnel_mb.id_52_cod <= 2 ) then round(cast( tables_ar.tbl_tunnel_mb.id_52*1.9125  AS numeric), 2) end AS no2
    ,case when (tables_ar.tbl_tunnel_mb.id_53_cod <= 2 ) then round(cast( tables_ar.tbl_tunnel_mb.id_53         AS numeric), 1) end AS pm10
    ,case when (tables_ar.tbl_tunnel_mb.id_54_cod <= 2 ) then round(cast( tables_ar.tbl_tunnel_mb.id_54         AS numeric), 1) end AS pm25
    ,case when (tables_ar.tbl_tunnel_mb.id_6_cod  <= 2 ) then round(cast( tables_ar.tbl_tunnel_mb.id_6          AS numeric), 1) end AS ww
    ,case when (tables_ar.tbl_tunnel_mb.id_7_cod  <= 2 ) then round(cast( tables_ar.tbl_tunnel_mb.id_7          AS numeric), 1) end AS wd
FROM
    _master m
    LEFT JOIN tables_ar.tbl_tunnel_mb USING(fulldate )
ORDER BY date;
GRANT SELECT ON TABLE tool_web_lily.view_tunnel_mb_rcsv TO read_only_sdms;

CREATE OR REPLACE VIEW tool_web_lily.view_la_thuile_rcsv AS
SELECT
    m.fulldate AS date
    ,case when (tables_ar.tbl_la_thuile.id_50_cod <= 2 ) then round(cast( tables_ar.tbl_la_thuile.id_50*2.6609  AS numeric), 2) end AS so2
    ,case when (tables_ar.tbl_la_thuile.id_51_cod <= 2 ) then round(cast( tables_ar.tbl_la_thuile.id_51*1.9125  AS numeric), 2) end AS nox
    ,case when (tables_ar.tbl_la_thuile.id_52_cod <= 2 ) then round(cast( tables_ar.tbl_la_thuile.id_52*1.2473  AS numeric), 2) end AS no
    ,case when (tables_ar.tbl_la_thuile.id_53_cod <= 2 ) then round(cast( tables_ar.tbl_la_thuile.id_53*1.9125  AS numeric), 2) end AS no2
    ,case when (tables_ar.tbl_la_thuile.id_55_cod <= 2 ) then round(cast( tables_ar.tbl_la_thuile.id_55*1.9957  AS numeric), 2) end AS o3
    ,case when (tables_ar.tbl_la_thuile.id_9_cod  <= 2 ) then round(cast( tables_ar.tbl_la_thuile.id_9          AS numeric), 1) end AS ww
    ,case when (tables_ar.tbl_la_thuile.id_10_cod <= 2 ) then round(cast( tables_ar.tbl_la_thuile.id_10         AS numeric), 1) end AS wd
FROM
    _master m
    LEFT JOIN tables_ar.tbl_la_thuile USING(fulldate )
ORDER BY date;
GRANT SELECT ON TABLE tool_web_lily.view_la_thuile_rcsv TO read_only_sdms;

CREATE OR REPLACE VIEW tool_web_lily.view_donnas_rcsv AS
SELECT
    m.fulldate AS date
    ,case when (tables_ar.tbl_donnas.id_51_cod <= 2 ) then round(cast( tables_ar.tbl_donnas.id_51*1.9125  AS numeric), 2) end AS nox
    ,case when (tables_ar.tbl_donnas.id_52_cod <= 2 ) then round(cast( tables_ar.tbl_donnas.id_52*1.2473  AS numeric), 2) end AS no
    ,case when (tables_ar.tbl_donnas.id_53_cod <= 2 ) then round(cast( tables_ar.tbl_donnas.id_53*1.9125  AS numeric), 2) end AS no2
    ,case when (tables_ar.tbl_donnas.id_56_cod <= 2 ) then round(cast( tables_ar.tbl_donnas.id_56*1.9957  AS numeric), 2) end AS o3
    ,case when (tables_ar.tbl_donnas.id_10_cod <= 2 ) then round(cast( tables_ar.tbl_donnas.id_10         AS numeric), 1) end AS ww
    ,case when (tables_ar.tbl_donnas.id_11_cod <= 2 ) then round(cast( tables_ar.tbl_donnas.id_11         AS numeric), 1) end AS wd
FROM
    _master m
    LEFT JOIN tables_ar.tbl_donnas USING(fulldate )
ORDER BY date;

GRANT SELECT ON TABLE tool_web_lily.view_donnas_rcsv TO read_only_sdms;

CREATE OR REPLACE VIEW tool_web_lily.view_plouves_cc_csv AS
SELECT
    fulldate AS date
    ,max(CASE WHEN (id = 1  AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS nox_zero
    ,max(CASE WHEN (id = 2  AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS no_zero
    ,max(CASE WHEN (id = 3  AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS no2_zero
    ,max(CASE WHEN (id = 4  AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS nox_span_trovato
    ,max(CASE WHEN (id = 5  AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS nox_span_verifica
    ,max(CASE WHEN (id = 6  AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS nox_span_deriva
    ,max(CASE WHEN (id = 7  AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS no_span_trovato
    ,max(CASE WHEN (id = 8  AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS no_span_verifica
    ,max(CASE WHEN (id = 9  AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS no_span_deriva
    ,max(CASE WHEN (id = 10 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS no2_span_trovato
    ,max(CASE WHEN (id = 11 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS no2_span_verifica
    ,max(CASE WHEN (id = 12 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS no2_span_deriva
    ,max(CASE WHEN (id = 13 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS nox_span_impostato
    ,max(CASE WHEN (id = 14 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS o3_zero
    ,max(CASE WHEN (id = 15 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS o3_span_trovato
    ,max(CASE WHEN (id = 16 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS o3_span_verifica
    ,max(CASE WHEN (id = 17 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS o3_span_deriva
    ,max(CASE WHEN (id = 18 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS o3_span_impostato
    ,max(CASE WHEN (id = 19 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS co_zero
    ,max(CASE WHEN (id = 20 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS co_span_trovato
    ,max(CASE WHEN (id = 21 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS co_span_verifica
    ,max(CASE WHEN (id = 22 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS co_span_deriva
    ,max(CASE WHEN (id = 23 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS co_span_impostato
    ,max(CASE WHEN (id = 24 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS so2_zero
    ,max(CASE WHEN (id = 25 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS so2_span_trovato
    ,max(CASE WHEN (id = 26 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS so2_span_verifica
    ,max(CASE WHEN (id = 27 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS so2_span_deriva
    ,max(CASE WHEN (id = 28 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS so2_span_impostato
    ,max(CASE WHEN (id = 29 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS ben_zero
    ,max(CASE WHEN (id = 30 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS tol_zero
    ,max(CASE WHEN (id = 31 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS xil_zero
    ,max(CASE WHEN (id = 32 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS ben_span_trovato
    ,max(CASE WHEN (id = 33 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS ben_span_verifica
    ,max(CASE WHEN (id = 34 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS ben_span_deriva
    ,max(CASE WHEN (id = 35 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS tol_span_trovato
    ,max(CASE WHEN (id = 36 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS tol_span_verifica
    ,max(CASE WHEN (id = 37 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS tol_span_deriva
    ,max(CASE WHEN (id = 38 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS xil_span_trovato
    ,max(CASE WHEN (id = 39 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS xil_span_verifica
    ,max(CASE WHEN (id = 40 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS xil_span_deriva
    ,max(CASE WHEN (id = 41 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS btx_span_impostato
    ,max(CASE WHEN (id = 42 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS sm200_pm10_flusso_trovato
    ,max(CASE WHEN (id = 43 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS sm200_pm10_flusso_verifica
    ,max(CASE WHEN (id = 44 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS sm200_pm10_flusso_deriva
    ,max(CASE WHEN (id = 45 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS sm200_pm10_flusso_impostato
    ,max(CASE WHEN (id = 46 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS sm200_pm25_flusso_trovato
    ,max(CASE WHEN (id = 47 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS sm200_pm25_flusso_verifica
    ,max(CASE WHEN (id = 48 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS sm200_pm25_flusso_deriva
    ,max(CASE WHEN (id = 49 AND calccode <= 2) THEN round (cast(meanvalue AS numeric), 1) END) AS sm200_pm25_flusso_impostato
FROM
    tables_ar.data_plouves_calibrations
GROUP BY date
ORDER BY date;
GRANT SELECT ON TABLE tool_web_lily.view_plouves_cc_csv TO read_only_sdms;

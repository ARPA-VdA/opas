CREATE OR REPLACE VIEW _stations_parameters_master AS SELECT * FROM _stations_parameters;
GRANT SELECT ON TABLE _stations_parameters_master TO read_only_sdms;

DROP VIEW IF EXISTS tool_web_lily.view_stations_metadata CASCADE;
CREATE OR REPLACE VIEW tool_web_lily.view_stations_metadata AS
SELECT
    ss.st_id                            AS st_id,
    ss.stationname                      AS stazione,
    ss.schema || '.data_' || ss.tableid AS tabella,
    srt.roaming_type                    AS tipo_roaming,
    mstty.typology                      AS tipo_stazione,
    mstnt.networktype                   AS tipo_rete,
    mst.startupdate                     AS data_inizio,
    mst.dismissdate                     AS data_fine,
    mst.zone                            AS zona,
    mst.basin                           AS bacino,
    mst.locality                        AS localita,
    mst.commune                         AS comune,
    mst.community                       AS comunita,
    mst.province                        AS provincia,
    mst.region                          AS regione,
    mst.longitude                       AS longitudine,
    mst.latitude                        AS latitudine,
    mst.north                           AS utm_nord_ed50,
    mst.east                            AS utm_est_ed50,
    mst.north_wgs84                     AS utm_nord_wgs84,
    mst.east_wgs84                      AS utm_est_wgs84,
    mst.lat_wgs84                       AS lat_gradi_wgs84,
    mst.lon_wgs84                       AS lon_gradi_wgs84,
    mst.altitude                        AS altitudine,
    mst.note                            AS note,
    mstty.id                            AS tipo_stazione_id,
    mstnt.id                            AS tipo_rete_id,
    bsp.active                          AS b_active,
    bsp.hoursframe                      AS b_hoursframe,
    bsp.conntype                        AS b_conntype,
    bsp.tcpip                           AS b_tcpip,
    bsp.tcpip2                          AS b_tcpip2,
    bsp.check_update                    AS b_check_update
FROM _stations ss
     LEFT JOIN metadata.stations_metadata mst USING (st_id)
     LEFT JOIN metadata.station_typology mstty ON mst.typology = mstty.id
     LEFT JOIN metadata.station_networktype mstnt ON mst.networktype = mstnt.id
     LEFT JOIN tool_builder.stations_polling bsp USING(st_id)
     LEFT JOIN _station_roaming_type srt ON  ss.station_roaming_type = srt.id
ORDER BY ss.st_id;
GRANT SELECT ON TABLE tool_web_lily.view_stations_metadata TO read_only_sdms;

DROP VIEW IF EXISTS tool_web_lily.view_instruments_metadata CASCADE;
CREATE OR REPLACE VIEW tool_web_lily.view_instruments_metadata AS
SELECT
    i.in_id,
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
FROM
    tool_netcom.instruments i
    LEFT JOIN tool_netcom.instruments_types it ON it.in_ty_id = i.in_ty_id
    LEFT JOIN tool_netcom.instrument_categories ic ON ic.in_ca_id = it.in_ca_id
ORDER BY
    i.arpa_id;
GRANT SELECT ON TABLE tool_web_lily.view_instruments_metadata TO read_only_sdms;

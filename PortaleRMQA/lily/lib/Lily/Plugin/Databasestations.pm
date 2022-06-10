package Lily::Plugin::Databasestations;
use strict;
use warnings;
use Mojo::Base 'Mojolicious::Plugin';

has app => undef;

sub register {
    my ( $self, $app ) = @_;

    $app->log->debug('Lily::Plugin::Databasestations :: register()');

    $self->app($app);

    $app->helper(
        databasestations => sub {
            return $self;
        }
    );

    return;
}

sub DESTROY {
    my $self = shift;
    return;
}

sub getStationStatus {
    my ($self) = @_;

    $self->app->log->debug("sub getStationStatus");

    my $usid = 1;

    my $sql = qq{
        SELECT
            s.st_id,
            stationname,
            status,
            lastupdate,
            tcpip2,
            SUBSTRING(tcpip2 from 9 for 7) AS tcpip2_format,
            CASE
                WHEN status = 0 THEN 'Ok'
                WHEN status = 1 THEN 'Errore'
                WHEN status = 2 THEN 'Disabilitata'
            END AS status_desc,
            --to_char(lastupdate, 'DD/MM HH24:MI') AS lastupdate_format,
            to_char(lastupdate, 'DD.MM h HH24') AS lastupdate_format,
            CASE
                WHEN current_timestamp - lastupdate > interval '8 hour' THEN 3
                WHEN current_timestamp - lastupdate > interval '4 hour' THEN 2
                WHEN current_timestamp - lastupdate > interval '2 hour' THEN 1
            ELSE 0
            END AS gap
        FROM
            _stations s
            RIGHT JOIN tool_builder.stations_polling sp USING (st_id)
            LEFT JOIN _users_stations us USING (st_id)
        WHERE
            us_id = ?
            AND sp.active = true
            AND s.active = true
        ORDER BY sp.ordering
    };

    return $self->app->database->database_query_records_by_parameter( $sql,
        $usid );
}

sub getStationAlarmsByDatesAndStation {
    my ( $self, $date_from, $date_to, $st_id ) = @_;

    $self->app->log->debug("sub getStationAlarmsByDatesAndStation");

    $st_id = ".*" unless $st_id >= 0;

    my $sql = qq{
        SELECT
            sa.fulldate                                                         AS date,
            --to_char(sa.fulldate, '"h" HH24:MI "del" DD.MM.YYYY'))             AS date_format,
            max(to_char(sa.fulldate, 'DD.MM "h" HH24'))                         AS date_format,
            max(to_char(sa.fulldate, 'DD.MM.YYYY "h" HH24.MI'))                 AS fulldate_format,
            max(sa.st_id)                                                       AS st_id,
            max(s.stationname)                                                  AS station,
            --sa.alarm                                                          AS alarm_id,
            --tool_builder.stations_alarms_string(sa.alarm)                     AS alarm_desc,
            array_agg(distinct sa.alarm)                                        AS alarm_id,
            --array_agg(distinct tool_builder.stations_alarms_string(sa.alarm)) AS alarm_desc
            tool_builder.stations_alarms_string_v2(sum(sa.alarm)::integer)      AS alarm_desc
            /*
            array(
                SELECT distinct(sai.alarm)
                FROM tool_builder.stations_alarms sai
                WHERE sai.fulldate = sa.fulldate
                AND sa.fulldate > '2014-12-01'
                ORDER BY 1
            )                                                                   AS alarm_id,
            array(
                SELECT distinct(tool_builder.stations_alarms_string(sai.alarm))
                FROM tool_builder.stations_alarms sai
                WHERE sai.fulldate = sa.fulldate
                AND sa.fulldate > '2014-12-01'
                ORDER BY 1
            )                                                                   AS alarm_desc
            */
        FROM
            tool_builder.stations_alarms sa
            JOIN _stations s USING (st_id)
        WHERE
            sa.st_id::text ~ ?
            AND sa.fulldate BETWEEN ? AND ?
        GROUP BY 1
        ORDER BY 1 DESC
    };
    $sql = qq{
        SELECT
            sa.fulldate                                                AS date,
            to_char(sa.fulldate, 'DD.MM "h" HH24')                     AS date_format,
            to_char(sa.fulldate, 'DD.MM.YYYY "h" HH24.MI')             AS fulldate_format,
            sa.st_id                                                   AS st_id,
            s.stationname                                              AS station,
            sa.alarm                                                   AS alarm_id,
            tool_builder.stations_alarms_string_v2(sa.alarm::integer)  AS alarm_desc
        FROM
            tool_builder.stations_alarms sa
            JOIN _stations s USING (st_id)
        WHERE
            sa.st_id::text ~ ?
            AND sa.fulldate BETWEEN ? AND ?
        ORDER BY 1 DESC
    };

    return $self->app->database->database_query_records_by_3parameters( $sql,
        $st_id, $date_from, $date_to );
}

sub getMetadataStations {
    my ( $self, $location ) = @_;

    $self->app->log->debug("sub getMetadataStations");

    my @stations;

    if ( $location eq 'arpa' ) {
        push( @stations, ( 4000, 4020, 4050, 4070, 4080, 4110, 4140, 4160 ) );
        push( @stations, ( 4010, 4030, 4120 ) );
        push( @stations, (4510) );
        push( @stations, ( 4990, 4991, 4992 ) );
        push( @stations, (4999) );
        push( @stations, ( 4570, 4580, 4590 ) );
    }

    if ( $location eq 'torrazza' ) {
        @stations = ();
        push( @stations, 9999 );
        push( @stations, 10000 );
        push( @stations, 10010 );
        push( @stations, 10020 );
        push( @stations, 10030 );
        push( @stations, 10040 );
        push( @stations, 10050 );
        push( @stations, 10060 );
        push( @stations, 10070 );
        push( @stations, 10080 );
        push( @stations, 10090 );
        push( @stations, 10100 );
        push( @stations, 10110 );
        push( @stations, 10120 );
        push( @stations, 10130 );
        push( @stations, 10140 );
        push( @stations, 10150 );
        push( @stations, 10160 );
        push( @stations, 10170 );
        push( @stations, 10180 );
        push( @stations, 10190 );
        push( @stations, 10200 );
        push( @stations, 10210 );
        push( @stations, 10220 );
        push( @stations, 10230 );
        push( @stations, 10240 );
        push( @stations, 10250 );
        push( @stations, 10260 );
        push( @stations, 10300 );
        push( @stations, 10310 );
        push( @stations, 11000 );
        push( @stations, 11010 );
        push( @stations, 11020 );
        push( @stations, 11030 );
        push( @stations, 11040 );
        push( @stations, 11050 );
        push( @stations, 11060 );
        push( @stations, 11070 );
        push( @stations, 11080 );
        push( @stations, 11090 );
        push( @stations, 11100 );
        push( @stations, 11110 );
        push( @stations, 11120 );
    }

    my $sql = qq{
        SELECT
            st_id,
            stationname,
            CASE
                when active IS true  THEN stationname
                WHEN active IS false THEN stationname || ' [ Non attiva ]'
            END AS station_title
            --, tableid, station_roaming_type, po_id, schema, active
        FROM
            _stations
        WHERE st_id IN ( };
    $sql .= join( ',', @stations );
    $sql .= qq{ )
        ORDER BY active DESC, stationname
    };

    return $self->app->database->database_query_records($sql);
}

sub getMetadataByStid {
    my ( $self, $stid, $location ) = @_;

    $self->app->log->debug("sub getMetadataByStid");

    my $sql;

    if ( $location eq 'arpa' ) {
        $sql = qq{
            SELECT
                st_id,
                stazione,
                tabella,
                tipo_roaming,
                tipo_stazione,
                tipo_rete,
                data_inizio,
                data_fine,
                zona,
                bacino,
                localita,
                comune,
                comunita,
                provincia,
                regione,
                longitudine,
                latitudine,
                utm_nord_ed50,
                utm_est_ed50,
                utm_nord_wgs84,
                utm_est_wgs84,
                lat_gradi_wgs84,
                lon_gradi_wgs84,
                altitudine,
                note,
                tipo_stazione_id,
                tipo_rete_id,
                b_active,
                b_hoursframe,
                b_conntype,
                b_tcpip,
                b_tcpip2,
                b_check_update
            FROM
                tool_web_lily.view_stations_metadata
            WHERE
                st_id = ?
        };
    }
    elsif ( $location eq 'torrazza' ) {

        $sql = qq{
            SELECT
                st_id,
                stazione,
                tabella,
                tipo_roaming,
                tipo_stazione,
                tipo_rete,
                data_inizio,
                data_fine,
                zona,
                bacino,
                localita,
                comune,
                comunita,
                provincia,
                regione,
                longitudine,
                latitudine,
                utm_nord_ed50,
                utm_est_ed50,
                utm_nord_wgs84,
                utm_est_wgs84,
                lat_gradi_wgs84,
                lon_gradi_wgs84,
                altitudine,
                note,
                tipo_stazione_id,
                tipo_rete_id,
                b_active,
                b_hoursframe,
                b_conntype,
                b_tcpip,
                b_tcpip2,
                b_check_update,

                sw.wall_bottom,
                sw.wall_top,
                sw.groundwater_level,
                sw.pump_level,
                sw.probe_level

            FROM
                tool_web_lily.view_stations_metadata sm
                LEFT JOIN metadata.stations_metadata_walls sw USING (st_id)
            WHERE
                st_id = ?
        };
    }

    return $self->app->database->database_query_record_by_parameter( $sql,
        $stid );
}

sub getMetadataParamMeteoByStid {
    my ( $self, $stid, $location ) = @_;

    $self->app->log->debug("sub getMetadataParamMeteoByStid");

    my $sql = qq{
        SELECT
           pr_id,
           name,
           shortname,
           unit,
           unitconv,
           decimals
        FROM
            _parameters_list pl
            LEFT JOIN _stations_parameters_master USING(pr_id)
        WHERE
    };

    if ( $location eq 'arpa' ) {
        $sql .= qq{
            st_id = ?
            AND pr_id < 500
            AND active = true
        };
    }

    if ( $location eq 'torrazza' ) {
        $sql .= qq{
            st_id = ?
            AND active = true
        };
    }

    $sql .= qq{
        ORDER BY 1
    };

    return $self->app->database->database_query_records_by_parameter( $sql,
        $stid );
}

sub getMetadataParamChemicalByStid {
    my ( $self, $stid, $location ) = @_;

    $self->app->log->debug("sub getMetadataParamChemicalByStid");

    my $sql = qq{
        SELECT
           pr_id,
           name,
           shortname,
           unit,
           unitconv,
           decimals
        FROM
            _parameters_list pl
            LEFT JOIN _stations_parameters_master USING(pr_id)
        WHERE
            st_id = ?
            AND pr_id BETWEEN 1000 AND 2999
            AND active = true
        ORDER BY 1
    };

    return $self->app->database->database_query_records_by_parameter( $sql,
        $stid );
}

sub getMetadataParamAnalisysByStid {
    my ( $self, $stid, $location ) = @_;

    $self->app->log->debug("sub getMetadataParamAnalisysByStid");

    my $sql = qq{
        SELECT
           pr_id,
           name,
           shortname,
           unit,
           unitconv,
           decimals
        FROM
            _parameters_list pl
            LEFT JOIN _stations_parameters_master USING(pr_id)
        WHERE
            st_id = ?
            AND pr_id BETWEEN 3000 AND 3245
            AND active = true
        ORDER BY 1
    };

    return $self->app->database->database_query_records_by_parameter( $sql,
        $stid );
}

1;

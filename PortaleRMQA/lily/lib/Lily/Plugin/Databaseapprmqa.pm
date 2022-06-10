package Lily::Plugin::Databaseapprmqa;
use strict;
use warnings;
use Mojo::Base 'Mojolicious::Plugin';

has app => undef;

sub register {
    my ( $self, $app ) = @_;

    $app->log->debug('Lily::Plugin::Databaseapprmqa :: register()');

    $self->app($app);

    $app->helper(
        databaseapprmqa => sub {
            return $self;
        }
    );

    return;
}

sub DESTROY {
    my $self = shift;
    return;
}

sub getInstrumentbyId {
    my ( $self, $ARPAid ) = @_;

    $self->app->log->debug(
        'Lily::Plugin::Databaseapprmqa :: getInstrumentbyId()');

    my $sql = qq{
        SELECT
            strumento,
            numero_serie,
            data_consegna,
            marca,
            modello,
            costruttore,
            tipo
        FROM
            tool_netcom.view_instruments
        WHERE
            arpa_id= ?;
    };

    return $self->app->database->database_query_record_by_parameter( $sql,
        $ARPAid );

}

sub getInstrumentCalibrationsById {
    my ( $self, $ARPAid ) = @_;

    $self->app->log->debug(
        'Lily::Plugin::Databaseapprmqa :: getInstrumentCalibrationsById()');

    my $sql = qq{
        SELECT
            c.id,
            c.fulldate,
            to_char(c.fulldate, '"h" HH24:MI "del" DD.MM.YYYY') AS date_format,
            case
                when current_timestamp - c.fulldate < interval '1 hour' then
                    to_char(current_timestamp - c.fulldate, 'MI "m fa"')
                when current_timestamp - c.fulldate < interval '1 day' then
                    to_char(current_timestamp - c.fulldate, 'HH24 h MI "m fa"')
                else
                    to_char(current_timestamp - c.fulldate, 'DD "gg fa"')
            end AS date_gap,
            lu.us_id,
            --lu.user_name,
            --lu.user_surname,
            lu.user_name || ' ' || lu.user_surname AS user_fullname,
            COALESCE(lu.user_avatar, 'default.png'::text) AS user_avatar,
            --c.st_id,
            s.stationname AS station_name,
            --u.username,
            --vi1.name AS instrument,
            vi1.in_ty_id AS instrument_type,
            --array_to_string(ARRAY[c.span_found, c.span_found2, c.span_found3], ','::text) AS span_found,
            --array_to_string(ARRAY[c.span_set, c.span_set2, c.span_set3], ','::text) AS span_set,
            case when c.span_changed is true then 'Sì' else 'No' end as span_changed,
            case when c.flux_changed is true then 'Sì' else 'No' end as flux_changed
            --c.note,
            --cyz.description AS zero_tank,
            --cys.description AS span_tank,
            --vi2.name AS calibrator
        FROM
            tool_netcom.data_calibrations c
            LEFT JOIN _stations s ON s.st_id = c.st_id
            LEFT JOIN tool_netcom.network_users u ON c.us_id = u.id
            LEFT JOIN tool_netcom.instruments vi1 ON c.arpa_id = vi1.arpa_id
            LEFT JOIN tool_netcom.instruments vi2 ON c.cal_arpa_id = vi2.arpa_id
            LEFT JOIN tool_netcom.calibration_reasons r ON c.re_id = r.re_id
            LEFT JOIN tool_netcom.calibration_methods cm1 ON c.zero_me_id = cm1.me_id
            LEFT JOIN tool_netcom.calibration_methods cm2 ON c.span_me_id = cm2.me_id
            LEFT JOIN tool_netcom.cylinders cyz ON c.zero_cyl_arpa_id = cyz.arpa_id
            LEFT JOIN tool_netcom.cylinders cys ON c.span_cyl_arpa_id = cys.arpa_id
            LEFT JOIN tool_web_lily.users lu ON c.us_id = lu.user_main_id
        WHERE
            c.arpa_id= ?
        ORDER BY
            c.fulldate DESC
        LIMIT 25;

    };

    return $self->app->database->database_query_records_by_parameter( $sql,
        $ARPAid );
}

sub getInstrumentMaintenancesById {

    my ( $self, $ARPAid ) = @_;

    $self->app->log->debug(
        'Lily::Plugin::Databaseapprmqa :: getInstrumentMaintenancesById()');

    my $sql = qq{
        SELECT DISTINCT m.ma_id,
            m.fulldate,
            to_char(m.fulldate, '"h" HH24:MI "del" DD.MM.YYYY') AS date_format,
            case
                when current_timestamp - m.fulldate < interval '1 hour' then
                    to_char(current_timestamp - m.fulldate, 'MI "m fa"')
                when current_timestamp - m.fulldate < interval '1 day' then
                    to_char(current_timestamp - m.fulldate, 'HH24 h MI "m fa"')
                else
                    to_char(current_timestamp - m.fulldate, 'DD "gg fa"')
            end AS date_gap,
            --u.us_id,
            --u.username,
            lu.us_id,
            --lu.user_name,
            --lu.user_surname,
            lu.user_name || ' ' || lu.user_surname AS user_fullname,
            COALESCE(lu.user_avatar, 'default.png'::text) AS user_avatar,
            s.stationname AS station_name,
            m.note
            --m.st_id,
            --m.ma_id
        FROM
            tool_netcom.data_maintenances m
            LEFT JOIN _users u USING (us_id)
            LEFT JOIN _stations s ON s.st_id = m.st_id
            LEFT JOIN tool_web_lily.users lu ON u.us_id = lu.user_main_id
            LEFT JOIN tool_netcom.data_operations dop USING (ma_id)
        WHERE
            dop.arpa_id = ?
        ORDER BY m.fulldate DESC LIMIT 20;
    };

    return $self->app->database->database_query_records_by_parameter( $sql,
        $ARPAid );
}

sub getCalibrationDetail {
    my ( $self, $rpid ) = @_;

    $self->app->log->debug("sub getCalibrationDetail");

    my $sql = qq{
        SELECT
            ca_id,
            st_id,
            us_id,
            fulldate,
            to_char(fulldate::date, 'DD/MM/YYYY')   AS date,
            to_char(fulldate::time, 'HH24:MI:00')   AS time,
            to_char(fulldate, 'DD.MM.YYYY HH24:MI') AS fulldate_format,
            to_char(fulldate::date, 'DD.MM.YYYY')   AS date_format,
            to_char(fulldate::date, 'DD/MM/YYYY')   AS date_cal,
            to_char(fulldate::time, 'HH24:MI')      AS time_format,
            station_name,
            user_fullname,
            user_avatar,
            re_id,
            reason_description,
            instrument_in_ty_id,
            instrument_in_ca_id,
            instrument_arpa_id,
            instrument_name,
            instrument_active,
            instrument_brand,
            instrument_model,
            instrument_constructor,
            instrument_category,
            calibrator_in_ty_id,
            calibrator_in_ca_id,
            calibrator_arpa_id,
            calibrator_name,
            calibrator_active,
            calibrator_brand,
            calibrator_model,
            calibrator_constructor,
            calibrator_category,
            zero_found,
            zero_set,
            zero_found2,
            zero_set2,
            zero_found3,
            zero_set3,
            zero_changed,
            zero_me_id,
            zero_method_description,
            span_found,
            span_set,
            span_found2,
            span_set2,
            span_found3,
            span_set3,
            span_changed,
            span_me_id,
            span_method_description,
            flux,
            flux2,
            flux3,
            temperature,
            presssure,
            flux_changed,
            tank_zero_cyl_arpa_id,
            tank_zero_is_zero,
            tank_zero_date_expiry,
            tank_zero_description,
            tank_zero_ch1,
            tank_zero_ch2,
            tank_zero_ch3,
            tank_span_cyl_arpa_id,
            tank_span_is_zero,
            tank_span_date_expiry,
            tank_span_description,
            tank_span_ch1,
            tank_span_ch2,
            tank_span_ch3,
            note
        FROM
            tool_web_lily.view_data_calibrations_details
        WHERE
            ca_id = ?
    };

    return $self->app->database->database_query_record_by_parameter( $sql,
        $rpid );
}

sub getMaintenanceDetail {
    my ( $self, $ma_id ) = @_;

    $self->app->log->debug("sub getMaintenanceDetail");

    my $sql = qq{
        SELECT
           os.id,
           os.ma_id,
           os.arpa_id,
           os.op_id,
           os.note,
           os.ca_id,
           os.filters_expdate,
           --to_char(os.filters_expdate, 'DD.MM.YYYY') AS filters_expdate,
           --i.name AS instrument,
           coalesce(i.name, 'Stazione') AS instrument,
           o.description,
           f.freq_days,
           to_char(cs.fulldate, 'DD.MM.YYYY HH24:MI') || ' - ' ||
           cs.us_id || ' : ' ||
           cs.id || ' ' AS calibration
       FROM
           tool_netcom.data_operations os
           LEFT JOIN tool_netcom.instruments i USING(arpa_id)
           LEFT JOIN tool_netcom.operations o USING(op_id)
           LEFT JOIN tool_netcom.operation_frequency f USING(op_fr_id)
           LEFT JOIN tool_netcom.data_calibrations cs ON os.ca_id = cs.id
       WHERE
           ma_id = ?
       ORDER BY os.id
    };

    return $self->app->database->database_query_records_by_parameter( $sql,
        $ma_id );
}

1;

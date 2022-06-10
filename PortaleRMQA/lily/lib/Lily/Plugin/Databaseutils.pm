package Lily::Plugin::Databaseutils;
use strict;
use warnings;
use Mojo::Base 'Mojolicious::Plugin';
use Encode qw(encode_utf8);
use utf8;
use Mojo::JSON qw(decode_json encode_json);
use Data::Dumper;
no warnings "experimental::smartmatch";
use feature qw(switch);

has app => undef;

sub register {
    my ( $self, $app ) = @_;

    $app->log->debug('Lily::Plugin::Databaseutils :: register()');

    $self->app($app);

    $app->helper(
        databaseutils => sub {
            return $self;
        }
    );

    return;
}

sub DESTROY {
    my $self = shift;
    return;
}

sub userApp {
    my ( $self, $usid ) = @_;

    $self->app->log->debug("sub userApp - usid: $usid");

    my $sql = qq{
        SELECT
            menu_id, menu_href
        FROM
            tool_web_lily.view_user_menu
        WHERE us_id = ? AND menu_published = true
        ORDER BY menu_order
    };

    return $self->app->database->database_query_records_by_parameter( $sql,
        $usid );
}

sub userLogin {
    my ( $self, $user, $pass ) = @_;

    $self->app->log->debug("sub userLogin - user: $user, pass: $pass");

    my $sql = qq{
        SELECT
            us_id,
            gr_id, group_name,
            user_name, user_surname,
            user_fullname, user_avatar,
            tool_web_lily.get_user_last_login(u.us_id) AS user_last_login,
            COALESCE (
                to_char(tool_web_lily.get_user_last_login(u.us_id), 'HH24:MI DD.MM.YYYY'), 'Primo Login :-)'
            ) AS user_last_login_format
        FROM
            tool_web_lily.view_users u
            LEFT JOIN tool_web_lily.users_settings us USING(us_id)
        WHERE user_name = ? AND user_password = md5(?)
    };

    return $self->app->database->database_query_record_by_2parameters( $sql,
        $user, $pass );
}

sub userSettings {
    my ( $self, $usid ) = @_;

    $self->app->log->debug("sub userSettings - usid: $usid");

    my $sql = qq{
        SELECT
            us.homepage AS settings_homepage,
            u.user_fullname,
            u.user_telephone,
            u.user_email,
            u.user_active,
            u.user_avatar,
            group_name
        FROM
            tool_web_lily.users_settings us
            LEFT JOIN tool_web_lily.view_users u USING(us_id)
        WHERE
            us_id = ?
    };

    return $self->app->database->database_query_record_by_parameter( $sql,
        $usid );
}

sub setStettings_Homepage {
    my ( $self, $usid, $array_pos, $array_onoff ) = @_;

    $self->app->log->debug("sub setStettings_Homepage - usid: $usid");

    my $sql = "UPDATE tool_web_lily.users_settings SET homepage = homepage\n";
    $sql .=
        " || 'row"
      . @{$array_pos}[0]
      . "_on => "
      . @{$array_onoff}[0]
      . "'::hstore\n";
    $sql .=
        " || 'row"
      . @{$array_pos}[1]
      . "_on => "
      . @{$array_onoff}[1]
      . "'::hstore\n";
    $sql .=
        " || 'row"
      . @{$array_pos}[2]
      . "_on => "
      . @{$array_onoff}[2]
      . "'::hstore\n";
    $sql .=
        " || 'row"
      . @{$array_pos}[3]
      . "_on => "
      . @{$array_onoff}[3]
      . "'::hstore\n";
    $sql .=
        " || 'row"
      . @{$array_pos}[4]
      . "_on => "
      . @{$array_onoff}[4]
      . "'::hstore\n";

    $sql .= " || 'row" . @{$array_pos}[0] . "_pos => 1'::hstore\n";
    $sql .= " || 'row" . @{$array_pos}[1] . "_pos => 2'::hstore\n";
    $sql .= " || 'row" . @{$array_pos}[2] . "_pos => 3'::hstore\n";
    $sql .= " || 'row" . @{$array_pos}[3] . "_pos => 4'::hstore\n";
    $sql .= " || 'row" . @{$array_pos}[4] . "_pos => 5'::hstore\n";
    $sql .= "WHERE us_id=?";

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute($usid);
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub resetStettings_Homepage {
    my ( $self, $usid ) = @_;

    $self->app->log->debug("sub resetStettings_Homepage - usid: $usid");

    my $sql = qq{
    UPDATE tool_web_lily.users_settings SET
      homepage = homepage
      || 'row1_on => true'::hstore
      || 'row2_on => true'::hstore
      || 'row3_on => true'::hstore
      || 'row4_on => true'::hstore
      || 'row5_on => true'::hstore
      || 'row1_pos => 1'::hstore
      || 'row2_pos => 2'::hstore
      || 'row3_pos => 3'::hstore
      || 'row4_pos => 4'::hstore
      || 'row5_pos => 5'::hstore
    WHERE
        us_id = ?
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute($usid);
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub setStettings_Pwd {
    my ( $self, $usid, $params ) = @_;

    $self->app->log->debug("sub setStettings_Pwd - usid: $usid");

    my $old_psw = encode_utf8 $params->{'old_psw'};
    my $new_psw = encode_utf8 $params->{'new_psw'};
    $self->app->log->debug( "old_psw: " . $old_psw );
    $self->app->log->debug( "new_psw: " . $new_psw );

    my $sql =
"SELECT count(*) FROM tool_web_lily.users WHERE us_id=? AND user_password=md5(?)";
    my $usercount =
      $self->app->database->database_query_value_by_2parameters( $sql, $usid,
        $old_psw );
    if ( $usercount == 0 ) {
        $self->app->log->debug("Old password is wrong !");
        return 0;
    }

    $sql = "UPDATE tool_web_lily.users SET user_password=md5(?) WHERE us_id=?";

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute( $new_psw, $usid );
    $sth->finish;

    $self->app->log->debug("Query: $res");

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub userMenu {
    my ( $self, $usid ) = @_;

    $self->app->log->debug("sub userMenu - usid: $usid");

    my $sql = qq{
        SELECT
            menu_id,
            menu_order, menu_name, menu_href,
            menu_desc, menu_level, menu_css,
            badge_css, isdropdown, isvisible
        FROM
            tool_web_lily.view_user_menu
        WHERE us_id = ? AND menu_published = true
        ORDER BY menu_order
    };

    return $self->app->database->database_query_records_by_parameter( $sql,
        $usid );
}

sub menuItemGrants {
    my ( $self, $usid, $menuid ) = @_;

    $self->app->log->debug("sub menuItemGrants - usid: $usid, menuid: $menuid");

    my $sql = qq{
        SELECT
            (user_grants->'a')::integer AS add,
            (user_grants->'u')::integer AS update,
            (user_grants->'d')::integer AS delete
        FROM
            tool_web_lily.view_user_menu
        WHERE
            us_id = ? AND menu_id = ? AND menu_published = true
    };

    return $self->app->database->database_query_record_by_2parameters( $sql,
        $usid, $menuid );
}

sub getStationAlarms {
    my ($self) = @_;

    $self->app->log->debug("sub getStationAlarms");

    my $sql = qq{
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
            sa.fulldate > '2014-12-01'
        ORDER BY 1 DESC
        LIMIT 10
    };

    return $self->app->database->database_query_records($sql);
}

sub getStationWarnings {
    my ($self) = @_;

    $self->app->log->debug("sub getStationWarnings");

    my $sql = qq{
    SELECT
        fulldate     AS date_format,
        stationname  AS station,
        name         AS parameter,
        warning_type AS warning_type,
        value        AS warning_value,
        "limit"      AS warning_limit,
        st_pr_id     AS stprid
    FROM
        warnings.view_warnings
        ORDER BY fulldate DESC
    LIMIT 10
    };

    return $self->app->database->database_query_records($sql);
}

sub getHomepageCounters {
    my ( $self, $session ) = @_;

    $self->app->log->debug("sub getHomepageCounters");

    my $sql  = qq{ SELECT tool_web_lily.get_user_last_login( ? ) };
    my $date = $self->app->database->database_query_value_by_parameter( $sql,
        $session->{'us_id'} );
    $session->{'user_last_login_format'} = $date;
    $self->app->log->debug("date: $date");

    $date = 'infinity' if !defined($date);

    $sql = qq{
        SELECT
            foo1.new_tasks,
            foo2.new_surveys,
            foo3.new_calibrations,
            foo4.new_maintenances,
            foo5.new_alarms,
            foo6.new_warnings,
            foo7.station_late,
            (coalesce(foo1.new_tasks, 0) +
                coalesce(foo2.new_surveys, 0) +
                coalesce(foo3.new_calibrations, 0) +
                coalesce(foo4.new_maintenances, 0) +
                coalesce(foo5.new_alarms, 0) +
                coalesce(foo6.new_warnings, 0) +
                coalesce(foo7.station_late, 0)
            ) AS all_count
        FROM
            (SELECT count(*) AS new_tasks        FROM tool_web_lily.tasks           WHERE task_insert_time > ?) foo1,
            (SELECT count(*) AS new_surveys      FROM tool_web_lily.surveys         WHERE survey_date      > ?) foo2,
            (SELECT count(*) AS new_calibrations FROM tool_netcom.data_calibrations WHERE fulldate         > ?) foo3,
            (SELECT count(*) AS new_maintenances FROM tool_netcom.data_maintenances WHERE fulldate         > ?) foo4,
            (SELECT count(*) AS new_alarms       FROM tool_builder.stations_alarms  WHERE fulldate         > ?) foo5,
            (SELECT count(*) AS new_warnings     FROM warnings.warnings_list        WHERE fulldate         > ?) foo6,
            (SELECT count(CASE WHEN current_timestamp - lastupdate > interval '2 hour' THEN 1 END) AS station_late
                FROM tool_builder.stations_polling sp WHERE sp.active = true) foo7
    };

    return $self->app->database->database_query_record_by_6parameters( $sql,
        $date, $date, $date, $date, $date, $date );
}

sub getReportMaintenances {
    my ($self) = @_;

    $self->app->log->debug("sub getReportMaintenances");

    my $sql = qq{
        SELECT
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
            lu.user_name,
            lu.user_surname,
            lu.user_name || ' ' || lu.user_surname AS user_fullname,
            COALESCE(lu.user_avatar, 'default.png'::text) AS user_avatar,
            s.stationname AS station_name,
            m.note,
            m.st_id,
            m.ma_id,
            array_to_string(array(
                SELECT
                    COALESCE(
                        case when i.name is not null then '<strong>Strumento:</strong> ' || i.name || '<br />' end, ''
                    ) ||
                    COALESCE(
                        case when o.note is not null then '<strong>Note:</strong> ' || o.note || '<br />' end, ''
                    ) ||
                    COALESCE(
                        case when op.description is not null then '<strong>Descrizione:</strong> ' || op.description end, ''
                    )
                    --'Strumento: ' || coalesce(i.name, '') || '<br />Note: ' || o.note || '<br />Descrizione: ' || op.description
                FROM
                    tool_netcom.data_operations o
                    LEFT JOIN tool_netcom.operations op USING (op_id)
                    LEFT JOIN tool_netcom.instruments i ON i.arpa_id = o.arpa_id
                WHERE o.ma_id = m.ma_id
            )::text[], '<hr>') AS operations
        FROM
            tool_netcom.data_maintenances m
            LEFT JOIN _users u USING (us_id)
            LEFT JOIN _stations s ON s.st_id = m.st_id
            LEFT JOIN tool_web_lily.users lu ON u.us_id = lu.user_main_id
        WHERE
            m.fulldate > current_date - interval '15 day'
        ORDER BY m.fulldate DESC LIMIT 4;
    };

    return $self->app->database->database_query_records($sql);
}

sub getReportMaintenancesByDatesAndFilters {
    my ( $self, $date_from, $date_to, $gr_id, $filter_station ) = @_;

    $self->app->log->debug("sub getReportMaintenancesByDatesAndFilters");

    my @params = ( 200, 201, 300 );
    @params = (201) if $gr_id == 201;
    @params = (200) if $gr_id == 203;
    my $groups = join( ",", @params );

    $filter_station = ".*" if ( !$filter_station || $filter_station == -1 );
    $filter_station = "4040" if ( $gr_id == 203 );

    my $sql = qq{
        SELECT
            m.ma_id                                                  AS ma_id,
            max(m.st_id)                                             AS st_id,
            max(m.fulldate)                                          AS fulldate,
            max(to_char(m.fulldate, '"h" HH24:MI "del" DD.MM.YYYY')) AS fulldate_format,
            max(g.gr_id)                                             AS gr_id,
            max(lu.us_id)                                            AS us_id,
            max(lu.user_name)                                        AS user_name,
            max(lu.user_surname)                                     AS user_surname,
            max(lu.user_name || ' ' || lu.user_surname)              AS user_fullname,
            max(COALESCE(lu.user_avatar, 'default.png'::text))       AS user_avatar,
            max(s.stationname)                                       AS station_name,
            max(m.note)                                              AS note,
            count(op.id) > 0                                         AS has_operations,
            count(sp.id) > 0                                         AS has_spare_parts,
            count(ca.id) > 0                                         AS has_calibrations
        FROM
            tool_netcom.data_maintenances m
            LEFT JOIN _users u USING (us_id)
            LEFT JOIN _stations s USING (st_id)
            LEFT JOIN tool_web_lily.users lu ON u.us_id = lu.user_main_id
            LEFT JOIN tool_web_lily.users_groups ug  ON lu.us_id = ug.us_id
            LEFT JOIN tool_web_lily.groups g   ON g.gr_id = ug.gr_id
            LEFT JOIN tool_netcom.data_operations op USING (ma_id)
            LEFT JOIN tool_netcom.data_spare_parts sp USING (ma_id)
            LEFT JOIN tool_netcom.data_calibrations ca ON ca.ca_id = m.ma_id
        WHERE
            m.fulldate BETWEEN ? AND ?
            AND g.gr_id IN ($groups)
            AND m.st_id::text ~ ?::text
        GROUP BY 1
        ORDER BY max(m.fulldate) DESC
    };

    return $self->app->database->database_query_records_by_3parameters( $sql,
        $date_from, $date_to, $filter_station );
}

sub getReportCalibrations {
    my ($self) = @_;

    $self->app->log->debug("sub getReportCalibrations");

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
            lu.user_name,
            lu.user_surname,
            lu.user_name || ' ' || lu.user_surname AS user_fullname,
            COALESCE(lu.user_avatar, 'default.png'::text) AS user_avatar,
            c.st_id,
            s.stationname AS station_name,
            --u.username,
            vi1.name AS instrument,
            vi1.in_ty_id AS instrument_type,
            array_to_string(ARRAY[c.span_found, c.span_found2, c.span_found3], ','::text) AS span_found,
            array_to_string(ARRAY[c.span_set, c.span_set2, c.span_set3], ','::text) AS span_set,
            case when c.span_changed is true then 'Sì' else 'No' end as span_changed,
            case when c.flux_changed is true then 'Sì' else 'No' end as flux_changed,
            c.note,
            cyz.description AS zero_tank,
            cys.description AS span_tank,
            vi2.name AS calibrator
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
        ORDER BY
            c.fulldate DESC
        LIMIT 5;
    };

    return $self->app->database->database_query_records($sql);
}

sub getReportCalibrationsByDatesAndFilters {
    my ( $self, $date_from, $date_to, $gr_id, $filter_station,
        $filter_instrument )
      = @_;

    $self->app->log->debug("sub getReportCalibrationsByDatesAndFilters");

    my @params = ( 200, 201, 300 );
    @params = (201) if $gr_id == 201;
    @params = (200) if $gr_id == 203;
    my $groups = join( ",", @params );

    $filter_station    = ".*" if ( !$filter_station || $filter_station == -1 );
    $filter_instrument = ".*"
      if ( !$filter_instrument || $filter_instrument == -1 );
    $filter_station = "4040" if ( $gr_id == 203 );

    my $sql = qq{
        SELECT
            ca_id,
            fulldate,
            to_char(fulldate, 'DD.MM.YYYY HH24:MI') AS fulldate_format,
            st_id,
            station_name,
            gr_id,
            user_fullname,
            user_avatar,
            instrument_in_id,
            instrument,
            zero_info, zero_changed,
            span_info, span_changed,
            note,
            tank_zero, tank_span,
            calibrator_in_id, calibrator
        FROM
            tool_web_lily.view_data_calibrations_master
        WHERE
            fulldate BETWEEN ? AND ?
            AND gr_id IN ($groups)
            AND st_id::text ~ ?::text
            AND instrument_ca_id::text ~ ?::text
        ORDER BY fulldate DESC
    };

    return $self->app->database->database_query_records_by_4parameters( $sql,
        $date_from, $date_to, $filter_station, $filter_instrument );
}

sub getReportSurveys {
    my ( $self, $limit ) = @_;

    $self->app->log->debug("sub getReportSurveys");

    $limit = 999999 unless defined($limit);

    my $sql = qq{
        SELECT
            s.su_id                                                AS su_id                    ,
            lpad(s.su_id::text, 9, '0')                            AS path_id                  ,
            s.us_id                                                AS us_id                    ,
            u.user_name || ' ' || u.user_surname                   AS user_fullname            ,
            COALESCE(u.user_avatar, 'default.png'::text)           AS user_avatar              ,
            s.survey_place                                         AS survey_place             ,
            g.gr_id                                                AS gr_id                    ,
            g.group_name                                           AS user_group               ,
            s.survey_date                                          AS survey_date              ,
            to_char(s.survey_date, 'DD.MM.YYYY')                   AS survey_date_format       ,
            s.survey_start_time                                    AS survey_start_time        ,
            to_char(s.survey_start_time, 'HH24:MI')                AS survey_start_time_format ,
            s.survey_end_time                                      AS survey_end_time          ,
            to_char(s.survey_end_time, 'HH24:MI')                  AS survey_end_time_format   ,
            to_char(s.survey_date, 'DD.MM.YYYY') || ' da ' ||
            to_char(s.survey_start_time, 'HH24:MI') || ' a ' ||
            to_char(s.survey_end_time, 'HH24:MI')                  AS survey_date_time_format  ,
            case
                when current_timestamp - s.user_insert_time < interval '1 hour' then
                    to_char(current_timestamp - s.user_insert_time, 'MI "m fa"')
                when current_timestamp - s.user_insert_time < interval '1 day' then
                    to_char(current_timestamp - s.user_insert_time, 'HH24 h MI "m fa"')
                else
                    to_char(current_timestamp - s.user_insert_time, 'DD "gg fa"')
            end                                                    AS date_gap,
            s.survey_desc AS survey_desc,
            array_to_string(array(
                SELECT stored_filename
                FROM tool_web_lily.surveys_attachements a
                WHERE a.su_id = s.su_id
                ORDER BY a.attachement_id
            )::text[], ', ')                                       AS stored_attachments,
            array_to_string(array(
                SELECT source_filename
                FROM tool_web_lily.surveys_attachements a
                WHERE a.su_id = s.su_id
                ORDER BY a.attachement_id
            )::text[], ', ')                                       AS attachments
        FROM
            tool_web_lily.surveys s
            LEFT JOIN tool_web_lily.users u USING(us_id)
            LEFT JOIN tool_web_lily.users_groups ug  USING(us_id)
            LEFT JOIN tool_web_lily.groups g  USING(gr_id)
        ORDER BY
            s.survey_date DESC, s.survey_start_time DESC
        LIMIT $limit;
    };

    return $self->app->database->database_query_records($sql);
}

sub getReportSurveysByDates {
    my ( $self, $date_from, $date_to ) = @_;

    $self->app->log->debug("sub getReportSurveysByDates");

    my $sql = qq{
        SELECT
            s.su_id                                                         AS su_id                    ,
            lpad(s.su_id::text, 9, '0')                                     AS path_id                  ,
            s.us_id                                                         AS us_id                    ,
            u.user_name || ' ' || u.user_surname                            AS user_fullname            ,
            COALESCE(u.user_avatar, 'default.png'::text)                    AS user_avatar              ,
            s.survey_place                                                  AS survey_place             ,
            g.gr_id                                                         AS gr_id                    ,
            g.group_name                                                    AS user_group               ,
            s.survey_date                                                   AS survey_date              ,
            to_char(survey_date + survey_start_time, 'YYYY-MM-DD HH24:MI')  AS survey_date_t_format     ,
            to_char(s.survey_date, 'DD.MM.YYYY')                            AS survey_date_format       ,
            s.survey_start_time                                             AS survey_start_time        ,
            to_char(s.survey_start_time, 'HH24:MI')                         AS survey_start_time_format ,
            s.survey_end_time                                               AS survey_end_time          ,
            to_char(s.survey_end_time, 'HH24:MI')                           AS survey_end_time_format   ,
            to_char(s.survey_date, 'DD.MM.YYYY') || ' da ' ||
            to_char(s.survey_start_time, 'HH24:MI') || ' a ' ||
            to_char(s.survey_end_time, 'HH24:MI')                           AS survey_date_time_format  ,
            case
                when current_timestamp - s.user_insert_time < interval '1 hour' then
                    to_char(current_timestamp - s.user_insert_time, 'MI "m fa"')
                when current_timestamp - s.user_insert_time < interval '1 day' then
                    to_char(current_timestamp - s.user_insert_time, 'HH24 h MI "m fa"')
                else
                    to_char(current_timestamp - s.user_insert_time, 'DD "gg fa"')
            end                                                    AS date_gap,
            s.survey_desc AS survey_desc,
            array_to_string(array(
                SELECT stored_filename
                FROM tool_web_lily.surveys_attachements a
                WHERE a.su_id = s.su_id
                ORDER BY a.attachement_id
            )::text[], ', ')                                       AS stored_attachments,
            array_to_string(array(
                SELECT source_filename
                FROM tool_web_lily.surveys_attachements a
                WHERE a.su_id = s.su_id
                ORDER BY a.attachement_id
            )::text[], ', ')                                       AS attachments
        FROM
            tool_web_lily.surveys s
            LEFT JOIN tool_web_lily.users u USING(us_id)
            LEFT JOIN tool_web_lily.users_groups ug  USING(us_id)
            LEFT JOIN tool_web_lily.groups g  USING(gr_id)
        WHERE
            s.survey_date BETWEEN ? AND ?
        ORDER BY
            s.survey_date DESC, s.survey_start_time DESC
    };

    return $self->app->database->database_query_records_by_2parameters( $sql,
        $date_from, $date_to );
}

sub getReportMemos {
    my ( $self, $limit ) = @_;

    $self->app->log->debug("sub getReportMemos");

    $limit = 999999 unless defined($limit);

    my $sql = qq{
        SELECT
            m.me_id                                                AS me_id                    ,
            lpad(m.me_id::text, 9, '0')                            AS path_id                  ,
            m.us_id                                                AS us_id                    ,
            u.user_name || ' ' || u.user_surname                   AS user_fullname            ,
            COALESCE(u.user_avatar, 'default.png'::text)           AS user_avatar              ,
            m.memo_place                                           AS memo_place               ,
            g.gr_id                                                AS gr_id                    ,
            g.group_name                                           AS user_group               ,
            m.memo_date                                            AS memo_date                ,
            to_char(m.memo_date, 'DD.MM.YYYY')                     AS memo_date_format         ,
            m.memo_start_time                                      AS memo_start_time          ,
            to_char(m.memo_start_time, 'HH24:MI')                  AS memo_start_time_format   ,
            m.memo_end_time                                        AS memo_end_time            ,
            to_char(m.memo_end_time, 'HH24:MI')                    AS memo_end_time_format     ,
            to_char(m.memo_date, 'DD.MM.YYYY') || ' da ' ||
            to_char(m.memo_start_time, 'HH24:MI') || ' a ' ||
            to_char(m.memo_end_time, 'HH24:MI')                    AS memo_date_time_format    ,
            case
                when current_timestamp - m.memo_insert_time < interval '1 hour' then
                    to_char(current_timestamp - m.memo_insert_time, 'MI "m fa"')
                when current_timestamp - m.memo_insert_time < interval '1 day' then
                    to_char(current_timestamp - m.memo_insert_time, 'HH24 h MI "m fa"')
                else
                    to_char(current_timestamp - m.memo_insert_time, 'DD "gg fa"')
            end                                                    AS date_gap,
            m.memo_title                                           AS memo_title,
            m.memo_body                                            AS memo_body,
            array_to_string(array(
                SELECT p.name || ' ' || p.surname
                FROM tool_web_lily.memo_participants mp
                LEFT JOIN tool_web_lily.participants p USING(pa_id)
                WHERE mp.me_id = m.me_id
                ORDER BY mp.me_pa_id
            )::text[], ', ')                                       AS memo_participants
        FROM
            tool_web_lily.memos m
            LEFT JOIN tool_web_lily.users u USING(us_id)
            LEFT JOIN tool_web_lily.users_groups ug  USING(us_id)
            LEFT JOIN tool_web_lily.groups g  USING(gr_id)
        ORDER BY
            m.memo_date DESC, m.memo_start_time DESC
        LIMIT $limit;
    };

    return $self->app->database->database_query_records($sql);
}

sub getTasks {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub getTasks");

    my $count    = $params->{count}    || 10;
    my $assignee = $params->{assignee} || 'All';
    my $status   = $params->{status}   || 'All';

    $assignee = ".*" if $assignee eq 'All';

    $status = ".*"    if $status eq 'All';
    $status = "true"  if $status eq 'Done';
    $status = "false" if $status eq 'Todo';

    my $sql = qq{
    SELECT
        t.ta_id,
        t.task_name,
        t.task_done,
        t.task_type,
        t.task_assignee,
        ss.stationname AS task_station,
        t.task_insert_time,
        to_char(t.task_insert_time, 'DD mon "h" HH24') AS task_insert_time_format,
        CASE
            WHEN current_timestamp - t.task_insert_time < interval '1 hour' THEN
                to_char(current_timestamp - t.task_insert_time, 'MI "m fa"')
            WHEN current_timestamp - t.task_insert_time < interval '1 day' THEN
                to_char(current_timestamp - t.task_insert_time, 'HH24 h MI "m fa"')
            ELSE
                to_char(current_timestamp - t.task_insert_time, 'DD "gg fa"')
        END AS date_gap,
        tt.ty_id,
        tt.ty_desc,
        u1.user_name || ' ' || u1.user_surname AS user_fullname,
        t.task_close_time,
        to_char(t.task_close_time, 'DD mon "h" HH24') AS task_close_time_format,
        u2.user_name || ' ' || u2.user_surname AS user_fullname_close
    FROM
        tool_web_lily.tasks t
        LEFT JOIN tool_web_lily.task_types tt ON t.task_type = tt.ty_id
        LEFT JOIN tool_web_lily.users u1 ON t.us_id = u1.us_id
        LEFT JOIN tool_web_lily.users u2 ON t.us_id_close = u2.us_id
        LEFT JOIN _stations ss ON t.task_stid = ss.st_id
    WHERE
        t.task_assignee::text ~ ?
        AND t.task_done::text ~ ?
    ORDER BY
        ta_id DESC
    LIMIT ?;
    };

    return $self->app->database->database_query_records_by_3parameters( $sql,
        $assignee, $status, $count );
}

sub insertTask {
    my ( $self, $usid, $params ) = @_;

    $self->app->log->debug("sub insertTask, usid: $usid");

    $self->app->log->debug( $params->{msg} );
    $self->app->log->debug( $params->{tag} );
    $self->app->log->debug( $params->{rec} );

    my $sql = "INSERT INTO tool_web_lily.tasks ";
    $sql .=
      "(us_id, task_name, task_done, task_type, task_stid, task_assignee) ";
    $sql .= "VALUES (?, ?, false, ?, ?, ?)";
    $sql .= "RETURNING ta_id";

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);

    $sth->execute(
        escape_param($usid),
        escape_param( $params->{msg} ),
        escape_param( $params->{tag} ),
        escape_param( $params->{sid} ),
        escape_param( $params->{rec} )
    ) or $self->app->log->debug($!);

    my $taid = $sth->fetchrow_array();
    $self->app->log->debug( "taid: " . $taid );
    $sth->finish;
    return $taid;
}

sub setTaskDone {
    my ( $self, $usid, $params ) = @_;

    $self->app->log->debug("sub setTaskDone, usid: $usid");

    $self->app->log->debug( $params->{id} );
    $self->app->log->debug( escape_param($usid) );

    my $sql = "UPDATE tool_web_lily.tasks SET
        us_id_close=?,
        task_done=true,
        task_close_time = current_timestamp
        WHERE ta_id=?";

    $self->app->log->debug("Query: $sql");

    my $taid = $params->{id};

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute( escape_param($usid), escape_param($taid) );
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub getParametersStatsPm10 {
    my ($self) = @_;

    $self->app->log->debug("sub getParametersStatsPm10");

    my $sql = qq{
        SELECT 'Plouves'::text AS station, count(foo.*) AS count, coalesce(to_char(max(foo.fulldate), '"gg" DD.MM.YYYY'), 'NA') AS last_date
        FROM (
            SELECT date_trunc('day', fulldate) AS fulldate,
            avg(case when (id_67_cod <= 2) then id_67 end) AS meanvalue, max(id_67_cod)
            FROM tables_ar.tbl_plouves WHERE fulldate >= date_trunc('year', current_date)
            GROUP BY 1 HAVING avg(id_67) >= 50.5 AND max(id_67_cod) <= 2
        ) foo
        UNION ALL
        SELECT 'Donnas'::text AS station, count(foo.*) AS count, coalesce(to_char(max(foo.fulldate), '"gg" DD.MM.YYYY'), 'NA') AS last_date
        FROM (
            SELECT date_trunc('day', fulldate) AS fulldate,
            avg(case when (id_61_cod <= 2) then id_61 end) AS meanvalue, max(id_61_cod)
            FROM tables_ar.tbl_donnas WHERE fulldate >= date_trunc('year', current_date)
            GROUP BY 1 HAVING avg(id_61) >= 50.5 AND max(id_61_cod) <= 2
        ) foo
        UNION ALL
        SELECT 'Pepinière'::text AS station, count(foo.*) AS count, coalesce(to_char(max(foo.fulldate), '"gg" DD.MM.YYYY'), 'NA') AS last_date
        FROM (
            SELECT date_trunc('day', fulldate) AS fulldate,
            avg(case when (id_60_cod <= 2) then id_60 end) AS meanvalue, max(id_60_cod)
            FROM tables_ar.tbl_pepiniere WHERE fulldate >= date_trunc('year', current_date)
            GROUP BY 1 HAVING avg(id_60) >= 50.5 AND max(id_60_cod) <= 2
            ) foo
        UNION ALL
        SELECT 'Via Liconi'::text AS station, count(foo.*) AS count, coalesce(to_char(max(foo.fulldate), '"gg" DD.MM.YYYY'), 'NA') AS last_date
        FROM (
            SELECT date_trunc('day', fulldate) AS fulldate,
            avg(case when (id_61_cod <= 2) then id_61 end) AS meanvalue, max(id_61_cod)
            FROM tables_ar.tbl_liconi WHERE fulldate >= date_trunc('year', current_date)
            GROUP BY 1 HAVING avg(id_61) >= 50.5 AND max(id_61_cod) <= 2
        ) foo
        UNION ALL
        SELECT 'Geie TMB'::text AS station, count(foo.*) AS count, coalesce(to_char(max(foo.fulldate), '"gg" DD.MM.YYYY'), 'NA') AS last_date
        FROM (
            SELECT date_trunc('day', fulldate) AS fulldate,
            avg(case when (id_53_cod <= 2) then id_53 end) AS meanvalue, max(id_53_cod)
            FROM tables_ar.tbl_tunnel_mb WHERE fulldate >= date_trunc('year', current_date)
            GROUP BY 1 HAVING avg(id_53) >= 50.5 AND max(id_53_cod) <= 2
        ) foo
    };

    return $self->app->database->database_query_records($sql);
}

sub getParametersStatsNo2 {
    my ($self) = @_;

    $self->app->log->debug("sub getParametersStatsNo2");

    my $sql = qq{
        SELECT 'Plouves'::text AS station, count(*) AS count, coalesce(to_char(max(fulldate), '"h" HH24:MI "del" DD.MM.YYYY'), 'NA') AS last_date
            FROM tables_ar.data_plouves WHERE id=53 AND calccode <=2 AND fulldate >= date_trunc('year', current_date) AND (meanvalue*1.9125) > 200.5
        UNION ALL
        SELECT 'Mt. Fleury'::text AS station, count(*) AS count, coalesce(to_char(max(fulldate), '"h" HH24:MI "del" DD.MM.YYYY'), 'NA') AS last_date
            FROM tables_ar.data_mt_fleury WHERE id=52 AND calccode <=2 AND fulldate >= date_trunc('year', current_date) AND (meanvalue*1.9125) > 200.5
        UNION ALL
        SELECT 'Geie Tunnel M.B.'::text AS station, count(*) AS count, coalesce(to_char(max(fulldate), '"h" HH24:MI "del" DD.MM.YYYY'), 'NA') AS last_date
            FROM tables_ar.data_tunnel_mb WHERE id=52 AND calccode <=2 AND fulldate >= date_trunc('year', current_date) AND (meanvalue*1.9125) > 200.5
        UNION ALL
        SELECT 'La Thuile'::text AS station, count(*) AS count, coalesce(to_char(max(fulldate), '"h" HH24:MI "del" DD.MM.YYYY'), 'NA') AS last_date
            FROM tables_ar.data_la_thuile WHERE id=53 AND calccode <=2 AND fulldate >= date_trunc('year', current_date) AND (meanvalue*1.9125) > 200.5
        UNION ALL
        -- SELECT 'Etroubles'::text AS station, count(*) AS count, coalesce(to_char(max(fulldate), '"h" HH24:MI "del" DD.MM.YYYY'), 'NA') AS last_date
        --     FROM tables_ar.data_etroubles WHERE id=53 AND calccode <=2 AND fulldate >= date_trunc('year', current_date) AND (meanvalue*1.9125) > 200.5
        -- UNION ALL
        SELECT 'Donnas'::text AS station, count(*) AS count, coalesce(to_char(max(fulldate), '"h" HH24:MI "del" DD.MM.YYYY'), 'NA') AS last_date
            FROM tables_ar.data_donnas WHERE id=53 AND calccode <=2 AND fulldate >= date_trunc('year', current_date) AND (meanvalue*1.9125) > 200.5
        UNION ALL
        SELECT 'Pepinière'::text AS station, count(*) AS count, coalesce(to_char(max(fulldate), '"h" HH24:MI "del" DD.MM.YYYY'), 'NA') AS last_date
            FROM tables_ar.data_pepiniere WHERE id=53 AND calccode <=2 AND fulldate >= date_trunc('year', current_date) AND (meanvalue*1.9125) > 200.5
        UNION ALL
        SELECT 'Via Liconi'::text AS station, count(*) AS count, coalesce(to_char(max(fulldate), '"h" HH24:MI "del" DD.MM.YYYY'), 'NA') AS last_date
            FROM tables_ar.data_liconi WHERE id=52 AND calccode <=2 AND fulldate >= date_trunc('year', current_date) AND (meanvalue*1.9125) > 200.5
    };

    return $self->app->database->database_query_records($sql);
}

sub getParametersStatsO3 {
    my ($self) = @_;

    $self->app->log->debug("sub getParametersStatsO3");

    my $sql = qq{
        -- 55, 64
        SELECT 'Plouves'::text AS station, count(foo.*) AS count, coalesce(to_char(max(foo.fulldate), '"gg" DD.MM.YYYY'), 'NA') AS last_date
        FROM (
            SELECT date_trunc('day', fulldate) AS fulldate
            FROM
                tables_ar.tbl_plouves WHERE fulldate >= date_trunc('year', current_date)
            GROUP BY 1
            HAVING max(case when (id_64_cod <= 2 AND id_64*1.9957 > 120.5) then id_64*1.9957 end) > 120.5
            AND count((case when (id_64_cod <= 2) then 1 end)) >= 18
        ) foo
        UNION ALL
        -- 53, 54
        SELECT 'Mt. Fleury'::text AS station, count(*) AS count, coalesce(to_char(max(fulldate), '"gg" DD.MM.YYYY'), 'NA') AS last_date
        FROM (
            SELECT date_trunc('day', fulldate) AS fulldate
            FROM
                tables_ar.tbl_mt_fleury WHERE fulldate >= date_trunc('year', current_date)
            GROUP BY 1
            HAVING max(case when (id_54_cod <= 2 AND id_54*1.9957 > 120.5) then id_54*1.9957 end) > 120.5
            AND count((case when (id_54_cod <= 2) then 1 end)) >= 18
        ) foo
        UNION ALL
        -- 55, 58
        SELECT 'La Thuile'::text AS station, count(*) AS count, coalesce(to_char(max(fulldate), '"gg" DD.MM.YYYY'), 'NA') AS last_date
        FROM (
            SELECT date_trunc('day', fulldate) AS fulldate
            FROM
                tables_ar.tbl_la_thuile WHERE fulldate >= date_trunc('year', current_date)
            GROUP BY 1
            HAVING max(case when (id_58_cod <= 2 AND id_58*1.9957 > 120.5) then id_58*1.9957 end) > 120.5
            AND count((case when (id_58_cod <= 2) then 1 end)) >= 18
        ) foo
        UNION ALL
        -- 51, 53
        -- UNION ALL
        -- -- 54, 56
        -- UNION ALL
        -- 56, 58
        SELECT 'Donnas'::text AS station, count(*) AS count, coalesce(to_char(max(fulldate), '"gg" DD.MM.YYYY'), 'NA') AS last_date
        FROM (
            SELECT date_trunc('day', fulldate) AS fulldate
            FROM
                tables_ar.tbl_donnas WHERE fulldate >= date_trunc('year', current_date)
            GROUP BY 1
            HAVING max(case when (id_58_cod <= 2 AND id_58*1.9957 > 120.5) then id_58*1.9957 end) > 120.5
            AND count((case when (id_58_cod <= 2) then 1 end)) >= 18
        ) foo
        UNION ALL
        -- 53, 54
        SELECT 'Liconi'::text AS station, count(*) AS count, coalesce(to_char(max(fulldate), '"gg" DD.MM.YYYY'), 'NA') AS last_date
        FROM (
            SELECT date_trunc('day', fulldate) AS fulldate
            FROM
                tables_ar.tbl_liconi WHERE fulldate >= date_trunc('year', current_date)
            GROUP BY 1
            HAVING max(case when (id_54_cod <= 2 AND id_54*1.9957 > 120.5) then id_54*1.9957 end) > 120.5
            AND count((case when (id_54_cod <= 2) then 1 end)) >= 18
        ) foo
    };

    return $self->app->database->database_query_records($sql);
}

sub getParametersStatsO3_180 {
    my ($self) = @_;

    $self->app->log->debug("sub getParametersStatsO3_180");

    my $sql = qq{
        -- 55, 64
        SELECT 'Plouves'::text AS station, count(*) AS count, coalesce(to_char(max(fulldate), '"h" HH24:MI "del" DD.MM.YYYY'), 'NA') AS last_date
            FROM tables_ar.data_plouves
            WHERE id=55 AND calccode <=2 AND fulldate >= date_trunc('year', current_date) AND (meanvalue*1.9957) > 180.5
        UNION ALL
        -- 53, 54
        SELECT 'Mt. Fleury'::text AS station, count(*) AS count, coalesce(to_char(max(fulldate), '"h" HH24:MI "del" DD.MM.YYYY'), 'NA') AS last_date
            FROM tables_ar.data_mt_fleury
            WHERE id=53 AND calccode <=2 AND fulldate >= date_trunc('year', current_date) AND (meanvalue*1.9957) > 180.5
        UNION ALL
        -- 55, 58
        SELECT 'La Thuile'::text AS station, count(*) AS count, coalesce(to_char(max(fulldate), '"h" HH24:MI "del" DD.MM.YYYY'), 'NA') AS last_date
            FROM tables_ar.data_la_thuile
            WHERE id=55 AND calccode <=2 AND fulldate >= date_trunc('year', current_date) AND (meanvalue*1.9957) > 180.5
        UNION ALL
        -- 56, 58
        SELECT 'Donnas'::text AS station, count(*) AS count, coalesce(to_char(max(fulldate), '"h" HH24:MI "del" DD.MM.YYYY'), 'NA') AS last_date
            FROM tables_ar.data_donnas
            WHERE id=56 AND calccode <=2 AND fulldate >= date_trunc('year', current_date) AND (meanvalue*1.9957) > 180.5
        UNION ALL
        -- 53, 54
        SELECT 'Liconi'::text AS station, count(*) AS count, coalesce(to_char(max(fulldate), '"h" HH24:MI "del" DD.MM.YYYY'), 'NA') AS last_date
            FROM tables_ar.data_liconi
            WHERE id=53 AND calccode <=2 AND fulldate >= date_trunc('year', current_date) AND (meanvalue*1.9957) > 180.5
    };

    return $self->app->database->database_query_records($sql);
}

sub getTankStatus {
    my ($self) = @_;

    $self->app->log->debug("sub getTankStatus");

    my $sql = qq{
        SELECT
            c.cy_id,
            s.stationname,
            c.arpa_id,
            c.date_built,
            c.date_expiry,
            c.description,
            c.exhausted,
            --case when exhausted is true then 'Sì' else 'No' end as exhausted_format,
            c.returned,
            --case when returned is true then 'Sì' else 'No' end as returned_format,
            ic.instrument_category,
            c.date_expiry - current_date AS days_expiry,
            sc.date_start,
            sc.date_end,
            sc.note
        FROM
            tool_netcom.cylinders c
            LEFT JOIN tool_netcom.instrument_categories ic USING (in_ca_id)
            LEFT JOIN tool_netcom.stations_cylinders sc USING (arpa_id)
            LEFT JOIN _stations s USING (st_id)
        WHERE
            (date_expiry - current_date) BETWEEN 1 and 60
        ORDER BY date_expiry - current_date DESC
    };

    return $self->app->database->database_query_records($sql);
}

sub getTankListByDates {
    my ( $self, $date_from, $date_to ) = @_;

    $self->app->log->debug("sub getTankListByDates");

    my $sql = qq{
        SELECT
            c.cy_id,
            s.stationname,
            c.arpa_id,
            c.date_built::date AS date_built,
            c.date_expiry,
            c.description,
            c.is_zero,
            concat_ws(', ', c.ch1_value::text, c.ch2_value::text, c.ch3_value::text) AS ch_values,
            c.ch1_value,
            c.ch2_value,
            c.ch3_value,
            c.exhausted,
            --case when exhausted is true then 'Sì' else 'No' end as exhausted_format,
            c.returned,
            --case when returned is true then 'Sì' else 'No' end as returned_format,
            ic.instrument_category,
            c.date_expiry - current_date AS days_expiry,
            sc.date_start,
            sc.date_end,
            sc.note
        FROM
            tool_netcom.cylinders c
            LEFT JOIN tool_netcom.instrument_categories ic USING (in_ca_id)
            LEFT JOIN tool_netcom.stations_cylinders sc USING (arpa_id)
            LEFT JOIN _stations s USING (st_id)
        WHERE
            (date_built::date, date_expiry::date) OVERLAPS (?::date, ?::date)
        ORDER BY
            date_built DESC, st_id
    };

    return $self->app->database->database_query_records_by_2parameters( $sql,
        $date_from, $date_to );
}

sub getTankList {
    my ($self) = @_;

    $self->app->log->debug("sub getTankList");

    my $sql = qq{
        SELECT
            c.cy_id,
            s.stationname,
            c.arpa_id,
            c.date_built::date AS date_built,
            c.date_expiry,
            c.description,
            c.is_zero,
            concat_ws(', ', c.ch1_value::text, c.ch2_value::text, c.ch3_value::text) AS ch_values,
            c.ch1_value,
            c.ch2_value,
            c.ch3_value,
            c.exhausted,
            --case when exhausted is true then 'Sì' else 'No' end as exhausted_format,
            c.returned,
            --case when returned is true then 'Sì' else 'No' end as returned_format,
            ic.instrument_category,
            c.date_expiry - current_date AS days_expiry,
            sc.date_start,
            sc.date_end,
            sc.note
        FROM
            tool_netcom.cylinders c
            LEFT JOIN tool_netcom.instrument_categories ic USING (in_ca_id)
            LEFT JOIN tool_netcom.stations_cylinders sc USING (arpa_id)
            LEFT JOIN _stations s USING (st_id)
        ORDER BY
            --date_built DESC, st_id
            c.arpa_id
    };

    return $self->app->database->database_query_records($sql);
}

sub getTankById {
    my ( $self, $cyid ) = @_;

    $self->app->log->debug("sub getTankById");

    my $sql = qq{
        SELECT
            c.cy_id,
            c.arpa_id,
            c.date_built::date AS date_built,
            to_char(c.date_built::date, 'DD/MM/YYYY')   AS date_built_format,
            c.date_expiry,
            to_char(c.date_expiry::date, 'DD/MM/YYYY')   AS date_expiry_format,
            c.description,
            c.is_zero,
            concat_ws(', ', c.ch1_value::text, c.ch2_value::text, c.ch3_value::text) AS ch_values,
            c.ch1_value,
            c.ch2_value,
            c.ch3_value,
            c.exhausted,
            --case when exhausted is true then 'Sì' else 'No' end as exhausted_format,
            c.returned,
            --case when returned is true then 'Sì' else 'No' end as returned_format,
            c.delivery_note,
            c.shipment_note,
            c.purchase_invoice,
            c.reversal_invoice,
            c.payment_invoice,
            c.not_compliant,
            c.note,
            c.attachment,
            c.all_stations,
            ic.instrument_category,
            ic.in_ca_id,
            c.date_expiry - current_date AS days_expiry
        FROM
            tool_netcom.cylinders c
            LEFT JOIN tool_netcom.instrument_categories ic USING (in_ca_id)
        WHERE
            c.cy_id = ?
    };

    return $self->app->database->database_query_record_by_parameter( $sql,
        $cyid );
}

sub getTankLocationByStCyId {
    my ( $self, $stcyid ) = @_;

    $self->app->log->debug("sub getTankLocationByStCyId");

    my $sql = qq{
        SELECT
            sc.st_cy_id,
            c.cy_id,
            s.stationname,
            s.st_id,
            c.arpa_id,
            c.date_built::date AS date_built,
            c.date_expiry,
            c.description,
            c.is_zero,
            concat_ws(', ', c.ch1_value::text, c.ch2_value::text, c.ch3_value::text) AS ch_values,
            c.ch1_value,
            c.ch2_value,
            c.ch3_value,
            c.exhausted,
            --case when exhausted is true then 'Sì' else 'No' end as exhausted_format,
            c.returned,
            --case when returned is true then 'Sì' else 'No' end as returned_format,
            ic.instrument_category,
            c.date_expiry - current_date AS days_expiry,
            sc.date_start,
            sc.date_end,
            to_char(sc.date_start::date, 'DD/MM/YYYY') AS date_start_format,
            to_char(sc.date_end::date, 'DD/MM/YYYY') AS date_end_format,
            sc.note
        FROM
            tool_netcom.cylinders c
            LEFT JOIN tool_netcom.instrument_categories ic USING (in_ca_id)
            LEFT JOIN tool_netcom.stations_cylinders sc USING (arpa_id)
            LEFT JOIN _stations s USING (st_id)
        WHERE
            st_cy_id = ?
    };

    return $self->app->database->database_query_record_by_parameter( $sql,
        $stcyid );
}

sub getTankListByDates_Csv {
    my ( $self, $date_from, $date_to ) = @_;

    $self->app->log->debug("sub getTankListByDates_Csv");

    my $sql = qq{
        SELECT
            c.cy_id,
            s.stationname,
            c.arpa_id,
            to_char(c.date_built::date, 'DD/MM/YYYY')           AS date_built,
            to_char(c.date_expiry, 'DD/MM/YYYY')                AS date_expiry,
            c.description,
            c.is_zero,
            case when c.is_zero is true then 'Sì' else 'No' end as is_zero_format,
            concat_ws(', ', c.ch1_value::text, c.ch2_value::text, c.ch3_value::text) AS ch_values,
            c.ch1_value,
            c.ch2_value,
            c.ch3_value,
            --c.exhausted,
            case when exhausted is true then 'Sì' else 'No' end as exhausted_format,
            --c.returned,
            case when returned is true then 'Sì' else 'No' end as returned_format,
            ic.instrument_category,
            --c.date_expiry - current_date AS days_expiry,
            to_char(sc.date_start, 'DD/MM/YYYY') AS date_start,
            to_char(sc.date_end, 'DD/MM/YYYY')   AS date_end,
            sc.note
        FROM
            tool_netcom.cylinders c
            LEFT JOIN tool_netcom.instrument_categories ic USING (in_ca_id)
            LEFT JOIN tool_netcom.stations_cylinders sc USING (arpa_id)
            LEFT JOIN _stations s USING (st_id)
        WHERE
            (date_built::date, date_expiry::date) OVERLAPS (?::date, ?::date)
        ORDER BY
            date_built DESC, st_id
    };

    return $self->app->database->database_query_records_by_2parameters( $sql,
        $date_from, $date_to );
}

sub getFiltersStatus {
    my ($self) = @_;

    $self->app->log->debug("sub getFiltersStatus");

    my $sql = qq{
        SELECT
            oper_id,
            oper_ma_id,
            oper_arpa_id,
            oper_op_id,
            oper_op_note,
            oper_ca_id,
            oper_filter_expdate,
            oper_filter_time_left,
            main_st_id,
            main_us_id,
            main_fulldate,
            main_note,
            instr_name,
            instr_brand,
            instr_model,
            instr_constructor,
            instr_category,
            station_name,
            user_name,
            user_remark
        FROM
            tool_web_lily.view_operations_filters
        WHERE
            oper_filter_time_left between 1 and 14
    };

    return $self->app->database->database_query_records($sql);
}

sub getinstrumentsMatchListByDates {
    my ( $self, $date_from, $date_to ) = @_;

    $self->app->log->debug("sub getinstrumentsMatchListByDates");

    my $sql = qq{
        SELECT
            st_in_id,
            st_id,
            arpa_id,
            in_ty_id,
            in_ca_id,
            strumento,
            attivo,
            marca,
            modello,
            costruttore,
            tipo,
            date_start,
            to_char(date_start, 'DD/MM/YYYY h HH24') AS date_start_format,
            to_char(date_start, 'YYYY-MM-DD h HH24') AS date_start_format2,
            date_end,
            to_char(date_end, 'DD/MM/YYYY') AS date_end_format,
            to_char(date_end, 'YYYY-MM-DD') AS date_end_format2,
            note,
            station_name
            /*
                CASE WHEN date_end <> 'infinity'::timestamp THEN
                    ((((date_part('epoch'::text, date_end::timestamp without time zone - date_start::timestamp without time zone) / 3600::double precision)::integer / 24)
                    || ' giorni e '::text) || ((date_part('epoch'::text, date_end::timestamp without time zone - date_start::timestamp without time zone) /
                    3600::double precision)::integer % 24)) || ' ore '::text
                ELSE
                    'infinity'
                END AS duration
            */
        FROM
            tool_netcom.view_station_and_instruments
        WHERE
            (date_start::date, date_end::date) OVERLAPS (?::date, ?::date)
        ORDER BY
            arpa_id
    };

    return $self->app->database->database_query_records_by_2parameters( $sql,
        $date_from, $date_to );
}

sub getinstrumentsMatchListByStInId {
    my ( $self, $stinid ) = @_;

    $self->app->log->debug("sub getinstrumentsMatchListByStInId");

    my $sql = qq{
        SELECT
            st_in_id, st_id, arpa_id, in_ty_id, in_ca_id,
            strumento,
            attivo,
            marca,
            modello,
            costruttore,
            tipo,
            date_start,
            date_end,
            to_char(date_start::date, 'DD/MM/YYYY') AS date_start_format,
            to_char(date_end::date, 'DD/MM/YYYY') AS date_end_format,
            to_char(date_start::time, 'HH24:MI') AS time_start_format,
            to_char(date_end::time, 'HH24:MI') AS time_end_format,
            note,
            station_name
            /*
            CASE WHEN date_end <> 'infinity'::timestamp THEN
                ((((date_part('epoch'::text, date_end::timestamp without time zone - date_start::timestamp without time zone) / 3600::double precision)::integer / 24)
                || ' giorni e '::text) || ((date_part('epoch'::text, date_end::timestamp without time zone - date_start::timestamp without time zone) /
                3600::double precision)::integer % 24)) || ' ore '::text
            ELSE
                'infinity'
            END AS duration
            */
        FROM
            tool_netcom.view_station_and_instruments
        WHERE
            st_in_id = ?
    };

    return $self->app->database->database_query_record_by_parameter( $sql,
        $stinid );
}

sub getTankMatchListByDates {
    my ( $self, $date_from, $date_to ) = @_;

    $self->app->log->debug("sub getTankMatchListByDates");

    my $sql = qq{
        SELECT
            st_cy_id, st_id, arpa_id, in_ca_id, date_built, date_expiry,
            exhausted, returned, description, date_start, date_end, duration,
            note, stationname
        FROM
            tool_netcom.view_cylinders_stations
        WHERE
            (date_start::date, date_end::date) OVERLAPS (?::date, ?::date)
        ORDER BY
            arpa_id
    };

    return $self->app->database->database_query_records_by_2parameters( $sql,
        $date_from, $date_to );
}

sub getWorkstations {
    my ($self) = @_;

    $self->app->log->debug("sub getWorkstations");

    my $sql = qq{
        SELECT
            st_id, stationname
            --, tableid, station_roaming_type, po_id, schema, active
        FROM
            _stations
        WHERE
            station_roaming_type IN (0,1)
            --AND st_id BETWEEN 4000 AND 4999
            AND st_id IN (
                4000, 4020, 4030, 4040, 4050,
                4070, 4080, 4090, 4110,
                4140, 4160, 4180, 4510,
                4999, 9000
                -- 4150, 4570, 4580, 4590, 4620,
            )
            AND active = true
        ORDER BY st_id
    };

    return $self->app->database->database_query_records($sql);
}

sub getWorkstationsByGroup {
    my ( $self, $grid ) = @_;

    $self->app->log->debug("sub getWorkstations");

    my @stids = (
        4000, 4020, 4030, 4040, 4050, 4070, 4080, 4090,
        4110, 4140, 4160, 4180, 4510, 4999, 9000
    );

    if ( $grid == 202 ) {
        @stids = ( 4420, 4460, 4470, 4480, 9999 );
    }

    my $sql = "
        SELECT
            st_id, stationname
            --, tableid, station_roaming_type, po_id, schema, active
        FROM
            _stations
        WHERE
            station_roaming_type IN (0,1)
            --AND st_id BETWEEN 4000 AND 4999
            AND st_id IN( " . join( ',', @stids ) . " )
            AND active = true
        ORDER BY st_id";

    return $self->app->database->database_query_records($sql);
}

sub getOperators {
    my ( $self, $usid ) = @_;

    $self->app->log->debug("sub getOperators");

    $usid = -1 unless defined($usid);

    my $sql = qq{
        SELECT
            u.us_id,
            u.user_name,
            u.user_surname,
            (u.user_name || ' '::text) || u.user_surname AS user_fullname,
            g.group_name,
            u.user_main_id,
            CASE WHEN u.us_id = ? THEN true ELSE false END AS user_logged
        FROM
            tool_web_lily.users u
            LEFT JOIN tool_web_lily.users_groups ug USING (us_id)
            LEFT JOIN tool_web_lily.groups g USING (gr_id)
        WHERE
            g.gr_id = (SELECT gr_id FROM tool_web_lily.users_groups ug2 WHERE ug2.us_id = ?)
        ORDER BY u.us_id;
    };

    return $self->app->database->database_query_records_by_2parameters( $sql,
        $usid, $usid );
}

sub getOperatorsNetcom {
    my ( $self, $usid ) = @_;

    $self->app->log->debug("sub getOperators");

    $usid = -1 unless defined($usid);

    my $sql = qq{
        SELECT
            u.us_id,
            u.user_name,
            u.user_surname,
            (u.user_name || ' '::text) || u.user_surname AS user_fullname,
            g.group_name,
            u.user_main_id,
            CASE WHEN u.us_id = ? THEN true ELSE false END AS user_logged
        FROM
            tool_web_lily.users u
            LEFT JOIN tool_web_lily.users_groups ug USING (us_id)
            LEFT JOIN tool_web_lily.groups g USING (gr_id)
        WHERE
            u.user_main_id IS NOT null
            AND g.gr_id = (SELECT gr_id FROM tool_web_lily.users_groups ug2 WHERE ug2.us_id = ?)
        ORDER BY u.us_id;
    };

    return $self->app->database->database_query_records_by_2parameters( $sql,
        $usid, $usid );
}

sub getParticipants {
    my ($self) = @_;

    $self->app->log->debug("sub getStations");

    my $sql = qq{
        SELECT
            pa_id, name, surname
        FROM
            tool_web_lily.participants
        ORDER BY
            pa_id;
    };

    return $self->app->database->database_query_records($sql);
}

sub getStations {
    my ($self) = @_;

    $self->app->log->debug("sub getStations");

    my $sql = qq{ SELECT * FROM tool_web_lily.view_main_stations ORDER BY pos };

    return $self->app->database->database_query_records($sql);
}

sub getReasons {
    my ($self) = @_;

    $self->app->log->debug("sub getReasons");

    my $sql = qq{
        SELECT * FROM tool_netcom.calibration_reasons ORDER BY re_id
    };

    return $self->app->database->database_query_records($sql);
}

sub getMethods {
    my ( $self, $type ) = @_;

    $self->app->log->debug("sub getMethods");

    my $sql;

    if ( $type eq "zero" ) {
        $sql =
qq{SELECT * FROM tool_netcom.calibration_methods WHERE me_id BETWEEN 0 AND 9 ORDER BY me_id};
    }
    else {
        $sql =
qq{SELECT * FROM tool_netcom.calibration_methods WHERE me_id >= 10 ORDER BY me_id};
    }

    return $self->app->database->database_query_records($sql);
}

sub getStatroamsListByDates {
    my ( $self, $date_from, $date_to ) = @_;

    $self->app->log->debug("sub getStatroamsListByDates");

    my $sql;
    $sql = qq{
        SELECT
            id,
            stationname,
            stationnameoverride,
            datefrom,
            to_char(datefrom::date, 'DD/MM/YYYY')   AS datefrom_format,
            to_char(datefrom::date, 'YYYY-MM-DD')   AS datefrom_format2,
            dateto,
            to_char(dateto::date, 'DD/MM/YYYY')   AS dateto_format,
            to_char(dateto::date, 'YYYY-MM-DD')   AS dateto_format2,
            cast(extract(epoch from (dateto - datefrom)) / 3600 as integer) / 24  || ' giorni e ' ||
            cast(extract(epoch from (dateto - datefrom)) / 3600 as integer) % 24  || ' ore' AS durata,
            note,
            stationroamingtype
        FROM
            view_laboratories_roaming
        WHERE
            (datefrom::date, dateto::date) OVERLAPS (?::date, ?::date)
        ORDER BY datefrom DESC;
    };

    return $self->app->database->database_query_records_by_2parameters( $sql,
        $date_from, $date_to );
}

sub getStationsList {
    my ($self) = @_;

    $self->app->log->debug("sub getStationsList");

    my $sql;
    $sql = qq{
        SELECT
            st_id, stationname, tablename,
            station_roaming_type, roaming_type,
            active, pos
        FROM
            tool_web_lily.view_main_stations;
    };

    return $self->app->database->database_query_records($sql);
}

sub getStationByStId {
    my ( $self, $id ) = @_;

    $self->app->log->debug("sub getStationByStId");

    my $sql;
    $sql = qq{
        SELECT
            st_id, stationname, tablename,
            station_roaming_type, roaming_type,
            active, pos
        FROM
            tool_web_lily.view_main_stations
        WHERE st_id = ?
    };

    return $self->app->database->database_query_record_by_parameter( $sql,
        $id );

}

sub getInstruments {
    my ( $self, $stid ) = @_;

    $self->app->log->debug("sub getInstruments");

    my $sql = qq{
        SELECT
            st_in_id, st_id, strumento, attivo,
            arpa_id, in_ty_id, in_ca_id,
            strumento, marca, modello, costruttore, tipo
        FROM
            tool_netcom.view_station_and_instruments
        WHERE
            st_id in (0, ?)
            AND attivo = true
            AND current_timestamp BETWEEN date_start AND date_end
        ORDER BY in_ty_id
    };

    return $self->app->database->database_query_records_by_parameter( $sql,
        $stid );
}

sub getInstrumentList {
    my ($self) = @_;

    $self->app->log->debug("sub getInstrumentList");

    my $sql;
    $sql = qq{
        SELECT
            in_id, arpa_id, in_ty_id, in_ca_id, strumento, marca, modello,
            costruttore, tipo, numero_serie, data_consegna
        FROM
            tool_netcom.view_instruments
        WHERE
            in_ty_id >= 1000
        ORDER BY
            in_ty_id, data_consegna desc
    };

    return $self->app->database->database_query_records($sql);
}

sub getInstrumentById {
    my ( $self, $id ) = @_;

    $self->app->log->debug("sub getInstrumentById");

    my $sql;
    $sql = qq{
        SELECT
            in_id, arpa_id, in_ty_id, in_ca_id, strumento, marca, modello,
            costruttore, tipo, numero_serie, data_consegna,
            to_char(data_consegna::date, 'DD/MM/YYYY')   AS data_consegna_format
        FROM
            tool_netcom.view_instruments
        WHERE
            in_id = ?
    };

    return $self->app->database->database_query_record_by_parameter( $sql,
        $id );
}

sub getInstrumentTypes {
    my ($self) = @_;

    $self->app->log->debug("sub getInstrumentTypes");

    my $sql;
    $sql = qq{
        SELECT in_ty_id, brand, model, constructor, in_ca_id
        FROM tool_netcom.instruments_types
        WHERE in_ty_id >= 1000
        ORDER BY brand, model
    };

    return $self->app->database->database_query_records($sql);
}

sub getInstrumentCategories {
    my ($self) = @_;

    $self->app->log->debug("sub getInstrumentCategories");

    my $sql;
    $sql = qq{
        SELECT
            in_ca_id, instrument_category
        FROM
            tool_netcom.instrument_categories
        WHERE
            in_ca_id >= 1000
        ORDER
            BY in_ca_id;
    };

    return $self->app->database->database_query_records($sql);
}

sub getInstrumentCategoriesHasTank {
    my ($self) = @_;

    $self->app->log->debug("sub getInstrumentCategoriesHasTank");

    my $sql;
    $sql = qq{
        SELECT
            * FROM tool_netcom.instrument_categories
        WHERE
            in_ca_id IN(1000,1010,1020,1070,1110)
        ORDER
            BY in_ca_id;
    };

    return $self->app->database->database_query_records($sql);
}

sub getTanks {
    my ( $self, $type, $stid ) = @_;

    $self->app->log->debug("sub getTanks");

    my $iszero = 'false';
    if ( $type eq "zero" ) {
        $iszero = 'true';
    }

    my $sql;
    $sql = qq{
        SELECT
            c.cy_id,
            c.is_zero,
            c.arpa_id,
            c.in_ca_id,
            c.date_built,
            c.date_expiry,
            c.exhausted,
            c.returned,
            c.description,
            c.ch1_value,
            c.ch2_value,
            c.ch3_value,
            ic.instrument_category,
            sc.st_cy_id,
            sc.st_id,
            sc.date_start,
            sc.date_end,
            sc.note,
            --sc.arpa_id,
            s.stationname,
            array_to_string(ARRAY[c.ch1_value, c.ch2_value, c.ch3_value], ','::text) AS tank_values
        FROM
            tool_netcom.cylinders c
            LEFT JOIN tool_netcom.instrument_categories ic USING (in_ca_id)
            LEFT JOIN tool_netcom.stations_cylinders sc USING (arpa_id)
            LEFT JOIN _stations s USING (st_id)
        WHERE
            --c.in_ca_id IN (?)
            is_zero IS $iszero
            AND st_id = ? AND exhausted = false
            AND current_timestamp BETWEEN date_start AND date_end
            OR all_stations IS true
        ORDER BY c.in_ca_id, date_built
    };

    return $self->app->database->database_query_records_by_parameter( $sql,
        $stid );
}

sub insertNewTank {
    my ( $self, $attachment_name, $params ) = @_;

    $self->app->log->debug("sub insertNewTank");

    my $date_built  = $params->{'tank-date-built'};
    my $date_expiry = $params->{'tank-date-expiry'};

    $date_built =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_built = "$3-$2-$1";
    $self->app->log->debug("Post date_built: $date_built");

    $date_expiry =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_expiry = "$3-$2-$1";
    $self->app->log->debug("Post date_expiry: $date_expiry");

    my $exhausted = 0;
    if ( defined( $params->{'tank-exhausted'} )
        && $params->{'tank-exhausted'} eq "" )
    {
        $exhausted = 1;
    }

    my $returned = 0;
    if ( defined( $params->{'tank-returned'} )
        && $params->{'tank-returned'} eq "" )
    {
        $returned = 1;
    }

    my $iszero = 0;
    if ( defined( $params->{'tank-iszero'} )
        && $params->{'tank-iszero'} eq "" )
    {
        $iszero = 1;
    }

    my $allstations = 0;
    if ( defined( $params->{'all-stations'} )
        && $params->{'all-stations'} eq "" )
    {
        $allstations = 1;
    }

    my $notcompliant = 0;
    if ( defined( $params->{'not-compliant'} )
        && $params->{'not-compliant'} eq "" )
    {
        $notcompliant = 1;
    }

    my $sql = qq{
        INSERT INTO tool_netcom.cylinders(
            arpa_id, is_zero, in_ca_id, date_built, date_expiry, description,
            ch1_value, ch2_value, ch3_value, exhausted, returned,
            delivery_note, shipment_note, purchase_invoice, reversal_invoice,
            payment_invoice, not_compliant, note, attachment, all_stations)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'arpa-id'} ),
        escape_param($iszero),
        escape_param( $params->{'tank-instrument'} ),
        escape_param($date_built),
        escape_param($date_expiry),
        escape_param( $params->{'tank-description'} ),
        escape_param( $params->{'val-first'} ),
        escape_param( $params->{'val-second'} ),
        escape_param( $params->{'val-third'} ),
        escape_param($exhausted),
        escape_param($returned),

        escape_param( $params->{'delivery-note'} ),
        escape_param( $params->{'shipment-note'} ),
        escape_param( $params->{'purchase-invoice'} ),
        escape_param( $params->{'reversal-invoice'} ),
        escape_param( $params->{'payment-invoice'} ),
        escape_param($notcompliant),
        escape_param( $params->{'note'} ),
        escape_param($attachment_name),
        escape_param($allstations)
    );
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub editTank {
    my ( $self, $attachment_name, $params ) = @_;

    $self->app->log->debug("sub editTank");

    my $date_built  = $params->{'tank-date-built'};
    my $date_expiry = $params->{'tank-date-expiry'};

    $date_built =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_built = "$3-$2-$1";
    $self->app->log->debug("Post date_built: $date_built");

    $date_expiry =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_expiry = "$3-$2-$1";
    $self->app->log->debug("Post date_expiry: $date_expiry");

    my $exhausted = 0;
    if ( defined( $params->{'tank-exhausted'} )
        && $params->{'tank-exhausted'} eq "" )
    {
        $exhausted = 1;
    }

    my $returned = 0;
    if ( defined( $params->{'tank-returned'} )
        && $params->{'tank-returned'} eq "" )
    {
        $returned = 1;
    }

    my $iszero = 0;
    if ( defined( $params->{'tank-iszero'} )
        && $params->{'tank-iszero'} eq "" )
    {
        $iszero = 1;
    }

    my $allstations = 0;
    if ( defined( $params->{'all-stations'} )
        && $params->{'all-stations'} eq "" )
    {
        $allstations = 1;
    }

    my $notcompliant = 0;
    if ( defined( $params->{'not-compliant'} )
        && $params->{'not-compliant'} eq "" )
    {
        $notcompliant = 1;
    }

    my $sql = "UPDATE tool_netcom.cylinders SET
            arpa_id=?, is_zero=?, in_ca_id=?, date_built=?, date_expiry=?,
            description=?, ch1_value=?, ch2_value=?, ch3_value=?, exhausted=?, returned=?,
            delivery_note=?, shipment_note=?, purchase_invoice=?, reversal_invoice=?,
            payment_invoice=?, not_compliant=?, note=?, attachment=?, all_stations=?
        WHERE
            cy_id=?
    ";

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'arpa-id'} ),
        escape_param($iszero),
        escape_param( $params->{'tank-instrument'} ),
        escape_param($date_built),
        escape_param($date_expiry),
        escape_param( $params->{'tank-description'} ),
        escape_param( $params->{'val-first'} ),
        escape_param( $params->{'val-second'} ),
        escape_param( $params->{'val-third'} ),
        escape_param($exhausted),
        escape_param($returned),

        escape_param( $params->{'delivery-note'} ),
        escape_param( $params->{'shipment-note'} ),
        escape_param( $params->{'purchase-invoice'} ),
        escape_param( $params->{'reversal-invoice'} ),
        escape_param( $params->{'payment-invoice'} ),
        escape_param($notcompliant),
        escape_param( $params->{'note'} ),
        escape_param($attachment_name),
        escape_param($allstations),

        escape_param( $params->{'tank-cy-id'} )
    );
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub insertNewTankMatch {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub insertNewTankMatch");

    my $date_start = $params->{'start-date'};
    my $date_end   = $params->{'end-date'};

    $date_start =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_start = "$3-$2-$1";
    $self->app->log->debug("Post date_start: $date_start");

    $date_end =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_end = "$3-$2-$1";
    $self->app->log->debug("Post date_end: $date_end");

    my $sql = qq{
        INSERT INTO tool_netcom.stations_cylinders(
            st_id, date_start, date_end, note, arpa_id
        ) VALUES (?, ?, ?, ?, ?);
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'workstation'} ),
        escape_param($date_start),
        escape_param($date_end),
        escape_param( $params->{'notes'} ),
        escape_param( $params->{'tank'} )
    );
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub editTankMatch {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub editTankMatch");

    my $date_start = $params->{'start-date'};
    my $date_end   = $params->{'end-date'};

    $date_start =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_start = "$3-$2-$1";
    $self->app->log->debug("Post date_start: $date_start");

    $date_end =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_end = "$3-$2-$1";
    $self->app->log->debug("Post date_end: $date_end");

    my $sql = "UPDATE tool_netcom.stations_cylinders SET
            st_id=?, date_start=?, date_end=?, note=?, arpa_id=?
        WHERE
            st_cy_id=?
    ";

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'workstation'} ),
        escape_param($date_start),
        escape_param($date_end),
        escape_param( $params->{'notes'} ),
        escape_param( $params->{'tank'} ),
        escape_param( $params->{'tank-st-cy-id'} )
    );
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub editStation {
    my ( $self, $params ) = @_;

    my $active = 0;
    if ( defined( $params->{'st-active'} )
        && $params->{'st-active'} eq "" )
    {
        $active = 1;
    }

    my $sql = qq{
        UPDATE _stations SET
            stationname = ?, active = ?
        WHERE
            st_id = ?
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'st-name'} ),
        escape_param($active),
        escape_param( $params->{'st-id'} )
    );
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub insertNewInstrument {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub insertNewInstrument");

    my $date_delivery = $params->{'date-delivery'};

    $date_delivery =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_delivery = "$3-$2-$1";
    $self->app->log->debug("Post date_delivery: $date_delivery");

    my $sql = qq{
        INSERT INTO tool_netcom.instruments(
            arpa_id, in_ty_id, name, serial_number, date_delivery
        )
        VALUES (?, ?, ?, ?, ?);
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'arpa-id'} ),
        escape_param( $params->{'in-ty-id'} ),
        escape_param( $params->{'name'} ),
        escape_param( $params->{'serial-numb'} ),
        escape_param($date_delivery)
    );
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub editInstrument {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub editInstrument");

    my $date_delivery = $params->{'date-delivery'};

    $date_delivery =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_delivery = "$3-$2-$1";
    $self->app->log->debug("Post date_delivery: $date_delivery");

    my $sql = "UPDATE
        tool_netcom.instruments SET
            arpa_id=?, in_ty_id=?, name=?, serial_number=?, date_delivery=?
        WHERE
            in_id=?
    ";

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'arpa-id'} ),
        escape_param( $params->{'in-ty-id'} ),
        escape_param( $params->{'name'} ),
        escape_param( $params->{'serial-numb'} ),
        escape_param($date_delivery),
        escape_param( $params->{'in-id'} )
    );
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub deleteInstrument {
    my ( $self, $inid ) = @_;

    $self->app->log->debug("sub deleteInstrument");

    my $sql = "DELETE FROM tool_netcom.instruments WHERE in_id = ?";

    $self->app->log->debug("Query: $sql -> [$inid]");

    my $sth = $self->app->dbh->prepare($sql);

    if ( $sth->execute($inid) ) {
        return 1;
    }
    else {
        $self->app->log->debug("Error executing query: $sql -> [$inid]");
        return 0;
    }
}

sub getCalibrators {
    my ($self) = @_;

    $self->app->log->debug("sub getCalibrators");

    my $sql = qq{
        SELECT * FROM tool_netcom.view_instruments WHERE in_ca_id >= 2000 ORDER BY in_ty_id
    };

    return $self->app->database->database_query_records($sql);
}

sub getInstrumentsOperations {
    my ( $self, $arpaid ) = @_;

    $self->app->log->debug("sub getInstrumentsOperations");

    my $sql;
    $sql = qq{
        SELECT
            op_id, description
            -- op_ca_id, op_fr_id,
            --io.id, in_ty_id, op_id,
            --it.in_ca_id
        FROM
            tool_netcom.operations o
            LEFT JOIN tool_netcom.instruments_operations io USING(op_id)
            LEFT JOIN tool_netcom.instruments i USING(in_ty_id)
            --LEFT JOIN tool_netcom.instruments_types it USING(in_ty_id)
        WHERE
            i.arpa_id = ?
        ORDER BY used_frequency DESC NULLS LAST, op_id
    };

    return $self->app->database->database_query_records_by_parameter( $sql,
        $arpaid );
}

sub getInstrumentsSpareParts {
    my ( $self, $arpaid ) = @_;

    $self->app->log->debug("sub getInstrumentsOperations");

    my $sql;
    $sql = qq{
        SELECT
            sp_id, description
        FROM
            tool_netcom.spare_parts sp
            LEFT JOIN tool_netcom.instruments_spare_parts io USING(sp_id)
            LEFT JOIN tool_netcom.instruments i USING(in_ty_id)
        WHERE
            i.arpa_id = ?
        ORDER BY sp_id
    };

    return $self->app->database->database_query_records_by_parameter( $sql,
        $arpaid );
}

sub insertNewInstrumentMatch {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub insertNewInstrumentMatch");

    my $date_start = $params->{'start-date'};
    my $date_end   = $params->{'end-date'};
    my $time_start = $params->{'start-time'};
    my $time_end   = $params->{'end-time'};

    $date_start =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_start = "$3-$2-$1";
    $self->app->log->debug("Post date_start: $date_start");

    $date_end =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_end = "$3-$2-$1";
    $self->app->log->debug("Post date_end: $date_end");

    $time_start =~ m|^(\d?\d):(\d\d)$|;
    $time_start = "$1:$2:00";
    $self->app->log->debug("Post time_start: $time_start");

    $time_end =~ m|^(\d?\d):(\d\d)$|;
    $time_end = "$1:$2:00";
    $self->app->log->debug("Post time_end: $time_end");

    $date_start = $date_start . " " . $time_start;
    $date_end   = $date_end . " " . $time_end;

    my $active = 0;
    if ( defined( $params->{'active_ins'} )
        && $params->{'active_ins'} eq "" )
    {
        $active = 1;
    }

    my $sql = qq{
        INSERT INTO tool_netcom.stations_instruments(
            st_id, arpa_id, fl_active, date_start, date_end, note)
        VALUES (?, ?, ?, ?, ?, ?);
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'station'} ),
        escape_param( $params->{'instrument'} ),
        escape_param($active),
        escape_param($date_start),
        escape_param($date_end),
        escape_param( $params->{'notes'} )
    );
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub editInstrumentMatch {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub editInstrumentMatch");

    my $date_start = $params->{'start-date'};
    my $date_end   = $params->{'end-date'};
    my $time_start = $params->{'start-time'};
    my $time_end   = $params->{'end-time'};

    $date_start =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_start = "$3-$2-$1";
    $self->app->log->debug("Post date_start: $date_start");

    $date_end =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_end = "$3-$2-$1";
    $self->app->log->debug("Post date_end: $date_end");

    $time_start =~ m|^(\d?\d):(\d\d)$|;
    $time_start = "$1:$2:00";
    $self->app->log->debug("Post time_start: $time_start");

    $time_end =~ m|^(\d?\d):(\d\d)$|;
    $time_end = "$1:$2:00";
    $self->app->log->debug("Post time_end: $time_end");

    $date_start = $date_start . " " . $time_start;
    $date_end   = $date_end . " " . $time_end;

    my $active = 0;
    if ( defined( $params->{'active_ins'} )
        && $params->{'active_ins'} eq "" )
    {
        $active = 1;
    }

    my $sql = qq{
        UPDATE tool_netcom.stations_instruments SET
            st_id = ?,
            arpa_id = ?,
            fl_active = ?,
            date_start = ?,
            date_end = ?,
            note=?
        WHERE
            st_in_id = ?
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'station'} ),
        escape_param( $params->{'instrument'} ),
        escape_param($active),
        escape_param($date_start),
        escape_param($date_end),
        escape_param( $params->{'notes'} ),
        escape_param( $params->{'in-match-id'} )
    );
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub deleteInstrumentMatch {
    my ( $self, $stinid ) = @_;

    $self->app->log->debug("sub deleteInstrumentMatch");

    my $sql = "DELETE FROM tool_netcom.stations_instruments WHERE st_in_id = ?";

    $self->app->log->debug("Query: $sql -> [$stinid]");

    my $sth = $self->app->dbh->prepare($sql);

    if ( $sth->execute($stinid) ) {
        return 1;
    }
    else {
        $self->app->log->debug("Error executing query: $sql -> [$stinid]");
        return 0;
    }
}

sub insertNewStatroamMatch {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub insertNewStatroamMatch");

    my $date_start = $params->{'start-date'};
    my $date_end   = $params->{'end-date'};

    $date_start =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_start = "$3-$2-$1";
    $self->app->log->debug("Post date_start: $date_start");

    $date_end =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_end = "$3-$2-$1";
    $self->app->log->debug("Post date_end: $date_end");

    my $sql = qq{
        INSERT INTO _stations_override(
            st_id, st_id_override, datefrom, dateto, note)
        VALUES (?, ?, ?, ?, ?);
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'st_mob'} ),
        escape_param( $params->{'st_sito'} ),
        escape_param($date_start),
        escape_param($date_end),
        escape_param( $params->{'notes'} )
    );
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub editStatroamMatch {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub editStatroamMatch");

    my $date_start = $params->{'start-date'};
    my $date_end   = $params->{'end-date'};

    $date_start =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_start = "$3-$2-$1";
    $self->app->log->debug("Post date_start: $date_start");

    $date_end =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_end = "$3-$2-$1";
    $self->app->log->debug("Post date_end: $date_end");

    my $sql = qq{
        UPDATE _stations_override SET
            st_id = ?,
            st_id_override = ?,
            datefrom = ?,
            dateto = ?,
            note = ?
        WHERE
            id = ?
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'st_mob'} ),
        escape_param( $params->{'st_sito'} ),
        escape_param($date_start),
        escape_param($date_end),
        escape_param( $params->{'notes'} ),
        escape_param( $params->{'st-match-id'} )
    );
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub deleteStatroamMatch {
    my ( $self, $inid ) = @_;

    $self->app->log->debug("sub deleteStatroamMatch");

    return 1;

}

sub getStatroamMatchListByStInId {
    my ( $self, $stinid ) = @_;

    $self->app->log->debug("sub getStatroamMatchListByStInId");

    my $sql = qq{
        SELECT
            id,
            st_id,
            stationname,
            st_id_override,
            stationnameoverride,
            datefrom,
            to_char(datefrom::date, 'DD/MM/YYYY')   AS datefrom_format,
            dateto,
            to_char(dateto::date, 'DD/MM/YYYY')   AS dateto_format,
            cast(extract(epoch from (dateto - datefrom)) / 3600 as integer) / 24  || ' giorni e ' ||
            cast(extract(epoch from (dateto - datefrom)) / 3600 as integer) % 24  || ' ore' AS durata,
            note,
            stationroamingtype
        FROM
            view_laboratories_roaming
        WHERE id = ?
    };

    return $self->app->database->database_query_record_by_parameter( $sql,
        $stinid );
}

sub getMobStations {
    my ($self) = @_;

    $self->app->log->debug("sub getMobStations");

    my $sql = qq{
        SELECT
            st_id, stationname, tableid,
            station_roaming_type, po_id, schema, active
        FROM
            _stations
        WHERE
            station_roaming_type IN (1)
        ORDER BY st_id
    };

    return $self->app->database->database_query_records($sql);
}

sub getMatchStations {
    my ($self) = @_;

    $self->app->log->debug("sub getMatchStations");

    my $sql = qq{
        SELECT
            st_id, stationname, tableid,
            station_roaming_type, po_id, schema, active
        FROM
            _stations
        WHERE
            station_roaming_type IN (2,4)
        ORDER BY st_id
    };

    return $self->app->database->database_query_records($sql);
}

sub insertNewCalibration {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub insertNewCalibration");

    my $sql = qq{
        SELECT in_ca_id
        FROM tool_netcom.view_stations_instruments
        WHERE arpa_id = ?
    };
    my $incaid = $self->app->database->database_query_value_by_parameter( $sql,
        $params->{'instrument_calib'} );
    $self->app->log->debug("incaid: $incaid");

    my $date = $params->{'date_calib'};
    my $time = $params->{'time_calib'};
    $date =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date = "$3-$2-$1";
    $time =~ m|^(\d?\d):(\d\d)$|;
    $time = "$1:$2:00";
    my $datetime = "$date $time";
    $self->app->log->debug("Post datetime: $datetime");

    $sql = qq{
        INSERT INTO tool_netcom.data_calibrations(

            st_id, us_id, fulldate, note, arpa_id, re_id,

            zero_found,   zero_set,
            zero_found2,  zero_set2,
            zero_found3,  zero_set3,
            zero_changed, zero_me_id, zero_cyl_arpa_id,

            span_found,   span_set,
            span_found2,  span_set2,
            span_found3,  span_set3,
            span_changed, span_me_id, span_cyl_arpa_id,

            flux, flux2, flux3, flux_changed, temperature, presssure

        ) VALUES (
            ?, ?, ?, ?, ?, ?,

            ?, ?,
            ?, ?,
            ?, ?,
            ?, ?, ?,

            ?, ?,
            ?, ?,
            ?, ?,
            ?, ?, ?,

            ?, ?, ?, ?, ?, ?
        )
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);

    my $res;
    given ($incaid) {
        when (1000) {

            my $zero_set = 0;
            if ( defined( $params->{'mod_zero_api100'} )
                && $params->{'mod_zero_api100'} eq "" )
            {
                $zero_set = 1;
            }
            my $tank_zero_api100 = undef;
            if ( $params->{'method_zero_api100'} eq "2" ) {
                $tank_zero_api100 = $params->{'tank_zero_api100'};
                if ( $tank_zero_api100 == -1 ) { $tank_zero_api100 = undef; }
            }

            my $span_set = 0;
            if ( defined( $params->{'mod_span_api100'} )
                && $params->{'mod_span_api100'} eq "" )
            {
                $span_set = 1;
            }
            my $tank_span_api100 = undef;
            if ( $params->{'method_span_api100'} eq "10" ) {
                $tank_span_api100 = $params->{'tank_span_api100'};
                if ( $tank_span_api100 == -1 ) { $tank_span_api100 = undef; }
            }

            $res = $sth->execute(
                escape_param( $params->{'station_calib'} ),
                escape_param( $params->{'operator_calib'} ),
                escape_param($datetime),
                escape_param( $params->{'notes_calib'} ),
                escape_param( $params->{'instrument_calib'} ),
                escape_param( $params->{'reason_calib'} ),
                escape_param( $params->{'find_zero_api100'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param($zero_set),
                escape_param( $params->{'method_zero_api100'} ),
                escape_param($tank_zero_api100),
                escape_param( $params->{'read_span_api100'} ),
                escape_param( $params->{'theory_span_api100'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param($span_set),
                escape_param( $params->{'method_span_api100'} ),
                escape_param($tank_span_api100),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef)
            );
        }
        when (1010) {

            my $zero_set = 0;
            if ( defined( $params->{'mod_zero_api200'} )
                && $params->{'mod_zero_api200'} eq "" )
            {
                $zero_set = 1;
            }
            my $tank_zero_api200 = undef;

            my $span_set = 0;
            if ( defined( $params->{'mod_span_api200'} )
                && $params->{'mod_span_api200'} eq "" )
            {
                $span_set = 1;
            }
            my $tank_span_api200 = undef;
            if ( $params->{'method_span_api200'} eq "10" ) {
                $tank_span_api200 = $params->{'tank_span_api200'};
                if ( $tank_span_api200 == -1 ) { $tank_span_api200 = undef; }
            }

            $res = $sth->execute(
                escape_param( $params->{'station_calib'} ),
                escape_param( $params->{'operator_calib'} ),
                escape_param($datetime),
                escape_param( $params->{'notes_calib'} ),
                escape_param( $params->{'instrument_calib'} ),
                escape_param( $params->{'reason_calib'} ),
                escape_param( $params->{'nox_zero_api200'} ),
                escape_param(undef),
                escape_param( $params->{'no_zero_api200'} ),
                escape_param(undef),
                escape_param( $params->{'no2_zero_api200'} ),
                escape_param(undef),
                escape_param($zero_set),
                escape_param( $params->{'method_zero_api200'} ),
                escape_param($tank_zero_api200),
                escape_param( $params->{'l1_read_nox_span_api200'} ),
                escape_param( $params->{'l1_theory_nox_span_api200'} ),
                escape_param( $params->{'l1_read_no_span_api200'} ),
                escape_param( $params->{'l1_theory_no_span_api200'} ),
                escape_param( $params->{'l1_read_no2_span_api200'} ),
                escape_param( $params->{'l1_theory_no2_span_api200'} ),
                escape_param($span_set),
                escape_param( $params->{'method_span_api200'} ),
                escape_param($tank_span_api200),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef)
            );
        }
        when (1020) {

            my $zero_set = 0;
            if ( defined( $params->{'mod_zero_api300'} )
                && $params->{'mod_zero_api300'} eq "" )
            {
                $zero_set = 1;
            }
            my $tank_zero_api300 = undef;

            my $span_set = 0;
            if ( defined( $params->{'mod_span_api300'} )
                && $params->{'mod_span_api300'} eq "" )
            {
                $span_set = 1;
            }
            my $tank_span_api300 = undef;
            if ( $params->{'method_span_api100'} eq "10" ) {
                $tank_span_api300 = $params->{'tank_span_api100'};
                if ( $tank_span_api300 == -1 ) { $tank_span_api300 = undef; }
            }

            $res = $sth->execute(
                escape_param( $params->{'station_calib'} ),
                escape_param( $params->{'operator_calib'} ),
                escape_param($datetime),
                escape_param( $params->{'notes_calib'} ),
                escape_param( $params->{'instrument_calib'} ),
                escape_param( $params->{'reason_calib'} ),
                escape_param( $params->{'find_zero_api300'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param($zero_set),
                escape_param( $params->{'method_zero_api300'} ),
                escape_param($tank_zero_api300),
                escape_param( $params->{'read_span_api300'} ),
                escape_param( $params->{'theory_span_api300'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param($span_set),
                escape_param( $params->{'method_span_api300'} ),
                escape_param($tank_span_api300),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef)
            );
        }
        when (1030) {

            my $zero_set = 0;
            if ( defined( $params->{'mod_zero_api400'} )
                && $params->{'mod_zero_api400'} eq "" )
            {
                $zero_set = 1;
            }
            my $tank_zero_api400 = undef;

            my $span_set = 0;
            if ( defined( $params->{'mod_span_api400'} )
                && $params->{'mod_span_api400'} eq "" )
            {
                $span_set = 1;
            }
            my $tank_span_api400 = undef;

            $res = $sth->execute(
                escape_param( $params->{'station_calib'} ),
                escape_param( $params->{'operator_calib'} ),
                escape_param($datetime),
                escape_param( $params->{'notes_calib'} ),
                escape_param( $params->{'instrument_calib'} ),
                escape_param( $params->{'reason_calib'} ),
                escape_param( $params->{'find_zero_api400'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param($zero_set),
                escape_param( $params->{'method_zero_api400'} ),
                escape_param($tank_zero_api400),
                escape_param( $params->{'100_read_span_api400'} ),
                escape_param( $params->{'100_theory_span_api400'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param($span_set),
                escape_param( $params->{'method_span_api400'} ),
                escape_param($tank_span_api400),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef)
            );
        }
        when (1070) {

            my $span_set = 0;
            if ( defined( $params->{'mod_span_gc955'} )
                && $params->{'mod_span_gc955'} eq "" )
            {
                $span_set = 1;
            }
            my $tank_span_gc955 = undef;
            if ( $params->{'method_span_gc955'} eq "10" ) {
                $tank_span_gc955 = $params->{'tank_span_gc955'};
                if ( $tank_span_gc955 == -1 ) { $tank_span_gc955 = undef; }
            }

            $res = $sth->execute(
                escape_param( $params->{'station_calib'} ),
                escape_param( $params->{'operator_calib'} ),
                escape_param($datetime),
                escape_param( $params->{'notes_calib'} ),
                escape_param( $params->{'instrument_calib'} ),
                escape_param( $params->{'reason_calib'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param( $params->{'read_ben_span_gc955'} ),
                escape_param( $params->{'theory_ben_span_gc955'} ),
                escape_param( $params->{'read_tol_span_gc955'} ),
                escape_param( $params->{'theory_tol_span_gc955'} ),
                escape_param( $params->{'read_xil_span_gc955'} ),
                escape_param( $params->{'theory_xil_span_gc955'} ),
                escape_param($span_set),
                escape_param( $params->{'method_span_gc955'} ),
                escape_param($tank_span_gc955),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef)
            );
        }
        when (/1040|1090|1100/) {

            my $flux_set = 0;
            if ( defined( $params->{'mod_flow_sampler'} )
                && $params->{'mod_flow_sampler'} eq "" )
            {
                $flux_set = 1;
            }

            $res = $sth->execute(
                escape_param( $params->{'station_calib'} ),
                escape_param( $params->{'operator_calib'} ),
                escape_param($datetime),
                escape_param( $params->{'notes_calib'} ),
                escape_param( $params->{'instrument_calib'} ),
                escape_param( $params->{'reason_calib'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param( $params->{'read_flow_sampler'} ),
                escape_param( $params->{'reference_flow_sampler'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param($flux_set),
                escape_param( $params->{'temp_flow_sampler'} ),
                escape_param( $params->{'press_flow_sampler'} )
            );
        }
        when (1110) {

            my $zero_set = 0;
            if ( defined( $params->{'mod_zero_ch4'} )
                && $params->{'mod_zero_ch4'} eq "" )
            {
                $zero_set = 1;
            }
            my $tank_zero_ch4 = undef;

            my $span_set = 0;
            if ( defined( $params->{'mod_span_ch4'} )
                && $params->{'mod_span_ch4'} eq "" )
            {
                $span_set = 1;
            }
            my $tank_span_ch4 = undef;
            if ( $params->{'method_span_ch4'} eq "10" ) {
                $tank_span_ch4 = $params->{'tank_span_ch4'};
                if ( $tank_span_ch4 == -1 ) { $tank_span_ch4 = undef; }
            }

            $res = $sth->execute(
                escape_param( $params->{'station_calib'} ),
                escape_param( $params->{'operator_calib'} ),
                escape_param($datetime),
                escape_param( $params->{'notes_calib'} ),
                escape_param( $params->{'instrument_calib'} ),
                escape_param( $params->{'reason_calib'} ),
                escape_param( $params->{'find_zero_ch4'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param($zero_set),
                escape_param( $params->{'method_zero_ch4'} ),
                escape_param($tank_zero_ch4),
                escape_param( $params->{'read_span_ch4'} ),
                escape_param( $params->{'theory_span_ch4'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param($span_set),
                escape_param( $params->{'method_span_ch4'} ),
                escape_param($tank_span_ch4),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef)
            );
        }

        default {

            $res = $sth->execute(
                escape_param( $params->{'station_calib'} ),
                escape_param( $params->{'operator_calib'} ),
                escape_param($datetime),
                escape_param( $params->{'notes_calib'} ),
                escape_param( $params->{'instrument_calib'} ),
                escape_param( $params->{'reason_calib'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef)
            );
        }
    }
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub updateCalibration {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub insertNewCalibration");

    my $sql = qq{
        SELECT in_ca_id
        FROM tool_netcom.view_stations_instruments
        WHERE arpa_id = ?
    };
    my $incaid = $self->app->database->database_query_value_by_parameter( $sql,
        $params->{'instrument_calib'} );
    $self->app->log->debug("incaid: $incaid");

    my $date = $params->{'date_calib'};
    my $time = $params->{'time_calib'};
    $date =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date = "$3-$2-$1";
    $time =~ m|^(\d?\d):(\d\d)$|;
    $time = "$1:$2:00";
    my $datetime = "$date $time";
    $self->app->log->debug("Post datetime: $datetime");

    $sql = qq{
        UPDATE tool_netcom.data_calibrations SET

            st_id = ?, us_id = ?, fulldate = ?, note = ?, arpa_id = ?, re_id = ?,

            zero_found = ?,   zero_set = ?,
            zero_found2 = ?,  zero_set2 = ?,
            zero_found3 = ?,  zero_set3 = ?,
            zero_changed = ?, zero_me_id = ?, zero_cyl_arpa_id = ?,

            span_found = ?,   span_set = ?,
            span_found2 = ?,  span_set2 = ?,
            span_found3 = ?,  span_set3 = ?,
            span_changed = ?, span_me_id = ?, span_cyl_arpa_id = ?,

            flux = ?, flux2 = ?, flux3 = ?, flux_changed = ?, temperature = ?, presssure = ?

        WHERE
            id = ?
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);

    my $res;
    given ($incaid) {
        when (1000) {

            my $zero_set = 0;
            if ( defined( $params->{'mod_zero_api100'} )
                && $params->{'mod_zero_api100'} eq "" )
            {
                $zero_set = 1;
            }
            my $tank_zero_api100 = undef;
            if ( $params->{'method_zero_api100'} eq "2" ) {
                $tank_zero_api100 = $params->{'tank_zero_api100'};
            }

            my $span_set = 0;
            if ( defined( $params->{'mod_span_api100'} )
                && $params->{'mod_span_api100'} eq "" )
            {
                $span_set = 1;
            }
            my $tank_span_api100 = undef;
            if ( $params->{'method_span_api100'} eq "10" ) {
                $tank_span_api100 = $params->{'tank_span_api100'};
                if ( $tank_span_api100 == -1 ) { $tank_span_api100 = undef; }
            }

            $res = $sth->execute(
                escape_param( $params->{'station_calib'} ),
                escape_param( $params->{'operator_calib'} ),
                escape_param($datetime),
                escape_param( $params->{'notes_calib'} ),
                escape_param( $params->{'instrument_calib'} ),
                escape_param( $params->{'reason_calib'} ),
                escape_param( $params->{'find_zero_api100'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param($zero_set),
                escape_param( $params->{'method_zero_api100'} ),
                escape_param($tank_zero_api100),
                escape_param( $params->{'read_span_api100'} ),
                escape_param( $params->{'theory_span_api100'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param($span_set),
                escape_param( $params->{'method_span_api100'} ),
                escape_param($tank_span_api100),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param( $params->{'report-caid'} )
            );
        }
        when (1010) {

            my $zero_set = 0;
            if ( defined( $params->{'mod_zero_api200'} )
                && $params->{'mod_zero_api200'} eq "" )
            {
                $zero_set = 1;
            }
            my $tank_zero_api200 = undef;

            my $span_set = 0;
            if ( defined( $params->{'mod_span_api200'} )
                && $params->{'mod_span_api200'} eq "" )
            {
                $span_set = 1;
            }
            my $tank_span_api200 = undef;
            if ( $params->{'method_span_api200'} eq "10" ) {
                $tank_span_api200 = $params->{'tank_span_api200'};
                if ( $tank_span_api200 == -1 ) { $tank_span_api200 = undef; }
            }

            $res = $sth->execute(
                escape_param( $params->{'station_calib'} ),
                escape_param( $params->{'operator_calib'} ),
                escape_param($datetime),
                escape_param( $params->{'notes_calib'} ),
                escape_param( $params->{'instrument_calib'} ),
                escape_param( $params->{'reason_calib'} ),
                escape_param( $params->{'nox_zero_api200'} ),
                escape_param(undef),
                escape_param( $params->{'no_zero_api200'} ),
                escape_param(undef),
                escape_param( $params->{'no2_zero_api200'} ),
                escape_param(undef),
                escape_param($zero_set),
                escape_param( $params->{'method_zero_api200'} ),
                escape_param($tank_zero_api200),
                escape_param( $params->{'l1_read_nox_span_api200'} ),
                escape_param( $params->{'l1_theory_nox_span_api200'} ),
                escape_param( $params->{'l1_read_no_span_api200'} ),
                escape_param( $params->{'l1_theory_no_span_api200'} ),
                escape_param( $params->{'l1_read_no2_span_api200'} ),
                escape_param( $params->{'l1_theory_no2_span_api200'} ),
                escape_param($span_set),
                escape_param( $params->{'method_span_api200'} ),
                escape_param($tank_span_api200),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param( $params->{'report-caid'} )
            );
        }
        when (1020) {

            my $zero_set = 0;
            if ( defined( $params->{'mod_zero_api300'} )
                && $params->{'mod_zero_api300'} eq "" )
            {
                $zero_set = 1;
            }
            my $tank_zero_api300 = undef;

            my $span_set = 0;
            if ( defined( $params->{'mod_span_api300'} )
                && $params->{'mod_span_api300'} eq "" )
            {
                $span_set = 1;
            }
            my $tank_span_api300 = undef;
            if ( $params->{'method_span_api100'} eq "10" ) {
                $tank_span_api300 = $params->{'tank_span_api100'};
                if ( $tank_span_api300 == -1 ) { $tank_span_api300 = undef; }
            }

            $res = $sth->execute(
                escape_param( $params->{'station_calib'} ),
                escape_param( $params->{'operator_calib'} ),
                escape_param($datetime),
                escape_param( $params->{'notes_calib'} ),
                escape_param( $params->{'instrument_calib'} ),
                escape_param( $params->{'reason_calib'} ),
                escape_param( $params->{'find_zero_api300'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param($zero_set),
                escape_param( $params->{'method_zero_api300'} ),
                escape_param($tank_zero_api300),
                escape_param( $params->{'read_span_api300'} ),
                escape_param( $params->{'theory_span_api300'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param($span_set),
                escape_param( $params->{'method_span_api300'} ),
                escape_param($tank_span_api300),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param( $params->{'report-caid'} )
            );
        }
        when (1030) {

            my $zero_set = 0;
            if ( defined( $params->{'mod_zero_api400'} )
                && $params->{'mod_zero_api400'} eq "" )
            {
                $zero_set = 1;
            }
            my $tank_zero_api400 = undef;

            my $span_set = 0;
            if ( defined( $params->{'mod_span_api400'} )
                && $params->{'mod_span_api400'} eq "" )
            {
                $span_set = 1;
            }
            my $tank_span_api400 = undef;

            $res = $sth->execute(
                escape_param( $params->{'station_calib'} ),
                escape_param( $params->{'operator_calib'} ),
                escape_param($datetime),
                escape_param( $params->{'notes_calib'} ),
                escape_param( $params->{'instrument_calib'} ),
                escape_param( $params->{'reason_calib'} ),
                escape_param( $params->{'find_zero_api400'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param($zero_set),
                escape_param( $params->{'method_zero_api400'} ),
                escape_param($tank_zero_api400),
                escape_param( $params->{'100_read_span_api400'} ),
                escape_param( $params->{'100_theory_span_api400'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param($span_set),
                escape_param( $params->{'method_span_api400'} ),
                escape_param($tank_span_api400),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param( $params->{'report-caid'} )
            );
        }
        when (1070) {

            my $span_set = 0;
            if ( defined( $params->{'mod_span_gc955'} )
                && $params->{'mod_span_gc955'} eq "" )
            {
                $span_set = 1;
            }
            my $tank_span_gc955 = undef;
            if ( $params->{'method_span_gc955'} eq "10" ) {
                $tank_span_gc955 = $params->{'tank_span_gc955'};
                if ( $tank_span_gc955 == -1 ) { $tank_span_gc955 = undef; }
            }

            $res = $sth->execute(
                escape_param( $params->{'station_calib'} ),
                escape_param( $params->{'operator_calib'} ),
                escape_param($datetime),
                escape_param( $params->{'notes_calib'} ),
                escape_param( $params->{'instrument_calib'} ),
                escape_param( $params->{'reason_calib'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param( $params->{'read_ben_span_gc955'} ),
                escape_param( $params->{'theory_ben_span_gc955'} ),
                escape_param( $params->{'read_tol_span_gc955'} ),
                escape_param( $params->{'theory_tol_span_gc955'} ),
                escape_param( $params->{'read_xil_span_gc955'} ),
                escape_param( $params->{'theory_xil_span_gc955'} ),
                escape_param($span_set),
                escape_param( $params->{'method_span_gc955'} ),
                escape_param($tank_span_gc955),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param( $params->{'report-caid'} )
            );
        }
        when (/1040|1090|1100/) {

            my $flux_set = 0;
            if ( defined( $params->{'mod_flow_sampler'} )
                && $params->{'mod_flow_sampler'} eq "" )
            {
                $flux_set = 1;
            }

            $res = $sth->execute(
                escape_param( $params->{'station_calib'} ),
                escape_param( $params->{'operator_calib'} ),
                escape_param($datetime),
                escape_param( $params->{'notes_calib'} ),
                escape_param( $params->{'instrument_calib'} ),
                escape_param( $params->{'reason_calib'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param( $params->{'read_flow_sampler'} ),
                escape_param( $params->{'reference_flow_sampler'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param($flux_set),
                escape_param( $params->{'temp_flow_sampler'} ),
                escape_param( $params->{'press_flow_sampler'} ),
                escape_param( $params->{'report-caid'} )
            );
        }
        when (1110) {

            my $zero_set = 0;
            if ( defined( $params->{'mod_zero_ch4'} )
                && $params->{'mod_zero_ch4'} eq "" )
            {
                $zero_set = 1;
            }
            my $tank_zero_ch4 = undef;

            my $span_set = 0;
            if ( defined( $params->{'mod_span_ch4'} )
                && $params->{'mod_span_ch4'} eq "" )
            {
                $span_set = 1;
            }
            my $tank_span_ch4 = undef;
            if ( $params->{'method_span_ch4'} eq "10" ) {
                $tank_span_ch4 = $params->{'tank_span_ch4'};
                if ( $tank_span_ch4 == -1 ) { $tank_span_ch4 = undef; }
            }

            $res = $sth->execute(
                escape_param( $params->{'station_calib'} ),
                escape_param( $params->{'operator_calib'} ),
                escape_param($datetime),
                escape_param( $params->{'notes_calib'} ),
                escape_param( $params->{'instrument_calib'} ),
                escape_param( $params->{'reason_calib'} ),
                escape_param( $params->{'find_zero_ch4'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param($zero_set),
                escape_param( $params->{'method_zero_ch4'} ),
                escape_param($tank_zero_ch4),
                escape_param( $params->{'read_span_ch4'} ),
                escape_param( $params->{'theory_span_ch4'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param($span_set),
                escape_param( $params->{'method_span_ch4'} ),
                escape_param($tank_span_ch4),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param( $params->{'report-caid'} )
            );
        }
        default {

            $res = $sth->execute(
                escape_param( $params->{'station_calib'} ),
                escape_param( $params->{'operator_calib'} ),
                escape_param($datetime),
                escape_param( $params->{'notes_calib'} ),
                escape_param( $params->{'instrument_calib'} ),
                escape_param( $params->{'reason_calib'} ),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param(undef),
                escape_param( $params->{'report-caid'} )
            );
        }
    }
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub deleteCalibrationReport {
    my ( $self, $rpid ) = @_;

    $self->app->log->debug("sub deleteCalibrationReport");

    my $sql = "DELETE FROM tool_netcom.data_calibrations WHERE id = ?";

    $self->app->log->debug("Query: $sql -> [$rpid]");

    my $sth = $self->app->dbh->prepare($sql);

    if ( $sth->execute($rpid) ) {

        return 1;

    }
    else {
        $self->app->log->debug("Error executing query: $sql -> [$rpid]");
        return 0;
    }
}

sub deleteTank {
    my ( $self, $cyid ) = @_;

    $self->app->log->debug("sub deleteTank");

    my $sql = "DELETE FROM tool_netcom.cylinders WHERE cy_id = ?";

    $self->app->log->debug("Query: $sql -> [$cyid]");

    my $sth = $self->app->dbh->prepare($sql);

    if ( $sth->execute($cyid) ) {

        return 1;

    }
    else {
        $self->app->log->debug("Error executing query: $sql -> [$cyid]");
        return 0;
    }
}

sub deleteTankMatch {
    my ( $self, $id ) = @_;

    $self->app->log->debug("sub deleteTank");

    my $sql = "DELETE FROM tool_netcom.stations_cylinders WHERE st_cy_id = ?";

    $self->app->log->debug("Query: $sql -> [$id]");

    my $sth = $self->app->dbh->prepare($sql);

    if ( $sth->execute($id) ) {

        return 1;

    }
    else {
        $self->app->log->debug("Error executing query: $sql -> [$id]");
        return 0;
    }
}

sub verifyTankArpaId {
    my ( $self, $id ) = @_;

    $self->app->log->debug("sub verifyTankArpaId");

    my $sql = "SELECT count(*) FROM tool_netcom.cylinders WHERE arpa_id = ?";

    $self->app->log->debug("Query: $sql -> [$id]");

    return !$self->app->database->database_query_value_by_parameter( $sql,
        $id );
}

sub verifyIntrumentArpaId {
    my ( $self, $id ) = @_;

    $self->app->log->debug("sub verifyIntrumentArpaId");

    my $sql = "SELECT count(*) FROM tool_netcom.instruments WHERE arpa_id = ?";

    $self->app->log->debug("Query: $sql -> [$id]");

    return !$self->app->database->database_query_value_by_parameter( $sql,
        $id );
}

sub getCalibrationReport {
    my ( $self, $rpid ) = @_;

    $self->app->log->debug("sub getCalibrationReport");

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

sub getCalibrationsLatest {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub getCalibrationsLatest");

    my $sql = qq{
        SELECT
            ca_id AS value,
                to_char(fulldate, 'DD.MM.YYYY HH24:MI') || ' - ' ||
                user_fullname || ' : ' ||
                instrument || ' '
            AS text

            -- fulldate,
            -- to_char(fulldate, 'DD.MM.YYYY HH24:MI') AS fulldate_format,
            -- st_id,
            -- station_name
            -- user_fullname,
            -- user_avatar,
            -- instrument_in_id,
            -- instrument,
            -- zero_info, zero_changed,
            -- span_info, span_changed,
            -- note,
            -- tank_zero, tank_span,
            -- calibrator_in_id, calibrator
        FROM
            tool_web_lily.view_data_calibrations_master
        WHERE
            st_id = ?
        ORDER BY fulldate DESC
        LIMIT 10
    };

    return $self->app->database->database_query_records_by_parameter( $sql,
        $params->{'stid'} );
}

sub insertNewMaintenance {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub insertNewMaintenance");

    my $date = $params->{'report-date'};
    my $time = $params->{'report-time'};
    $date =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date = "$3-$2-$1";
    $time =~ m|^(\d?\d):(\d\d)$|;
    $time = "$1:$2:00";
    my $datetime = "$date $time";
    $self->app->log->debug("Post datetime: $datetime");

    my $sql = qq{
        INSERT INTO tool_netcom.data_maintenances(
            st_id, us_id, fulldate, note
        ) VALUES (?, ?, ?, ?)
        RETURNING ma_id;
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'report-stations'} ),
        escape_param( $params->{'report-operators'} ),
        escape_param($datetime),
        escape_param( $params->{'note-maintenance'} )
    ) or $self->app->log->error($!);
    my $maid = $sth->fetchrow_array();
    $sth->finish;

    if ( !$maid ) {
        $self->app->log->debug("Errore inserimento manutenzione!");
        return 0;
    }

    my $json_data  = encode_utf8( $params->{'operations'} );
    my $operations = decode_json($json_data);
    foreach my $operation ( @{$operations} ) {
        $self->app->log->debug( "operation:" . $operation->{'opid'} );

        my $sql = qq{
            INSERT INTO tool_netcom.data_operations(
                ma_id, arpa_id, op_id, note, ca_id, filters_expdate)
            VALUES (?, ?, ?, ?, ?, ?);
        };

        $self->app->log->debug("Query: $sql");

        my $opdate = $operation->{'date'};
        if ( $opdate eq "Vuoto" ) {
            $opdate = undef;
        }
        else {
            $opdate =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
            $opdate = "$3-$2-$1";
        }

        my $opnote = $operation->{'note'};
        if ( $opnote eq "Vuoto" ) { $opnote = undef; }

        my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
        my $res = $sth->execute(
            $maid,
            escape_param( $operation->{'arid'} ),
            escape_param( $operation->{'opid'} ),
            escape_param($opnote),
            escape_param( $operation->{'caid'} ),
            escape_param($opdate)
        ) or $self->app->log->error($!);
        $sth->finish;
    }

    $json_data = encode_utf8( $params->{'spareparts'} );
    my $spareparts = decode_json($json_data);
    foreach my $sparepart ( @{$spareparts} ) {
        $self->app->log->debug( "sparepart:" . $sparepart->{'spid'} );

        my $sql = qq{
            INSERT INTO tool_netcom.data_spare_parts(
                ma_id, arpa_id, sp_id, quantity)
            VALUES (?, ?, ?, ?);
        };

        $self->app->log->debug("Query: $sql");

        my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
        my $res = $sth->execute(
            $maid,
            escape_param( $sparepart->{'arid'} ),
            escape_param( $sparepart->{'spid'} ),
            escape_param( $sparepart->{'quan'} )
        ) or $self->app->log->error($!);
        $sth->finish;
    }

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }

}

sub updateMaintenance {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub updateMaintenance");

    my $date = $params->{'report-date'};
    my $time = $params->{'report-time'};
    $date =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date = "$3-$2-$1";
    $time =~ m|^(\d?\d):(\d\d)$|;
    $time = "$1:$2:00";
    my $datetime = "$date $time";
    $self->app->log->debug("Post datetime: $datetime");

    my $sql = qq{
        UPDATE tool_netcom.data_maintenances SET
            st_id = ?, us_id = ?, fulldate = ?, note = ?
        WHERE ma_id = ?
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'report-stations'} ),
        escape_param( $params->{'report-operators'} ),
        escape_param($datetime),
        escape_param( $params->{'note-maintenance'} ),
        escape_param( $params->{'report-maid'} )
    ) or $self->app->log->error($!);
    $sth->finish;

    if ($res) {
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }

    $sql = qq{ DELETE FROM tool_netcom.data_operations WHERE ma_id = ? };
    $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    $res = $sth->execute( escape_param( $params->{'report-maid'} ) );

    $sql = qq{ DELETE FROM tool_netcom.data_spare_parts WHERE ma_id = ? };
    $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    $res = $sth->execute( escape_param( $params->{'report-maid'} ) );

    my $json_data  = encode_utf8( $params->{'operations'} );
    my $operations = decode_json($json_data);
    foreach my $operation ( @{$operations} ) {
        $self->app->log->debug( "operation:" . $operation->{'opid'} );

        my $sql = qq{
            INSERT INTO tool_netcom.data_operations(
                ma_id, arpa_id, op_id, note, ca_id, filters_expdate)
            VALUES (?, ?, ?, ?, ?, ?);
        };

        $self->app->log->debug("Query: $sql");

        my $opdate = $operation->{'date'};
        if ( $opdate eq "Vuoto" ) {
            $opdate = undef;
        }
        else {
            $opdate =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
            $opdate = "$3-$2-$1";
        }

        my $opnote = $operation->{'note'};
        if ( $opnote eq "Vuoto" ) { $opnote = undef; }

        my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
        my $res = $sth->execute(
            escape_param( $params->{'report-maid'} ),
            escape_param( $operation->{'arid'} ),
            escape_param( $operation->{'opid'} ),
            escape_param($opnote),
            escape_param( $operation->{'caid'} ),
            escape_param($opdate)
        ) or $self->app->log->error($!);
        $sth->finish;
    }

    $json_data = encode_utf8( $params->{'spareparts'} );
    my $spareparts = decode_json($json_data);
    foreach my $sparepart ( @{$spareparts} ) {
        $self->app->log->debug( "sparepart:" . $sparepart->{'spid'} );

        my $sql = qq{
            INSERT INTO tool_netcom.data_spare_parts(
                ma_id, arpa_id, sp_id, quantity)
            VALUES (?, ?, ?, ?);
        };

        $self->app->log->debug("Query: $sql");

        my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
        my $res = $sth->execute(
            escape_param( $params->{'report-maid'} ),
            escape_param( $sparepart->{'arid'} ),
            escape_param( $sparepart->{'spid'} ),
            escape_param( $sparepart->{'quan'} )
        ) or $self->app->log->error($!);
        $sth->finish;
    }

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub deleteMaintenanceReport {
    my ( $self, $rpid ) = @_;

    $self->app->log->debug("sub deleteMaintenanceReport");

    my $sql = qq{ DELETE FROM tool_netcom.data_operations WHERE ma_id = ? };
    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    if ( $sth->execute($rpid) ) {

        $sql = qq{ DELETE FROM tool_netcom.data_spare_parts WHERE ma_id = ? };
        $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
        if ( $sth->execute($rpid) ) {

            $sql =
              qq{ DELETE FROM tool_netcom.data_maintenances WHERE ma_id = ? };
            $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
            if ( $sth->execute($rpid) ) {

                return 1;

            }
            else {
                $self->app->log->debug(
                    "Error executing query: $sql -> [$rpid]");
                return 0;
            }

        }
        else {
            $self->app->log->debug("Error executing query: $sql -> [$rpid]");
            return 0;
        }

    }
    else {
        $self->app->log->debug("Error executing query: $sql -> [$rpid]");
        return 0;
    }
}

sub getMaintenanceReport {
    my ( $self, $rpid ) = @_;

    $self->app->log->debug("sub getMaintenanceReport");

    my $sql = qq{
        SELECT
            m.ma_id                                               AS ma_id,
            m.st_id                                               AS st_id,
            m.fulldate                                            AS fulldate,
            to_char(fulldate::date, 'DD/MM/YYYY')                 AS date,
            to_char(fulldate::time, 'HH24:MI:00')                 AS time,
            to_char(fulldate, 'DD.MM.YYYY HH24:MI')               AS fulldate_format,
            --to_char(m.fulldate, '"h" HH24:MI "del" DD.MM.YYYY') AS fulldate_format,
            to_char(fulldate::date, 'DD.MM.YYYY')                 AS date_format,
            to_char(fulldate::date, 'DD/MM/YYYY')                 AS date_cal,
            to_char(fulldate::time, 'HH24:MI')                    AS time_format,
            u.us_id                                               AS us_id, -- needed for netcom schema, does not use lily us_id
            --lu.us_id                                            AS us_id,
            lu.user_name                                          AS user_name,
            lu.user_surname                                       AS user_surname,
            lu.user_name || ' ' || lu.user_surname                AS user_fullname,
            COALESCE(lu.user_avatar, 'default.png'::text)         AS user_avatar,
            s.stationname                                         AS station_name,
            m.note                                                AS note
        FROM
            tool_netcom.data_maintenances m
            LEFT JOIN _users u USING (us_id)
            LEFT JOIN _stations s USING (st_id)
            LEFT JOIN tool_web_lily.users lu ON u.us_id = lu.user_main_id
        WHERE
            m.ma_id = ?
    };

    return $self->app->database->database_query_record_by_parameter( $sql,
        $rpid );
}

sub getMaintenanceReportOperations {
    my ( $self, $rpid ) = @_;

    $self->app->log->debug("sub getMaintenanceReportOperations");

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
            f.frequency,
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
        $rpid );
}

sub getMaintenanceReportSpareparts {
    my ( $self, $rpid ) = @_;

    $self->app->log->debug("sub getMaintenanceReportSpareparts");

    my $sql = qq{
        SELECT
            id, ma_id, arpa_id, sp_id, quantity,
            i.name AS instrument,
            sp.description
        FROM
            tool_netcom.data_spare_parts sps
            LEFT JOIN tool_netcom.instruments i USING(arpa_id)
            LEFT JOIN tool_netcom.spare_parts sp USING(sp_id)
        WHERE
            ma_id = ?
        ORDER BY id
    };

    return $self->app->database->database_query_records_by_parameter( $sql,
        $rpid );
}

sub getReportMaintenancesByDates_Csv {
    my ( $self, $date_from, $date_to ) = @_;

    $self->app->log->debug("sub getReportMaintenancesByDates_Csv");

    my $sql = qq{
        SELECT
            m.ma_id                                             AS ma_id,
            m.st_id                                             AS st_id,
            m.fulldate                                          AS fulldate,
            to_char(m.fulldate, '"h" HH24:MI "del" DD.MM.YYYY') AS fulldate_format,
            to_char(m.fulldate, 'DD/MM/YYYY')                   AS date_format,
            to_char(m.fulldate, 'HH24:MI')                      AS time_format,
            lu.us_id                                            AS us_id,
            lu.user_name || ' ' || lu.user_surname              AS user_fullname,
            s.stationname                                       AS station_name,
            m.note                                              AS note
        FROM
            tool_netcom.data_maintenances m
            LEFT JOIN _users u USING (us_id)
            LEFT JOIN _stations s USING (st_id)
            LEFT JOIN tool_web_lily.users lu ON u.us_id = lu.user_main_id
        WHERE
            m.fulldate BETWEEN ? AND ?
        ORDER BY fulldate DESC
    };

    return $self->app->database->database_query_records_by_2parameters( $sql,
        $date_from, $date_to );
}

sub getSurveyNextReportId {
    my ($self) = @_;

    $self->app->log->debug("sub getSurveyNextReportId");

    my $sql = "SELECT nextval('tool_web_lily.surveys_su_id_seq'::regclass)";

    return $self->app->database->database_query_value($sql);
}

sub insertNewSurvey {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub insertNewSurvey");

    my $date  = $params->{'report-date'};
    my $time1 = $params->{'report-time-start'};
    my $time2 = $params->{'report-time-end'};

    $date =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date = "$3-$2-$1";
    $self->app->log->debug("Post date: $date");

    $time1 =~ m|^(\d?\d):(\d\d)$|;
    $time1 = "$1:$2:00";
    $self->app->log->debug("Post time1: $time1");

    $time2 =~ m|^(\d?\d):(\d\d)$|;
    $time2 = "$1:$2:00";
    $self->app->log->debug("Post time2: $time2");

    my $sql = qq{
        INSERT INTO tool_web_lily.surveys(
            su_id, us_id, survey_place, survey_date, survey_start_time, survey_end_time, survey_desc
        ) VALUES (?, ?, ?, ?, ?, ?, ?)
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'report-suid'} ),
        escape_param( $params->{'report-operator'} ),
        escape_param( $params->{'report-place'} ),
        escape_param($date),
        escape_param($time1),
        escape_param($time2),
        escape_param( $params->{'report-note'} )
    );
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub editSurvey {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub editSurvey");

    my $date  = $params->{'report-date'};
    my $time1 = $params->{'report-time-start'};
    my $time2 = $params->{'report-time-end'};

    $date =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date = "$3-$2-$1";
    $self->app->log->debug("Post date: $date");

    $time1 =~ m|^(\d?\d):(\d\d)$|;
    $time1 = "$1:$2:00";
    $self->app->log->debug("Post time1: $time1");

    $time2 =~ m|^(\d?\d):(\d\d)$|;
    $time2 = "$1:$2:00";
    $self->app->log->debug("Post time2: $time2");

    my $sql = qq{
        UPDATE tool_web_lily.surveys SET
            us_id = ?,
            survey_place = ?,
            survey_date = ?,
            survey_start_time = ?,
            survey_end_time = ?,
            survey_desc = ?
        WHERE
            su_id = ?
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'report-operator'} ),
        escape_param( $params->{'report-place'} ),
        escape_param($date),
        escape_param($time1),
        escape_param($time2),
        escape_param( $params->{'report-note'} ),
        escape_param( $params->{'report-suid'} )
    );
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub insertSurveyAttachmentFiles {
    my ( $self, $rpid, $file_original, $file_ondisk, $is_image ) = @_;

    $self->app->log->debug(
        "sub insertSurveyAttachmentFiles - rpid: $rpid,
        file_original: $file_original, file_ondisk: $file_ondisk, is_image: $is_image"
    );

    my $sql = "INSERT INTO tool_web_lily.surveys_attachements\n";
    $sql .= "(su_id, source_filename, stored_filename, is_image)\n";
    $sql .= "VALUES (?,?,?,?)\n";
    $sql .= "RETURNING attachement_id";

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);

    $sth->execute( $rpid, $file_original, $file_ondisk, $is_image )
      or $self->app->log->debug($!);
    my $atid = $sth->fetchrow_array();

    $self->app->log->debug( "atid: " . $atid );
    $sth->finish;

    return $atid;
}

sub deleteSurveyAttachmentFiles {
    my ( $self, $rpid, $fiid ) = @_;

    $self->app->log->debug("sub deleteSurveyAttachmentFiles");

    my $sql =
"DELETE FROM tool_web_lily.surveys_attachements WHERE su_id = ? AND attachement_id = ?";

    $self->app->log->debug("Query: $sql -> [$rpid, $fiid]");

    my $sth = $self->app->dbh->prepare($sql);

    if ( $sth->execute( $rpid, $fiid ) ) {
        return 1;
    }
    else {
        $self->app->log->debug("Error executing query: $sql -> [$rpid]");
        return 0;
    }
}

sub deleteSurveyReport {
    my ( $self, $rpid ) = @_;

    $self->app->log->debug("sub deleteSurveyReport");

    my $sql = "DELETE FROM tool_web_lily.surveys_attachements WHERE su_id = ?";

    $self->app->log->debug("Query: $sql -> [$rpid]");

    my $sth = $self->app->dbh->prepare($sql);

    if ( $sth->execute($rpid) ) {

        my $sql = "DELETE FROM tool_web_lily.surveys WHERE su_id = ?";

        $self->app->log->debug("Query: $sql -> [$rpid]");

        my $sth = $self->app->dbh->prepare($sql);

        if ( $sth->execute($rpid) ) {

            return 1;

        }
        else {
            $self->app->log->debug("Error executing query: $sql -> [$rpid]");
            return 0;
        }

    }
    else {
        $self->app->log->debug("Error executing query: $sql -> [$rpid]");
        return 0;
    }
}

sub getSurveyReport {
    my ( $self, $rpid ) = @_;

    $self->app->log->debug("sub getSurveyReport");

    my $sql = qq{
        SELECT
            s.su_id                                                AS su_id                    ,
            lpad(s.su_id::text, 9, '0')                            AS path_id                  ,
            s.us_id                                                AS us_id                    ,
            u.user_name || ' ' || u.user_surname                   AS user_fullname            ,
            s.survey_place                                         AS survey_place             ,
            g.group_name                                           AS user_group               ,
            s.survey_date                                          AS survey_date              ,
            to_char(s.survey_date, 'DD.MM.YYYY')                   AS survey_date_format       ,
            to_char(s.survey_date, 'DD/MM/YYYY')                   AS survey_date_cal          ,
            s.survey_start_time                                    AS survey_start_time        ,
            to_char(s.survey_start_time, 'HH24:MI')                AS survey_start_time_format ,
            s.survey_end_time                                      AS survey_end_time          ,
            to_char(s.survey_end_time, 'HH24:MI')                  AS survey_end_time_format   ,
            to_char(s.survey_date, 'DD.MM.YYYY') || ' da ' ||
            to_char(s.survey_start_time, 'HH24:MI') || ' a ' ||
            to_char(s.survey_end_time, 'HH24:MI')                  AS survey_date_time_format  ,
            s.survey_desc AS survey_desc,
            array_to_string(array(
                SELECT stored_filename
                FROM tool_web_lily.surveys_attachements a
                WHERE a.su_id = s.su_id
                ORDER BY a.attachement_id
            )::text[], ', ')                                       AS stored_attachments,
            array_to_string(array(
                SELECT source_filename
                FROM tool_web_lily.surveys_attachements a
                WHERE a.su_id = s.su_id
                ORDER BY a.attachement_id
            )::text[], ', ')                                       AS attachments
        FROM
            tool_web_lily.surveys s
            LEFT JOIN tool_web_lily.users u USING(us_id)
            LEFT JOIN tool_web_lily.users_groups ug  USING(us_id)
            LEFT JOIN tool_web_lily.groups g  USING(gr_id)
        WHERE s.su_id = ?
    };

    return $self->app->database->database_query_record_by_parameter( $sql,
        $rpid );
}

sub getEquipmentsList {
    my ($self) = @_;

    $self->app->log->debug("sub getEquipmentsList");

    my $sql = qq{
        SELECT
            eq_id, arpa_id, equipment
        FROM
            tool_netcom.equipments
        ORDER BY
            eq_id
    };

    return $self->app->database->database_query_records($sql);
}

sub getEquipmentsList_Csv {
    my ($self) = @_;

    $self->app->log->debug("sub getEquipmentsList");

    my $sql = qq{
        SELECT
            eq_id, arpa_id, equipment
        FROM
            tool_netcom.equipments
        ORDER BY
            eq_id
    };

    return $self->app->database->database_query_records($sql);
}

sub getEquipmentById {
    my ( $self, $eqid ) = @_;

    $self->app->log->debug("sub getEquipmentById");

    my $sql = qq{
        SELECT
            eq_id, arpa_id, equipment
        FROM
            tool_netcom.equipments
        WHERE
            eq_id = ?
    };

    return $self->app->database->database_query_record_by_parameter( $sql,
        $eqid );
}

sub insertNewEquipment {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub insertNewEquipment");

    my $sql = qq{
        INSERT INTO tool_netcom.equipments(
            arpa_id, equipment
        ) VALUES (?, ?)
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'arpa-id'} ),
        escape_param( $params->{'equipment'} )
    );
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub editEquipment {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub editEquipment");

    my $sql = qq{
        UPDATE tool_netcom.equipments SET
            arpa_id = ?, equipment = ?
        WHERE
            eq_id = ?
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'arpa-id'} ),
        escape_param( $params->{'equipment'} ),
        escape_param( $params->{'equipment-eq-id'} )
    );
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub deleteEquipmentById {
    my ( $self, $eqid ) = @_;

    $self->app->log->debug("sub deleteEquipmentById");

    my $sql = "DELETE FROM tool_netcom.equipments WHERE eq_id = ?";

    $self->app->log->debug("Query: $sql -> [$eqid]");

    my $sth = $self->app->dbh->prepare($sql);

    if ( $sth->execute($eqid) ) {

        return 1;

    }
    else {
        $self->app->log->debug("Error executing query: $sql -> [$eqid]");
        return 0;
    }
}

sub verifyEquipmentArpaId {
    my ( $self, $id ) = @_;

    $self->app->log->debug("sub verifyEquipmentArpaId");

    my $sql = "SELECT count(*) FROM tool_netcom.equipments WHERE arpa_id = ?";

    $self->app->log->debug("Query: $sql -> [$id]");

    return !$self->app->database->database_query_value_by_parameter( $sql,
        $id );
}

sub getEquipmentsMatchesByDates {
    my ( $self, $date_from, $date_to ) = @_;

    $self->app->log->debug("sub getEquipmentsMatchesByDates");

    my $sql = qq{
        SELECT
            st_eq_id, eq_id, arpa_id, equipment, date_start, date_end, note,
            st_id, station, duration
        FROM
            tool_netcom.view_equipments_stations
        WHERE
            (date_start::date, date_end::date) OVERLAPS (?::date, ?::date)
        ORDER BY
            arpa_id
    };

    return $self->app->database->database_query_records_by_2parameters( $sql,
        $date_from, $date_to );
}

sub getEquipmentsMatchesList_Csv {
    my ( $self, $date_from, $date_to ) = @_;

    $self->app->log->debug("sub getEquipmentsMatchesList_Csv");

    my $sql = qq{
        SELECT
            st_eq_id, eq_id, arpa_id, equipment, date_start, date_end, note,
            st_id, station, duration
        FROM
            tool_netcom.view_equipments_stations
        WHERE
            (date_start::date, date_end::date) OVERLAPS (?::date, ?::date)
        ORDER BY
            arpa_id
    };

    return $self->app->database->database_query_records_by_2parameters( $sql,
        $date_from, $date_to );
}

sub insertNewAllocationMatch {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub insertNewAllocationMatch");

    my $date_start = $params->{'start-date'};
    my $date_end   = $params->{'end-date'};

    $date_start =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_start = "$3-$2-$1";
    $self->app->log->debug("Post date_start: $date_start");

    $date_end =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_end = "$3-$2-$1";
    $self->app->log->debug("Post date_end: $date_end");

    my $sql = qq{
        INSERT INTO tool_netcom.stations_equipments(
            st_id, eq_id, date_start, date_end, note
        ) VALUES (?, ?, ?, ?, ?);
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'workstation'} ),
        escape_param( $params->{'equipment'} ),
        escape_param($date_start),
        escape_param($date_end),
        escape_param( $params->{'notes'} )
    );
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub editNewAllocationMatch {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub editNewAllocationMatch");

    my $date_start = $params->{'start-date'};
    my $date_end   = $params->{'end-date'};

    $date_start =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_start = "$3-$2-$1";
    $self->app->log->debug("Post date_start: $date_start");

    $date_end =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_end = "$3-$2-$1";
    $self->app->log->debug("Post date_end: $date_end");

    my $sql = qq{
        UPDATE tool_netcom.stations_equipments SET
            st_id=?, eq_id=?, date_start=?, date_end=?, note=?
        WHERE
            st_eq_id = ?
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'workstation'} ),
        escape_param( $params->{'equipment'} ),
        escape_param($date_start),
        escape_param($date_end),
        escape_param( $params->{'notes'} ),
        escape_param( $params->{'st-eq-id'} )
    );
    $sth->finish;

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub deleteAllocationMatch {
    my ( $self, $id ) = @_;

    $self->app->log->debug("sub deleteAllocationMatch");

    my $sql = "DELETE FROM tool_netcom.stations_equipments WHERE st_eq_id = ?";

    $self->app->log->debug("Query: $sql -> [$id]");

    my $sth = $self->app->dbh->prepare($sql);

    if ( $sth->execute($id) ) {

        return 1;

    }
    else {
        $self->app->log->debug("Error executing query: $sql -> [$id]");
        return 0;
    }
}

sub getAllocationMatchById {
    my ( $self, $id ) = @_;

    $self->app->log->debug("sub getAllocationMatchById");

    my $sql = qq{
        SELECT
            st_eq_id, eq_id, arpa_id, equipment, date_start, date_end, note,
            st_id, station, duration,
            to_char(date_start::date, 'DD/MM/YYYY') AS date_start_format,
            to_char(date_end::date, 'DD/MM/YYYY') AS date_end_format
        FROM
            tool_netcom.view_equipments_stations
        WHERE
            st_eq_id = ?
    };

    return $self->app->database->database_query_record_by_parameter( $sql,
        $id );
}

sub escape_param {
    my $param = shift;

    if ( defined($param) ) {
        if ( $param eq "" ) {
            return undef;
        }
        else {
            my $str = $param;
            $str =~ s/^\s+|\s+$//g;
            return $str;
        }
    }
    else {
        return undef;
    }
}

1;

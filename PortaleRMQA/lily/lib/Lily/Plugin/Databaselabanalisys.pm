package Lily::Plugin::Databaselabanalisys;
use strict;
use warnings;
use Mojo::Base 'Mojolicious::Plugin';

has app => undef;

sub register {
    my ( $self, $app ) = @_;

    $app->log->debug('Lily::Plugin::Databaselabanalisys :: register()');

    $self->app($app);

    $app->helper(
        databaselabanalisys => sub {
            return $self;
        }
    );

    return;
}

sub DESTROY {
    my $self = shift;
    return;
}

sub getPrels {
    my ($self) = @_;

    $self->app->log->debug("sub getPrels");

    my $sql;
    $sql = qq{
        SELECT
            fi_id, filter
        FROM
            labanalysis._laboratory_filter
        WHERE
            fi_id IN(2, 4, 6)
        ORDER BY
            fi_id;
    };

    return $self->app->database->database_query_records($sql);
}

sub getAnalysis {
    my ($self) = @_;

    $self->app->log->debug("sub getAnalysis");

    my $sql;
    $sql = qq{
        SELECT
            an_id, analysis, unit, unitconv, formule
        FROM
            labanalysis._laboratory_analysis
        WHERE
            an_id IN(53, 55, 3120, 8140, 8145, 9005)
        ORDER BY an_id;
    };

    return $self->app->database->database_query_records($sql);
}

sub getAnalysisWhite {
    my ($self) = @_;

    $self->app->log->debug("sub getAnalysisWhite");

    my $sql;
    $sql = qq{
        SELECT
            an_id, analysis, unit, unitconv, formule
        FROM
            labanalysis._laboratory_analysis
        WHERE
            an_id IN(53, 57)
        ORDER BY an_id;
    };

    return $self->app->database->database_query_records($sql);
}

sub getStationsSamples {
    my ($self) = @_;

    $self->app->log->debug("sub getStationsSamples");

    my $sql;
    $sql = qq{
        SELECT st_id, stationname, tableid, station_roaming_type, po_id FROM _stations
        JOIN _users_stations using(st_id)
        WHERE us_id = 2 ORDER BY st_id;
    };

    return $self->app->database->database_query_records($sql);
}

sub getDataWhite {
    my ( $self, $date_from, $date_to, $filter_st_id, $filter_an_id ) = @_;

    $self->app->log->debug("sub getDataWhite");

    $filter_st_id = ".*" if ( !$filter_st_id || $filter_st_id == -1 );
    $filter_an_id = ".*" if ( !$filter_an_id || $filter_an_id == -1 );

    my $sql;
    $sql = qq{
        SELECT
            sp_id,
            lab_pr_id,
            st_id,
            station_name,
            fi_id,
            filter,
            an_id,
            analysis,
            date_start,
            days,
            volume,
            note,
            parameter_name,
            round(cadmio_mass::numeric,4) AS cadmio_mass,
            round(cadmio_conc::numeric,4) AS cadmio_conc,
            round(cromo_mass::numeric,4) AS cromo_mass,
            round(cromo_conc::numeric,4) AS cromo_conc,
            round(ferro_mass::numeric,4) AS ferro_mass,
            round(ferro_conc::numeric,4) AS ferro_conc,
            round(manganese_mass::numeric,4) AS manganese_mass,
            round(manganese_conc::numeric,4) AS manganese_conc,
            round(nichel_mass::numeric,4) AS nichel_mass,
            round(nichel_conc::numeric,4) AS nichel_conc,
            round(piombo_mass::numeric,4) AS piombo_mass,
            round(piombo_conc::numeric,4) AS piombo_conc,
            round(rame_mass::numeric,4) AS rame_mass,
            round(rame_conc::numeric,4) AS rame_conc,
            round(zinco_mass::numeric,4) AS zinco_mass,
            round(zinco_conc::numeric,4) AS zinco_conc,
            round(arsenico_mass::numeric,4) AS arsenico_mass,
            round(arsenico_conc::numeric,4) AS arsenico_conc,
            round(molibdeno_mass::numeric,4) AS molibdeno_mass,
            round(molibdeno_conc::numeric,4) AS molibdeno_conc,
            round(cobalto_mass::numeric,4) AS cobalto_mass,
            round(cobalto_conc::numeric,4) AS cobalto_conc,

            round(ac_sodio_mass::numeric,4) AS ac_sodio_mass,
            round(ac_sodio_conc::numeric,4) AS ac_sodio_conc,
            round(ac_ammonio_mass::numeric,4) AS ac_ammonio_mass,
            round(ac_ammonio_conc::numeric,4) AS ac_ammonio_conc,
            round(ac_magnesio_mass::numeric,4) AS ac_magnesio_mass,
            round(ac_magnesio_conc::numeric,4) AS ac_magnesio_conc,
            round(ac_potassio_mass::numeric,4) AS ac_potassio_mass,
            round(ac_potassio_conc::numeric,4) AS ac_potassio_conc,
            round(ac_calcio_mass::numeric,4) AS ac_calcio_mass,
            round(ac_calcio_conc::numeric,4) AS ac_calcio_conc,
            round(ac_cloruri_mass::numeric,4) AS ac_cloruri_mass,
            round(ac_cloruri_conc::numeric,4) AS ac_cloruri_conc,
            round(ac_nitrati_mass::numeric,4) AS ac_nitrati_mass,
            round(ac_nitrati_conc::numeric,4) AS ac_nitrati_conc,
            round(ac_solfati_mass::numeric,4) AS ac_solfati_mass,
            round(ac_solfati_conc::numeric,4) AS ac_solfati_conc
        FROM
            labanalysis.view_laboratory_data_white
        WHERE
            date_start BETWEEN ? AND ?
            AND st_id::text ~ ?::text
            AND an_id::text ~ ?::text
    };

    return $self->app->database->database_query_records_by_4parameters( $sql,
        $date_from, $date_to, $filter_st_id, $filter_an_id );
}

sub getSamplesListByDatesAndFilters {
    my ( $self, $date_from, $date_to, $filter_st_id, $filter_fi_id,
        $filter_an_id, $filter_spid_from, $filter_spid_to )
      = @_;

    $self->app->log->debug("sub getSamplesListByDatesAndFilters");

    $filter_st_id = ".*" if ( !$filter_st_id || $filter_st_id == -1 );
    $filter_fi_id = ".*" if ( !$filter_fi_id || $filter_fi_id == -1 );
    $filter_an_id = ".*" if ( !$filter_an_id || $filter_an_id == -1 );

    my $sql;
    if ( defined($filter_spid_from) && $filter_spid_from =~ m'^\d{9}$' ) {

        if ( defined($filter_spid_to) && $filter_spid_to =~ m'^\d{9}$' ) {
        }
        else {
            $filter_spid_to = $filter_spid_from;
        }

        $sql = qq{
            SELECT
                id, sp_id, st_id, fi_id, an_id, date_start, no_days, volume, date_insert,
                note, locked_sample, locked_data, stationname, filter_name, analysis_name,
                us_id,
                to_char(date_start::date, 'DD/MM/YYYY') AS date_start_format
            FROM
                labanalysis.view_analysis_samples_lily
            WHERE
                us_id = 2
                AND sp_id BETWEEN ? AND ?
            ORDER BY sp_id;
        };

        return $self->app->database->database_query_records_by_2parameters(
            $sql, $filter_spid_from, $filter_spid_to );

    }
    else {

        $sql = qq{
            SELECT
                id, sp_id, st_id, fi_id, an_id, date_start, no_days, volume, date_insert,
                note, locked_sample, locked_data, stationname, filter_name, analysis_name,
                us_id,
                to_char(date_start::date, 'DD/MM/YYYY') AS date_start_format
            FROM
                labanalysis.view_analysis_samples_lily
            WHERE
                us_id = 2
                AND date_start BETWEEN ? AND ?
                AND st_id::text ~ ?::text
                AND fi_id::text ~ ?::text
                AND an_id::text ~ ?::text
            ORDER BY sp_id;
        };

        return $self->app->database->database_query_records_by_5parameters(
            $sql, $date_from, $date_to, $filter_st_id, $filter_fi_id,
            $filter_an_id );
    }
}

sub verifyLabAnalisysSampleId {
    my ( $self, $id ) = @_;

    $self->app->log->debug("sub verifyLabAnalisysSampleId");

    my $sql =
      "SELECT count(*) FROM labanalysis.laboratory_samples WHERE sp_id = ?";

    $self->app->log->debug("Query: $sql -> [$id]");

    return !$self->app->database->database_query_value_by_parameter( $sql,
        $id );
}

sub insertNewSample {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub insertNewSample");

    my $date_start = $params->{'start-date'};
    $date_start =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_start = "$3-$2-$1";
    $self->app->log->debug("Post date_start: $date_start");

    my $sql = qq{
       INSERT INTO labanalysis.laboratory_samples(
           sp_id, st_id, fi_id, an_id, date_start, no_days, volume,
            date_insert, note, locked_sample, locked_data
       )
       VALUES (?, ?, ?, ?, ?, ?, ?, current_timestamp, ?, ?, ?);
    };

    $self->app->log->debug("Query: $sql");
    my $res;
    eval {

        my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
        $res = $sth->execute(
            escape_param( $params->{'sample-id'} ),
            escape_param( $params->{'station'} ),
            escape_param( $params->{'prel'} ),
            escape_param( $params->{'analysis'} ),
            escape_param($date_start),
            escape_param( $params->{'days'} ),
            escape_param( $params->{'vol-sample'} ),
            escape_param( $params->{'notes'} ),
            0,
            0
        );
        $sth->finish;

    };
    if ($@) {
        $self->app->log->error( "Errore: " . $@ );
        return 0;
    }

    if ($res) {
        return 1;
    }
    else {
        $self->app->log->error( "Errore: " . $! );
        return 0;
    }
}

sub getSampleInfoById {
    my ( $self, $id ) = @_;

    $self->app->log->debug("sub getSampleInfoById");

    my $sql;
    $sql = qq{
        SELECT
            id, sp_id, st_id, fi_id, an_id,
            date_start,
            to_char(date_start::date, 'DD/MM/YYYY') AS date_start_format,
            no_days,
            volume,
            date_insert,
            note, locked_sample, locked_data, stationname, filter_name, analysis_name,
            us_id
        FROM
            labanalysis.view_analysis_samples_lily
        WHERE
            id = ?;
    };

    return $self->app->database->database_query_record_by_parameter( $sql,
        $id );
}

sub getSampleDataById {
    my ( $self, $id ) = @_;

    $self->app->log->debug("sub getSampleDataById");

    my $sql;
    $sql = qq{
        SELECT
            sp_id,
            name,
            mass,
            conc,
            lap.lab_pr_id,
            la.unit,
            la.unitconv,
            la.formule
        FROM
            labanalysis.laboratory_data ld
            LEFT JOIN labanalysis._laboratory_analysis_parameters lap USING(lab_pr_id)
            LEFT JOIN labanalysis._laboratory_analysis la USING(an_id)
            LEFT JOIN _parameters_list pl USING(pr_id)
        WHERE
            sp_id = (select sp_id from labanalysis.laboratory_samples where id = ?)
            AND enabled = true
        ORDER BY lab_pr_id;
    };

    return $self->app->database->database_query_records_by_parameter( $sql,
        $id );
}

sub editSample {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub editSample");

    my $date_start = $params->{'start-date'};
    $date_start =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_start = "$3-$2-$1";
    $self->app->log->debug("Post date_start: $date_start");

    my $sql = qq{
        UPDATE labanalysis.laboratory_samples SET
            sp_id=?, st_id=?, fi_id=?, an_id=?, date_start=?, no_days=?,
            volume=?, date_insert=current_timestamp, note=?, locked_sample=?, locked_data=?
        WHERE id = ?
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'sample-id'} ),
        escape_param( $params->{'station'} ),
        escape_param( $params->{'prel'} ),
        escape_param( $params->{'analysis'} ),
        escape_param($date_start),
        escape_param( $params->{'days'} ),
        escape_param( $params->{'vol-sample'} ),
        escape_param( $params->{'notes'} ),
        0,
        0,
        escape_param( $params->{'sp-id'} )
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

sub lockSample {
    my ( $self, $id ) = @_;

    $self->app->log->debug("sub lockSample");

    my $sql = qq{
        UPDATE labanalysis.laboratory_samples SET
            locked_sample = true
        WHERE id = ?
    };

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

sub unlockSample {
    my ( $self, $id ) = @_;

    $self->app->log->debug("sub unlockSample");

    my $sql = qq{
        UPDATE labanalysis.laboratory_samples SET
            locked_sample = false
        WHERE id = ?
    };

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

sub deleteSample {
    my ( $self, $id ) = @_;

    $self->app->log->debug("sub deleteSample");

    my $sql =
"DELETE FROM labanalysis.laboratory_samples WHERE id = ? AND locked_sample = false";

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

sub getEmptyFilterById {
    my ( $self, $id ) = @_;

    $self->app->log->debug("sub getEmptyFilterById");

    my $sql;
    $sql = qq{
        SELECT
            lap.lab_pr_id,
            pl.pr_id,
            la.an_id,
            pl.name,
            la.unit,
            la.unitconv,
            la.formule
        FROM
            labanalysis._laboratory_analysis_parameters lap
            left join _parameters_list pl using(pr_id)
            left join labanalysis._laboratory_analysis la using(an_id)
        WHERE
            an_id = ? AND enabled = true order by lab_pr_id;
    };

    return $self->app->database->database_query_records_by_parameter( $sql,
        $id );
}

sub insertFilterData {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub insertFilterData");

    my $spid = $params->{'sample_id_filter'};

    $self->app->log->debug("Deleting sample: $spid");
    eval {
        my $sth =
          $self->app->dbh->prepare("SELECT labanalysis.delete_sample_data(?)")
          or $self->app->log->debug($!);
        $sth->execute( escape_param($spid) );
        $sth->finish;
    };
    if ($@) {
        $self->app->log->error( "Errore: " . $@ );
        return 0;
    }

    my $sql = qq{
       INSERT INTO labanalysis.laboratory_data(
           sp_id, lab_pr_id, conc, mass
       )
       VALUES (?, ?, ?, ?)
    };

    my ( $prid, $conc, $mass );
    $self->app->log->debug("Parsing hash");
    foreach my $key ( keys %{$params} ) {

        if ( $key =~ /mass_(\d+)/ ) {
            $prid = $1;
            $mass = ${$params}{$key};
            $conc = ${$params}{ "conc_" . $prid };
            $self->app->log->debug(
                "Parameter mass $prid, mass: $mass, conc: $conc");

            $self->app->log->debug("Query: $sql");
            eval {

                my $sth = $self->app->dbh->prepare($sql)
                  or $self->app->log->debug($!);
                $sth->execute(
                    escape_param($spid), escape_param($prid),
                    escape_param($conc), escape_param($mass)
                );
                $sth->finish;
            };
            if ($@) {
                $self->app->log->error( "Errore: " . $@ );
                return 0;
            }
        }
    }

    return 1;
}

sub getAnalisysFilesType {
    my ($self) = @_;

    $self->app->log->debug("sub getAnalisysFilesType");

    my $sql = qq{
        SELECT
            type_id, analysis
        FROM
            tool_web_lily.analysis_types
        ORDER
            BY type_id;
    };

    return $self->app->database->database_query_records($sql);
}

sub getAnalisysFilesTypeNameById {
    my ( $self, $id ) = @_;

    $self->app->log->debug("sub getAnalisysFilesTypeNameById");

    my $sql = qq{
        SELECT
            analysis
        FROM
            tool_web_lily.analysis_types
        WHERE
            type_id = ?;
    };

    return $self->app->database->database_query_value_by_parameter( $sql, $id );
}

sub getFiles {
    my ( $self, $date_from, $date_to ) = @_;

    $self->app->log->debug(
        "sub getFiles - date_from: $date_from, date_to: $date_to");

    my $sql = qq{
        SELECT
            file_id, t.analysis, source_filename, stored_filename, processed, result, upload_date,
            to_char(upload_date AT TIME ZONE 'UTC +2', 'DD/MM/YYYY HH24:MI') AS upload_date_format
        FROM
            tool_web_lily.labanalysis_files f
            LEFT JOIN tool_web_lily.analysis_types t ON f.analysis_type_fk = t.type_id
        WHERE
            upload_date BETWEEN ? AND ?
        ORDER BY file_id;
    };

    return $self->app->database->database_query_records_by_2parameters( $sql,
        $date_from, $date_to );
}

sub insertDataFile {
    my ( $self, $analysis_type, $file_original, $file_ondisk ) = @_;

    $self->app->log->debug(
"sub insertDataFile - analysis_type: $analysis_type, file_original: $file_original, file_ondisk: $file_ondisk"
    );

    my $sql = "INSERT INTO tool_web_lily.labanalysis_files\n";
    $sql .= "(analysis_type_fk, source_filename, stored_filename)\n";
    $sql .= "VALUES (?,?,?)\n";
    $sql .= "RETURNING file_id";

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);

    $sth->execute( $analysis_type, $file_original, $file_ondisk )
      or $self->app->log->debug($!);
    my $id = $sth->fetchrow_array();

    $self->app->log->debug( "New file id: " . $id );
    $sth->finish;

    return $id;
}

sub getChartDataByRpId {
    my ( $self, $labprid ) = @_;

    $self->app->log->debug("sub getChartDataByRpId - labprid: $labprid");

    my $sql = qq{
        WITH master AS (
            select ('2017-01-01'::date + interval '1 month' * s.a)::date as fulldate from generate_series(0,5) as s(a)
        ),
        plouves AS (
            SELECT
                s.date_start::date AS fulldate,
                d.conc AS plouves_conc --, d.mass
            FROM
                labanalysis.laboratory_data_white d
                LEFT JOIN labanalysis.laboratory_samples_white s USING(sp_id)
            WHERE
                s.st_id = 4000
                AND s.fi_id = 2
                AND s.an_id = 53
                AND d.lab_pr_id = $labprid
        ),
        col_du_mont AS (
            SELECT
                s.date_start::date AS fulldate,
                d.conc AS col_du_mont_conc --, d.mass
            FROM
                labanalysis.laboratory_data_white d
                LEFT JOIN labanalysis.laboratory_samples_white s USING(sp_id)
            WHERE
                s.st_id = 4140
                AND s.fi_id = 2
                AND s.an_id = 53
                AND d.lab_pr_id = $labprid
        ),
        liconi AS (
            SELECT
                s.date_start::date AS fulldate,
                d.conc AS liconi_conc --, d.mass
            FROM
                labanalysis.laboratory_data_white d
                LEFT JOIN labanalysis.laboratory_samples_white s USING(sp_id)
            WHERE
                s.st_id = 4160
                AND s.fi_id = 2
                AND s.an_id = 53
                AND d.lab_pr_id = $labprid
        ),
        lab2 AS (
            SELECT
                s.date_start::date AS fulldate,
                d.conc AS lab2_conc --, d.mass
            FROM
                labanalysis.laboratory_data_white d
                LEFT JOIN labanalysis.laboratory_samples_white s USING(sp_id)
            WHERE
                s.st_id = 4510
                AND s.fi_id = 2
                AND s.an_id = 53
                AND d.lab_pr_id = $labprid
        )
        SELECT * FROM master
        LEFT JOIN plouves USING (fulldate)
        LEFT JOIN col_du_mont USING (fulldate)
        LEFT JOIN liconi USING (fulldate)
        LEFT JOIN lab2 USING (fulldate)
        ORDER BY fulldate;
    };

    return $self->app->database->database_query_records($sql);
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

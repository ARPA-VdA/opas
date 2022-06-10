package Lily::Plugin::Databasereports;
use strict;
use warnings;
use Mojo::Base 'Mojolicious::Plugin';

has app => undef;

sub register {
    my ( $self, $app ) = @_;

    $app->log->debug('Lily::Plugin::Databasereports :: register()');

    $self->app($app);

    $app->helper(
        databasereports => sub {
            return $self;
        }
    );

    return;
}

sub DESTROY {
    my $self = shift;
    return;
}

sub getMemoReportsByDates {
    my ( $self, $date_from, $date_to ) = @_;

    $self->app->log->debug("sub getMemoReportsByDates");

    my $sql = qq{
        SELECT
            me.me_id,
            me.us_id,
            me.memo_place,
            memo_date, memo_start_time, memo_end_time,
            memo_title, memo_body, memo_insert_time, memo_username,
            participant_ids, participant_names,
            gr_id
        FROM
            tool_web_lily.view_memos me
            LEFT JOIN tool_web_lily.users_groups ug ON me.us_id = ug.us_id
        WHERE
            me.memo_date BETWEEN ? AND ?
        ORDER BY
            me.me_id
    };

    return $self->app->database->database_query_records_by_2parameters( $sql,
        $date_from, $date_to );
}

sub getMemoReportById {
    my ( $self, $meid ) = @_;

    $self->app->log->debug("sub getMemoReportById");

    my $sql = qq{
        SELECT
            me_id, us_id, memo_place,
            memo_date,
            to_char(memo_date, 'DD.MM.YYYY') AS memo_date_format,
            memo_start_time, memo_end_time,
            memo_title, memo_body, memo_insert_time, memo_username,
            participant_ids, participant_names
        FROM
            tool_web_lily.view_memos
        WHERE
            me_id = ?
    };

    return $self->app->database->database_query_record_by_parameter( $sql,
        $meid );
}

sub insertNewMemo {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub insertNewMemo");

    my $date_main  = $params->{'memo-date'};
    my $time_start = $params->{'memo-time-start'};
    my $time_end   = $params->{'memo-time-end'};

    $date_main =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_main = "$3-$2-$1";
    $self->app->log->debug("Post date_main: $date_main");

    $time_start =~ m|^(\d?\d):(\d\d)$|;
    $time_start = "$1:$2:00";
    $self->app->log->debug("Post time_start: $time_start");

    $time_end =~ m|^(\d?\d):(\d\d)$|;
    $time_end = "$1:$2:00";
    $self->app->log->debug("Post time_end: $time_end");

    my $sql = qq{
        INSERT INTO tool_web_lily.memos(
            us_id,
            memo_place, memo_title, memo_body,
            memo_date, memo_start_time, memo_end_time
        )
        VALUES (?, ?, ?, ?, ?, ?, ?) RETURNING me_id;
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    $sth->execute(
        escape_param( $params->{'memo-verbalize'} ),
        escape_param( $params->{'memo-place'} ),
        escape_param( $params->{'memo-title'} ),
        escape_param( $params->{'memo-body'} ),
        escape_param($date_main),
        escape_param($time_start),
        escape_param($time_end)
    );
    my $rpid = $sth->fetchrow_array();
    $sth->finish;

    return 0 unless $rpid;

    $self->app->log->debug( "rpid: " . $rpid );

    my $rpmeid;
    $self->app->log->debug( "participant: " . $params->{'memo-participant'} );
    if ( ref( $params->{'memo-participant'} ) eq 'ARRAY' ) {

        my $rows = scalar( @{ $params->{'memo-participant'} } );
        for ( my $i = 0 ; $i < $rows ; $i++ ) {

            $sql = "INSERT INTO tool_web_lily.memo_participants (\n";
            $sql .= "me_id, pa_id\n";
            $sql .= ") VALUES ( ?, ? )\n";
            $sql .= "RETURNING me_pa_id";

            $self->app->log->debug("Query: $sql");

            my $sth = $self->app->dbh->prepare($sql)
              or $self->app->log->error($!);
            $sth->execute( $rpid,
                escape_param( @{ $params->{'memo-participant'} }[$i] ) )
              or $self->app->log->error($!);
            $rpmeid = $sth->fetchrow_array();
            $sth->finish;

            return 0 unless $rpmeid;

        }

    }

    if ( $rpid && $rpmeid ) {
        return 1;
    }
    else {
        $self->app->log->debug( "Errore: " . $! );
        return 0;
    }
}

sub editMemo {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub editMemo");

    my $date_main  = $params->{'memo-date'};
    my $time_start = $params->{'memo-time-start'};
    my $time_end   = $params->{'memo-time-end'};

    $date_main =~ m|^(\d\d)/(\d\d)/(\d\d\d\d)$|;
    $date_main = "$3-$2-$1";
    $self->app->log->debug("Post date_main: $date_main");

    $time_start =~ m|^(\d?\d):(\d\d)$|;
    $time_start = "$1:$2:00";
    $self->app->log->debug("Post time_start: $time_start");

    $time_end =~ m|^(\d?\d):(\d\d)$|;
    $time_end = "$1:$2:00";
    $self->app->log->debug("Post time_end: $time_end");

    my $meid = $params->{'memo-meid'};

    my $sql = qq{
        UPDATE
            tool_web_lily.memos
        SET
            us_id=?,
            memo_place=?, memo_title=?, memo_body=?,
            memo_date=?, memo_start_time=?, memo_end_time=?
        WHERE
            me_id=?
    };

    $self->app->log->debug("Query: $sql");

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'memo-verbalize'} ),
        escape_param( $params->{'memo-place'} ),
        escape_param( $params->{'memo-title'} ),
        escape_param( $params->{'memo-body'} ),
        escape_param($date_main),
        escape_param($time_start),
        escape_param($time_end),
        escape_param($meid)
    );
    $sth->finish;

    if ($res) {

        my $sql = "DELETE FROM tool_web_lily.memo_participants WHERE me_id = ?";

        $self->app->log->debug("Query: $sql -> [$meid]");

        my $sth = $self->app->dbh->prepare($sql);

        if ( $sth->execute($meid) ) {

            my $rpmeid;
            $self->app->log->debug(
                "participant: " . $params->{'memo-participant'} );
            if ( ref( $params->{'memo-participant'} ) eq 'ARRAY' ) {

                my $rows = scalar( @{ $params->{'memo-participant'} } );
                for ( my $i = 0 ; $i < $rows ; $i++ ) {

                    $sql = "INSERT INTO tool_web_lily.memo_participants (\n";
                    $sql .= "me_id, pa_id\n";
                    $sql .= ") VALUES ( ?, ? )\n";
                    $sql .= "RETURNING me_pa_id";

                    $self->app->log->debug("Query: $sql");

                    my $sth = $self->app->dbh->prepare($sql)
                      or $self->app->log->error($!);
                    $sth->execute( $meid,
                        escape_param( @{ $params->{'memo-participant'} }[$i] ) )
                      or $self->app->log->error($!);
                    $rpmeid = $sth->fetchrow_array();
                    $sth->finish;

                    return 0 unless $rpmeid;

                }

                if ($rpmeid) {
                    return 1;
                }
                else {
                    $self->app->log->debug( "Errore: " . $! );
                    return 0;
                }

            }
            else {

                $self->app->log->debug( "Error: " . $! );
                return 0;
            }

        }
        else {

            $self->app->log->debug( "Error: " . $! );
            return 0;
        }

    }
    else {
        $self->app->log->debug( "Error: " . $! );
        return 0;
    }
}

sub deleteMemoReport {
    my ( $self, $rpid ) = @_;

    $self->app->log->debug("sub deleteMemoReport");

    return 1;
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

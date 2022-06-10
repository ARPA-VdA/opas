package Lily::Plugin::Databasevisualizer;
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

our $MASTER_TABLE = '_master';

sub register {
    my ( $self, $app ) = @_;

    $app->log->debug('Lily::Plugin::Databaseutils :: register()');

    $self->app($app);

    $app->helper(
        databasevisualizer => sub {
            return $self;
        }
    );

    return;
}

sub DESTROY {
    my $self = shift;
    return;
}

sub getVisualizerGroups {
    my ( $self, $master_user_id ) = @_;

    $self->app->log->debug(
        "sub getVisualizerGroups, master_user_id: $master_user_id");

    my $sql = qq{
        SELECT
            gr_id,
            name,
            po_id
        FROM
            tool_visualizer_lily.pages_groups
            LEFT JOIN tool_visualizer_lily.pages_groups_users USING(gr_id)
        WHERE
            us_id = $master_user_id
            AND name != 'STAZ-MAP'
        ORDER BY po_id
    };

    return $self->app->database->database_query_records($sql);
}

sub getVisualizerPages {
    my ( $self, $grid ) = @_;

    $self->app->log->debug("sub getVisualizerPages");

    my $sql = qq{
        SELECT
            pg_id,
            name,
            description
        FROM
            tool_visualizer_lily.pages
        WHERE gr_id = ?
        ORDER BY po_id

    };

    return $self->app->database->database_query_records_by_parameter( $sql,
        $grid );
}

sub getVisualizerWindows {
    my ( $self, $pgid ) = @_;

    $self->app->log->debug("sub getVisualizerWindows");

    my $sql = qq{
        SELECT
            pw.wd_id,
            pw.st_pr_id,
            pw.name,
            pw.parametername,
            pw.stationname,
            pw.inttime,
            pw.nodays,
            pw.charttype,
            pw.decimals,
            pw.autoscale,
            pw.scalemin,
            pw.scalemax,
            pw.alertmin,
            pw.alertmax,
            pw.linered,
            pw.linegreen,
            pw.lineorange,
            pw.showminvalues,
            pw.showmaxvalues,
            pw.points,
            pw.marks,
            pw.useformule,
            lpad(to_hex(pw.color), 6, '0') AS color,
            pw.view_id,
            pw.useview,
            pi.integration,
            pl.pr_id,
            pl.unit,
            pl.unitconv,
            pl.formule,
            msi.rain_gauge_heated AS heated,
            sp.id,
            st.st_id,
            st.schema || '._' || st.tableid as tablename
        FROM
            tool_visualizer_lily.pages_windows pw
            LEFT JOIN tool_visualizer_lily.page_integration pi on pw.inttime = pi.id
            LEFT JOIN _stations_parameters sp using (st_pr_id)
            LEFT JOIN _stations st using (st_id)
            LEFT JOIN _parameters_list pl using (pr_id)
            LEFT JOIN metadata.stations_metadata_instruments msi ON st.st_id = msi.st_id
        WHERE
            pg_id = ?
        ORDER BY pw.po_id
    };

    return $self->app->database->database_query_records_by_parameter( $sql,
        $pgid );
}

sub getVisualizerWindow {
    my ( $self, $wdid ) = @_;

    $self->app->log->debug("sub getVisualizerWindows");

    my $sql = qq{
        SELECT
            pw.wd_id,
            pw.st_pr_id,
            pw.name,
            pw.parametername,
            pw.stationname,
            pw.inttime,
            pw.nodays,
            pw.charttype,
            pw.decimals,
            pw.autoscale,
            pw.scalemin,
            pw.scalemax,
            pw.alertmin,
            pw.alertmax,
            pw.linered,
            pw.linegreen,
            pw.lineorange,
            pw.showminvalues,
            pw.showmaxvalues,
            pw.points,
            pw.marks,
            pw.useformule,
            lpad(to_hex(pw.color), 6, '0') AS color,
            pw.view_id,
            pw.useview,
            pi.integration,
            pl.pr_id,
            pl.unit,
            pl.unitconv,
            pl.formule,
            sp.id,
            st.st_id,
            st.schema || '._' || st.tableid as tablename
        FROM
            tool_visualizer_lily.pages_windows pw
            LEFT JOIN tool_visualizer_lily.page_integration pi on pw.inttime = pi.id
            LEFT JOIN _stations_parameters sp using (st_pr_id)
            LEFT JOIN _stations st using (st_id)
            LEFT JOIN _parameters_list pl using (pr_id)
        WHERE
            wd_id = ?
    };

    return $self->app->database->database_query_record_by_parameter( $sql,
        $wdid );
}

sub getVisualizerMapStationsByGroup {
    my ( $self, $grid, $params ) = @_;

    $self->app->log->debug("sub getVisualizerMapStationsByGroup");

    my @nets;
    push( @nets, -1 );
    if ( $params->{'filter[chStz]'} eq "true" ) {
        push( @nets, 4040 );
        push( @nets, 4050 );
        push( @nets, 4070 );
        push( @nets, 4080 );
        push( @nets, 4180 );
        push( @nets, 4020 );
        push( @nets, 4000 );
        push( @nets, 4140 );
        push( @nets, 4110 );
        push( @nets, 4160 );
    }
    if ( $params->{'filter[chLab]'} eq "true" ) { push( @nets, 4510 ); }

    if ( $grid == 202 ) {
        @nets = ();
        push( @nets, -1 );
        if ( $params->{'filter[chStz]'} eq "true" ) {
        }
    }

    if ( $grid == 303 ) {
        @nets = ();
        push( @nets, -1 );
        if ( $params->{'filter[chStz]'} eq "true" ) {
            push( @nets, 1 );
            push( @nets, 2 );
            push( @nets, 3 );
            push( @nets, 4 );
            push( @nets, 5 );
            push( @nets, 6 );
            push( @nets, 7 );
            push( @nets, 8 );
            push( @nets, 9 );
            push( @nets, 10 );
            push( @nets, 11 );
            push( @nets, 12 );
            push( @nets, 13 );
            push( @nets, 14 );
            push( @nets, 15 );
            push( @nets, 16 );
            push( @nets, 17 );
        }
    }

    if ( $grid == 304 ) {
        @nets = ();
        push( @nets, -1 );
        if ( $params->{'filter[chStz]'} eq "true" ) {
            push( @nets, 4230 );
        }
    }

    if ( $grid == 203 ) {
        @nets = ();
        push( @nets, -1 );
        if ( $params->{'filter[chStz]'} eq "true" ) {
            push( @nets, 4040 );
        }
    }

    my $sql = "SELECT * FROM tool_web_lily.view_visualizer_map_stations\n";
    $sql .= "WHERE st_id IN (" . join( ',', @nets ) . ")\n";
    $sql .= "ORDER BY st_id";

    return $self->app->database->database_query_records($sql);
}

sub getVisualizerData {
    my ( $self, $params ) = @_;

    my $stprid   = $params->{'stprid'};
    my $integ    = $params->{'inttime'};
    my $days     = $params->{'days'};
    my $date1    = $params->{'date1'};
    my $date2    = $params->{'date2'};
    my $viewid   = $params->{'viewid'};
    my $useview  = $params->{'useview'};
    my $formule  = $params->{'formule'};
    my $useform  = $params->{'useform'};
    my $alldata  = $params->{'alldata'};
    my $decimals = $params->{'decimals'};

    $self->app->log->debug("sub getVisualizerData, stprid: $stprid");

    my $hours = $days * 24;
    my ( $end_date, $start_date );
    if ( $days != -1 ) {
        $end_date   = $self->app->helperGetGmtDateTime(1);
        $start_date = $self->app->helperDateAddHour( $end_date, $hours * -1 );
        $start_date = $self->app->helperTruncateDate($start_date);
    }
    else {
        $start_date = $date1;
        $end_date   = "$date2 23:59:59";
    }
    $self->app->log->debug("start_date: $start_date");
    $self->app->log->debug("end_date: $end_date");

    my $calcode = 2;
    $self->app->log->debug("alldata: $alldata");
    if ( $alldata eq 'true' ) { $calcode = 9999; }

    $self->app->log->debug("useform: $useform");
    $self->app->log->debug("formule: $formule");
    my ( $form_mea, $form_max, $form_min );
    $form_mea = $formule;
    $form_max = $formule;
    $form_min = $formule;
    if ( $useform == 1 || $useform eq 'true' ) {
        $form_mea =~ s/y=//;
        $form_mea =~ s/x/meanvalue/;
        $form_max =~ s/y=//;
        $form_max =~ s/x/max/;
        $form_min =~ s/y=//;
        $form_min =~ s/x/min/;
    }
    else {
        $form_mea = 'meanvalue';
        $form_max = 'max';
        $form_min = 'min';
    }

    my $sql = qq{
        SELECT
            schema, tableid, id, pr_id
        FROM
            _stations
            LEFT JOIN _stations_parameters USING (st_id)
        WHERE
            st_pr_id = ?
    };
    my $arr =
      $self->app->database->database_query_record_by_parameter( $sql, $stprid );
    my $table   = $arr->{'schema'} . '.data_' . $arr->{'tableid'};
    my $tableid = $arr->{'id'};
    my $prid    = $arr->{'pr_id'};
    if ( defined($viewid) && $viewid ne "" ) {
        $self->app->log->debug("overriding default id: $tableid -> $viewid");
        $tableid = $viewid;
    }
    my $tableid_door = 500;

    given ($integ) {
        when (2) {
            $sql = qq{
                SELECT
                    m.fulldate,
                    CASE WHEN t1.calccode <= $calcode THEN round(cast(t1.$form_mea as numeric), $decimals)::numeric::float END AS avg_value,
                    CASE WHEN t1.calccode <= $calcode THEN round(cast(t1.$form_max as numeric), $decimals)::numeric::float END AS max_value,
                    CASE WHEN t1.calccode <= $calcode THEN round(cast(t1.$form_min as numeric), $decimals)::numeric::float END AS min_value,
                    t1.calccode,
                    t2.meanvalue AS door
                FROM
                    $MASTER_TABLE m
                    LEFT JOIN $table t1 ON m.fulldate = t1.fulldate AND t1.id = $tableid
                    LEFT JOIN $table t2 ON m.fulldate = t2.fulldate AND t2.id = $tableid_door
                WHERE
                    m.fulldate BETWEEN '$start_date' AND '$end_date'
                ORDER BY 1
            };
        }
        when (4) {
            given ($prid) {
                when ( [ 7, 4, 21, 80 ] ) {
                    $sql = qq{
                        SELECT
                            date_trunc('hour', m.fulldate) AS fulldate,
                            round(cast(sum(CASE WHEN t1.calccode <= $calcode THEN t1.$form_mea END) as numeric), $decimals)::numeric::float AS avg_value,
                            round(cast(max(CASE WHEN t1.calccode <= $calcode THEN t1.$form_max END) as numeric), $decimals)::numeric::float AS max_value,
                            round(cast(min(CASE WHEN t1.calccode <= $calcode THEN t1.$form_min END) as numeric), $decimals)::numeric::float AS min_value,
                            max(t1.calccode) AS calccode,
                            max(t2.meanvalue) AS door
                        FROM
                            $MASTER_TABLE m
                            LEFT JOIN $table t1 ON m.fulldate = t1.fulldate AND t1.id = $tableid
                            LEFT JOIN $table t2 ON m.fulldate = t2.fulldate AND t2.id = $tableid_door
                        WHERE
                            m.fulldate BETWEEN '$start_date' AND '$end_date'
                        GROUP BY 1
                        ORDER BY 1
                    };
                }
                when ( [ 10, 11 ] ) {
                    $sql = qq{
                        SELECT
                            date_trunc('hour', m.fulldate) AS fulldate,
                            round(cast(avg(CASE WHEN t1.calccode <= $calcode AND EXTRACT ('minute' FROM m.fulldate) = 0 THEN t1.$form_mea END) as numeric), $decimals)::numeric::float AS avg_value,
                            round(cast(max(CASE WHEN t1.calccode <= $calcode AND EXTRACT ('minute' FROM m.fulldate) = 0 THEN t1.$form_max END) as numeric), $decimals)::numeric::float AS max_value,
                            round(cast(min(CASE WHEN t1.calccode <= $calcode AND EXTRACT ('minute' FROM m.fulldate) = 0 THEN t1.$form_min END) as numeric), $decimals)::numeric::float AS min_value,
                            max(t1.calccode) AS calccode,
                            max(t2.meanvalue) AS door
                        FROM
                            $MASTER_TABLE m
                            LEFT JOIN $table t1 ON m.fulldate = t1.fulldate AND t1.id = $tableid
                            LEFT JOIN $table t2 ON m.fulldate = t2.fulldate AND t2.id = $tableid_door
                        WHERE
                            m.fulldate BETWEEN '$start_date' AND '$end_date'
                        GROUP BY 1
                        ORDER BY 1
                    };
                }
                default {
                    $sql = qq{
                        SELECT
                            date_trunc('hour', m.fulldate) AS fulldate,
                            round(cast(avg(CASE WHEN t1.calccode <= $calcode THEN t1.$form_mea END) as numeric), $decimals)::numeric::float AS avg_value,
                            round(cast(max(CASE WHEN t1.calccode <= $calcode THEN t1.$form_max END) as numeric), $decimals)::numeric::float AS max_value,
                            round(cast(min(CASE WHEN t1.calccode <= $calcode THEN t1.$form_min END) as numeric), $decimals)::numeric::float AS min_value,
                            max(t1.calccode) AS calccode,
                            max(t2.meanvalue) AS door
                        FROM
                            $MASTER_TABLE m
                            LEFT JOIN $table t1 ON m.fulldate = t1.fulldate AND t1.id = $tableid
                            LEFT JOIN $table t2 ON m.fulldate = t2.fulldate AND t2.id = $tableid_door
                        WHERE
                            m.fulldate BETWEEN '$start_date' AND '$end_date'
                        GROUP BY 1
                        ORDER BY 1
                    };
                }
            }
        }
        when (6) {
            given ($prid) {
                when ( [ 7, 4, 21, 80 ] ) {
                    $sql = qq{
                        SELECT
                            date_trunc('day', m.fulldate) AS fulldate,
                            round(cast(sum(CASE WHEN t1.calccode <= $calcode THEN t1.$form_mea END) as numeric), $decimals)::numeric::float AS avg_value,
                            round(cast(max(CASE WHEN t1.calccode <= $calcode THEN t1.$form_max END) as numeric), $decimals)::numeric::float AS max_value,
                            round(cast(min(CASE WHEN t1.calccode <= $calcode THEN t1.$form_min END) as numeric), $decimals)::numeric::float AS min_value,
                            max(t1.calccode) AS calccode,
                            max(t2.meanvalue) AS door
                        FROM
                            $MASTER_TABLE m
                            LEFT JOIN $table t1 ON m.fulldate = t1.fulldate AND t1.id = $tableid
                            LEFT JOIN $table t2 ON m.fulldate = t2.fulldate AND t2.id = $tableid_door
                        WHERE
                            m.fulldate BETWEEN '$start_date' AND '$end_date'
                        GROUP BY 1
                        ORDER BY 1
                    };
                }
                when ( [ 1, 2, 3, 10, 11 ] ) {
                    $sql = qq{
                        SELECT
                            date_trunc('day', m.fulldate) AS fulldate,
                            round(cast(avg(CASE WHEN t1.calccode <= $calcode AND EXTRACT ('minute' FROM m.fulldate) = 0 THEN t1.$form_mea END) as numeric), $decimals)::numeric::float AS avg_value,
                            round(cast(max(CASE WHEN t1.calccode <= $calcode AND EXTRACT ('minute' FROM m.fulldate) = 0 THEN t1.$form_max END) as numeric), $decimals)::numeric::float AS max_value,
                            round(cast(min(CASE WHEN t1.calccode <= $calcode AND EXTRACT ('minute' FROM m.fulldate) = 0 THEN t1.$form_min END) as numeric), $decimals)::numeric::float AS min_value,
                            max(t1.calccode) AS calccode,
                            max(t2.meanvalue) AS door
                        FROM
                            $MASTER_TABLE m
                            LEFT JOIN $table t1 ON m.fulldate = t1.fulldate AND t1.id = $tableid
                            LEFT JOIN $table t2 ON m.fulldate = t2.fulldate AND t2.id = $tableid_door
                        WHERE
                            m.fulldate BETWEEN '$start_date' AND '$end_date'
                        GROUP BY 1
                        ORDER BY 1
                    };
                }
                default {
                    $sql = qq{
                        SELECT
                            date_trunc('day', m.fulldate) AS fulldate,
                            round(cast(avg(CASE WHEN t1.calccode <= $calcode THEN t1.$form_mea END) as numeric), $decimals)::numeric::float AS avg_value,
                            round(cast(max(CASE WHEN t1.calccode <= $calcode THEN t1.$form_max END) as numeric), $decimals)::numeric::float AS max_value,
                            round(cast(min(CASE WHEN t1.calccode <= $calcode THEN t1.$form_min END) as numeric), $decimals)::numeric::float AS min_value,
                            max(t1.calccode) AS calccode,
                            max(t2.meanvalue) AS door
                        FROM
                            $MASTER_TABLE m
                            LEFT JOIN $table t1 ON m.fulldate = t1.fulldate AND t1.id = $tableid
                            LEFT JOIN $table t2 ON m.fulldate = t2.fulldate AND t2.id = $tableid_door
                        WHERE
                            m.fulldate BETWEEN '$start_date' AND '$end_date'
                        GROUP BY 1
                        ORDER BY 1
                    };
                }
            }
        }
        when (8) {
            given ($prid) {
                when ( [ 7, 4, 21, 80 ] ) {
                    $sql = qq{
                        SELECT
                            date_trunc('month', m.fulldate) AS fulldate,
                            round(cast(sum(CASE WHEN t1.calccode <= $calcode THEN t1.$form_mea END) as numeric), $decimals)::numeric::float AS avg_value,
                            round(cast(max(CASE WHEN t1.calccode <= $calcode THEN t1.$form_max END) as numeric), $decimals)::numeric::float AS max_value,
                            round(cast(min(CASE WHEN t1.calccode <= $calcode THEN t1.$form_min END) as numeric), $decimals)::numeric::float AS min_value,
                            max(t1.calccode) AS calccode,
                            max(t2.meanvalue) AS door
                        FROM
                            $MASTER_TABLE m
                            LEFT JOIN $table t1 ON m.fulldate = t1.fulldate AND t1.id = $tableid
                            LEFT JOIN $table t2 ON m.fulldate = t2.fulldate AND t2.id = $tableid_door
                        WHERE
                            m.fulldate BETWEEN '$start_date' AND '$end_date'
                        GROUP BY 1
                        ORDER BY 1
                    };
                }
                when ( [ 10, 11 ] ) {
                    $sql = qq{
                        SELECT
                            date_trunc('month', m.fulldate) AS fulldate,
                            round(cast(avg(CASE WHEN t1.calccode <= $calcode AND EXTRACT ('minute' FROM m.fulldate) = 0 THEN t1.$form_mea END) as numeric), $decimals)::numeric::float AS avg_value,
                            round(cast(max(CASE WHEN t1.calccode <= $calcode AND EXTRACT ('minute' FROM m.fulldate) = 0 THEN t1.$form_max END) as numeric), $decimals)::numeric::float AS max_value,
                            round(cast(min(CASE WHEN t1.calccode <= $calcode AND EXTRACT ('minute' FROM m.fulldate) = 0 THEN t1.$form_min END) as numeric), $decimals)::numeric::float AS min_value,
                            max(t1.calccode) AS calccode,
                            max(t2.meanvalue) AS door
                        FROM
                            $MASTER_TABLE m
                            LEFT JOIN $table t1 ON m.fulldate = t1.fulldate AND t1.id = $tableid
                            LEFT JOIN $table t2 ON m.fulldate = t2.fulldate AND t2.id = $tableid_door
                        WHERE
                            m.fulldate BETWEEN '$start_date' AND '$end_date'
                        GROUP BY 1
                        ORDER BY 1
                    };
                }
                default {
                    $sql = qq{
                        SELECT
                            date_trunc('month', m.fulldate) AS fulldate,
                            round(cast(avg(CASE WHEN t1.calccode <= $calcode THEN t1.$form_mea END) as numeric), $decimals)::numeric::float AS avg_value,
                            round(cast(max(CASE WHEN t1.calccode <= $calcode THEN t1.$form_max END) as numeric), $decimals)::numeric::float AS max_value,
                            round(cast(min(CASE WHEN t1.calccode <= $calcode THEN t1.$form_min END) as numeric), $decimals)::numeric::float AS min_value,
                            max(t1.calccode) AS calccode,
                            max(t2.meanvalue) AS door
                        FROM
                            $MASTER_TABLE m
                            LEFT JOIN $table t1 ON m.fulldate = t1.fulldate AND t1.id = $tableid
                            LEFT JOIN $table t2 ON m.fulldate = t2.fulldate AND t2.id = $tableid_door
                        WHERE
                            m.fulldate BETWEEN '$start_date' AND '$end_date'
                        GROUP BY 1
                        ORDER BY 1
                    };
                }
            }
        }
        default {
            $sql = qq{
                SELECT
                current_timestamp AS fulldate,
                'integration not implemented' AS avg_value,
                'integration not implemented' AS max_value,
                'integration not implemented' AS min_value,
                'integration not implemented' AS calccode,
                'integration not implemented' AS door
            }
        }
    }

    return $self->app->database->database_query_records($sql);
}

sub setVisualizerWindow {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub setVisualizerWindow");

    my $sql = qq{
        UPDATE tool_visualizer_lily.pages_windows SET
            name=?, parametername=?, nodays=?,
            decimals=?, color=?,
            showmaxvalues=?, showminvalues=?,
            autoscale=?, points=?, marks=?,
            scalemin=?, scalemax=?,
            alertmin=?, alertmax=?,
            linered=?, lineorange=?, linegreen=?,
            useformule=?,
            view_id=?, useview=?

            -- defaultview=?,
            -- charttype=?, stationname=?,
            -- inttime=?,
            -- thick=?,
            -- marksdrawevery=?,
            -- scaleminoffset=?,
            -- scalemaxoffset=?,
            -- chartfunction=?,
            -- showstddevvalues=?, showsgridband=?,
            -- fontsize=?, fontbold=?,
            -- fontcolor=?,
            -- wtop=?, wleft=?, wwidth=?, wheight=?, wpretop=?,
            -- wpreleft=?, wprewidth=?, wpreheight=?, wnumtop=?, wnumleft=?,
            -- wnumwidth=?, wnumheight=?,
            -- po_id=?
        WHERE
            wd_id=?
    };

    $self->app->log->debug("Query: $sql");
    $self->app->log->debug( "wdid: " . $params->{'param-wdid'} );

    my $hex_val = $params->{'param-color-hex'};
    $self->app->log->debug("hex_val: $hex_val");

    $hex_val =~ s/#//;
    my $color_val = hex($hex_val);
    $self->app->log->debug("color_val: $color_val");

    my $maxval = 0;
    if ( defined( $params->{'param-maxval'} )
        && $params->{'param-maxval'} eq "" )
    {
        $maxval = 1;
    }
    my $minval = 0;
    if ( defined( $params->{'param-minval'} )
        && $params->{'param-minval'} eq "" )
    {
        $minval = 1;
    }
    my $points = 0;
    if ( defined( $params->{'param-points'} )
        && $params->{'param-points'} eq "" )
    {
        $points = 1;
    }
    my $values = 0;
    if ( defined( $params->{'param-values'} )
        && $params->{'param-values'} eq "" )
    {
        $values = 1;
    }
    my $vision = 0;
    if ( defined( $params->{'param-vision'} )
        && $params->{'param-vision'} eq "" )
    {
        $vision = 1;
    }
    $self->app->log->debug("maxval: $maxval");
    my $correction = 0;
    if ( defined( $params->{'param-formule-correction'} )
        && $params->{'param-formule-correction'} eq "" )
    {
        $correction = 1;
    }

    my $sth = $self->app->dbh->prepare($sql) or $self->app->log->debug($!);
    my $res = $sth->execute(
        escape_param( $params->{'param-label'} ),
        escape_param( $params->{'param-label'} ),
        escape_param( $params->{'param-days'} ),

        escape_param( $params->{'param-dec'} ),
        escape_param($color_val),

        escape_param($maxval),
        escape_param($minval),

        escape_param( $params->{'param-y'} ),
        escape_param($points),
        escape_param($values),

        escape_param( $params->{'param-min'} ),
        escape_param( $params->{'param-max'} ),

        escape_param( $params->{'param-almin'} ),
        escape_param( $params->{'param-almax'} ),

        escape_param( $params->{'param-red'} ),
        escape_param( $params->{'param-orange'} ),
        escape_param( $params->{'param-green'} ),

        escape_param($correction),

        escape_param( $params->{'param-idtable'} ),
        escape_param($vision),
        $params->{'param-wdid'}
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

sub setVisualizerGroupPosition {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub setVisualizerGroupPosition");

    my $sql = qq{
        SELECT po_id FROM tool_visualizer_lily.pages_groups po_id WHERE gr_id=?;
    };
    my $newpos = $params->{'po'};
    my $oldpos = $self->app->database->database_query_value_by_parameter( $sql,
        $params->{'id'} );
    $self->app->log->debug("oldpos: $oldpos, newpos: $newpos");

    if ( $oldpos < $newpos ) {
        $sql = qq{
            UPDATE tool_visualizer_lily.pages_groups SET po_id = po_id-1 WHERE po_id <= ? AND po_id > ?;
        };
    }
    else {
        $sql = qq{
            UPDATE tool_visualizer_lily.pages_groups SET po_id = po_id+1 WHERE po_id >= ? AND po_id < ?;
        };
    }
    $self->app->database->database_query_execute_2parameters( $sql, $newpos,
        $oldpos );
    $sql = qq{
        UPDATE tool_visualizer_lily.pages_groups SET
            po_id=? WHERE gr_id=?
    };

    return $self->app->database->database_query_execute_2parameters( $sql,
        $newpos, $params->{'id'} );
}

sub setVisualizerGroupName {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub setVisualizerGroupName");

    my $sql = qq{
        UPDATE tool_visualizer_lily.pages_groups SET
            name=? WHERE gr_id=?
    };

    return $self->app->database->database_query_execute_2parameters( $sql,
        $params->{'name'}, $params->{'id'} );
}

sub setVisualizerPageName {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub setVisualizerPageName");

    my $sql = qq{
        UPDATE tool_visualizer_lily.pages SET
            name=? WHERE pg_id=?
    };

    return $self->app->database->database_query_execute_2parameters( $sql,
        $params->{'name'}, $params->{'id'} );
}

sub setVisualizerWindowName {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub setVisualizerWindowName");

    my $sql = qq{
        UPDATE tool_visualizer_lily.pages_windows SET
            name=? WHERE wd_id=?
    };

    return $self->app->database->database_query_execute_2parameters( $sql,
        $params->{'name'}, $params->{'id'} );
}

sub setVisualizerPagePosition {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub setVisualizerPagePosition");

    my $sql = qq{
        SELECT po_id FROM tool_visualizer_lily.pages po_id WHERE gr_id=? AND pg_id=?;
    };
    my $group  = $params->{'se'};
    my $page   = $params->{'id'};
    my $newpos = $params->{'po'};
    my $oldpos =
      $self->app->database->database_query_value_by_2parameters( $sql, $group,
        $page );
    $self->app->log->debug("group: $group, page: $page");
    $self->app->log->debug("oldpos: $oldpos, newpos: $newpos");

    if ( $oldpos < $newpos ) {
        $sql = qq{
            UPDATE tool_visualizer_lily.pages SET po_id = po_id-1 WHERE po_id <= ? AND po_id > ? AND gr_id=?;
        };
    }
    else {
        $sql = qq{
            UPDATE tool_visualizer_lily.pages SET po_id = po_id+1 WHERE po_id >= ? AND po_id < ? AND gr_id=?;
        };
    }
    $self->app->database->database_query_execute_3parameters( $sql, $newpos,
        $oldpos, $group );
    $sql = qq{
        UPDATE tool_visualizer_lily.pages SET
            po_id=? WHERE pg_id=?
    };

    return $self->app->database->database_query_execute_2parameters( $sql,
        $newpos, $page );
}

sub setVisualizerWindowPosition {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub setVisualizerWindowPosition");

    my $sql = qq{
        SELECT po_id FROM tool_visualizer_lily.pages_windows po_id WHERE wd_id=?;
    };
    my $page   = $params->{'se'};
    my $wind   = $params->{'id'};
    my $newpos = $params->{'po'};
    my $oldpos =
      $self->app->database->database_query_value_by_parameter( $sql, $wind );
    $self->app->log->debug("page: $page, wind: $wind");
    $self->app->log->debug("oldpos: $oldpos, newpos: $newpos");

    if ( $oldpos < $newpos ) {
        $sql = qq{
            UPDATE tool_visualizer_lily.pages_windows SET po_id = po_id-1 WHERE po_id <= ? AND po_id > ? AND pg_id=?;
        };
    }
    else {
        $sql = qq{
            UPDATE tool_visualizer_lily.pages_windows SET po_id = po_id+1 WHERE po_id >= ? AND po_id < ? AND pg_id=?;
        };
    }
    $self->app->database->database_query_execute_3parameters( $sql, $newpos,
        $oldpos, $page );
    $sql = qq{
        UPDATE tool_visualizer_lily.pages_windows SET
            po_id=? WHERE wd_id=? AND pg_id=?
    };

    return $self->app->database->database_query_execute_3parameters( $sql,
        $newpos, $wind, $page );
}

sub updateVisualizerDataCode {
    my ( $self, $params ) = @_;

    $self->app->log->debug("sub updateVisualizerDataCode");

    my $sql = qq{
        SELECT update_calccode_stprid_fulldate(?::smallint, ?::timestamp, ?::smallint);
    };

    return $self->app->database->database_query_execute_3parameters( $sql,
        $params->{'stprid'}, $params->{'date'}, $params->{'code'} );
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

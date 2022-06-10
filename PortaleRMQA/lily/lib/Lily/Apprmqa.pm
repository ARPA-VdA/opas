package Lily::Apprmqa;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub getinstrument_metadata {
    my $self = shift;
    my $params = $self->req->body_params->to_hash;
    my $file =
      $self->helperDumperPostData( 'Apprmqa-getinstrument_metadata', $params );
    $self->app->log->debug( "Post: " . Dumper($params) );

    my $ARPAid = $params->{'arpa_id'};

    $self->app->log->debug("Lily::Apprmqa sub getinstrument_metadata");

    my $instrument = $self->databaseapprmqa->getInstrumentbyId($ARPAid);
    $self->app->log->debug( "Dump user: " . Dumper($instrument) );

    my $json = {};
    if ( !$instrument ) {
        $self->app->log->warn("User not found");
        $self->render(
            json => {
                message => "Strumento non trovato"
            },
            status => 403
        );
        return;
    }

    $json = {
        instrument => {
            arpa_id       => $ARPAid,
            costruttore   => $instrument->{'costruttore'},
            marca         => $instrument->{'marca'},
            modello       => $instrument->{'modello'},
            strumento     => $instrument->{'strumento'},
            numero_serie  => $instrument->{'numero_serie'},
            tipo          => $instrument->{'tipo'},
            data_consegna => $instrument->{'data_consegna'}
        }
    };

    $self->app->log->debug('Rendering JSON...');
    $self->render(
        json   => $json,
        status => 200
    );

}

sub getinstrument_calibrations {

    my $self = shift;
    my $params = $self->req->body_params->to_hash;
    my $file =
      $self->helperDumperPostData( 'Apprmqa-getinstrument_calibrations',
        $params );
    $self->app->log->debug( "Post: " . Dumper($params) );

    my $ARPAid = $params->{'arpa_id'};

    $self->app->log->debug("Lily::Apprmqa sub getinstrument_calibrations");

    my $calibrations =
      $self->databaseapprmqa->getInstrumentCalibrationsById($ARPAid);
    $self->app->log->debug( "Dump user: " . Dumper($calibrations) );

    my $json = {};
    my @array_calibrations;
    foreach my $elem (@$calibrations) {
        my $calibration = {
            type          => 'calibration',
            id            => $elem->{'id'},
            full_date     => $elem->{'fulldate'},
            date_format   => $elem->{'date_format'},
            date_gap      => $elem->{'date_gap'},
            user_id       => $elem->{'us_id'},
            user_fullname => $elem->{'user_fullname'},
            user_avatar   => 'http://rmqa.arpa.vda.it/img-lily/users/'
              . $elem->{'user_avatar'},
            station_name    => $elem->{'station_name'},
            instrument_type => $elem->{'instrument_type'},
            span_changed    => $elem->{'span_changed'},
            flux_changed    => $elem->{'flux_changed'}
        };
        push @array_calibrations, $calibration;
    }

    $json = { calibrations => \@array_calibrations };

    $self->render(
        json   => $json,
        status => 200
    );
}

sub getinstrument_maintenances {

    my $self = shift;
    my $params = $self->req->body_params->to_hash;
    my $file =
      $self->helperDumperPostData( 'Apprmqa-getinstrument_maintenances',
        $params );
    $self->app->log->debug( "Post: " . Dumper($params) );

    my $ARPAid = $params->{'arpa_id'};

    $self->app->log->debug("Lily::Apprmqa sub getinstrument_maintenances");

    my $maintenances =
      $self->databaseapprmqa->getInstrumentMaintenancesById($ARPAid);
    $self->app->log->debug( "Dump user: " . Dumper($maintenances) );

    my $json = {};
    my @array_maintenances;
    foreach my $elem (@$maintenances) {
        my $maintenance = {
            type          => 'maintenance',
            id            => $elem->{'ma_id'},
            full_date     => $elem->{'fulldate'},
            date_format   => $elem->{'date_format'},
            date_gap      => $elem->{'date_gap'},
            user_id       => $elem->{'us_id'},
            user_fullname => $elem->{'user_fullname'},
            user_avatar   => 'http://rmqa.arpa.vda.it/img-lily/users/'
              . $elem->{'user_avatar'},
            station_name => $elem->{'station_name'},
            note         => $elem->{'note'}
        };
        push @array_maintenances, $maintenance;
    }

    $json = { maintenances => \@array_maintenances };

    $self->render(
        json   => $json,
        status => 200
    );

}

sub getcalibration_detail {
    my $self = shift;

    $self->app->log->debug("Lily::Apprmqa sub getcalibration_detail");

    my $caid = $self->param('ca_id');
    $self->app->log->debug("caid: $caid");

    my $calibration = $self->databaseapprmqa->getCalibrationDetail($caid);

    my $json = { calibration => $calibration };

    $self->render(
        json   => $json,
        status => 200
    );
}

sub getmaintenance_detail {
    my $self = shift;

    $self->app->log->debug("Lily::Apprmqa sub getmaintenance_detail");

    my $maid = $self->param('ma_id');
    $self->app->log->debug("maid: $maid");

    my $operations = $self->databaseapprmqa->getMaintenanceDetail($maid);

    my $json = {};
    my @array_operations;
    foreach my $elem (@$operations) {
        my $operation = {
            id              => $elem->{'id'},
            ma_id           => $elem->{'ma_id'},
            op_id           => $elem->{'op_id'},
            arpa_id         => $elem->{'arpa_id'},
            instrument      => $elem->{'instrument'},
            description     => $elem->{'description'},
            frequency       => $elem->{'freq_days'},
            filters_expdate => $elem->{'filters_expdate'},
            note            => $elem->{'note'}
        };

        push @array_operations, $operation;
    }

    $json = { operations => \@array_operations };

    $self->render(
        json   => $json,
        status => 200
    );

}

1;

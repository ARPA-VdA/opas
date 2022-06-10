package Lily::Visualizer;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub visualizer_app {
    my $self = shift;

    $self->app->log->debug("Lily::visualizer_app");

    $self->helperGetHomepageStash('visualizer_app');

    my $params = $self->req->body_params->to_hash;
    $self->helperDumper($params);
    my $date_from = $params->{'startDate'};
    my $date_to   = $params->{'endDate'};
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");
    if ( $date_from !~ m/^(\d{4})-(\d{2})-(\d{2})$/ ) {
        $date_to   = $self->helperGetDateNoTime();
        $date_from = $self->helperDateNoTimeAddDay( $date_to, -6 );
    }
    $date_to = "$date_to 23:59:59";
    $self->stash( date_from => $date_from, date_to => $date_to );
    $self->app->log->debug("date_from: $date_from");
    $self->app->log->debug("date_to: $date_to");

    my $grid = $self->session('lily.app.ecometer')->{'gr_id'};
    $self->stash( grid => $grid );

    my $master_user_id =
      $self->config->{'apps'}->{'visualizer'}->{'master_user_id'};
    if ( $grid == 202 ) { $master_user_id = 39; }
    if ( $grid == 304 ) { $master_user_id = 40; }
    if ( $grid == 203 ) { $master_user_id = 41; }

    my $groups =
      $self->databasevisualizer->getVisualizerGroups($master_user_id);
    $self->stash( groups => $groups );

    $self->render();
}

sub visualizer_pages {
    my $self = shift;

    $self->app->log->debug("Lily::visualizer_pages");

    my $params = $self->req->body_params->to_hash;

    my $json;
    $self->app->log->debug('visualizer_pages');

    my $pages =
      $self->databasevisualizer->getVisualizerPages( $params->{'grid'} );

    $json = {
        res  => 'OK',
        data => $pages
    };

    $self->render( json => $json );
}

sub visualizer_windows {
    my $self = shift;

    $self->app->log->debug("Lily::visualizer_windows");

    my $params = $self->req->body_params->to_hash;

    my $json;
    $self->app->log->debug('visualizer_windows');

    my $windows =
      $self->databasevisualizer->getVisualizerWindows( $params->{'pgid'} );

    $json = {
        res  => 'OK',
        data => $windows
    };

    $self->render( json => $json );
}

sub visualizer_window {
    my $self = shift;

    $self->app->log->debug("Lily::visualizer_window");

    my $params = $self->req->body_params->to_hash;

    my $json;
    $self->app->log->debug('visualizer_window');

    my $windows =
      $self->databasevisualizer->getVisualizerWindow( $params->{'wdid'} );

    $json = {
        res  => 'OK',
        data => $windows
    };

    $self->render( json => $json );
}

sub visualizer_map_stations {
    my $self = shift;

    $self->app->log->debug("Lily visualizer_map_stations");

    my $params = $self->req->body_params->to_hash;

    my $grid = $self->session('lily.app.ecometer')->{'gr_id'};

    my $stations =
      $self->databasevisualizer->getVisualizerMapStationsByGroup( $grid,
        $params );

    my $json = {
        res      => 'OK',
        stations => $stations
    };

    $self->render( json => $json );
}

sub visualizer_data {
    my $self = shift;

    $self->app->log->debug("Lily::visualizer_data");

    my $params = $self->req->body_params->to_hash;

    my $json;
    $self->app->log->debug('visualizer_data');

    my $data = $self->databasevisualizer->getVisualizerData($params);

    $json = {
        res  => 'OK',
        data => $data
    };

    $self->render( json => $json );
}

sub visualizer_update_window {
    my $self = shift;

    $self->app->log->debug("Lily::visualizer_update_window");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file =
      $self->helperDumperPostData( 'visualizer_update_window', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $res = $self->databasevisualizer->setVisualizerWindow($params);

    my $json;
    if ($res) {
        $json = {
            res  => 'OK',
            desc => "Impostazioni aggiornate correttamente."
        };
    }
    else {
        $json = {
            res  => 'ERROR',
            desc => "Errore durante l\'aggiornamento delle impostazioni."
        };
    }

    $self->render( json => $json );
}

sub visualizer_update_group_pos {
    my $self = shift;

    $self->app->log->debug("Lily::visualizer_update_group_pos");

    my $params = $self->req->body_params->to_hash;

    my $res = $self->databasevisualizer->setVisualizerGroupPosition($params);

    my $json;
    if ($res) {
        $json = {
            res  => 'OK',
            desc => "Impostazioni aggiornate correttamente."
        };
    }
    else {
        $json = {
            res  => 'ERROR',
            desc => "Errore durante l\'aggiornamento delle impostazioni."
        };
    }

    $self->render( json => $json );
}

sub visualizer_update_group_name {
    my $self = shift;
    $self->app->log->debug("Lily::visualizer_update_group_name");

    my $params = $self->req->body_params->to_hash;

    my $res = $self->databasevisualizer->setVisualizerGroupName($params);

    my $json;
    if ($res) {
        $json = {
            res  => 'OK',
            desc => "Impostazioni aggiornate correttamente."
        };
    }
    else {
        $json = {
            res  => 'ERROR',
            desc => "Errore durante l\'aggiornamento delle impostazioni."
        };
    }

    $self->render( json => $json );
}

sub visualizer_update_page_name {
    my $self = shift;
    $self->app->log->debug("Lily::visualizer_update_page_name");

    my $params = $self->req->body_params->to_hash;

    my $res = $self->databasevisualizer->setVisualizerPageName($params);

    my $json;
    if ($res) {
        $json = {
            res  => 'OK',
            desc => "Impostazioni aggiornate correttamente."
        };
    }
    else {
        $json = {
            res  => 'ERROR',
            desc => "Errore durante l\'aggiornamento delle impostazioni."
        };
    }

    $self->render( json => $json );
}

sub visualizer_update_window_name {
    my $self = shift;
    $self->app->log->debug("Lily::visualizer_update_window_name");

    my $params = $self->req->body_params->to_hash;

    my $res = $self->databasevisualizer->setVisualizerWindowName($params);

    my $json;
    if ($res) {
        $json = {
            res  => 'OK',
            desc => "Impostazioni aggiornate correttamente."
        };
    }
    else {
        $json = {
            res  => 'ERROR',
            desc => "Errore durante l\'aggiornamento delle impostazioni."
        };
    }

    $self->render( json => $json );
}

sub visualizer_update_page_pos {
    my $self = shift;

    $self->app->log->debug("Lily::visualizer_update_page_pos");

    my $params = $self->req->body_params->to_hash;

    my $res = $self->databasevisualizer->setVisualizerPagePosition($params);

    my $json;
    if ($res) {
        $json = {
            res  => 'OK',
            desc => "Impostazioni aggiornate correttamente."
        };
    }
    else {
        $json = {
            res  => 'ERROR',
            desc => "Errore durante l\'aggiornamento delle impostazioni."
        };
    }

    $self->render( json => $json );
}

sub visualizer_update_window_pos {
    my $self = shift;

    $self->app->log->debug("Lily::visualizer_update_window_pos");

    my $params = $self->req->body_params->to_hash;

    my $res = $self->databasevisualizer->setVisualizerWindowPosition($params);

    my $json;
    if ($res) {
        $json = {
            res  => 'OK',
            desc => "Impostazioni aggiornate correttamente."
        };
    }
    else {
        $json = {
            res  => 'ERROR',
            desc => "Errore durante l\'aggiornamento delle impostazioni."
        };
    }

    $self->render( json => $json );
}

sub visualizer_settings {
    my $self = shift;

    $self->app->log->debug("Lily::visualizer_settings");

    $self->helperGetHomepageStash('visualizer_settings');

    my $groups = $self->databasevisualizer->getVisualizerGroups(
        $self->config->{'apps'}->{'visualizer'}->{'master_user_id'} );
    $self->stash( groups => $groups );

    $self->render();
}

sub visualizer_update_data_code {
    my $self = shift;

    $self->app->log->debug("Lily::visualizer_update_data_code");

    my $params = $self->req->body_params->to_hash;

    my $res = $self->databasevisualizer->updateVisualizerDataCode($params);

    my $json;
    if ($res) {
        $json = {
            res  => 'OK',
            desc => "Dati modificati."
        };
    }
    else {
        $json = {
            res  => 'ERROR',
            desc => "Errore durante l\'aggiornamento dei dati."
        };
    }

    $self->render( json => $json );
}

1;

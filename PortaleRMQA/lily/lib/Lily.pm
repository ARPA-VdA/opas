package Lily;
use Mojo::Base 'Mojolicious';
use Mojolicious::Sessions;
use Mojolicious::Plugin::Authentication;
use Mojolicious::Plugin::Authorization;

use DBI;
use DBIx::Connector;
use Data::Dumper;

has dbh => sub {
    my $self = shift;

    $self->app->log->info("Database connection ...");

    my $dbh = DBIx::Connector->connect(
        $self->config->{database}->{dsn},
        $self->config->{database}->{username},
        $self->config->{database}->{password},
        $self->config->{database}->{options}
    );
    return $dbh;
};

sub startup {
    my $self = shift;

    $self->app->log->level('info');

    my $config = $self->plugin( Config => { file => 'app.conf' } );
    $self->app->log->level( $self->config->{'loglevel'} );

    $self->app->log->info(
        sprintf( "Log level : %s", $self->config->{'loglevel'} ) );
    $self->app->log->info(
        sprintf( "Application mode : %s", $ENV{'MOJO_MODE'} ) );

    $self->sessions->cookie_name( $self->config->{'cookie_name'} );
    $self->secrets( $self->config->{'secrets'} );
    $self->sessions->default_expiration(2592000);

    $self->plugins->namespaces(
        [ "Lily::Plugin", @{ $self->plugins->namespaces } ] );

    $self->renderer->encoding('utf-8');

    $self->plugin('PODRenderer');

    $self->plugin( 'Lily::Plugin::Helpers', $config );
    $self->plugin('Lily::Plugin::Homepage');
    $self->plugin('Lily::Plugin::RenderFile');

    $self->plugin('database');
    $self->plugin('databaseutils');
    $self->plugin('databasestations');
    $self->plugin('databasereports');
    $self->plugin('databasemanagement');
    $self->plugin('databaselabanalisys');
    $self->plugin('databasevisualizer');
    $self->plugin('databaseinfoaria');
    $self->plugin('databaseapprmqa');
    $self->plugin(
        'Authentication' => {
            'session_key' => 'lily.app.ecometer',
            'load_user'   => sub {
                my $self = shift;
                my $uid  = shift;
                return $uid;

            },
            'validate_user' => sub {
                my $self      = shift;
                my $username  = shift || '';
                my $password  = shift || '';
                my $extradata = shift || {};

                $self->app->log->debug( 'validate_user ' . '*' x 60 );

                my $user =
                  $self->databaseutils->userLogin( $username, $password );
                if ($user) {
                    $self->app->log->debug('user found');
                    return $user;
                }
                $self->app->log->debug('user NOT found');
                return undef;

            },
        }
    );

    $self->plugin(
        'Authorization' => {
            'has_priv' => sub {
                my ( $self, $priv ) = @_;

                $self->app->log->debug( '^' x 60 );

                if ( !$self->session('lily.app.ecometer') ) {
                    $self->app->log->info(
'AUTHORIZATION DENIED : self->session(lilyappecometer) not set'
                    );
                    $self->redirect_to('/') and return 0;
                }
                $self->helperDumper( $self->session() );

                my $user_app = $self->databaseutils->userApp(
                    $self->session('lily.app.ecometer')->{'us_id'} );

                my ($item) = grep { $_->{menu_href} eq $priv } @{$user_app};
                $self->app->log->debug( "Authorization for [$priv] : "
                      . ( $item->{'menu_id'} || 'n.d.' ) );

                if ( !$item->{'menu_id'} ) {
                    $self->app->log->info(
                        'AUTHORIZATION DENIED : item->{menu_id} not set');
                    $self->redirect_to('/') and return 0;
                }

                return 1;
            },
            'is_role'    => sub { return 1 if $_[1] eq 'rolemodel' },
            'user_privs' => sub { return [qw( rolemodel rolemodel )] },
            'user_role'  => sub { return 'rolemodel' },
        }
    );

    my $r = $self->routes;

    if ( $self->config->{maintenance} ) {
        $r->any()->to( controller => 'controller', action => 'maintenance' );
    }

    $r->route('/apprmqa_getinstrument_metadata')
      ->to( controller => 'apprmqa', action => 'getinstrument_metadata' );
    $r->route('/apprmqa_getinstrument_calibrations')
      ->to( controller => 'apprmqa', action => 'getinstrument_calibrations' );
    $r->route('/apprmqa_getinstrument_maintenances')
      ->to( controller => 'apprmqa', action => 'getinstrument_maintenances' );
    $r->route('/apprmqa_getcalibration_detail')
      ->to( controller => 'apprmqa', action => 'getcalibration_detail' );
    $r->route('/apprmqa_getmaintenance_detail')
      ->to( controller => 'apprmqa', action => 'getmaintenance_detail' );

    $r->route('/login_page')
      ->to( controller => 'auth', action => 'login_page' );
    $r->post->route('/login')->to( controller => 'auth', action => 'login' );
    $r->route('/logout')->to( controller => 'auth', action => 'delete' );
    my $auth = $r->under()->to( controller => 'auth', action => 'check' );

    $auth->route('/')->to( controller => 'main', action => 'index' );

    $auth->route('/settings')->over( has_priv => 'settings' )
      ->to( controller => 'main', action => 'settings' );
    $auth->route('/tutorial')->over( has_priv => 'tutorial' )
      ->to( controller => 'main', action => 'tutorial' );

    $auth->route('/task')->over( has_priv => 'task' )
      ->to( controller => 'task', action => 'task' );

    $auth->route('/man_tank_list')->over( has_priv => 'man_tank_list' )
      ->to( controller => 'tank', action => 'man_tank_list' );
    $auth->route('/man_tank_match')->over( has_priv => 'man_tank_match' )
      ->to( controller => 'tank', action => 'man_tank_match' );

    $auth->route('/man_statroam_list')->over( has_priv => 'man_statroam_list' )
      ->to( controller => 'lab', action => 'man_statroam_list' );
    $auth->route('/man_statroam_match')
      ->over( has_priv => 'man_statroam_match' )
      ->to( controller => 'lab', action => 'man_statroam_match' );

    $auth->route('/man_instrument_list')
      ->over( has_priv => 'man_instrument_list' )
      ->to( controller => 'tool', action => 'man_instrument_list' );
    $auth->route('/man_instrument_match')
      ->over( has_priv => 'man_instrument_match' )
      ->to( controller => 'tool', action => 'man_instrument_match' );

    $auth->route('/man_allocation_list')
      ->over( has_priv => 'man_allocation_list' )
      ->to( controller => 'allocation', action => 'man_allocation_list' );
    $auth->route('/man_allocation_match')
      ->over( has_priv => 'man_allocation_match' )
      ->to( controller => 'allocation', action => 'man_allocation_match' );

    $auth->route('/netmedia')->over( has_priv => 'netmedia' )
      ->to( controller => 'netmedia', action => 'netmedia' );

    $auth->route('/report_survey')->over( has_priv => 'report_survey' )
      ->to( controller => 'report', action => 'report_survey' );
    $auth->route('/report_memo')->over( has_priv => 'report_memo' )
      ->to( controller => 'report', action => 'report_memo' );
    $auth->route('/report_calibration')
      ->over( has_priv => 'report_calibration' )
      ->to( controller => 'report', action => 'report_calibration' );
    $auth->route('/report_maintenance')
      ->over( has_priv => 'report_maintenance' )
      ->to( controller => 'report', action => 'report_maintenance' );

    $auth->route('/data_validation')->over( has_priv => 'data_validation' )
      ->to( controller => 'data', action => 'data_validation' );
    $auth->route('/stats_calculation')->over( has_priv => 'stats_calculation' )
      ->to( controller => 'data', action => 'stats_calculation' );
    $auth->route('/stats_description')->over( has_priv => 'stats_description' )
      ->to( controller => 'data', action => 'stats_description' );
    $auth->route('/stats_limits')->over( has_priv => 'stats_limits' )
      ->to( controller => 'data', action => 'stats_limits' );
    $auth->route('/stats_parameter')->over( has_priv => 'stats_parameter' )
      ->to( controller => 'data', action => 'stats_parameter' );

    $auth->route('/station_alarm')->over( has_priv => 'station_alarm' )
      ->to( controller => 'station', action => 'station_alarm' );
    $auth->route('/station_abnormal')->over( has_priv => 'station_abnormal' )
      ->to( controller => 'station', action => 'station_abnormal' );
    $auth->route('/station_download')->over( has_priv => 'station_download' )
      ->to( controller => 'station', action => 'station_download' );
    $auth->route('/station_istantaneous')
      ->over( has_priv => 'station_istantaneous' )
      ->to( controller => 'station', action => 'station_istantaneous' );
    $auth->route('/station_late')->over( has_priv => 'station_late' )
      ->to( controller => 'station', action => 'station_late' );
    $auth->route('/station_metadata')->over( has_priv => 'station_metadata' )
      ->to( controller => 'station', action => 'station_metadata' );
    $auth->route('/station_status')->over( has_priv => 'station_status' )
      ->to( controller => 'station', action => 'station_status' );

    $auth->route('/instrument_control')
      ->over( has_priv => 'instrument_control' )
      ->to( controller => 'instrument', action => 'instrument_control' );
    $auth->route('/instrument_excess')->over( has_priv => 'instrument_excess' )
      ->to( controller => 'instrument', action => 'instrument_excess' );
    $auth->route('/instrument_mapper')->over( has_priv => 'instrument_mapper' )
      ->to( controller => 'instrument', action => 'instrument_mapper' );
    $auth->route('/instrument_techroom')
      ->over( has_priv => 'instrument_techroom' )
      ->to( controller => 'instrument', action => 'instrument_techroom' );
    $auth->route('/instrument_pollutants')
      ->over( has_priv => 'instrument_pollutants' )
      ->to( controller => 'instrument', action => 'instrument_pollutants' );

    $auth->route('/visualizer_app')->over( has_priv => 'visualizer_app' )
      ->to( controller => 'visualizer', action => 'visualizer_app' );
    $auth->route('/visualizer_settings')
      ->over( has_priv => 'visualizer_settings' )
      ->to( controller => 'visualizer', action => 'visualizer_settings' );

    $auth->route('/analyser_app')->over( has_priv => 'analyser_app' )
      ->to( controller => 'analyser', action => 'analyser_app' );
    $auth->route('/analyser_settings')->over( has_priv => 'analyser_settings' )
      ->to( controller => 'analyser', action => 'analyser_settings' );

    $auth->route('/labanalisys_filter')
      ->over( has_priv => 'labanalisys_filter' )
      ->to( controller => 'labanalisys', action => 'labanalisys_filter' );
    $auth->route('/labanalisys_sample')
      ->over( has_priv => 'labanalisys_sample' )
      ->to( controller => 'labanalisys', action => 'labanalisys_sample' );
    $auth->route('/labanalisys_files')->over( has_priv => 'labanalisys_files' )
      ->to( controller => 'labanalisys', action => 'labanalisys_files' );
    $auth->route('/labanalisys_add_data')
      ->over( has_priv => 'labanalisys_sample' )
      ->to( controller => 'labanalisys', action => 'labanalisys_add_data' );
    $auth->route('/labanalisys_white')
      ->over( has_priv => 'labanalisys_sample' )
      ->to( controller => 'labanalisys', action => 'labanalisys_white' );

    $auth->route('/server_hardware')->over( has_priv => 'server_hardware' )
      ->to( controller => 'server', action => 'server_hardware' );
    $auth->route('/server_logical')->over( has_priv => 'server_logical' )
      ->to( controller => 'server', action => 'server_logical' );

    $auth->route('/network')->over( has_priv => 'network' )
      ->to( controller => 'network', action => 'network' );

    $auth->route('/calendar')->over( has_priv => 'network' )
      ->to( controller => 'calendar', action => 'calendar' );

    $auth->route('/file_manager')
      ->to( controller => 'filemanager', action => 'file_manager' );

    $auth->route('/settings_homepage')->via('POST')
      ->to( controller => 'main', action => 'settings_homepage' );
    $auth->route('/settings_homepage_reset')->via('POST')
      ->to( controller => 'main', action => 'settings_homepage_reset' );
    $auth->route('/settings_psw')->via('POST')
      ->to( controller => 'main', action => 'settings_psw' );

    $auth->route('/task_new')->via('POST')
      ->to( controller => 'task', action => 'task_new' );
    $auth->route('/task_set_done')->via('POST')
      ->to( controller => 'task', action => 'task_set_done' );

    $auth->route('/man_tank_csv')->via('POST')
      ->to( controller => 'tank', action => 'man_tank_csv' );
    $auth->route('/man_tank_new')->via('POST')
      ->to( controller => 'tank', action => 'man_tank_new' );
    $auth->route('/man_tank_edit')->via('POST')
      ->to( controller => 'tank', action => 'man_tank_edit' );
    $auth->route('/man_tank_match_new')->via('POST')
      ->to( controller => 'tank', action => 'man_tank_match_new' );
    $auth->route('/man_tank_match_edit')->via('POST')
      ->to( controller => 'tank', action => 'man_tank_match_edit' );
    $auth->route('/tank_list_get_report')->via('POST')
      ->to( controller => 'tank', action => 'tank_list_get_report' );
    $auth->route('/tank_match_get_report')->via('POST')
      ->to( controller => 'tank', action => 'tank_match_get_report' );
    $auth->route('/man_tank_delete')->via('POST')
      ->to( controller => 'tank', action => 'man_tank_delete' );
    $auth->route('/man_tank_match_delete')->via('POST')
      ->to( controller => 'tank', action => 'man_tank_match_delete' );
    $auth->route('/man_tank_arpa_id')->via('POST')
      ->to( controller => 'tank', action => 'man_tank_arpa_id' );

    $auth->route('/man_instrument_new')->via('POST')
      ->to( controller => 'tool', action => 'man_instrument_new' );
    $auth->route('/man_instrument_edit')->via('POST')
      ->to( controller => 'tool', action => 'man_instrument_edit' );
    $auth->route('/man_instrument_delete')->via('POST')
      ->to( controller => 'tool', action => 'man_instrument_delete' );
    $auth->route('/man_instrument_arpa_id')->via('POST')
      ->to( controller => 'tool', action => 'man_instrument_arpa_id' );
    $auth->route('/man_instrument_get')->via('POST')
      ->to( controller => 'tool', action => 'man_instrument_get' );
    $auth->route('/man_instrument_match_new')->via('POST')
      ->to( controller => 'tool', action => 'man_instrument_match_new' );
    $auth->route('/man_instrument_match_edit')->via('POST')
      ->to( controller => 'tool', action => 'man_instrument_match_edit' );
    $auth->route('/man_instrument_match_delete')->via('POST')
      ->to( controller => 'tool', action => 'man_instrument_match_delete' );
    $auth->route('/man_instrument_get_match')->via('POST')
      ->to( controller => 'tool', action => 'man_instrument_get_match' );

    $auth->route('/man_statroam_edit')->via('POST')
      ->to( controller => 'lab', action => 'man_statroam_edit' );
    $auth->route('/man_statroam_get')->via('POST')
      ->to( controller => 'lab', action => 'man_statroam_get' );
    $auth->route('/man_statroam_match_new')->via('POST')
      ->to( controller => 'lab', action => 'man_statroam_match_new' );
    $auth->route('/man_statroam_match_edit')->via('POST')
      ->to( controller => 'lab', action => 'man_statroam_match_edit' );
    $auth->route('/man_statroam_match_delete')->via('POST')
      ->to( controller => 'lab', action => 'man_statroam_match_delete' );
    $auth->route('/man_statroam_get_match')->via('POST')
      ->to( controller => 'lab', action => 'man_statroam_get_match' );

    $auth->route('/man_allocation_get_equipment')->via('POST')->to(
        controller => 'allocation',
        action     => 'man_allocation_get_equipment'
    );
    $auth->route('/man_allocation_arpa_id')->via('POST')
      ->to( controller => 'allocation', action => 'man_allocation_arpa_id' );
    $auth->route('/man_allocation_new_equipment')->via('POST')->to(
        controller => 'allocation',
        action     => 'man_allocation_new_equipment'
    );
    $auth->route('/man_allocation_edit_equipment')->via('POST')->to(
        controller => 'allocation',
        action     => 'man_allocation_edit_equipment'
    );
    $auth->route('/man_allocation_delete_equipment')->via('POST')->to(
        controller => 'allocation',
        action     => 'man_allocation_delete_equipment'
    );
    $auth->route('/man_allocation_csv')->via('POST')
      ->to( controller => 'allocation', action => 'man_allocation_csv' );

    $auth->route('/man_allocation_get_match')->via('POST')
      ->to( controller => 'allocation', action => 'man_allocation_get_match' );
    $auth->route('/man_allocation_match_new')->via('POST')
      ->to( controller => 'allocation', action => 'man_allocation_match_new' );
    $auth->route('/man_allocation_match_edit')->via('POST')
      ->to( controller => 'allocation', action => 'man_allocation_match_edit' );
    $auth->route('/man_allocation_match_delete')->via('POST')->to(
        controller => 'allocation',
        action     => 'man_allocation_match_delete'
    );
    $auth->route('/man_allocation_match_csv')->via('POST')
      ->to( controller => 'allocation', action => 'man_allocation_match_csv' );

    $auth->route('/station_istantaneous_get_camp')->via('POST')->to(
        controller => 'station',
        action     => 'station_istantaneous_get_camp'
    );
    $auth->route('/station_istantaneous_get_lognet')->via('POST')->to(
        controller => 'station',
        action     => 'station_istantaneous_get_lognet'
    );
    $auth->route('/metadata_get_station')->via('POST')
      ->to( controller => 'station', action => 'metadata_get_station' );
    $auth->route('/ping_station')->via('POST')
      ->to( controller => 'station', action => 'ping_station' );

    $auth->route('/visualizer_pages')->via('POST')
      ->to( controller => 'visualizer', action => 'visualizer_pages' );
    $auth->route('/visualizer_windows')->via('POST')
      ->to( controller => 'visualizer', action => 'visualizer_windows' );
    $auth->route('/visualizer_window')->via('POST')
      ->to( controller => 'visualizer', action => 'visualizer_window' );
    $auth->route('/visualizer_map_stations')->via('POST')
      ->to( controller => 'visualizer', action => 'visualizer_map_stations' );
    $auth->route('/visualizer_data')->via('POST')
      ->to( controller => 'visualizer', action => 'visualizer_data' );
    $auth->route('/visualizer_update_window')->via('POST')
      ->to( controller => 'visualizer', action => 'visualizer_update_window' );
    $auth->route('/visualizer_update_group_pos')->via('POST')->to(
        controller => 'visualizer',
        action     => 'visualizer_update_group_pos'
    );
    $auth->route('/visualizer_update_group_name')->via('POST')->to(
        controller => 'visualizer',
        action     => 'visualizer_update_group_name'
    );
    $auth->route('/visualizer_update_page_pos')->via('POST')->to(
        controller => 'visualizer',
        action     => 'visualizer_update_page_pos'
    );
    $auth->route('/visualizer_update_page_name')->via('POST')->to(
        controller => 'visualizer',
        action     => 'visualizer_update_page_name'
    );
    $auth->route('/visualizer_update_window_pos')->via('POST')->to(
        controller => 'visualizer',
        action     => 'visualizer_update_window_pos'
    );
    $auth->route('/visualizer_update_window_name')->via('POST')->to(
        controller => 'visualizer',
        action     => 'visualizer_update_window_name'
    );
    $auth->route('/visualizer_update_data_code')->via('POST')->to(
        controller => 'visualizer',
        action     => 'visualizer_update_data_code'
    );

    $auth->route('/report_survey_new_next_id')->via('POST')
      ->to( controller => 'report', action => 'report_survey_new_next_id' );
    $auth->route('/report_survey_new')->via('POST')
      ->to( controller => 'report', action => 'report_survey_new' );
    $auth->route('/report_survey_new_upload_file')->via('POST')
      ->to( controller => 'report', action => 'report_survey_new_upload_file' );
    $auth->route('/report_survey_new_delete_file')->via('POST')
      ->to( controller => 'report', action => 'report_survey_new_delete_file' );
    $auth->route('/report_survey_delete')->via('POST')
      ->to( controller => 'report', action => 'report_survey_delete' );
    $auth->route('/report_survey_get_report')->via('POST')
      ->to( controller => 'report', action => 'report_survey_get_report' );
    $auth->route('/report_survey_edit')->via('POST')
      ->to( controller => 'report', action => 'report_survey_edit' );
    $auth->route('/report_survey_csv')->via('POST')
      ->to( controller => 'report', action => 'report_survey_csv' );
    $auth->route('/report_survey_pdf')->via('POST')
      ->to( controller => 'report', action => 'report_survey_pdf' );

    $auth->route('/report_calibration_data')->via('POST')
      ->to( controller => 'report', action => 'calibration_data' );
    $auth->route('/report_calibration_instrument')->via('POST')
      ->to( controller => 'report', action => 'calibration_instrument' );
    $auth->route('/report_calibration_new')->via('POST')
      ->to( controller => 'report', action => 'report_calibration_new' );
    $auth->route('/report_calibration_edit')->via('POST')
      ->to( controller => 'report', action => 'report_calibration_edit' );
    $auth->route('/report_calibration_delete')->via('POST')
      ->to( controller => 'report', action => 'report_calibration_delete' );
    $auth->route('/report_calibration_get_report')->via('POST')
      ->to( controller => 'report', action => 'report_calibration_get_report' );
    $auth->route('/report_calibration_csv')->via('POST')
      ->to( controller => 'report', action => 'report_calibration_csv' );
    $auth->route('/report_calibration_pdf')->via('POST')
      ->to( controller => 'report', action => 'report_calibration_pdf' );

    $auth->route('/report_maintenance_data')->via('POST')
      ->to( controller => 'report', action => 'maintenance_data' );
    $auth->route('/report_maintenance_instrument')->via('POST')
      ->to( controller => 'report', action => 'maintenance_instrument' );
    $auth->route('/report_maintenance_instrument_operations')->via('POST')->to(
        controller => 'report',
        action     => 'maintenance_instrument_operations'
    );
    $auth->route('/report_maintenance_instrument_spareparts')->via('POST')->to(
        controller => 'report',
        action     => 'maintenance_instrument_spareparts'
    );
    $auth->route('/report_maintenance_delete')->via('POST')
      ->to( controller => 'report', action => 'report_maintenance_delete' );
    $auth->route('/report_maintenance_get_report')->via('POST')
      ->to( controller => 'report', action => 'report_maintenance_get_report' );
    $auth->route('/report_maintenance_calibrations_latest')->via('POST')->to(
        controller => 'report',
        action     => 'maintenance_calibrations_latest'
    );
    $auth->route('/report_maintenance_new')->via('POST')
      ->to( controller => 'report', action => 'report_maintenance_new' );
    $auth->route('/report_maintenance_edit')->via('POST')
      ->to( controller => 'report', action => 'report_maintenance_edit' );
    $auth->route('/report_maintenance_csv')->via('POST')
      ->to( controller => 'report', action => 'report_maintenance_csv' );
    $auth->route('/report_maintenance_pdf')->via('POST')
      ->to( controller => 'report', action => 'report_maintenance_pdf' );

    $auth->route('/report_memo_new')->via('POST')
      ->to( controller => 'report', action => 'report_memo_new' );
    $auth->route('/report_memo_edit')->via('POST')
      ->to( controller => 'report', action => 'report_memo_edit' );
    $auth->route('/report_memo_delete')->via('POST')
      ->to( controller => 'report', action => 'report_memo_delete' );
    $auth->route('/report_memo_get_report')->via('POST')
      ->to( controller => 'report', action => 'report_memo_get_report' );
    $auth->route('/report_memo_pdf')->via('POST')
      ->to( controller => 'report', action => 'report_memo_pdf' );

    $auth->route('/sample_new')->via('POST')
      ->to( controller => 'labanalisys', action => 'sample_new' );
    $auth->route('/sample_get')->via('POST')
      ->to( controller => 'labanalisys', action => 'sample_get' );
    $auth->route('/sample_edit')->via('POST')
      ->to( controller => 'labanalisys', action => 'sample_edit' );
    $auth->route('/sample_delete')->via('POST')
      ->to( controller => 'labanalisys', action => 'sample_delete' );
    $auth->route('/sample_locked')->via('POST')
      ->to( controller => 'labanalisys', action => 'sample_locked' );
    $auth->route('/sample_unlocked')->via('POST')
      ->to( controller => 'labanalisys', action => 'sample_unlocked' );
    $auth->route('/filter_empty')->via('POST')
      ->to( controller => 'labanalisys', action => 'filter_empty' );
    $auth->route('/filter_data')->via('POST')
      ->to( controller => 'labanalisys', action => 'filter_data' );
    $auth->route('/labanalisys_sample_id')->via('POST')
      ->to( controller => 'labanalisys', action => 'labanalisys_sample_id' );
    $auth->route('/labanalisys_file')->via('POST')
      ->to( controller => 'labanalisys', action => 'labanalisys_file' );
    $auth->route('/labanalisys_white_chart_data')->via('POST')
      ->to( controller => 'labanalisys', action => 'white_chart_data' );

    $auth->route('/ia_home')->over( has_priv => 'ia_home' )
      ->to( controller => 'infoaria', action => 'ia_home' );

    $auth->route('/views_authority')->over( has_priv => 'views_authority' )
      ->to( controller => 'infoaria', action => 'views_authority' );
    $auth->route('/views_networks')->over( has_priv => 'views_networks' )
      ->to( controller => 'infoaria', action => 'views_networks' );
    $auth->route('/views_stations')->over( has_priv => 'views_stations' )
      ->to( controller => 'infoaria', action => 'views_stations' );
    $auth->route('/views_samples')->over( has_priv => 'views_samples' )
      ->to( controller => 'infoaria', action => 'views_samples' );

    $auth->websocket('/websocket')
      ->to( controller => 'main', action => 'websocket' );
}
1;

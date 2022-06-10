package Lily::Task;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub task {
    my $self = shift;

    $self->app->log->debug("Lily::Task sub task");

    $self->helperGetHomepageStash('task');

    my $params = $self->req->body_params->to_hash;
    $self->helperDumper($params);
    my $count    = $params->{count}    || 10;
    my $assignee = $params->{assignee} || 'All';
    my $done     = $params->{done}     || 'All';

    $self->stash(
        count    => $count,
        assignee => $assignee,
        done     => $done
    );

    my $stations = $self->databaseutils->getStations();
    $self->stash( stations => $stations );

    my $report_tasks = $self->databaseutils->getTasks($params);
    $self->stash( report_tasks => $report_tasks );

    $self->render();
}

sub task_new {
    my $self = shift;

    $self->app->log->debug("Lily::Task sub task_new");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'task_new', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $usid = $self->session('lily.app.ecometer')->{'us_id'};

    my $res = $self->databaseutils->insertTask( $usid, $params );
    my $json;
    if ($res) {
        $json = {
            res  => 'OK',
            desc => "Task inserito correttamente."
        };
    }
    else {
        $json = {
            res  => 'ERROR',
            desc => "Errore durante l\'inserimento del task."
        };
    }

    $self->render( json => $json );
}

sub task_set_done {
    my $self = shift;

    $self->app->log->debug("Lily::Task sub task_set_done");

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'task_set_done', $params );
    $self->app->log->debug( "Dump post data: " . $self->helperDumper($params) );

    my $usid = $self->session('lily.app.ecometer')->{'us_id'};

    my $res = $self->databaseutils->setTaskDone( $usid, $params );
    my $json;
    if ($res) {
        $json = {
            res  => 'OK',
            desc => "Task aggiornato correttamente."
        };
    }
    else {
        $json = {
            res  => 'ERROR',
            desc => "Errore durante l\'aggiornamento del task."
        };
    }

    $self->render( json => $json );
}

1;

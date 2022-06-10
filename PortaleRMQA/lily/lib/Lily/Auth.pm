package Lily::Auth;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub login_page {
    my $c = shift;
    $c->render( template => 'auth/login' );
}

sub check {
    my $self = shift;

    $self->app->log->debug("Lily::Auth sub check");

    $self->redirect_to('/login_page') and return 0
      unless ( $self->is_user_authenticated );
    $self->app->log->debug("user is authenticated");
    return 1;
}

sub login {
    my $self = shift;

    $self->app->log->debug("Lily::Auth sub login");

    my $u = $self->req->body_params->param('login_name');
    my $p = $self->req->body_params->param('login_password');
    my $r = 1;

    my $params = $self->req->body_params->to_hash;
    $self->app->log->debug("Store post data");
    my $file = $self->helperDumperPostData( 'Lily-Auth-login', $params );
    $self->app->log->debug("Dump post data:");
    $self->helperDumper($params);

    my $authenticate = $self->authenticate( $u, $p );

    if ($r) {
        $self->app->log->debug("User has set long expiration");
        $self->session( expiration => 25920000 );
    }

    unless ($authenticate) {
        $self->flash( login_error => "Errore: utente e/o password errati." );
        $self->redirect_to('/');
        return 0;
    }

    $self->helperAuthenticationLogs( 1, $self->session('lily.app.ecometer') );

    $self->redirect_to('/') and return 1;
}

sub delete {
    my $self = shift;

    $self->app->log->debug("Lily::Auth sub delete");

    $self->helperAuthenticationLogs( 0, $self->session('lily.app.ecometer') );

    $self->logout();

    $self->redirect_to('/');
    return 1;
}

1;

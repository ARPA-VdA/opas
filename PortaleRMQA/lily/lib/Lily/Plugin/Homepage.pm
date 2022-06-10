package Lily::Plugin::Homepage;
use Mojo::Base 'Mojolicious::Plugin';

use Data::Dumper;

sub register {
    my ( $self, $app ) = @_;

    $app->log->debug('Ibex::Plugin::Homepage :: register()');

    $app->helper(
        helperGetHomepageStash => sub {
            my $self    = shift;
            my $appname = shift;

            $app->log->debug(
                'Ibex::Plugin::Homepage :: helperGetHomepageStash()');

            $self->stash( user => $self->session('lily.app.ecometer') );

            my $user_menu = $self->helperGetNavListStructure();

            my $navlist = $self->helperGetNavListHtml( $user_menu, $appname );
            $self->stash( navlist => $navlist );

            my $item = $self->helperGetNavListItem( $user_menu, $appname );
            $self->stash( pagetitle => $item->{'menu_name'} );

            my $breadcrumb =
              $self->helperGetNavListBreadcrumb( $user_menu, $appname );
            $self->stash( breadcrumb => $breadcrumb );

            my $item_tutorial =
              $self->helperCheckItemExist( $user_menu, 'tutorial' );
            $self->stash( item_tutorial => $item_tutorial );

            my $homepage_counters = $self->databaseutils->getHomepageCounters(
                $self->session('lily.app.ecometer') );
            $self->stash( homepage_counters => $homepage_counters );

            my $grants = $self->databaseutils->menuItemGrants(
                $self->session('lily.app.ecometer')->{'us_id'},
                $item->{'menu_id'} );
            $self->stash( grants => $grants );

            my $settings = $self->databaseutils->userSettings(
                $self->session('lily.app.ecometer')->{'us_id'} );
            my $settings_homepage_str = $settings->{'settings_homepage'};
            $settings_homepage_str =~ s/([\$\@\%])/\\$1/g;
            my $settings_homepage = eval "{$settings_homepage_str}";
            $self->stash(
                settings          => $settings,
                settings_homepage => $settings_homepage
            );
            $app->log->debug('Ibex::Plugin::Homepage :: settings_homepage()');

            return $settings_homepage;
        }
    );
}

1;

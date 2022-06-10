package Lily::Plugin::Helpers;
use Mojo::Base 'Mojolicious::Plugin';

use strict;
use warnings;
use Date::Calc
  qw(Now Today Today_and_Now Day_of_Year Add_Delta_DHMS Delta_Days Delta_DHMS Add_Delta_Days This_Year);
use feature qw{ switch };
use Data::Dumper;
use File::Temp ();
use File::Path qw(make_path);
use GD::Thumbnail;
use Archive::Zip qw( :ERROR_CODES :CONSTANTS );

our $mail_bulletin_critic_conf = {
    mail_from        => '',
    smtp_user        => '',
    smtp_pass        => 'funzionale',
    mail_from_header => 'Centro funzionale regionale VdA',
};

sub register {
    my ( $self, $app, $config ) = @_;

    $app->log->debug('Ibex::Plugin::Helpers :: register()');

    $app->helper(
        helperDbVersion => sub {
            my $self = shift;

            my $sql = "SHOW server_version_num";
            return $self->app->database->database_query_value($sql);
        }
    );

    $app->helper(
        helperDumper => sub {
            my $self = shift;
            my $var  = shift;
            local $Data::Dumper::Terse    = 1;
            local $Data::Dumper::Useqq    = 1;
            local $Data::Dumper::Sortkeys = 1;
            $self->app->log->debug( Dumper($var) );
        }
    );

    $app->helper(
        helperGetFileVersion => sub {
            my $self = shift;
            my $file = shift;

            my $path = $self->app->home->rel_file( 'public/' . $file );
            my $epoch_timestamp = ( stat($path) )[9];
            unless ($epoch_timestamp) {
                $app->log->debug( 'helperGetFileVersion: ' . $path );
            }
            return $file . "?v=" . ( $epoch_timestamp || '' );
        }
    );

    $app->helper(
        helperGetFullDate => sub {
            my $self = shift;
            my ( $year, $month, $day, $hour, $min, $sec ) = Today_and_Now();
            $month = sprintf "%02d", $month;
            $day   = sprintf "%02d", $day;
            $hour  = sprintf "%02d", $hour;
            $min   = sprintf "%02d", $min;
            $sec   = sprintf "%02d", $sec;
            return "$year-$month-$day $hour:$min:$sec";
        }
    );

    $app->helper(
        helperGetTime => sub {
            my $self = shift;
            my ( $hour, $min, $sec ) = Now();
            $hour = sprintf "%02d", $hour;
            $min  = sprintf "%02d", $min;
            $sec  = sprintf "%02d", $sec;
            return "$hour:$min:$sec";
        }
    );

    $app->helper(
        helperGetFullDateUnderscore => sub {
            my $self = shift;
            my ( $year, $month, $day, $hour, $min, $sec ) = Today_and_Now();
            $month = sprintf "%02d", $month;
            $day   = sprintf "%02d", $day;
            $hour  = sprintf "%02d", $hour;
            $min   = sprintf "%02d", $min;
            $sec   = sprintf "%02d", $sec;
            return
                $year . ""
              . $month . ""
              . $day . "_"
              . $hour . ""
              . $min . ""
              . $sec;
        }
    );

    $app->helper(
        helperGetGmtDateTime => sub {
            my $self   = shift;
            my $format = shift;
            my ( $year, $month, $day, $hour, $min, $sec ) = Today_and_Now(1);
            $month = sprintf "%02d", $month;
            $day   = sprintf "%02d", $day;
            $hour  = sprintf "%02d", $hour;
            $min   = sprintf "%02d", $min;
            $sec   = sprintf "%02d", $sec;
            my $date;

            if ( $format == 0 ) {
                $date = "$year-$month-$day $hour:00:00";
            }
            elsif ( $format == 1 ) {
                $date = "$year-$month-$day $hour:59:59";
            }
            elsif ( $format == 2 ) {
                $date = "$year-$month-$day 23:59:59";
            }
            return $date;
        }
    );
    $app->helper(
        helperGetDateTime => sub {
            my $self   = shift;
            my $format = shift;
            my ( $year, $month, $day, $hour, $min, $sec ) = Today_and_Now();
            $month = sprintf "%02d", $month;
            $day   = sprintf "%02d", $day;
            $hour  = sprintf "%02d", $hour;
            $min   = sprintf "%02d", $min;
            $sec   = sprintf "%02d", $sec;
            my $date;

            if ( $format == 0 ) {
                $date = "$year-$month-$day $hour:00:00";
            }
            elsif ( $format == 1 ) {
                $date = "$year-$month-$day $hour:59:59";
            }
            elsif ( $format == 2 ) {
                $date = "$year-$month-$day 23:59:59";
            }
            return $date;
        }
    );

    $app->helper(
        helperGetDateNoTime => sub {
            my $self = shift;
            my ( $year, $month, $day, $hour, $min, $sec ) = Today_and_Now();
            $month = sprintf "%02d", $month;
            $day   = sprintf "%02d", $day;
            return "$year-$month-$day";
        }
    );

    $app->helper(
        helperGetYear => sub {
            my $self = shift;
            return This_Year();
        }
    );

    $app->helper(
        helperGetGmtDate => sub {
            my $self = shift;
            my ( $year, $month, $day, $hour, $min, $sec ) = Today_and_Now(1);
            $month = sprintf "%02d", $month;
            $day   = sprintf "%02d", $day;
            return "$year-$month-$day 00:00:00";
        }
    );
    $app->helper(
        helperGetDate => sub {
            my $self = shift;
            my ( $year, $month, $day, $hour, $min, $sec ) = Today_and_Now();
            $month = sprintf "%02d", $month;
            $day   = sprintf "%02d", $day;
            return "$year-$month-$day 00:00:00";
        }
    );

    $app->helper(
        helperDateFormat => sub {
            my $self     = shift;
            my $datetime = shift;
            my ( $year, $month, $day, $hour, $min, $sec );
            $datetime =~ m/^(\d+)-(\d+)-(\d+)\s(\d+):(\d+):(\d+)/;
            $year  = $1;
            $month = $2;
            $day   = $3;
            return "$year-$month-$day 00:00:00";
        }
    );

    $app->helper(
        helperDateTimeFormat => sub {
            my $self     = shift;
            my $datetime = shift;
            my ( $year, $month, $day, $hour, $min, $sec );
            $datetime =~ m/^(\d+)-(\d+)-(\d+)\s(\d+):(\d+):(\d+)/;
            $year  = $1;
            $month = $2;
            $day   = $3;
            $hour  = $4;
            return "$year-$month-$day $hour:00:00";
        }
    );

    $app->helper(
        helperTruncateDate => sub {
            my $self     = shift;
            my $datetime = shift;
            my ( $year, $month, $day, $hour, $min, $sec );
            $datetime =~ m/^(\d+)-(\d+)-(\d+)\s\d+:\d+:\d+/;
            $year  = $1;
            $month = $2;
            $day   = $3;
            return "$year-$month-$day";
        }
    );

    $app->helper(
        helperDateAddMinute => sub {
            my $self    = shift;
            my $time    = shift;
            my $minutes = shift;
            my ( $year, $month, $day, $hour, $min, $sec );
            $time =~ m/^(\d+)-(\d+)-(\d+)\s(\d+):(\d+):(\d+)/;
            $year  = $1;
            $month = $2;
            $day   = $3;
            $hour  = $4;
            $min   = $5;
            $sec   = $6;
            ( $year, $month, $day, $hour, $min, $sec ) =
              Add_Delta_DHMS( $year, $month, $day, $hour, $min, $sec, 0, 0,
                $minutes, 0 );
            $month = sprintf "%02d", $month;
            $day   = sprintf "%02d", $day;
            $hour  = sprintf "%02d", $hour;
            $min   = sprintf "%02d", $min;
            $sec   = sprintf "%02d", $sec;
            return "$year-$month-$day $hour:$min:$sec";
        }
    );

    $app->helper(
        helperDateAddHour => sub {
            my $self  = shift;
            my $time  = shift;
            my $hours = shift;
            my ( $year, $month, $day, $hour, $min, $sec );
            $time =~ m/^(\d+)-(\d+)-(\d+)\s(\d+):(\d+):(\d+)/;
            $year  = $1;
            $month = $2;
            $day   = $3;
            $hour  = $4;
            $min   = $5;
            $sec   = $6;
            ( $year, $month, $day, $hour, $min, $sec ) =
              Add_Delta_DHMS( $year, $month, $day, $hour, $min, $sec, 0,
                $hours, 0, 0 );
            $month = sprintf "%02d", $month;
            $day   = sprintf "%02d", $day;
            $hour  = sprintf "%02d", $hour;
            $min   = sprintf "%02d", $min;
            $sec   = sprintf "%02d", $sec;
            return "$year-$month-$day $hour:$min:$sec";
        }
    );

    $app->helper(
        helperDateAddDay => sub {
            my $self = shift;
            my $time = shift;
            my $days = shift;
            my ( $year, $month, $day, $hour, $min, $sec );
            $time =~ m/^(\d+)-(\d+)-(\d+)\s(\d+):(\d+):(\d+)/;
            $year  = $1;
            $month = $2;
            $day   = $3;
            $hour  = $4;
            $min   = $5;
            $sec   = $6;
            ( $year, $month, $day, $hour, $min, $sec ) =
              Add_Delta_DHMS( $year, $month, $day, $hour, $min, $sec, $days, 0,
                0, 0 );
            $month = sprintf "%02d", $month;
            $day   = sprintf "%02d", $day;
            $hour  = sprintf "%02d", $hour;
            $min   = sprintf "%02d", $min;
            $sec   = sprintf "%02d", $sec;
            return "$year-$month-$day $hour:$min:$sec";
        }
    );

    $app->helper(
        helperDateNoTimeAddDay => sub {
            my $self = shift;
            my $date = shift;
            my $days = shift;
            my ( $year, $month, $day );
            $date =~ m/^(\d+)-(\d+)-(\d+)/;
            $year  = $1;
            $month = $2;
            $day   = $3;
            ( $year, $month, $day ) =
              Add_Delta_Days( $year, $month, $day, $days );
            $month = sprintf "%02d", $month;
            $day   = sprintf "%02d", $day;
            return "$year-$month-$day";
        }
    );

    $app->helper(
        helperDateDeltaHours => sub {
            my $self  = shift;
            my $date1 = shift;
            my $date2 = shift;
            my ( $year1, $month1, $day1, $hour1, $min1, $sec1 );
            $date1 =~ m/^(\d+)-(\d+)-(\d+)\s(\d+):(\d+):(\d+)/;
            $year1  = $1;
            $month1 = $2;
            $day1   = $3;
            $hour1  = $4;
            $min1   = $5;
            $sec1   = $6;
            my ( $year2, $month2, $day2, $hour2, $min2, $sec2 );
            $date2 =~ m/^(\d+)-(\d+)-(\d+)\s(\d+):(\d+):(\d+)/;
            $year2  = $1;
            $month2 = $2;
            $day2   = $3;
            $hour2  = $4;
            $min2   = $5;
            $sec2   = $6;
            my ( $Dd, $Dh, $Dm, $Ds ) = Delta_DHMS(
                $year1, $month1, $day1, $hour1, $min1, $sec1,
                $year2, $month2, $day2, $hour2, $min2, $sec2
            );
            return $Dd * 24 + $Dh;
        }
    );

    $app->helper(
        helperDateDeltaDays => sub {
            my $self  = shift;
            my $date1 = shift;
            my $date2 = shift;
            my ( $year1, $month1, $day1 );
            $date1 =~ m/^(\d+)-(\d+)-(\d+)/;
            $year1  = $1;
            $month1 = $2;
            $day1   = $3;
            my ( $year2, $month2, $day2 );
            $date2 =~ m/^(\d+)-(\d+)-(\d+)/;
            $year2  = $1;
            $month2 = $2;
            $day2   = $3;
            my $Dd =
              Delta_Days( $year1, $month1, $day1, $year2, $month2, $day2 );
            return $Dd;
        }
    );

    $app->helper(
        helperGetDateLastSeasonStart => sub {
            my $self = shift;
            my ( $year, $month, $day ) = Today();
            if ( $month >= 10 ) {
                $year = $year;
            }
            else {
                $year = $year - 1;
            }
            $day   = 1;
            $month = 9;

            $month = sprintf "%02d", $month;
            $day   = sprintf "%02d", $day;
            return "$year-$month-$day 00:00:00";
        }
    );

    $app->helper(
        helperGetBulletinId => sub {
            my $self = shift;
            my ( $year, $month, $day ) = Today();
            my $doy = Day_of_Year( $year, $month, $day );
            return ( 1000 * $year ) + $doy;
        }
    );

    $app->helper(
        helperGetBulletinIdNotPadded => sub {
            my $self = shift;
            my ( $year, $month, $day ) = Today();
            my $doy = Day_of_Year( $year, $month, $day );
            return $doy;
        }
    );

    $app->helper(
        helperGetBulletinIdYesterday => sub {
            my $self = shift;
            my ( $year, $month, $day ) = Today();
            ( $year, $month, $day ) = Add_Delta_Days( $year, $month, $day, -1 );
            my $doy = Day_of_Year( $year, $month, $day );
            return ( 1000 * $year ) + $doy;
        }
    );

    $app->helper(
        helperDumperPostData => sub {
            my $self   = shift;
            my $header = shift;
            my $params = shift;
            $self->app->log->debug("helperDumperPostData");

            my ( $year, $month, $day, $hour, $min, $sec ) = Today_and_Now(1);
            $month = sprintf "%02d", $month;
            $day   = sprintf "%02d", $day;
            $hour  = sprintf "%02d", $hour;
            $min   = sprintf "%02d", $min;
            $sec   = sprintf "%02d", $sec;
            my $head_time = "{$year-$month-$day-$hour-$min-$sec}";

            my $path = $self->app->home->rel_file('public/uploads/post_dumps');
            my $file = File::Temp->new(
                TEMPLATE => $header . '.' . $head_time . '.XXXXXXXXXX',
                UNLINK   => 0,
                DIR      => $path,
                SUFFIX   => '.dat'
            );

            $self->app->log->debug("file : $file");

            open my $fh, '>', $file
              or $self->app->log->warn("Can't write '$file': $!");
            local $Data::Dumper::Terse    = 1;
            local $Data::Dumper::Useqq    = 1;
            local $Data::Dumper::Sortkeys = 1;
            print $fh Dumper $params;
            close $fh or $self->app->log->warn("Can't close '$file': $!");

            if ( $^O eq 'linux' ) {
                $self->app->log->debug(
                    "helperDumperPostData - chmod 0744 : $file");
                chmod 0744, $file or die "Couldn't chmod $file: $!";
            }

            return $file;
        }
    );

    $app->helper(
        helperCreatePath => sub {
            my $self = shift;
            my $dir  = shift;

            $self->app->log->debug("helperCreatePath - dir: $dir");

            $dir =~ s/ /\\ /g;
            unless ( -e $dir ) {
                my $dir_test = make_path($dir);
                if ($dir_test) {
                    if ( $^O eq 'linux' ) {
                        $self->app->log->debug(
                            "helperCreatePath - chmod 0755 : $dir");
                        chmod 0755, $dir or die "Couldn't chmod $dir: $!";
                    }
                    return 1;
                }
                else {
                    return 0;
                }
            }
            return 1;
        }
    );

    $app->helper(
        helperImageCreateThumbanail => sub {
            my $self      = shift;
            my $image     = shift;
            my $image_dir = shift;

            $self->app->log->debug(
                "helperImageCreateThumbanail - image: $image");

            my $source    = $image_dir . '/' . $image;
            my $thumbnail = $image_dir . '/thumb_' . $image;

            my $thumb = GD::Thumbnail->new( square => 1, );
            my $raw   = $thumb->create( $source, 200, 0 );
            open IMG, ">$thumbnail" or die "Error: $!";
            binmode IMG;
            print IMG $raw;
            close IMG;
            return 1;
        }
    );

    $app->helper(
        helperFileUploadGetFileId => sub {
            my ( $sec, $min, $hour, $mday, $month, $year ) = localtime;
            $month = $month + 1;
            $year  = $year + 1900;
            my $rand_num = int( rand 100000 );
            return sprintf( "file-%04s%02s%02s%02s%02s%02s-%05s",
                $year, $month, $mday, $hour, $min, $sec, $rand_num );
        }
    );

    $app->helper(
        helperSendEmail => sub {
            my $self       = shift;
            my $recipients = shift;
            my $subject    = shift;
            my $body       = shift;

            $self->app->log->debug("helperSendEmail");

            my @recipients_list;
            foreach my $recipient (@$recipients) {
                $self->app->log->debug("Sending Mail to : $recipient");
                push( @recipients_list, $recipient );
            }

            my $sql =
"INSERT INTO tool_mail.mails(app, recipients, subject, body) VALUES (?,?,?,?)";

            my $sth = $self->app->dbh->prepare($sql);
            return $sth->execute( $config->{'title'},
                join( ";", @recipients_list ),
                $subject, $body );
        }
    );

    $app->helper(
        helperAuthenticationLogs => sub {
            my $self    = shift;
            my $login   = shift;
            my $session = shift;

            $self->app->log->debug("helperAuthenticationLogs");

            my $action = ( $login == 0 ? 'Logout' : 'Login' );

            my $sql = qq{
        INSERT INTO tool_web_lily.users_logs (log_info) VALUES ('
            usid    => $session->{'us_id'},
            action  => $action
        ')};

            return $self->database->app->dbh->do($sql);
        }
    );

    $app->helper(
        helperUpdateLastOnline => sub {
            my $self    = shift;
            my $session = shift;

            $self->app->log->debug("helperUpdateLastOnline");

            my $sql = qq{
            UPDATE
                tool_web_lily.users
            SET
                user_last_online = current_timestamp
            WHERE
                us_id = ?
        };

            return $self->database->database_query_execute_1parameters( $sql,
                $session->{'us_id'} );
        }
    );

    $app->helper(
        helperGetNavListStructure => sub {
            my $self = shift;

            $self->app->log->debug("helperGetNavListStructure");

            my $us_id = 1;
            if ( $self->session('lily.app.ecometer') ) {
                $us_id = $self->session('lily.app.ecometer')->{'us_id'};
            }
            return $self->databaseutils->userMenu($us_id);
        }
    );

    $app->helper(
        helperGetNavListHtml => sub {
            my $self        = shift;
            my $member_menu = shift;
            my $menu_active = shift;

            $self->app->log->debug("helperGetNavListHtml");

            my $menu          = '';
            my $submenu1_open = 0;
            my $submenu2_open = 0;

            foreach my $item ( @{$member_menu} ) {

                next if ( !$item->{'isvisible'} );

                if ( $item->{'menu_level'} == 1 && $submenu2_open == 1 ) {

                    $menu .= '</ul>' . "\n";
                    $menu .= '</li>' . "\n";
                    $submenu2_open = 0;

                    $menu .= '</ul>' . "\n";
                    $menu .= '</li>' . "\n";
                    $submenu1_open = 0;

                    $menu =~ s/LEVEL1-ACTIVE//g;
                }

                if ( $item->{'menu_level'} == 1 && $submenu1_open == 1 ) {

                    $menu .= '</ul>' . "\n";
                    $menu .= '</li>' . "\n";
                    $submenu1_open = 0;

                    $menu =~ s/LEVEL1-ACTIVE//g;
                }

                if ( $item->{'menu_level'} == 2 && $submenu2_open == 1 ) {

                    $menu .= '</ul>' . "\n";
                    $menu .= '</li>' . "\n";

                    $submenu2_open = 0;

                    $menu =~ s/LEVEL2-ACTIVE//g;
                }

                if ( $item->{'isdropdown'} ) {

                    if ( $item->{'menu_level'} == 1 && $submenu1_open == 0 ) {

                        $menu .= '<li class="LEVEL1-ACTIVE">' . "\n";
                        $menu .=
                            '<a href="#"><i class="fa '
                          . $item->{'menu_css'}
                          . '"></i>' . "\n";
                        $menu .=
                            '<span class="nav-label">'
                          . $item->{'menu_name'}
                          . '</span><span class="fa arrow"></span>' . "\n";
                        if ( $item->{'badge_css'} ) {
                            $self->app->log->debug("\t\tbadge_css");
                        }
                        $menu .= '</a>' . "\n";
                        $menu .= '<ul class="nav nav-second-level">' . "\n";

                        $submenu1_open = 1;
                    }

                    if ( $item->{'menu_level'} == 2 && $submenu2_open == 0 ) {

                        $menu .= '<li class="LEVEL2-ACTIVE">' . "\n";
                        $menu .=
                            '<a href="#">'
                          . $item->{'menu_name'}
                          . '<span class="fa arrow"></span></a>' . "\n";
                        $menu .= '<ul class="nav nav-third-level">' . "\n";

                        $submenu2_open = 1;
                    }

                    next;
                }

                if ( $item->{'menu_level'} == 1 ) {

                    if ( $item->{'menu_href'} eq $menu_active ) {
                        $menu .= '<li class="active">' . "\n";
                    }
                    else {
                        $menu .= '<li class="">' . "\n";
                    }
                    $menu .= '<a href="/' . $item->{'menu_href'} . '">' . "\n";
                    $menu .=
                      '<i class="fa ' . $item->{'menu_css'} . '"></i>' . "\n";
                    $menu .=
                        '<span class="nav-label"> '
                      . $item->{'menu_name'}
                      . ' </span>' . "\n";
                    $menu .= '</a>' . "\n";
                    $menu .= '</li>' . "\n\n";

                }
                elsif ( $item->{'menu_level'} == 2 ) {

                    if ( $item->{'menu_href'} eq $menu_active ) {
                        $menu =~ s/LEVEL1-ACTIVE/active/g;
                        $menu .= '<li class="active">' . "\n";
                    }
                    else {
                        $menu .= '<li class="">' . "\n";
                    }
                    $menu .=
                        '<a href="/'
                      . $item->{'menu_href'} . '">'
                      . $item->{'menu_name'}
                      . '</a></li>' . "\n";

                }
                elsif ( $item->{'menu_level'} == 3 ) {

                    if ( $item->{'menu_href'} eq $menu_active ) {
                        $menu .= '<li class="active">' . "\n";
                    }
                    else {
                        $menu .= '<li class="">' . "\n";
                    }

                    if ( $item->{'menu_href'} eq $menu_active ) {
                        $menu =~ s/LEVEL1-ACTIVE/active/g;
                        $menu =~ s/LEVEL2-ACTIVE/active/g;
                        $menu .= '<li class="active">' . "\n";
                    }
                    else {
                        $menu .= '<li>' . "\n";
                    }
                    $menu .=
                        '<a href="/'
                      . $item->{'menu_href'} . '">'
                      . $item->{'menu_name'}
                      . '</a></li>' . "\n";
                }

            }

            if ( $submenu1_open == 1 ) {
                $menu .= '</ul></li>' . "\n";
            }

            $menu .= '<!-- /.nav-list -->' . "\n\n";

            return $menu;
        }
    );

    $app->helper(
        helperGetNavListBreadcrumb => sub {
            my $self        = shift;
            my $member_menu = shift;
            my $menu_active = shift;

            $self->app->log->debug("helperGetNavListBreadcrumb");

            my $bread       = '<ol class="breadcrumb">';
            my $old_level   = 0;
            my $old_menu    = '';
            my $bread_inner = '';
            foreach my $item ( @{$member_menu} ) {

                if ( $item->{'menu_level'} != $old_level ) {
                    if ( $old_menu ne '' ) {
                        $bread_inner .=
                          '<li><a href="#">' . $old_menu . '</a></li>';
                    }
                }

                if ( $item->{'menu_level'} < $old_level ) {
                    $bread_inner = '<li><a href="/">Homepage</a></li>';
                }

                if ( $item->{'menu_href'} eq $menu_active ) {
                    $bread .=
                        $bread_inner
                      . '<li class="active"><strong>'
                      . $item->{'menu_name'}
                      . '</strong></li>';
                    last;
                }

                $old_level = $item->{'menu_level'};
                $old_menu  = $item->{'menu_name'};
            }

            $bread .= '</ol>';

            return $bread;
        }
    );

    $app->helper(
        helperGetNavListItem => sub {
            my $self        = shift;
            my $member_menu = shift;
            my $menu_active = shift;

            $self->app->log->debug("helperGetNavListItem");

            foreach my $item ( @{$member_menu} ) {
                if ( $item->{'menu_href'} eq $menu_active ) {
                    return $item;
                }
            }

            return undef;
        }
    );

    $app->helper(
        helperCheckItemExist => sub {
            my $self        = shift;
            my $member_menu = shift;
            my $menu_item   = shift;

            $self->app->log->debug("helperCheckItemExist");

            foreach my $item ( @{$member_menu} ) {
                if ( $item->{'menu_href'} eq $menu_item ) {
                    return 1;
                }
            }

            return 0;
        }
    );

    $app->helper(
        helperGetNewsUnread => sub {
            my $self = shift;

            $self->app->log->debug("helperGetNews");

            my $boid = $self->session('lily.app.ecometer')->{'bo_id'} || -1;
            my $news = $self->database->getNewsUnread_per_board($boid);

            return $news;
        }
    );

}

1;

package Lily::Plugin::Database;
use strict;
use warnings;
use Mojo::Base 'Mojolicious::Plugin';

our $VERSION = '0.01';

has app => undef;

sub register {
    my ( $self, $app ) = @_;

    $app->log->info('Lily::Plugin::Database :: register()');

    $self->app($app);

    $app->helper(
        database => sub {
            return $self;
        }
    );

    return;
}

sub DESTROY {
    my $self = shift;
    return;
}

sub database_query_execute() {
    my ( $self, $sql, $silent ) = @_;

    $self->app->log->debug("database_query_execute -> query: [$sql]")
      unless $silent;

    return $self->app->dbh->do($sql);

}

sub database_query_execute_1parameters() {
    my ( $self, $sql, $parameter ) = @_;

    $self->app->log->debug(
        "database_query_execute_1parameters -> query: [$sql] {$parameter}");

    my $sth = $self->app->dbh->prepare($sql);

    $sth->execute($parameter);

    $sth->finish;

    if   ( $sth->err() ) { return 0; }
    else                 { return 1; }
}

sub database_query_execute_2parameters() {
    my ( $self, $sql, $parameter1, $parameter2 ) = @_;

    $self->app->log->debug(
"database_query_execute_2parameters -> query: [$sql] {$parameter1, $parameter2}"
    );

    my $sth = $self->app->dbh->prepare($sql);

    $sth->execute( $parameter1, $parameter2 );

    $sth->finish;

    if   ( $sth->err() ) { return 0; }
    else                 { return 1; }
}

sub database_query_execute_3parameters() {
    my ( $self, $sql, $parameter1, $parameter2, $parameter3 ) = @_;

    $self->app->log->debug(
"database_query_execute_3parameters -> query: [$sql] {$parameter1, $parameter2, $parameter3}"
    );

    my $sth = $self->app->dbh->prepare($sql);

    $sth->execute( $parameter1, $parameter2, $parameter3 );

    $sth->finish;

    if   ( $sth->err() ) { return 0; }
    else                 { return 1; }
}

sub database_query_execute_4parameters() {
    my ( $self, $sql, $parameter1, $parameter2, $parameter3, $parameter4 ) = @_;

    $self->app->log->debug(
"database_query_execute_4parameters -> query: [$sql] {$parameter1, $parameter2, $parameter3, $parameter4}"
    );

    my $sth = $self->app->dbh->prepare($sql);

    $sth->execute( $parameter1, $parameter2, $parameter3, $parameter4 );

    $sth->finish;

    if   ( $sth->err() ) { return 0; }
    else                 { return 1; }
}

sub database_query_execute_5parameters() {
    my (
        $self,       $sql,        $parameter1, $parameter2,
        $parameter3, $parameter4, $parameter5
    ) = @_;

    $self->app->log->debug(
"database_query_execute_5parameters -> query: [$sql] {$parameter1, $parameter2, $parameter3, $parameter4, $parameter5}"
    );

    my $sth = $self->app->dbh->prepare($sql);

    $sth->execute( $parameter1, $parameter2, $parameter3, $parameter4,
        $parameter5 );

    $sth->finish;

    if   ( $sth->err() ) { return 0; }
    else                 { return 1; }
}

sub database_query_value() {
    my ( $self, $sql, $debugoff ) = @_;

    if ( !defined $debugoff ) {
        $self->app->log->debug("database_query_value -> query: [$sql]");
    }

    my $sth = $self->app->dbh->prepare($sql);

    $sth->execute();

    my $value = $sth->fetchrow_array();

    $sth->finish;

    return $value;
}

sub database_query_value_by_parameter() {
    my ( $self, $sql, $parameter ) = @_;

    $self->app->log->debug(
        "database_query_value_by_parameter -> query: [$sql]");

    my $sth = $self->app->dbh->prepare($sql);

    $sth->execute($parameter);

    my $value = $sth->fetchrow_array();

    $sth->finish;

    return $value;
}

sub database_query_value_by_2parameters() {
    my ( $self, $sql, $parameter1, $parameter2 ) = @_;

    $self->app->log->debug(
"database_query_value_by_2parameters -> query: [$sql] {$parameter1, $parameter2}"
    );

    my $sth = $self->app->dbh->prepare($sql);

    $sth->execute( $parameter1, $parameter2 );

    my $value = $sth->fetchrow_array();

    $sth->finish;

    return $value;
}

sub database_query_records_by_parameter() {
    my ( $self, $sql, $parameter ) = @_;

    $self->app->log->debug(
        "database_query_records_by_parameter -> query: [$sql] {$parameter}");

    my $sth = $self->app->dbh->prepare($sql);

    $sth->execute($parameter);

    my $rows = $sth->fetchall_arrayref( {} );

    $sth->finish;

    return $rows;
}

sub database_query_records_by_2parameters {
    my ( $self, $sql, $parameter1, $parameter2 ) = @_;

    $self->app->log->debug(
"database_query_records_by_2parameters -> query: [$sql] {$parameter1, $parameter2}"
    );

    my $sth = $self->app->dbh->prepare($sql);

    $sth->execute( $parameter1, $parameter2 );

    my $rows = $sth->fetchall_arrayref( {} );

    $sth->finish;

    return $rows;
}

sub database_query_records_by_3parameters {
    my ( $self, $sql, $parameter1, $parameter2, $parameter3 ) = @_;

    $self->app->log->debug(
"database_query_records_by_3parameters -> query: [$sql] {$parameter1, $parameter2, $parameter3}"
    );

    my $sth = $self->app->dbh->prepare($sql);

    $sth->execute( $parameter1, $parameter2, $parameter3 );

    my $rows = $sth->fetchall_arrayref( {} );

    $sth->finish;

    return $rows;
}

sub database_query_records_by_4parameters {
    my ( $self, $sql, $parameter1, $parameter2, $parameter3, $parameter4 ) = @_;

    $self->app->log->debug(
"database_query_records_by_4parameters -> query: [$sql] {$parameter1, $parameter2, $parameter3, $parameter4}"
    );

    my $sth = $self->app->dbh->prepare($sql);

    $sth->execute( $parameter1, $parameter2, $parameter3, $parameter4 );

    my $rows = $sth->fetchall_arrayref( {} );

    $sth->finish;

    return $rows;
}

sub database_query_records_by_5parameters {
    my (
        $self,       $sql,        $parameter1, $parameter2,
        $parameter3, $parameter4, $parameter5
    ) = @_;

    $self->app->log->debug(
"database_query_records_by_5parameters -> query: [$sql] {$parameter1, $parameter2, $parameter3, $parameter4, $parameter5}"
    );

    my $sth = $self->app->dbh->prepare($sql);

    $sth->execute( $parameter1, $parameter2, $parameter3, $parameter4,
        $parameter5 );

    my $rows = $sth->fetchall_arrayref( {} );

    $sth->finish;

    return $rows;
}

sub database_query_record_by_parameter() {
    my ( $self, $sql, $parameter ) = @_;

    $self->app->log->debug(
        "database_query_record_by_parameter -> query: [$sql] {$parameter}");

    my $sth = $self->app->dbh->prepare($sql);

    $sth->execute($parameter);

    my $rows = $sth->fetchall_arrayref( {} );

    $sth->finish;

    if ( scalar @{$rows} == 0 ) {
        return undef;
    }
    else {
        return $rows->[0];
    }
}

sub database_query_record_by_2parameters() {
    my ( $self, $sql, $parameter1, $parameter2 ) = @_;

    $self->app->log->debug(
"database_query_record_by_2parameters -> query: [$sql] {$parameter1, $parameter2}"
    );

    my $sth = $self->app->dbh->prepare($sql);

    $sth->execute( $parameter1, $parameter2 );

    my $rows = $sth->fetchall_arrayref( {} );

    $sth->finish;

    if ( scalar @{$rows} == 0 ) {
        return undef;
    }
    else {
        return $rows->[0];
    }
}

sub database_query_record_by_4parameters() {
    my ( $self, $sql, $parameter1, $parameter2, $parameter3, $parameter4 ) = @_;

    $self->app->log->debug(
"database_query_record_by_4parameters -> query: [$sql] {$parameter1, $parameter2, $parameter3, $parameter4}"
    );

    my $sth = $self->app->dbh->prepare($sql);

    $sth->execute( $parameter1, $parameter2, $parameter3, $parameter4 );

    my $rows = $sth->fetchall_arrayref( {} );

    $sth->finish;

    if ( scalar @{$rows} == 0 ) {
        return undef;
    }
    else {
        return $rows->[0];
    }
}

sub database_query_record_by_6parameters() {
    my (
        $self,       $sql,        $parameter1, $parameter2,
        $parameter3, $parameter4, $parameter5, $parameter6
    ) = @_;

    $self->app->log->debug(
"database_query_record_by_6parameters -> query: [$sql] {$parameter1, $parameter2, $parameter3, $parameter4, $parameter5, $parameter6}"
    );

    my $sth = $self->app->dbh->prepare($sql);

    $sth->execute(
        $parameter1, $parameter2, $parameter3,
        $parameter4, $parameter5, $parameter6
    );

    my $rows = $sth->fetchall_arrayref( {} );

    $sth->finish;

    if ( scalar @{$rows} == 0 ) {
        return undef;
    }
    else {
        return $rows->[0];
    }
}

sub database_query_records() {
    my ( $self, $sql ) = @_;

    $self->app->log->debug("database_query_records -> query: [$sql]");

    my $sth = $self->app->dbh->prepare($sql);

    $sth->execute();

    my $rows = $sth->fetchall_arrayref( {} );

    $sth->finish;

    return $rows;
}

sub database_query_record() {
    my ( $self, $sql, $silent ) = @_;

    $self->app->log->debug("database_query_record -> query: [$sql]")
      unless $silent;

    my $sth = $self->app->dbh->prepare($sql);

    $sth->execute();

    my $rows = $sth->fetchall_arrayref( {} );

    $sth->finish;

    if ( scalar @{$rows} == 0 ) {
        return undef;
    }
    else {
        return $rows->[0];
    }
}

sub prepare_param {
    my ( $params, $param ) = @_;
    if ( defined( $params->{$param} ) ) {
        if ( $params->{$param} eq "" ) {
            return undef;
        }
        else {
            my $str = $params->{$param};
            $str =~ s/^\s+|\s+$//g;
            return $str;
        }
    }
    else {
        return undef;
    }
}

sub prepare_param_hash {
    my ( $params, $param ) = @_;
    if ( defined( $params->{$param} ) ) {
        if ( $params->{$param} eq "" ) {
            return 'null';
        }
        else {
            my $str = $params->{$param};
            $str =~ s/^\s+|\s+$//g;
            return $str;
        }
    }
    else {
        return 'null';
    }
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

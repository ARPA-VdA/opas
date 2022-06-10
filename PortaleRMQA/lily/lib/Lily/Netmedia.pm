package Lily::Netmedia;
use Mojo::Base 'Mojolicious::Controller';
use File::Find::Rule;
use File::Basename;
use Data::Dumper;
use Mojo::JSON qw(decode_json encode_json);
use Number::Bytes::Human qw(format_bytes);
use locale;

sub netmedia {
    my $self = shift;

    $self->app->log->debug("Lily::Network sub netmedia");

    $self->helperGetHomepageStash('netmedia');

    my $public_dir = $self->app->home->rel_file('public');
    my $media_path = $public_dir . '/media-net';
    my $base_dir   = '/media-net';
    $self->app->log->debug("searching media files in: $media_path");

    my $rule = File::Find::Rule->new;
    $rule->name(
        '*.png', '*.jpg', '*.jpeg', '*.PNG', '*.JPG', '*.JPEG',
        '*.pdf', '*.PDF', '*.xls',  '*.xlsx'
    );
    $rule->relative;
    $rule->maxdepth(3);
    my @files = $rule->in($media_path);
    $self->app->log->debug( Dumper(@files) );
    @files =
      map { $_ }
      sort { $a cmp $b } @files;
    $self->app->log->debug( Dumper(@files) );

    $self->app->log->debug("create arrays");
    my @tree;
    my $oldpath1 = '';
    my $oldpath2 = '';
    my $block    = 0;
    my $tab      = 0;
    foreach my $file (@files) {
        my ( $basename, $dirname, $suffix ) = fileparse( $file, qr/\.[^.]*/ );
        my $dirname  = dirname($file);
        my $size     = format_bytes( -s "$media_path/$file" );
        my $file_url = $self->helperGetFileVersion("$base_dir/$file");
        my @dirs     = split( "/", $dirname );
        my $level    = scalar(@dirs);
        my $path1    = $dirs[0];
        my $path2    = $dirs[1];
        $self->app->log->debug("file: $file, $file_url, $basename, $dirname");
        $self->app->log->debug("path1: $path1, oldpath1: $oldpath1");
        $self->app->log->debug("path2: $path2, oldpath2: $oldpath2");

        if ( $path1 ne $oldpath1 ) {

            $oldpath1 = $dirs[0];

            $block++;

            $tab = 0;

            $oldpath2 = '';

            if ( defined($path2) && $path2 ne '' ) {
                $tab      = 1;
                $oldpath2 = $path2;
            }

        }
        else {

            if ( $path2 ne $oldpath2 ) {
                $oldpath2 = $path2;

                $tab++;
            }
        }

        $dirname  =~ s/_/ /g;
        $path1    =~ s/_/ /g;
        $path2    =~ s/_/ /g;
        $basename =~ s/_/ /g;

        push @tree,
          {
            block => $block,
            tab   => $tab,
            path  => $dirname,
            path1 => $path1,
            path2 => $path2,
            file  => $basename,
            suff  => $suffix,
            url   => $file_url,
            size  => $size
          };

    }

    @tree = sort {
             lc( $a->{block} ) cmp lc( $b->{block} )
          || lc( $a->{tab} ) cmp lc( $b->{tab} )
          || lc( $a->{file} ) cmp lc( $b->{file} )
    } @tree;

    $self->app->log->debug( Dumper(@tree) );
    my $jsontree = encode_json { tree => \@tree };

    $self->stash( tree => $jsontree );

    $self->render();
}

1;

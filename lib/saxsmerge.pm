package saxsmerge;
use base qw(saliweb::frontend);
use strict;

sub new {
    return saliweb::frontend::new(@_, @CONFIG@);
}

sub get_navigation_links {
    my $self = shift;
    my $q = $self->cgi;
    return [
        $q->a({-href=>$self->index_url}, "SAXS Merge Home"),
        $q->a({-href=>$self->queue_url}, "SAXS Merge Current queue"),
        $q->a({-href=>$self->help_url}, "SAXS Merge Help"),
        $q->a({-href=>$self->contact_url}, "SAXS Merge Contact")
        ];
}

sub get_project_menu {
    # TODO
}

sub get_footer {
    # TODO
}

sub get_index_page {
    # TODO
}

sub get_submit_page {
    # TODO
}

sub get_results_page {
    # TODO
}

1;

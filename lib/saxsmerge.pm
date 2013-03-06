package saxsmerge;
use base qw(saliweb::frontend);
use strict;


sub _display_content {
  my ($self, $content) = @_;
  print $content;
}

sub _display_web_page {
  my ($self, $content) = @_;
  # Call all prefix and suffix methods before printing anything, in case one
  # of them raises an error
  my $prefix = $self->start_html() . "<div id='container'>" . $self->get_header();
  my $suffix = $self->get_footer() . "</div>\n" . $self->end_html;
  my $navigation = $self->get_navigation_lab();
  print $prefix;
  print $navigation;
  $self->_display_content($content);
  print $suffix;
}

sub get_help_page {
  my ($self, $display_type) = @_;
  my $file;
  if ($display_type eq "contact") {
    $file = "contact.txt";
  } elsif ($display_type eq "news") {
    $file = "news.txt";
  } elsif ($display_type eq "about") {
    $file = "about.txt";
  } elsif ($display_type eq "FAQ") {
    $file = "FAQ.txt";
  } elsif ($display_type eq "links") {
    $file = "links.txt";
  } elsif ($display_type eq "download") {
    $file = "download.txt";
  } else {
    $file = "help.txt";
  }
  return $self->get_text_file($file);
}

sub new {
    return saliweb::frontend::new(@_, @CONFIG@);
}

sub get_navigation_lab {
  return "<div id=\"navigation_lab\">
      &bull;&nbsp; <a href=\"http://modbase.compbio.ucsf.edu/saxsmerge/help.cgi?type=about\">About SAXS Merge</a>&nbsp;
      &bull;&nbsp; <a href=\"http://salilab.org/saxsmerge\">Web Server</a>&nbsp;
      &bull;&nbsp; <a href=\"http://modbase.compbio.ucsf.edu/saxsmerge/help.cgi?type=help\">Help</a>&nbsp;
      &bull;&nbsp; <a href=\"http://modbase.compbio.ucsf.edu/saxsmerge/help.cgi?type=FAQ\">FAQ</a>&nbsp;
      &bull;&nbsp; <a href=\"http://modbase.compbio.ucsf.edu/saxsmerge/help.cgi?type=download\">Download</a>&nbsp;
      &bull;&nbsp; <a href=\"http://salilab.org/foxs\">FoXS</a>&nbsp;
      &bull;&nbsp; <a href=\"http://salilab.org\">Sali Lab</a>&nbsp;
      &bull;&nbsp; <a href=\"http://salilab.org/imp\">IMP</a>&nbsp;
      &bull;&nbsp; <a href=\"http://modbase.compbio.ucsf.edu/saxsmerge/help.cgi?type=links\">Links</a>&nbsp;</div>\n";
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
  # no menu
  return "";
}

sub get_header {
  return "<div id='header1'>
  <table> <tbody> <tr> <td halign='left'>
  <table><tr><td><img src=\"http://salilab.org/saxsmerge/logo.png\" align = 'right' height = '80'></td></tr>
         <tr><td><h3>SAXS Merge</h3> </td></tr></table>
      </td> <td halign='right'><img src=\"http://salilab.org/foxsdock/logo2.gif\" height = '80'></td></tr>
  </tbody>
  </table></div>\n";
}


sub get_footer {
  return "<hr size='2' width=\"80%\"><div id='address'>
<p> <p>Contact: <script>escramble(\"yannick\",\"salilab.org\")</script><br></div>\n";
}

sub make_dropdown {
    my ($self, $id, $title, $initially_visible, $text) = @_;
    my $style = "";
    if (!$initially_visible) {
      $style = " style=\"display:none\"";
    }
    return "<div class=\"dropdown_container\">\n" .
           "<a onclick=\"\$('#${id}').slideToggle('fast')\" " .
           "href=\"#\">$title</a>\n" .
           "<div class=\"dropdown\" id=\"${id}\"$style>\n" .
           $text . "\n</div></div>\n";
}


sub get_input_form {
  my $self = shift;
  my $q = $self->cgi;

  my $form = $q->table($q->Tr($q->td("Email (Required)"),
                              $q->td($q->textfield({-name=>"jobemail",
                                                    -value=>$self->email,
                                                    -size=>"25"})))) .
             $q->table({-id=>'profiles'},
                      $q->td("upload SAXS profile " .
                      $q->filefield({-name=>'uploaded_file'}))) .
              $q->p($q->button(-value=>'Add more profiles',
                               -onClick=>"add_structure()")) .
              $q->p("<center>" .
                    $q->input({-type=>"submit", -value=>"Submit"}) .
                    "</center>");
   return $q->h2({-align=>"center"}, "SAXS Merge ...") .
  $q->start_form({-name=>"saxsmerge_form", -method=>"post",
                  -action=>$self->submit_url}) .
  $form .
  $q->end_form;
}

sub get_index_page {
  my $self = shift;
  my $q = $self->cgi;

  my $input_form = get_input_form($self, $q);

  return "$input_form\n";

}

sub get_submit_page {
    # TODO
}

sub get_results_page {
    # TODO
}

1;

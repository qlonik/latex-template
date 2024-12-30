# vim:set ft=perl:

$out_dir = ".build";

$pdf_mode = 5;
push @extra_pdflatex_options, "-shell-escape";
push @extra_xelatex_options, "-shell-escape";

# From more writes package
$clean_ext .= ' %R.mw';

# List of Algorithms
push @generated_exts, 'loa';

# List of Listings
push @generated_exts, 'lol';

# Make latexmk handle glossaries
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

push @generated_exts, '*glo*', '*gls*', '*glg*';
push @generated_exts, '*acn*', '*acr*', '*alg*';
$clean_ext .= ' %R.ist %R.xdy';

use File::Basename;
sub run_makeglossaries {
  my $dir = dirname($_[0]);
  my $file = basename($_[0]);
  system "makeglossaries" . ($silent ? " -q" : "") . " -d '$dir' '$file'";
}


=begin
$e->index(
    index   => 'my_app',
    type    => 'blog_post',
    id      => 1,
    body    => {
        title   => 'Prueba con ES',
        content => 'Esta es una prueba  ...',
        date    => '2018-01-18'
    }
);
=cut

my $doc = $e->get(
    index   => 'my_app',
    type    => 'blog_post',
    id      => 1
);

print Dumper $doc;

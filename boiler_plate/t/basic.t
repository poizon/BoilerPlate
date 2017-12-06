use Mojo::Base -strict;

use Test::More;
use Test::Mojo;
use lib qw(lib);
use FindBin qw($Bin);

# tests with curl
# curl -F "import_file=@blog11.db.gz" http://localhost:9000/goods/import
# curl -F "import_file=@blog11.db.gz" -F "key=valid_secret_key" http://localhost:9000/goods/import

# for run tests via carton ()
# pavel@DellLPT:~/BoilerPlate/boiler_plate$ carton exec prove

my $t = Test::Mojo->new('BoilerPlate');

$t->get_ok('/')->status_is(200)->content_like(qr/Mojolicious/i);

$t->get_ok('/goods.json')->status_is(200)->json_has('/users');

# Test file upload
my $upload = {
                key         => 'valid_secret_key',
                import_file => {
                  file => $Bin . '/blog11.db.gz'
                }
              };

$t->post_ok('/goods/import' => form => $upload)->status_is(200);


done_testing();

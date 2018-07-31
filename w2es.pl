#
# Objetivo: Registro de respaldos en ES
#
# Parametros
#      $ts          : instante o fecha del respaldo
#      $serverid    : id. del servidor o cluster
#      $dbname      : nombre de la bd
#      $backup_type : tipo (full, incremental, diferencial, ...)
#      $operator    : nombre del operador                        (o automatico)
#      $result      : resultado del respaldo OK|ERR
#      $logline     : linea completa del log de respaldo
#

use strict;
use warnings;
use Data::Dumper;   # Sacar en amb. de Prod.
use Config::Tiny;
use Search::Elasticsearch;

my $DEBUG = 1;

# Parametros
my $ts          = shift;
my $serverid    = shift;
my $dbname      = shift;
my $backup_type = shift;
my $operator    = shift;
my $result      = shift;
my $logline     = shift;


# lee configuracion
my $Config = Config::Tiny->new;
$Config = Config::Tiny->read( 'w2es.conf' );
my $HOST  = $Config->{es_server}->{es_nodes};
my $PORT  = $Config->{es_server}->{es_port};

die "$0\nError: $Config::Tiny::errstr" if $Config::Tiny::errstr;

my $e = Search::Elasticsearch->new(
    nodes => [
                '$HOST:$PORT'
             ]
);

$e->index(
    index   => 'backup_log',
    type    => 'log',
 #   id      => 1,
    body    => {
                    timestamp   => $ts,
                    serverid    => $serverid,
                    dbname      => $dbname,
                    backup_type => $backup_type,
                    operator    => $operator,
                    result      => $result,
                    logline     => $logline
                }
);


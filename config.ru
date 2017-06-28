require_relative './lib/racker'

use Rack::Static, urls: ['/stylesheets', '/js'], root: 'public'
use Rack::Session::Cookie,  key: 'rack',
                            expire_after: 2_592_000,
                            secret: 'rack_codebreaker'
run Racker

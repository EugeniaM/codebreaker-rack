require_relative './lib/racker'

use Rack::Static, urls: ['/stylesheets', '/js'], root: 'public'
run Racker
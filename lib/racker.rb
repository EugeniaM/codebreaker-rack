require 'erb'
require 'codebreaker'
require_relative './action'

class Racker
  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
    @action = Action.new(@request)
  end

  def response
    case @request.path
    when "/" then @action.send('index')
    when "/post_name" then @action.send('post_name')
    when "/game" then @action.send('init_game')
    when "/game_continue" then @action.send('game_continue')
    when "/submit_guess" then @action.send('submit_guess')
    when "/hint" then @action.send('hint')
    when "/statistics" then @action.send('get_statistics')
    else Rack::Response.new('Not Found', 404)
    end
  end
end
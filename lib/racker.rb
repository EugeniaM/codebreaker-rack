require 'erb'
require 'codebreaker'
require_relative './action'

class Racker
  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
    @request.session['start'] = true
    @action = Action.new(@request)
  end

  def response
    case @request.path
    when '/' then @action.index
    when '/post_name' then @action.post_name
    when '/game' then @action.init_game
    when '/game_continue' then @action.game_continue
    when '/submit_guess' then @action.submit_guess
    when '/hint' then @action.hint
    when '/statistics' then @action.get_statistics
    else Rack::Response.new('Not Found', 404)
    end
  end
end

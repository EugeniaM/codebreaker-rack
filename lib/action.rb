require 'erb'
require 'codebreaker'
require 'yaml'
require_relative './base_methods.rb'
require_relative './sessions_handler.rb'

class Action < BaseMethods
  def initialize(req)
    @request = req
    @sessions_handler = SessionsHandler.new
    @session_id = @request.session['session_id']
    @session = @sessions_handler.get_session(@session_id)
    @game = @session[:game]
    @player = @session[:player] || nil
    @progress = @session[:progress] || []
    @game_over = @session[:game_over] || false
    @stats = []
  end

  def index
    Rack::Response.new(render('index.html.erb'))
  end

  def post_name
    if @request.params['name'] != ''
      @player = @request.params['name']
      @sessions_handler.save_param(@session_id, :player, @player)
      redirect('/game')
    else
      @player = nil
      redirect('/')
    end
  end

  def init_game
    @game.start
    @progress = []
    @game_over = false
    @sessions_handler.save_set_params(@session_id, %i(game progress game_over), [@game, @progress, @game_over])
    Rack::Response.new(render('game.html.erb'))
  end

  def submit_guess
    marked_guess = @game.submit_guess(@request.params['guess'])
    @progress.push(guess: @request.params['guess'], marked_guess: marked_guess)
    @game_over = @game.game_over
    @sessions_handler.save_set_params(@session_id, %i(game progress game_over), [@game, @progress, @game_over])
    redirect('/game_continue')
  end

  def game_continue
    save_score if @game_over && !@request.params['stats']
    Rack::Response.new(render('game.html.erb'))
  end

  def hint
    Rack::Response.new("#{@game.get_hint}")
  end

  def get_name_value
    @player || ''
  end

  def game_turns
    @game.turns
  end

  def get_code
    @game.instance_variable_get(:@secret_code)
  end

  def save_score
    if File.exist? ('./scores/scores.yml')
      scores = YAML.load(File.open('./scores/scores.yml')) || []
    else
      scores = []
      File.new('./scores/scores.yml', 'w')
    end

    scores.push({ name: @player, turns: (10 - @game.turns), status: @game.game_over, date: Time.now.strftime("%d/%m/%Y %H:%M") })
    File.open('./scores/scores.yml', 'w') { |f| f.write(scores.to_yaml) }
  end

  def get_statistics
    @stats = YAML.load(File.open('./scores/scores.yml')) || []
    Rack::Response.new(render('statistics.html.erb'))
  end
end

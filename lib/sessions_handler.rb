require 'yaml'
require 'codebreaker'

class SessionsHandler
  def initialize
    @sessions = YAML.load(File.open('./sessions/sessions.yml')) || {}
  end

  def get_session(id)
    if !@sessions[id.to_sym] || !@sessions[id.to_sym][:game]
      @sessions[id.to_sym] = { game: Codebreaker::Game.new }
      File.open('./sessions/sessions.yml', 'w') {|f| f.write(@sessions.to_yaml) }
    end
    @sessions[id.to_sym]
  end

  def save_param(id, param, value)
    @sessions[id.to_sym][param] = value
    File.open('./sessions/sessions.yml', 'w') { |f| f.write(@sessions.to_yaml) }
  end

  def save_set_params(id, params, values)
    params.each_with_index { |param, index| save_param(id, param, values[index])}
  end
end

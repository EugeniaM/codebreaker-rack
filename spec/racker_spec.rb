require 'rack/test'
require_relative '../lib/racker'

describe Racker do
  include Rack::Test::Methods

  context 'get to /' do
    let(:env) { { 'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/', 'rack.session' =>  { 'session_id' => 'test' } } }
    let(:app) { Racker.new(env) }
    let(:response) { Racker.call(env) }
    let(:status)   { response[0] }

    it 'returns the status 200' do
      expect(status).to eq 200
    end
  end

  context 'get to /post_name' do
    let(:env) { { 'REQUEST_METHOD' => 'POST', 'PATH_INFO' => '/post_name', 'rack.input' => StringIO.new, 'rack.session' =>  { 'session_id' => 'test' } } }
    let(:app) { Racker.new(env) }
    let(:response) { Racker.call(env) }
    let(:status)   { response[0] }

    it 'returns the status 302' do
      expect(status).to eq 302
    end

    it 'changes location to /game' do
      expect(response[1]['Location']).to eq '/game'
    end
  end

  context 'get to /game' do
    let(:env) { { 'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/game', 'rack.session' =>  { 'session_id' => 'test' } } }
    let(:app) { Racker.new(env) }
    let(:response) { Racker.call(env) }
    let(:status)   { response[0] }

    it 'returns the status 200' do
      expect(status).to eq 200
    end
  end

  context 'get to /game_continue' do
    let(:env) { { 'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/game_continue', 'rack.session' =>  { 'session_id' => 'test' } } }
    let(:app) { Racker.new(env) }
    let(:response) { Racker.call(env) }
    let(:status)   { response[0] }

    it 'returns the status 200' do
      expect(status).to eq 200
    end
  end

  context 'get to /hint' do
    let(:env) { { 'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/hint', 'rack.session' =>  { 'session_id' => 'test' } } }
    let(:app) { Racker.new(env) }
    let(:response) { Racker.call(env) }
    let(:status)   { response[0] }

    it 'returns the status 200' do
      expect(status).to eq 200
    end
  end

  context 'get to /statistics' do
    let(:env) { { 'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/statistics', 'rack.session' =>  { 'session_id' => 'test' } } }
    let(:app) { Racker.new(env) }
    let(:response) { Racker.call(env) }
    let(:status)   { response[0] }

    it 'returns the status 200' do
      expect(status).to eq 200
    end
  end
end

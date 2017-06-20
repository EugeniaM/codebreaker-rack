class BaseMethods
  @@game = ''
  @@player = ''
  @@progress = []
  @@game_over = false
  @@stats = []
  def render(template)
    path = File.expand_path("../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end

  def redirect(url)
    Rack::Response.new do |response|
      response.redirect(url)
    end
  end
end
# frozen_string_literal: true

class IpFiltering
  IP_WHITELIST = ['::1', 'localhost', '127.0.0.1'].freeze
  def initialize(app)
    @app = app
  end

  def call(env)
    unless IP_WHITELIST.include? env['action_dispatch.remote_ip'].calculate_ip
      [200, {}, ['Your IP is not on IP While List!']]
      return
    end
    @app.call(env)
  end
end

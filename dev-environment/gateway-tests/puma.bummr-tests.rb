root = "/home/deploy/gateway"

bind  "unix://#{root}/tmp/sockets/puma.sock"
pidfile "#{root}/tmp/pids/puma.pid"
state_path "#{root}/tmp/sockets/puma.state"
directory "#{root}"
daemonize false

activate_control_app "unix://#{root}/tmp/sockets/pumactl.sock"

stdout_redirect "#{root}/log/puma.bummr.stdout.log", "#{root}/log/puma.bummr.stderr.log"

workers Integer(ENV['PUMA_WORKERS'] || 2)
threads Integer(ENV['MIN_THREADS']  || 1), Integer(ENV['MAX_THREADS'] || 1)

preload_app!

rackup      DefaultRackup
port        3000
environment 'development'

on_worker_boot do
  # worker specific setup
  ActiveSupport.on_load(:active_record) do
    config = ActiveRecord::Base.configurations[Rails.env] ||
                Rails.application.config.database_configuration[Rails.env]
    config['pool'] = ENV['MAX_THREADS'] || 16
    config['adapter'] = 'postgis'
    ActiveRecord::Base.establish_connection(config)
  end
end


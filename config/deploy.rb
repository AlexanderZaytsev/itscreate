require 'intercity/capistrano'
require 'bundler/capistrano'

set :application, 'itscreate_production'
set :repository,  'git@github.com:AlexanderZaytsev/itscreate.git'
set :user, 'deploy'
set :deploy_via, :remote_cache

set :branch, ENV['BRANCH'] || "master"

server '5.153.13.36', :app, :web, :db, primary: true

namespace :deploy do
  task :symlink_shared_folders, roles: :app do
    run "ln -s #{shared_path}/system/uploads #{release_path}/public/uploads"
  end

end

task :c do
  find_servers_for_task(current_task).each do |current_server|
    exec "ssh #{user}@#{current_server.host} -t 'cd #{current_path}; bundle exec rails c production'"
  end
end

task :l do
  find_servers_for_task(current_task).each do |current_server|
    exec "ssh #{user}@#{current_server.host} -t 'cd #{current_path}; less log/production.log'"
  end
end

after "deploy:finalize_update", "deploy:symlink_shared_folders"

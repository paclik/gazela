set :application, "amelem"
#set :repository, "cesta_k_vasemu_repositari"
#set :repository, "ssh://totalplan@server3.railshosting.cz/usr/home/totalplan/git/totalplan.git"
#set :repository, "git://github.com/paclik/gazela.git" 
set :repository, "git://github.com/paclik/gazela.git" 
set :scm, "git"

role :web, "server3.railshosting.cz"
role :app, "server3.railshosting.cz"
role :db,  "server3.railshosting.cz", :primary => true

set :deploy_to, "/home/amelem/app/"
set :user, "amelem"

set :use_sudo, false

task :after_update_code, :roles => [:app, :db] do
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end


namespace :deploy do
  task :start, :roles => :app do
  end
end

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end


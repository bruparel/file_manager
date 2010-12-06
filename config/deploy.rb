set :rails_root, "#{File.dirname(__FILE__)}/.."
require "#{rails_root}/vendor/plugins/thinking-sphinx/lib/thinking_sphinx/deploy/capistrano"

set :application, "file_manager"
set :repository, "git@github.com:bruparel/file_manager.git"
#set :repository, "#{user}@#{domain}:git/#{application}.git"

set :user, "bruparel"
set :runner, "bruparel"
set :admin_runner, runner
#default_run_options[:pty] = true

set :domain, '192.168.1.104'
role :app, domain
role :web, domain
role :db,  domain, :primary => true

set :deploy_to, "/home/#{user}/r_work/#{application}"

set :deploy_via, :remote_cache
set :scm, "git"
set :branch, "master"
set :scm_verbose, true
set :use_sudo, false

namespace :deploy do

  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Cleanup older revisions"
  task :after_deploy do
    cleanup
  end

  desc "Update the crontab file"
  task :update_crontab, :roles => :db, :only => { :primary => true } do
    run "cd #{current_path} && /opt/ruby-enterprise/bin/whenever --update-crontab #{application}"
  end

end

after "deploy:setup", "thinking_sphinx:shared_sphinx_folder"
after "deploy:symlink", "deploy:update_crontab"
after "deploy:restart", "thinking_sphinx:rebuild"
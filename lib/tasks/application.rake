desc "Setup all for app"
task :setup => ['db:migrate', 'db:seed', 'db:populate']

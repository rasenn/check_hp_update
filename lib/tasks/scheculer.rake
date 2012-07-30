desc "This task is called by the Heroku scheduler add-on"

task :check_update => :environment do
    puts "Updating feed..."
    Url.update_all
    puts "done."
end
 


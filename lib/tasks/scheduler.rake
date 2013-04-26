desc "check hp"
task :update_all => :environment do
  Url.update_all
end



namespace :dev do
  task :build => ['db:drop', 'db:create', 'db:migrate'] do
  end

  task :fake => ['environment'] do
    ActiveRecord::Base.transaction do
      4.times { Factory(:forum) }
      Forum.all.each do |forum|
        26.times do 
          Factory(:post, :forum => forum)
        end
      end
    end
  end
end


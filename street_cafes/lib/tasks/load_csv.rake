require './db/csv/seed_starter.rb'

namespace :db do
  namespace :seed do
    desc "Uses remote CSV files to seed the database"
    task :from_csv => :environment do
      SeedStarter.destroy_models
      puts 'Cleared Existing Models'

      SeedStarter.create_restaurants
      puts 'Created Restaurants'

      ActiveRecord::Base.connection.tables.each do |t|
        ActiveRecord::Base.connection.reset_pk_sequence!(t)
      end
      puts 'Reset Primary Key Sequence'
      puts 'Database Seeded!'

      Restaurant.categorize_restaurants
      puts 'Restaurants categorized'
    end
  end
end

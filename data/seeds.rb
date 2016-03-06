require 'faker'
require 'csv'

# This file contains code that populates the database with
# fake data for testing purposes
@data_path = File.dirname(__FILE__) + "/../data/data.csv"

def db_seed
  CSV.open(@data_path, "ab") do |csv|
    10.times do |i|
      csv << [i, Faker::Commerce.department, Faker::Commerce.product_name, Faker::Number.decimal(2)]
    end
  end
end


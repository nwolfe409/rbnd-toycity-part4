require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  
  @@data_path = File.dirname(__FILE__) + "/../data/data.csv" 
  
  def self.create(attributes = nil)
  
    object = self.new(attributes) # Initialize new product # create the object

    CSV.foreach(@@data_path) do |row|
      if !row.include?(object.name) # If the object's data is not in the database
        CSV.open(@@data_path, "a+") do |csv| # save the data in the database
          csv << [object.id, object.brand, object.name, object.price]
        end
      end
    end

    object # return the object

  end 
  
end

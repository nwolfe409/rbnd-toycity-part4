require_relative 'find_by'
require_relative 'errors'
require 'csv'

@@data_path = File.dirname(__FILE__) + "/../data/data.csv"

class Udacidata
  
   
  
  
  def self.create(attributes = nil)
    File.open(@@data_path, 'ab+') do |this_file|
      csv_data_ids = CSV.read(this_file).map{|row| row.first.to_i}
      csv_data_ids.shift
      unless csv_data_ids.include?(attributes[:id])
        CSV.open(this_file, "ab") {|csv| csv << [csv_data_ids.length.to_s, attributes[:brand].to_s, attributes[:name].to_s, attributes[:price].to_s]} 
        attributes[:id] = csv_data_ids.length.to_s
      end
      return_object = self.new(attributes)
    end
  end
      
    
  
end

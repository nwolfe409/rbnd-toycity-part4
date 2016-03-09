require_relative 'find_by'
require_relative 'errors'
require 'csv'

#@@data_path = File.dirname(__FILE__) + "/../data/data.csv"

class Udacidata
  
  Module.create_finder_methods(:brand, :name)
  
  
  def self.create(attributes = nil)
    File.open(self.data_path, 'ab+') do |this_file|
      csv_data_ids = CSV.read(this_file).map{|row| row.first.to_i}
      csv_data_ids.shift
      unless csv_data_ids.include?(attributes[:id])
        CSV.open(this_file, "ab") {|csv| csv << [csv_data_ids.length.to_s, attributes[:brand].to_s, attributes[:name].to_s, attributes[:price].to_s]} 
        attributes[:id] = csv_data_ids.length.to_s
      end
      return_object = self.new(attributes)
    end
  end
  
  def self.all
    products_all = []
    all = CSV.table(self.data_path, write_headers: true)
    all.each do |i|
      products_all << self.create(id: i[:id], brand: i[:brand], name: i[:product], price: i[:price])
    end
    return products_all
  end
  
  def self.first(num=1)
    return self.all.first if num == 1
    self.all.first(num)
  end
  
  def self.last(num=1)
    return self.all.last if num ==1
    self.all.last(num)
  end
  
  def self.find(id)
    self.all.each do |product|
      if product.id == id
        return product
      end
    end
  end
  
  def self.destroy(id)
    item_removed = self.find(id)
    products = self.all.delete_if { |product| product.id == id }
    self.write_to_db(products)
    return item_removed
  end
  
  def self.data_path
    File.dirname(__FILE__) + "/../data/data.csv"
  end
  
  def self.write_to_db(items)
    CSV.open(self.data_path, "wb") do |csv|
      csv << ["id", "brand", "product", "price"]
      items.each do |i|
        csv << [i.id.to_s, i.brand.to_s, i.name.to_s, i.price.to_s]
      end
    end
  end
  
  def self.where(options={})
    products = []
    self.all.each do |product|
      if product.brand == options[:brand]
        products << product
      elsif product.name == options[:name]
        products << product
      end
    end
    return products
  end
  
  def update options={}
   	@brand, @price = options[:brand], options[:price]
   	data_table = CSV.table(self.class.data_path, write_headers: true)
 		  data_table.each do |row|
   		  if row[:id] == id
   			  row[:brand] = options[:brand]
   			  row[:price] = options[:price]
   		  end
 		  end
 
 		File.open(self.class.data_path, 'w') do |f|
   		f.write(data_table.to_csv)
 		end
 		self
  end
      
    
  
end

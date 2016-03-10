module Analyzable
  
  def self.average_price(items)
    sum = 0
    Product.where(brand: "AverageBrand")
    items.each do |item|
      sum += item.price.to_f
    end
    return (sum / items.size).round(2) if items.size > 0
  end
  
  def print_report(items)
    brands = count_by_brand(items)
    names = count_by_name(items)
    report = "Average price of toys: $#{average_price(items)}\nInventory by Brand:\n"
    brands.each {|brand, size| report << "- #{brand}: #{size}\n"}
    report += "Inventory by Name:\n"
    names.each {|name, size| report << "- #{name}: #{size}\n"}
    return report
  end
  
  def self.count_by_brand(items)
    brands = {}
    items.each do |item|
      brands[item.brand] = 0 unless brands[item.brand]
      brands[item.brand] += 1
    end
    brands
  end
  
  def self.count_by_name(items)
    names = {}
    items.each do |item|
      names[item.name] = 0 unless names[item.name]
      names[item.name] += 1
    end
    names
  end

end

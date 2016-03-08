class Module
  def create_finder_methods(*attributes)
    attributes.each do |attribute|
      new_finder_method = %Q{
        def find_by_#{attribute}(item)
          self.all.find {|product| product.#{attribute} == item }
        end
      }
      class_eval(new_finder_method)
    end
  end
end

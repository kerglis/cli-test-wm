class WimduThorApp < Thor

  desc "new",  "Create a new property"
  def new
    ::PropertyManager.new.run!
  end

  desc "edit", "Edit property"
  def edit(id)
    ::PropertyManager.new(id).run!
  end

  desc "list", "List offers"
  def list
    properties = ::Property.completed

    if properties.present?
      puts "#{properties.size} offers found!"
      properties.each do |property|
        puts property.info_str
      end
    else
      puts "No offers found!"
    end
  end

  desc "incomplete", "List incomplete properties"
  def incomplete
    properties = ::Property.incompleted

    if properties.present?
      puts "#{properties.size} offers found!"
      properties.each do |property|
        puts property.info_str
      end
    else
      puts "No incompleted properties found!"
    end
  end

end

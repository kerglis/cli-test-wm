class PropertyManager

  include ApplicationHelper

  attr_reader :property

  def initialize(property_id = nil)
    @property = get_property_instance(property_id)
  end

  def run!
    Property.user_interface_attributes.each do |key, name|
      if existing_value = @property.send(key)
        existing_value_str = " (#{existing_value})"
      else
        existing_value_str = ""
      end

      loop do
        puts "#{name}#{existing_value_str}: "
        value = $stdin.gets.try(:chomp)

        if value.present?
          if @property.update_attributes({ key => value })
            # no errors
            break
          else
            puts "---> Error: #{@property.errors.full_messages.join("; ")}"
          end
        else
          # no input
          break
        end
      end
    end

    @property.try(:reload)

    state = @property.is_completed? ? "Completed" : "Incompleted"
    puts "Property with ID: #{@property.id} - #{state}"
    puts table_properties(@property)
  end

private

  def get_property_instance(id)
    if id and property = Property.find(id)
      puts "Continuing with property: #{property.id}"
    else
      property = Property.create
      puts "Starting with new property: #{property.id}"
    end
    property
  end

end

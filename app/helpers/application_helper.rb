module ApplicationHelper

  def table_properties(properties)
    properties = [properties] if properties.is_a?(Property)

    table = Text::Table.new
    table.head = Property.keys_for_row
    table.rows = properties.map(&:values_for_row)
    table.to_s
  end

end

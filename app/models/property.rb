class Property < ActiveRecord::Base

  scope :completed, -> { where(is_completed: true) }
  scope :incompleted, -> { where(is_completed: [ false, nil ]) }

  validates :nightly_rate, :max_guests, numericality: { greater_than: 0 }, allow_blank: true
  validates :property_type, inclusion: { in: :property_types_keys }, allow_blank: true

  after_save :update_is_completed

  class << self
    def user_interface_attributes
      {
        title:              'Title',
        property_type_str:  "Property type. #{property_types_str}",
        address:            'Address',
        nightly_rate:       'Nightly rate in EUR',
        max_guests:         'Max guests',
        email:              'Email',
        phone_number:       'Phone number'
      }
    end

    def property_types
      {
        "1" => "Holiday home",
        "2" => "Apartment",
        "3" => "Private room"
      }
    end

    def property_types_str
      property_types.map{|a,b| "#{a} - #{b}"}.join(", ")
    end

    def keys_for_row
      [:id] + user_interface_attributes.keys
    end

  end

  def completed?
    Property.user_interface_attributes.keys.all? do |attr|
      send(attr).present?
    end
  end

  def property_type_str
    Property.property_types[self.property_type]
  end

  def property_type_str=(type_id)
    self.property_type = type_id.to_s
  end

  def property_types_keys
    Property.property_types.keys
  end

  def values_for_row
    Property.keys_for_row.map do |key|
      self.send(key)
    end
  end

private

  def update_is_completed
    update_column(:is_completed, completed?)
  end

end

require "spec_helper"

describe "Wimdu CLI" do
  let(:exe) { File.expand_path('../../bin/wimdu', __FILE__) }

  before do
    Property.delete_all
  end

  describe "new" do
    let(:cmd) { "#{exe} new" }

    it "allows for entering data" do
      expect(Property.completed).to be_empty

      process = run_interactive(cmd)
      expect(process.output).to include("Starting with new property")

      Property.user_interface_attributes.each do |key, name|
        expect(process.output).to include(name)
        type "1"
      end

      expect(Property.completed).to be_present
    end
  end
end

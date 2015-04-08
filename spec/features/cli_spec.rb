require "spec_helper"

describe "WimduThorApp" do

  let(:bin) { File.expand_path(Rails.root.join("bin/wimdu"), __FILE__) }

  describe "new" do
    let(:cmd) { "#{bin} new" }

    it "allows for entering data" do
      expect(Property.completed).to be_empty

      process = run_interactive(cmd)

      expect(process.stdout).to include("Starting with new property")

      Property.user_interface_attributes.each do |key, name|
        expect(process.stdout).to include(name)
      end

      expect(Property.completed).to be_present
    end
  end

end

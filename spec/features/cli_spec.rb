require "spec_helper"

describe "WimduThorApp" do

  let(:bin) { File.expand_path(Rails.root.join("bin/wimdu"), __FILE__) }

  describe "new" do
    let(:cmd) { "#{bin} new" }

    it "allows for entering data" do
      expect(Property.completed).to be_empty
      expect(Property.incompleted).to be_empty

      # Unfortunatelly, I did not succeeded to get run_interactive(cmd) to work properly with Aruba::InProcess :((
      # process = run_interactive(cmd)
      # expect(process.stdout).to include("Starting with new property")
      # Property.user_interface_attributes.each do |key, name|
      #   expect(process.stdout).to include(name)
      #   type "1"
      # end

      output = run_interactive(cmd).stdout

      expect(Property.incompleted).to be_present
      expect(output).to include("Starting with new property")
      expect(output).to include("#{Property.incompleted.first.id}")

    end
  end

  describe "lists" do
    let!(:p1) { Property.create(completed_hash)  }
    let!(:p2) { Property.create({ title: "Just title" }) }

    describe "list" do
      let(:cmd) { "#{bin} list" }

      it "shows only complete properties" do
        output = run_interactive(cmd).stdout
        expect(output).to include(p1.title)
        expect(output).to_not include(p2.title)
      end

    end

    describe "incomplete" do
      let(:cmd) { "#{bin} incomplete" }

      it "shows only incomplete properties" do
        output = run_interactive(cmd).stdout

        expect(output).to_not include(p1.title)
        expect(output).to include(p2.title)
      end
    end
  end

end

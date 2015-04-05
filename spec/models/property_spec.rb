RSpec.describe Property do

  completed_hash = {
      title:              "Title",
      property_type_str:  "1",
      address:            "Address",
      nightly_rate:       40.00,
      max_guests:         4,
      email:              "email@example.com",
      phone_number:       "+1 123 1234 5678"
  }

  describe '#completed?' do
    it 'when the property is completed' do
      expect(described_class.create(completed_hash).completed?).to be_truthy
    end

    it 'when the property is incompleted' do
      expect(described_class.create({ title: "Just title" }).completed?).to be_falsey
    end
  end

  describe ".completed" do
    let!(:p1) { described_class.create(completed_hash)  }
    let!(:p2) { described_class.create({ title: "Just title" }) }

    specify { expect(p1.id).to be_present }
    specify { expect(p2.id).to be_present }

    it "return only completed" do
      expect(described_class.completed).to include(p1)
      expect(described_class.completed).to_not include(p2)
    end

    it "return only incompleted" do
      expect(described_class.incompleted).to_not include(p1)
      expect(described_class.incompleted).to include(p2)
    end
  end

  describe "."

end

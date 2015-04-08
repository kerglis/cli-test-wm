require "spec_helper"

describe Property do

  it { should validate_numericality_of(:nightly_rate) }
  it { should validate_numericality_of(:max_guests) }
  it { should validate_inclusion_of(:property_type).in_array(Property.property_types.keys) }

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

    specify { expect(p1).to be_completed }
    specify { expect(p2).to_not be_completed }

    it "return only completed" do
      expect(described_class.completed).to include(p1)
      expect(described_class.completed).to_not include(p2)
    end

    it "return only incompleted" do
      expect(described_class.incompleted).to_not include(p1)
      expect(described_class.incompleted).to include(p2)
    end
  end

end

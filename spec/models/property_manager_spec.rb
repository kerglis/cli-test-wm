require "spec_helper"

describe PropertyManager do

  let!(:p1) { Property.create(completed_hash)  }
  let!(:p2) { Property.create({ title: "Just title" }) }

  describe "#initialize" do
    subject { PropertyManager.new(id).property }

    context "with existing id" do
      let(:id) { p1.id }
      it { is_expected.to eq p1 }
    end

    context "with no id" do
      let(:id) { nil }
      it { is_expected.to be_present }
    end

    it{ expect { PropertyManager.new(10000) }.to raise_error ActiveRecord::RecordNotFound }
  end

end

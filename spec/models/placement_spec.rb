# frozen_string_literal: true

require "rails_helper"

RSpec.describe Placement, type: :model do
  describe "creative" do
    subject(:placement_creative) { placement.creative }

    let(:placement) do
      described_class.create(
        placement_id: "plc-1",
        floor_price: 12.5
      )
    end

    context "when creative price less than floor price" do
      let!(:creative) do
        Creative.create(
          creative_id: "Video-1",
          price: 12
        )
      end

      it "returns nil" do
        expect(placement_creative).to be_nil
      end
    end

    context "when creative price greater than floor price" do
      let!(:creative) do
        Creative.create(
          creative_id: "Video-1",
          price: 12.7
        )
      end

      it "returns nil" do
        expect(placement_creative).not_to be_nil
      end
    end

    context "when creative price equal to floor price" do
      let!(:creative) do
        Creative.create(
          creative_id: "Video-1",
          price: 12.5
        )
      end

      it "returns nil" do
        expect(placement_creative).not_to be_nil
      end
    end
  end
end

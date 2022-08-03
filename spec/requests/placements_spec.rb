# frozen_string_literal: true

require "rails_helper"

RSpec.describe "placements", type: :request do
  describe "GET /show" do
    let!(:placement) do
      Placement.create(
        placement_id: "plc-1",
        floor_price: 12.5
      )
    end

    context "when placement exist" do
      let!(:creative1) do
        Creative.create(
          creative_id: "Video-1",
          price: 12
        )
      end

      let!(:creative2) do
        Creative.create(
          creative_id: "Video-2",
          price: 13
        )
      end

      it "returns corresponding placement" do
        get "/placements/#{placement.placement_id}"
        expect(json["placement_id"]).to eq(placement.placement_id)
      end

      it "returns placement with creative_2" do
        get "/placements/#{placement.placement_id}"
        expect(json["creative"]["creative_id"]).to eq(creative2.creative_id)
      end

      it "returns placement without creative_1" do
        get "/placements/#{placement.placement_id}"
        expect(json["creative"]["creative_id"]).not_to eq(creative1.creative_id)
      end
    end

    context "when placment has no creative" do
      it "returns corresponding placement without creative" do
        get "/placements/#{placement.placement_id}"
        expect(json["creative"]).to be_nil
      end
    end

    context "when placement does not exist" do
      it "returns failure" do
        get "/placements/test123"
        expect(json["success"]).to be(false)
      end
    end
  end
end

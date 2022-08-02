# frozen_string_literal: true

require "rails_helper"
require "./lib/ad_parameter"
require "./lib/currency_conversion"

RSpec.describe AdParameter do
  describe "parse xml document" do
    let!(:xml) { File.read("dashboard_configurations/sample_configuration.xml") }

    it "extracts creative" do
      object = described_class.new(xml)
      expect(object.creatives.map(&:id)).to include("Video-1")
    end

    it "extracts placements" do
      object = described_class.new(xml)
      expect(object.placements.map(&:id)).to include("plc-1")
    end
  end

  describe "currency_conversion" do
    context "when currency is USD" do
      let(:xml) do
        <<-EOF
          <Creatives>
          <Creative id="Video-4" price="1.1234" currency="USD"/>
          </Creatives>
        EOF
      end

      it "converts to EUR" do
        creative = described_class.new(xml).creatives.first
        expect(creative.price.round(4)).to eq((1.1234 / CurrencyConversion::CONVERSION_RATE["USD"]).round(4))
      end
    end

    context "when currency is SEK" do
      let(:xml) do
        <<-EOF
          <Creatives>
          <Creative id="Video-4" price="1.1234" currency="SEK"/>
          </Creatives>
        EOF
      end

      it "converts to EUR" do
        creative = described_class.new(xml).creatives.first
        expect(creative.price.round(4)).to eq((1.1234 / CurrencyConversion::CONVERSION_RATE["SEK"]).round(4))
      end
    end

    context "when currency is TYR" do
      let(:xml) do
        <<-EOF
          <Creatives>
          <Creative id="Video-4" price="1.1234" currency="TYR"/>
          </Creatives>
        EOF
      end

      it "converts to EUR" do
        creative = described_class.new(xml).creatives.first
        expect(creative.price.round(4)).to eq((1.1234 / CurrencyConversion::CONVERSION_RATE["TYR"]).round(4))
      end
    end
  end

  describe "placement only contains creatives with price greater than floor price" do
    let!(:xml) do
      <<-EOF
        <Creatives>
          <Creative id="Video-4" price="1.1234" currency="EUR"/>
          <Creative id="Video-5" price="3.1234" currency="EUR"/>
        </Creatives>
        <Placements>
          <Placement id="plc-1" floor="2.3456" currency="EUR"/>
        </Placements>
      EOF
    end

    let(:placement) { described_class.new(xml).placements.first }

    it "contains Video-5" do
      expect(placement.creative.map(&:id)).to include("Video-5")
    end

    it "does not contain only Video-4" do
      expect(placement.creative.map(&:id)).not_to include("Video-4")
    end
  end

  describe "serialization" do
    let!(:xml) do
      <<-EOF
        <Placements>
          <Placement id="plc-1" floor="2.3456" currency="EUR"/>
        </Placements>
      EOF
    end

    it "serializes the protobuf object" do
      object = described_class.new(xml)
      expect(object.serialize.class).to eq(String)
    end
  end
end

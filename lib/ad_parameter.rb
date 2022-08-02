# frozen_string_literal: true

require "nokogiri"
require "./lib/definitions/user_configuration_pb"
require "./lib/currency_conversion"

class AdParameter
  include FYBER::Userconfiguration
  include CurrencyConversion

  def initialize(configuration)
    @document = Nokogiri::XML::DocumentFragment.parse(configuration)
  end

  def creatives
    @creatives ||= creative_tags.map do |tag|
      Creative.new(
        id: get_attribute_value(tag, "id"),
        price: convert_to_euro(get_attribute_value(tag, "price"), get_attribute_value(tag, "currency"))
      )
    end
  end

  def placements
    @placements ||= placement_tags.map do |tag|
      floor_price = convert_to_euro(get_attribute_value(tag, "floor"), get_attribute_value(tag, "currency"))
      Placement.new(
        id: get_attribute_value(tag, "id"),
        creative: creatives.filter { |creative| creative.price >= floor_price }
      )
    end
  end

  def placement_sequence
    PlacementSeq.new(placement: placements)
  end

  def serialize
    PlacementSeq.encode(placement_sequence)
  end

  private

  def placement_tags
    @document.css("Placement")
  end

  def creative_tags
    @document.css("Creative")
  end

  def get_attribute_value(tag, attribute)
    tag.attributes[attribute].value
  end
end

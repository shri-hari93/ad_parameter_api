# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "nokogiri"
require "./lib/currency_conversion"

include CurrencyConversion

def create_placement(document)
  placement_tags = document.css("Placement")
  placement_tags.each do |tag|
    placement = Placement.create(
      placement_id: get_attribute_value(tag, 'id'),
      floor_price: convert_to_euro(get_attribute_value(tag, 'floor'), get_attribute_value(tag, 'currency'))
    )
  end
end

def create_creative(document)
  creative_tags = document.css("Creative")
  creative_tags.each do |tag|
    Creative.create(
      creative_id: get_attribute_value(tag, 'id'),
      price: convert_to_euro(get_attribute_value(tag, 'price'), get_attribute_value(tag, 'currency'))
    )
  end
end

def get_attribute_value(tag, attribute)
  tag.attributes[attribute].value
end

case Rails.env
when "development"
  paths = Dir["dashboard_configurations/*.xml"]
  paths.lazy.map { |file_path| File.read(file_path) }.each do |configuration|
    document = Nokogiri::XML::DocumentFragment.parse(configuration)
    create_placement(document)
    create_creative(document)
  end
end


# frozen_string_literal: true

class Placement < ApplicationRecord
  def creative
    Creative.where("price >= :price", price: floor_price).first
  end
end

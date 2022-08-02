# frozen_string_literal: true

class PlacementSerializer < ActiveModel::Serializer
  attributes :id, :placement_id, :floor_price, :creative

  def creative
    ActiveModelSerializers::SerializableResource.new(object.creative, serializer: CreativeSerializer)
  end
end

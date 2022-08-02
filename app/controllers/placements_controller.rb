# frozen_string_literal: true

class PlacementsController < ApplicationController
  def show
    @placement = Placement.find_by(placement_id: params[:placement_id])
    if @placement
      render json: @placement, serializer: PlacementSerializer
    else
      render json: { success: false, error_message: "placement_not_found" }
    end
  end
end

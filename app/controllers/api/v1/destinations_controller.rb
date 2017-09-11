class Api::V1::DestinationsController < ApplicationController

  def index
    render json: Destination.all
  end

  def show
    render json: Destination.find(params[:id])
  end

  def create
    destination = Destination.create!(destination_params)
    if destination.save
      head 201
    else
      head 403
    end
  end

  def update
    destination = Destination.find(params[:id])
    if destination.update(destination_params)
      head 201
    else
      head 403
    end
  end

  def destroy
    destination = Destination.find(params[:id])
    if destination.destroy
      head 201
    else
      head 403
    end
  end

  private

  def destination_params
    params.permit(:name, :zip, :description, :image_url)
  end

end

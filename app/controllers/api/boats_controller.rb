class Api::BoatsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  respond_to :json
  # GET /boats
  # GET /boats.json
  def index
    @boats = Boat.all
    render :json => @boats.as_json
  end
  # POST /boats
  # POST /boats.json
  def create
    @boat = Boat.new(boat_params)
    @boat.save!
    render :json => @boat.as_json
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def boat_params
      params.require(:boat).permit(:capacity, :name)
    end
end

class Api::TimeslotsController < ApplicationController
  include TimeslotsHelper
  skip_before_filter  :verify_authenticity_token
  respond_to :json
  # GET /timeslots
  # GET /timeslots.json
  def index
    date_range = unix_date(params[:date])
    @timeslots = Timeslot.where('start_time >= ? and start_time <= ?', date_range[:beginning_of_day], date_range[:end_of_day])
    # render :json => @timeslots.as_json(only: [])
  end

  # POST /timeslots
  # POST /timeslots.json
  def create
    @timeslot = Timeslot.new(timeslot_params)
    @timeslot.save!
    render :json => @timeslot.as_json
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def timeslot_params
      params.require(:timeslot).permit(:start_time, :duration, :availability, :customer_count)
    end
end

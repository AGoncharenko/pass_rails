class Api::BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  skip_before_filter  :verify_authenticity_token
  respond_to :json

  # POST /bookings
  # POST /bookings.json
  def create
     @booking = Booking.new(booking_params)
     @booking.save!
     current_timeslot = @booking.timeslot
     current_timeslot.customer_count += @booking.size
     current_timeslot.availability!
     current_timeslot.timeslot_xing!

     render :json => true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:timeslot_id, :size)
    end
end

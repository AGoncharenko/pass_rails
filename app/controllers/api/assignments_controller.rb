class Api::AssignmentsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.save!
    timeslot = @assignment.timeslot
    timeslot.availability!

    render :json => true
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:timeslot_id, :boat_id)
    end
end

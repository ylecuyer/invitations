class ImportAttendeesController < ApplicationController

  def destroy
    ImportAttendee.find(params[:id]).destroy
    redirect_to event_import_path(params[:event_id], params[:import_id])
  end

  def edit
    @event = Event.find params[:event_id]
    @import = Import.find params[:import_id]
    @import_attendee = ImportAttendee.find params[:id]
  end

  def update
    @event = Event.find params[:event_id]
    @import = Import.find params[:import_id]
    @import_attendee = ImportAttendee.find params[:id]
    if @import_attendee.update(import_attendee_params)
      redirect_to event_import_path(@event, @import) 
    else
      render :edit
    end
  end

  private

  def import_attendee_params
      params.require(:import_attendee).permit(:last_name, :first_name, :email)
  end

end

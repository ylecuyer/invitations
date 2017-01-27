class ImportsController < ApplicationController

  def show
    @event = Event.find params[:event_id]
    @import = Import.find(params[:id])
  end

  def terminate

    @event = Event.find params[:event_id]
    @import = Import.find(params[:import_id])

    @import.import_attendees.each do |import_attendee|

      if import_attendee.status == 'OK'
        Attendee.create(first_name: import_attendee.first_name, last_name: import_attendee.last_name, email: import_attendee.email, service: @import.service, event: @event)
      end

    end
 
    redirect_to event_attendees_path(@event)

  end

end

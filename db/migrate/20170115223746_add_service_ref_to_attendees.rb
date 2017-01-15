class AddServiceRefToAttendees < ActiveRecord::Migration[5.0]
  def change
    add_reference :attendees, :service, foreign_key: true
  end
end

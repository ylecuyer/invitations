class AddImportToImportAttendee < ActiveRecord::Migration[5.0]
  def change
    add_reference :import_attendees, :import, foreign_key: true
  end
end

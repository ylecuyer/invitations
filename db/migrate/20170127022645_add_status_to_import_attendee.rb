class AddStatusToImportAttendee < ActiveRecord::Migration[5.0]
  def change
    add_column :import_attendees, :status, :string
  end
end

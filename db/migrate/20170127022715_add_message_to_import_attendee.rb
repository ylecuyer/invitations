class AddMessageToImportAttendee < ActiveRecord::Migration[5.0]
  def change
    add_column :import_attendees, :message, :string
  end
end

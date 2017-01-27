class Import < ApplicationRecord

  belongs_to :service
  has_many :import_attendees, -> { order(:status) }

end

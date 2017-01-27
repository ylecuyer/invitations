class Attendee < ApplicationRecord

  before_create :save_reference

  belongs_to :event
  belongs_to :service

  #validate :not_yet_invited

  def full_name
    "#{last_name} #{first_name}"
  end

  private

  def save_reference
    loop do
      reference = generate_reference
      unless Attendee.where(reference: reference).first
        self.reference = reference
        break
      end
    end
  end

  def generate_reference(size = 6)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end

  def not_yet_invited
    attendee = Attendee.where(email: self.email, event_id: self.event.id).first
    errors.add(:base, 'This attendee has already been invited by : ' + attendee.service.name)
  end


end

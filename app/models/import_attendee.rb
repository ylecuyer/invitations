class ImportAttendee < ApplicationRecord

  belongs_to :import
  before_save :set_status
  
  def css_class
    return "success" if self.status == 'OK'
    return "danger" if self.status == 'NOK'
    ""
  end

  private

  def set_status

    self.status = 'OK'

    if self.first_name.blank?
      self.status = 'NOK'
      self.message = "First name can't be empty"
    end 

    if self.last_name.blank?
      self.status = 'NOK'
      self.message = "Last name can't be empty"
    end 
     
    if self.email.blank?
      self.status = 'NOK'
      self.message = "Email can't be empty"
    end 
     
    unless EmailValidator.valid?(self.email)
      self.status = 'NOK'
      self.message = "Email is malformed"
    end

  end
end

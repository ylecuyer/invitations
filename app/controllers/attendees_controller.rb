class AttendeesController < ApplicationController

  before_action :set_event
  
  def index
    @attendees = Attendee.order(id: :desc).all
  end

  def create
    attendee = Attendee.new(attendee_params)
    
    attendee.event = @event
  
    attendee.save

    redirect_to event_attendees_path(@event)

  end

  def import
    file = params[:file]
    @file_name = file.original_filename
  
    open_uploaded_file
    check_file
    @rows = get_rows

  end

  private

  def get_rows

    attendees = []

    (2..@spreadsheet.last_row).map do |row_number|
      row = get_row(row_number)
      
      attendees << row
    end

    attendees
  end

  def open_uploaded_file
    get_spreadsheet
    get_header_from_spreadsheet
  end

  def check_file
    check_header @header
    check_rows @spreadsheet
  end

  def check_rows(spreadsheet)
    (2..@spreadsheet.last_row).map do |row_number|
      check_row(row_number, get_row(row_number))
    end
  end

  def get_row(row_number)
      Hash[[@header, @spreadsheet.row(row_number)].transpose]
  end

  def check_row(row_number, row_data)
    raise "first_name can't be empty in row ##{row_number}" if row_data["first_name"].blank?
    raise "last_name can't be empty in row ##{row_number}" if row_data["last_name"].blank?
    raise "email can't be empty in row ##{row_number}" if row_data["email"].blank?
    raise "email(#{row_data["email"]}) is malformed in row ##{row_number}" unless EmailValidator.valid?(row_data["email"])
  end

  def check_header(header)
    required_fields = ["first_name", "last_name", "email"]

    required_fields.each do |field|
       raise "Missing field: #{field}" unless header.include? field 
    end
  end

  def get_spreadsheet
    @spreadsheet = Roo::Spreadsheet.open(params[:file])
  end

  def get_header_from_spreadsheet
    @header = @spreadsheet.row(1)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def attendee_params
    params.require(:attendee).permit(:service_id, :first_name, :last_name, :email)
  end

end

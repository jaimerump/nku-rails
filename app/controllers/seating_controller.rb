class SeatingController < ApplicationController
  
  def index
    # Get the students in each seat
    @selected_date = params[:selected_date] || Date.today
    @in_seat_1 = Student.in_seat(1, @selected_date)
    @in_seat_2 = Student.in_seat(2, @selected_date)
    @in_seat_3 = Student.in_seat(3, @selected_date)
    @in_seat_4 = Student.in_seat(4, @selected_date)
    @absent = Student.absent(@selected_date)
  end
  
end
class AttendancesController < ApplicationController
  
  def index
  end
  
  def new
    # Make sure they're logged in
    @current_student = get_current_student
    
    if !@current_student
      redirect_to login_page_path
    end
    
    @attendance = Attendance.new
  end
  
  def create
    # Make sure they're logged in
    @current_student = get_current_student
    
    if !@current_student
      redirect_to login_page_path
    end
    
    # Record the attendance
    @attendance = Attendance.new(attendance_params)
    if @attendance.save
      # Send them to the index page
      redirect_to attendances_path, notice: "Attendance successfully recorded!"
    else
      redirect_to 'new'
    end
  end

  private
  def attendance_params
    current_student = get_current_student
    params.require(:attendance).require(:seat)
    params[:attendance][:student_id] = current_student.id
    params[:attendance][:attended_on] = Date.today
  end
  
end
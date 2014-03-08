class AttendancesController < ApplicationController
  
  def index
    @current_student = get_current_student
    # Check if a student is specified
    if( params[:student_id] )
      # Get all of this student's attendances
      @selected_student = Student.find( params[:student_id] )
      @attendances = @selected_student.attendances
    else
      # Show all attendances
      @attendances = Attendance.all
    end
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
      render 'new'
    end
  end

  private
  def attendance_params
    current_student = get_current_student
    params[:attendance][:student_id] = current_student.id
    params[:attendance][:attended_on] = Date.today
    params.require(:attendance).permit(:seat, :student_id, :attended_on)
    
  end
  
end
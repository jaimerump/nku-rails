class AssignmentsController < ApplicationController
  
  def index
    # Displays all assignments for the given student, or for all students
    @current_student = get_current_student
    @students = Student.all

    if( @current_student.is_admin? )
      # Admin can see all
      if( params[:student_id] )
        # Fetch this student's assignments
        @selected_student = Student.find(params[:student_id])
        @assignments = @selected_student.assignments
        @average = Assignment.average_percentage(params[:student_id])
      else
        # Fetch all assignments
        @assignments = Assignment.all
        @average = Assignment.average_percentage
      end
      
    else 
      # Student can only see their grades
      @selected_student = @current_student
      @assignments = @current_student.assignments
      @average = Assignment.average_percentage(@selected_student.id)
    end
    
  end
  
  def new
    # Allows admins to create new assignments
    @current_student = get_current_student
    if( !@current_student.is_admin? )
      redirect_to students_path, notice: "Unauthorized!"
    end
    
    @assignment = Assignment.new
    @students = Student.all
    
  end
  
  def create
    # Processes the new assignment form
    current_student = get_current_student
    if( !current_student || !current_student.is_admin? )
      redirect_to students_path, notice: "Unauthorized!"
    end
    
    # Create the assignment
    @assignment = Assignment.new(assignment_params)
    if @assignment.save
      # Send them to the index page
      redirect_to assignments_path, notice: "Assignment successfully recorded!"
    else
      render 'new'
    end
  end
  
  def upload
    # Allows admin to upload csv file of assignments
    @current_student = get_current_student
    if( !@current_student.is_admin? )
      redirect_to assignments_path, notice: "Unauthorized!"
    end
  end
  
  def process_upload
    # Allows admin to upload csv file of assignments
    @current_student = get_current_student
    if( !@current_student.is_admin? )
      redirect_to assignments_path, notice: "Unauthorized!"
    end
    
    # Read in the file
    require 'csv'
    file = params[:csv]
    AssignmentUploader.upload_file(file)
    
    redirect_to assignments_path, notice: "Uploaded!"
  end
  
  private
  def assignment_params
    params.require(:assignment).permit(:student_id, :name, :score, :total)
  end
  
end
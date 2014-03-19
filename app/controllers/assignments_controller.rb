class AssignmentsController < ApplicationController
  
  def index
    # Displays all assignments for the given student, or for all students
    @current_student = get_current_student
    @selected_student = @current_student
    @assignments = Assignment.all
=begin
    if( @current_student.is_admin? )
      # Admin can see all
      if( params[:student_id] )
        # Fetch this student's assignments
        @selected_student = Student.find(params[:student_id])
        @assignments = @selected_student.assignments
      else
        # Fetch all assignments
        @assignments = Assignments.all
      end
      
    else 
      # Student can only see their grades
      
      if( !params[:student_id] || @current_student.id != params[:student_id] )
        # They're trying to see grades that aren't theirs
        redirect_to students_path, notice: "You can't see someone else's grades!"
      else
        # They're good, fetch their assignments
        @selected_student = @current_student
        @assignments = @current_student.assignments
      end
      
    end
=end
    
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
  
  private
  def assignment_params
    params.require(:assignment).permit(:student_id, :name, :score, :total)
  end
  
end
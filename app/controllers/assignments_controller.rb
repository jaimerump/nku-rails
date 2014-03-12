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
  
end
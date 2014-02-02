class SessionsController < ApplicationController
  
  def index
    # Displays the login page
    
    # Make sure they're not already logged in
    current_student = get_current_student
    if( current_student != nil )
      redirect_to students_path
    end
    
    # Create blank student for form to use
    @student = Student.new
    
  end
  
  def login
    # Processes the login form
    
    @student = Student.find_by_email(params[:student][:email])
    
    if( @student && @student.authenticate( params[:student][:password] ) )
      # Log them in
      session[:student_id] = @student.id
      redirect_to students_path
    else
      # Credentials were invalid
      @student = Student.new
      flash.now.notice = "Invalid email or password"
      render 'index'
    end
    
  end
  
  def logout
    # Clear their session and redirect
    session[:student_id] = nil
    redirect_to login_page_path
  end
  
end

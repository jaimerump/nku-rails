class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def get_current_student
    # Returns the currently logged in student
    if( session[:student_id] == nil )
      return nil
    end
    return Student.find( session[:student_id] )
  end
  
end

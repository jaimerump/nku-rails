class StudentsController < ApplicationController
  
  def index
     @current_student = get_current_student
    # Get the students in each seat
    @selected_date = params[:selected_date] || Date.today
    @in_seat_1 = Student.in_seat(1, @selected_date)
    @in_seat_2 = Student.in_seat(2, @selected_date)
    @in_seat_3 = Student.in_seat(3, @selected_date)
    @in_seat_4 = Student.in_seat(4, @selected_date)
    @absent = Student.absent(@selected_date)
  end
  
  #Student Creation actions
  
  def new
    # Make sure they're not already logged in
    @current_student = get_current_student
    if( @current_student != nil )
      redirect_to students_path
    end
      
    @student = Student.new
  end
  
  def create
    
    # Make sure they're not already logged in
    @current_student = get_current_student
    if( @current_student != nil )
      redirect_to students_path
    end
    
    #Check for email, add placeholder if missing
    if( params[:student][:email].empty? )
      params[:student][:email] = "placeholder@example.com"
    end
    
    #Check for image, consult Gravatar if missing
    if( params[:student][:image_url].empty? )
      require 'digest/md5'
      email_address = params[:student][:email].downcase
      hash = Digest::MD5.hexdigest(email_address)
      params[:student][:image_url] = "http://www.gravatar.com/avatar/#{hash}"
    end
    
    @student = Student.new(student_params)
    if @student.save
        
      # Log them in
      session[:student_id] = @student.id
        
      redirect_to students_path, notice: "Student successfully added!"
    else
      redirect_to 'new'
    end
  end
  
  #Student Update actions
  
  def edit
    @current_student = get_current_student
    @student = Student.find(params[:id])
    
    if( @current_student == nil )
      # They're not logged in
      redirect_to students_path, notice: "You must be logged in to edit your info."
    elsif( @current_student.id != @student.id )
      # They can't edit someone else's profile
      redirect_to students_path, notice: "You can't edit someone else's info!"
    end
    
  end
  
  def update
    @current_student = get_current_student
    @student = Student.find(params[:id])
    
    if( @current_student == nil )
      # They're not logged in
      redirect_to students_path, notice: "You must be logged in to edit your info."
    elsif( @current_student.id != @student.id )
      # They can't edit someone else's profile
      redirect_to students_path, notice: "You can't edit someone else's info!"
    end
  
    #Check for email, add placeholder if missing
    if( params[:student][:email].empty? )
      params[:student][:email] = "placeholder@example.com"
    end
    
    #Check for image, consult Gravatar if missing
    if( params[:student][:image_url].empty? )
      require 'digest/md5'
      email_address = params[:student][:email].downcase
      hash = Digest::MD5.hexdigest(email_address)
      params[:student][:image_url] = "http://www.gravatar.com/avatar/#{hash}"
    end
    
    if @student.update(student_params)
      redirect_to students_path, notice: "Student successfully updated!"
    else
      render 'edit'
    end
  end

  private
  def student_params
    params.require(:student).permit(:name, :nickname, :email, :image_url, :password, :password_confirmation)
  end
    
end
 

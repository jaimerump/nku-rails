class StudentsController < ApplicationController
  
  def index
    @students = Student.all
  end
  
  #Student Creation actions
  
  def new
    @student = Student.new
  end
  
  def create
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
    @student.save
    redirect_to students_path, notice: "Student successfully added!"
  end
  
  #Student Update actions
  
  def edit
    @student = Student.find(params[:id])
  end
  
  def update
    @student = Student.find(params[:id])
  
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

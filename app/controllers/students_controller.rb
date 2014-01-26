class StudentsController < ApplicationController
  
  def index
    @students = Student.all
  end
  
  def new
    @student = Student.new
  end
  
  def create
    @student = Student.new(params[:student].permit!)
    @student.save
    redirect_to students_path
  end
  
end

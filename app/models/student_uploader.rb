class StudentUploader
  # Allows an admin to upload records from a csv file
  
  def self.upload_file(file)
 
    # Process the contents
    CSV.foreach(file.path, :headers => true) do |record|
     
      upload_student(record)
      
    end
    
  end
  
  def self.upload_student(student_array)
    # Uploads the given student
    student = Student.new
    student.email = student_array['email']
    student.name = student_array['name']
    student.nickname = student_array['nickname']
    student.image_url = student_array['image_url']
    student.password = student_array['password']
    student.password_confirmation = student_array['password']
    student.save!
    
  end
  
end
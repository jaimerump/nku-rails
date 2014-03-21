class StudentUploader
  # Allows an admin to upload records from a csv file
  
  @@email_index
  @@name_index
  @@nickname_index
  @@image_index
  @@password_index
  
  def self.upload_file(file)
  
    records = CSV.read(file.path)
    
    # Define indicies
    @@email_index = 0 #records[0].index("email")
    @@name_index = 2 #records[0].index("name")
    @@nickname_index = 1 #records[0].index("nickname")
    @@image_index = 3 #records[0].index("image_url")
    @@password_index = 4 #records[0].index("password")
    
    # Process the contents
    records.each do |record|
      # Skip
      if record == records[0]
        next
      end
      
      upload_student(record)
      
    end
    
  end
  
  def self.upload_student(student_array)
    # Uploads the given student
    student = Student.new
    student.email = student_array[@@email_index]
    student.name = student_array[@@name_index]
    student.nickname = student_array[@@nickname_index]
    student.image_url = student_array[@@image_index]
    student.password = student_array[@@password_index]
    student.password_confirmation = student_array[@@password_index]
    student.save!
    
  end
  
end
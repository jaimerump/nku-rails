class AssignmentUploader
  # Allows an admin to upload records from a csv file
  
  def self.upload_file(file)
 
    # Process the contents
    CSV.foreach(file.path, :headers => true) do |record|
     
      upload_assignment(record)
      
    end
    
  end
  
  def self.upload_assignment(assignment_array)
    # Uploads the given assignment or alters existing one
    email = assignment_array['email']
    name = assignment_array['assignment_name']
    
    student = Student.find_by_email(email)
    assignments = Assignment.where("student_id = ? AND name = ?", student.id, name)
    if assignments.size == 0
      assignment = Assignment.new
      assignment.student = student
      assignment.name = name
    else
      assignment = assignments[0]
    end
    
    assignment.total = assignment_array['total']
    assignment.score = assignment_array['score']
    assignment.save!
    
  end
  
end
class Assignment < ActiveRecord::Base
  belongs_to :student
  
  def percentage
    ( score * 100 ) / total
  end
  
  def self.average_percentage
    # Gets average across all assignments
    
    # Get all assignments
    assignments = all
    
    # Sum up percentages
    percentage_sum = 0
    assignments.each{ |a| percentage_sum += a.percentage }
    
    # Get average percentage
    percentage_sum / assignments.size
    
  end
  
end
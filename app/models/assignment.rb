class Assignment < ActiveRecord::Base
  belongs_to :student
  
  validates :score, numericality: { only_integer: true,
    greater_than_or_equal_to: 0 }
  validates :total, numericality: { only_integer: true,
    greater_than_or_equal_to: 0 }
  
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
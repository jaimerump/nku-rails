require 'spec_helper'

describe Assignment do
  describe "#percentage" do
    specify do
      assignment = Assignment.new(score: 5, total: 10)
      expect(assignment.percentage).to eq(50)
    end
  end
 
  describe ".average" do
    specify do
      assignment1 = Assignment.create(score: 8, total: 10)
      assignment2 = Assignment.create(score: 4, total: 10)
      expect(Assignment.average_percentage).to eq(60)
    end
  end
end
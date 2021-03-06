require 'spec_helper'

describe Student do
  let(:now) { Date.today }

  # Define in_seat test
  describe ".in_seat" do
    
    # Define 3 students
    let!(:student_in_seat_1) do
      attendance = create(:attendance, attended_on: now, seat: 1)
      create(:student, attendances: [attendance])
    end

    
    let!(:student_in_seat_2) do
      attendance = create(:attendance, attended_on: now, seat: 2)
      create(:student, attendances: [attendance])
    end

    let!(:absent_student) do
      attendance = create(:attendance, attended_on: now - 1.day, seat: 1)
      create(:student, attendances: [attendance])
    end

    # Execute test
    specify do
      students = Student.in_seat(1, now)
      # Assertions
      expect(students).to include(student_in_seat_1)
      expect(students).to_not include(student_in_seat_2)
      expect(students).to_not include(absent_student)
    end
  end

  describe ".absent" do
    let!(:present_student) do
      attendance = create(:attendance, attended_on: now, seat: 1)
      create(:student, attendances: [attendance])
    end

    let!(:absent_student) do
      attendance = create(:attendance, attended_on: now - 1.day, seat: 1)
      create(:student, attendances: [attendance])
    end

    specify do
      students = Student.absent(now)
      expect(students).to include(absent_student)
      expect(students).to_not include(present_student)
    end
  end
end
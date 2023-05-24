class Course
  attr_reader :name,
              :capacity,
              :students,
              :grades

  def initialize(name, capacity)
    @name = name
    @capacity = capacity
    @students = []
    @grades = []
  end

  def full?
    students.length == capacity
  end

  def enroll(student)
    if !full?
      students << student 
    else
      "Sorry - Class is full!"
    end
  end

  def capture_grades
    students.each do |student|
      grades << student.grade if !student.grade.nil?
    end
  end
end

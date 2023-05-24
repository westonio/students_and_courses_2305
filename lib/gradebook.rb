class Gradebook
  attr_reader :instructor,
              :courses
  
  def initialize(instructor)
    @instructor = instructor
    @courses = []
  end

  def add_course(course)
    courses << course
  end

  def list_all_students
    list = {}
    courses.map do |course|
      list[course.name.to_sym] = course.students
    end
    list
  end

  def students_below(threshold)
    courses.map do |course|
      course.students.select do |student| 
        student if student.grade < threshold
      end
    end.flatten
  end

  def all_grades
    list = {}
    courses.map do |course|
      course.capture_grades
      list[course.name.to_sym] = course.grades
    end
    list
  end
end

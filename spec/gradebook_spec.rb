require 'rspec'
require './lib/gradebook'
require './lib/course'
require './lib/student'

RSpec.describe Gradebook do 
  before(:each) do
    @gradebook = Gradebook.new("Professor Snape")
    @calculus = Course.new("Calculus", 2)
    @physics = Course.new("Physics", 4)
  end

  it 'exists' do
    expect(@gradebook).to be_a(Gradebook)
  end

  it 'has an instructor' do
    expect(@gradebook.instructor).to eq("Professor Snape")
  end

  it 'starts with no courses, but can list them' do
    expect(@gradebook.courses).to eq([])
  end

  it 'can add courses' do
    @gradebook.add_course(@calculus)
    @gradebook.add_course(@physics)

    expect(@gradebook.courses).to eq([@calculus, @physics])
  end

  it 'can list all students by course' do
    @gradebook.add_course(@calculus)
      morgan = Student.new({name: "Morgan", age: 21})
      jordan = Student.new({name: "Jordan", age: 29})
      @calculus.enroll(morgan)
      @calculus.enroll(jordan)
    @gradebook.add_course(@physics)
      frank = Student.new({name: "Frank", age: 34})
      heather = Student.new({name: "Heather", age: 25})
      sharon = Student.new({name: "Sharon", age: 27})
      @physics.enroll(frank)
      @physics.enroll(heather)
      @physics.enroll(sharon)

    expected = {:Calculus => [morgan, jordan], :Physics => [frank, heather, sharon]}
    expect(@gradebook.list_all_students).to eq(expected)
  end

  it 'can list students below grade threshold' do
    @gradebook.add_course(@calculus)
      morgan = Student.new({name: "Morgan", age: 21})
      jordan = Student.new({name: "Jordan", age: 29})
      @calculus.enroll(morgan)
      @calculus.enroll(jordan)
      morgan.log_score(98)
      jordan.log_score(67)
    @gradebook.add_course(@physics)
      frank = Student.new({name: "Frank", age: 34})
      heather = Student.new({name: "Heather", age: 25})
      sharon = Student.new({name: "Sharon", age: 27})
      @physics.enroll(frank)
      @physics.enroll(heather)
      @physics.enroll(sharon)
      frank.log_score(74)
      heather.log_score(96)
      sharon.log_score(83)

    expect(@gradebook.students_below(70)).to eq([jordan])
    expect(@gradebook.students_below(80)).to eq([jordan, frank])
    expect(@gradebook.students_below(90)).to eq([jordan, frank, sharon])
  end

  it 'can list all grades by course' do
    @gradebook.add_course(@calculus)
      morgan = Student.new({name: "Morgan", age: 21})
      jordan = Student.new({name: "Jordan", age: 29})
      @calculus.enroll(morgan)
      @calculus.enroll(jordan)
      morgan.log_score(98)
      jordan.log_score(67)
    @gradebook.add_course(@physics)
      frank = Student.new({name: "Frank", age: 34})
      heather = Student.new({name: "Heather", age: 25})
      sharon = Student.new({name: "Sharon", age: 27})
      @physics.enroll(frank)
      @physics.enroll(heather)
      @physics.enroll(sharon)
      frank.log_score(74)
      heather.log_score(96)
      sharon.log_score(83)

      expected = {:Calculus => [98.0,67.0], :Physics => [74, 96,83]}
      expect(@gradebook.all_grades).to eq(expected)
  end

  it 'can list students with grades within a range' do
    @gradebook.add_course(@calculus)
      morgan = Student.new({name: "Morgan", age: 21})
      jordan = Student.new({name: "Jordan", age: 29})
      @calculus.enroll(morgan)
      @calculus.enroll(jordan)
      morgan.log_score(98)
      jordan.log_score(67)
    @gradebook.add_course(@physics)
      frank = Student.new({name: "Frank", age: 34})
      heather = Student.new({name: "Heather", age: 25})
      sharon = Student.new({name: "Sharon", age: 27})
      @physics.enroll(frank)
      @physics.enroll(heather)
      @physics.enroll(sharon)
      frank.log_score(74)
      heather.log_score(96)
      sharon.log_score(83)


      expect(@gradebook.students_in_range(90,100)).to eq([morgan, heather])
      expect(@gradebook.students_in_range(75,90)).to eq([sharon])
      expect(@gradebook.students_in_range(65,75)).to eq([jordan,frank])
      expect(@gradebook.students_in_range(70,100)).to eq([morgan,frank,heather,sharon])
  end
end
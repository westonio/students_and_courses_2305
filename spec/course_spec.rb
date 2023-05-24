require 'rspec'
require './lib/course'
require './lib/student'

RSpec.describe Course do 
  before(:each) do
    @course = Course.new("Calculus", 2)
  end

  it 'exists' do
    expect(@course).to be_a(Course)
  end

  it 'has a name' do
    expect(@course.name).to eq('Calculus')
  end

  it 'has a capacity' do
    expect(@course.capacity).to eq(2)
  end

  it 'starts with no students and can list them' do
    expect(@course.students).to eq([])
  end

  it 'starts not full (not at capacity)' do
    expect(@course.full?).to be(false)
  end

  it 'can enroll students' do
    student1 = Student.new({name: "Morgan", age: 21})
    student2 = Student.new({name: "Jordan", age: 29}) 

    @course.enroll(student1)
    @course.enroll(student2)

    expect(@course.students).to eq([student1, student2])
  end

  it 'once capacity is hit, course is full' do
    student1 = Student.new({name: "Morgan", age: 21})
    student2 = Student.new({name: "Jordan", age: 29}) 

    @course.enroll(student1)
    @course.enroll(student2)

    expect(@course.full?).to be(true)
  end

  it 'returns error if trying to enrolls student past capacity' do
    student1 = Student.new({name: "Morgan", age: 21})
    student2 = Student.new({name: "Jordan", age: 29})
    student3 = Student.new({name: "Fransisco", age: 25})

    @course.enroll(student1)
    @course.enroll(student2)
    
    expect(@course.enroll(student3)).to eq("Sorry - Class is full!")
  end
end
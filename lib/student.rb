class Student

  attr_reader :name, 
              :age,
              :scores
 
  def initialize(info)
    @name = info[:name]
    @age = info[:age]
    @scores = []
  end

  def log_score(score)
    scores << score
  end

  def grade
    num_scores = scores.length
    sum = scores.sum
    sum.to_f / num_scores
  end
end

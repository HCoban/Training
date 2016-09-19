class Question < ActiveRecord::Base
  has_many(
    :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice
  )

  belongs_to(
    :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  has_one(
    :author,
    through: :poll,
    source: :author
  )

  def results_n1
    results = Hash.new(0)

    responses.each do |response|
      results[response.answer_choice.body] += 1
    end

    results
  end

  def results_1
    responses = self.responses.includes(:answer_choice)
    results = Hash.new(0)

    responses.each do |response|
      results[response.answer_choice.body] += 1
    end

    results
  end

  def results
    # <<-SQL
    #   SELECT
    #     answer_choices.body, COUNT(*)
    #   FROM questions
    #   JOIN answer_choices
    #     ON answer_choices.question_id = questions.id
    #   JOIN responses
    #     ON responses.choice_id = answer_choices.id
    #   WHERE questions.id = ?
    #   GROUP BY answer_choices.body
    # SQL

    results = {}
    answer_choices = self
      .answer_choices
      .select("answer_choices.body, COUNT(*) AS count")
      .joins(:responses)
      .group("answer_choices.body")
      .each { |choice| results[choice.body] = choice.count }
    results
  end
end

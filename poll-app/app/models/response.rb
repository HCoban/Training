class Response < ActiveRecord::Base
  belongs_to(
    :answer_choice,
    primary_key: :id,
    foreign_key: :choice_id,
    class_name: :AnswerChoice
  )

  belongs_to(
    :respondent,
    primary_key: :id,
    foreign_key: :respondent_id,
    class_name: :User
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  validate :not_question_author, :not_duplicate_response

  def not_duplicate_response
    if sibling_responses.exists?({ respondent_id: self.respondent_id })
      errors[:respondant_id] << "User has already responded to this question."
    end
  end

  def sibling_responses
    question.responses.where.not(id: self.id)
  end

  def not_question_author
    if self.respondent_id == question.author.id
      errors[:respondent_id] << "Author cannot respond to own question."
    end
  end
end

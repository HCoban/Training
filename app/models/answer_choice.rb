class AnswerChoice < ActiveRecord::Base
  belongs_to(
    :question,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :Question
  )

  has_many(
    :responses,
    primary_key: :id,
    foreign_key: :choice_id,
    class_name: :Response
  )

  has_one(
    :author,
    through: :question,
    source: :author
  )
end

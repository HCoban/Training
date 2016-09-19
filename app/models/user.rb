class User < ActiveRecord::Base
  has_many(
    :authored_polls,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Poll
  )

  has_many(
    :responses,
    primary_key: :id,
    foreign_key: :respondent_id,
    class_name: :Response
  )

  def completed_polls
    polls = ActiveRecord::Base.connection.execute(<<-SQL, self.id)
      SELECT this_poll.title
      FROM polls AS this_poll
      JOIN questions
        ON questions.poll_id = this_poll.id
      JOIN answer_choices
        ON answer_choices.question_id = questions.id
      JOIN responses
        ON responses.choice_id = answer_choices.id
      WHERE responses.respondent_id = 2
      GROUP BY this_poll.title
      HAVING COUNT(*) = (
        SELECT COUNT(*)
        FROM polls
        JOIN questions
          ON questions.poll_id = polls.id
        WHERE polls.title = this_poll.title
      );
    SQL

    polls.map { |poll| poll["title"] }

  end
end

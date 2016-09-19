class QuestionFollow < QuestionsDBMB

  attr_accessor :id, :user_id, :question_id

  def self.all
    super('question_follows')
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.find_by_id(id)
    super(id, 'question_follows')
  end

  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      users.id, fname, lname
    FROM
      question_follows JOIN users
      ON users.id = question_follows.user_id
    WHERE
      question_follows.question_id = ?
    SQL

    return nil if followers.empty?

    followers.map { |follower| User.new(follower) }

  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      q.id, q.title, q.body, q.author_id
    FROM
      question_follows AS qf JOIN questions AS q
      ON qf.user_id = q.author_id
    WHERE
      qf.user_id = ?
    SQL

    return nil if questions.empty?

    questions.map { |question| Question.new(question) }
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      q.id, q.title, q.body, q.author_id
    FROM
      questions AS q
      JOIN question_follows AS qf
      ON q.id = qf.question_id
    GROUP BY
      -- q.id, q.title, q.body, q.author_id, qf.user_id
      qf.user_id
    ORDER BY
      COUNT(qf.user_id) DESC
    LIMIT
      ?
    SQL

    questions.map { |question| Question.new(question)}
  end
end

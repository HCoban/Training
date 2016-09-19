class QuestionLike < QuestionsDBMB
  attr_accessor :id, :user_id, :question_id

  def self.all
    super('question_likes')
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def self.find_by_id(id)
    super(id, 'question_likes')
  end

  def self.likers_for_question_id(question_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      u.id, u.fname, u.lname
    FROM
      users AS u
      JOIN question_likes as ql ON ql.user_id = u.id
    WHERE
      ql.question_id = ?
    SQL

    return nil if users.empty?

    users.map { |user| User.new(user) }
  end

  def self.num_likes_for_question_id(question_id)
    count = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      COUNT(*) AS count
    FROM
      users AS u
      JOIN question_likes as ql ON ql.user_id = u.id
    WHERE
      ql.question_id = ?
    SQL
    return 0 if count.empty?

    count.first['count']
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      q.id, q.title, q.body, q.author_id
    FROM
      questions AS q
      JOIN question_likes AS ql ON q.id = ql.question_id
    WHERE
      ql.user_id = ?
    SQL
    return nil if questions.empty?

    questions.map { |question| Question.new(question) }
  end


  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      q.id, q.title, q.body, q.author_id
    FROM
      questions AS q
      JOIN question_likes AS ql
      ON q.id = ql.question_id
    GROUP BY
      -- q.id, q.title, q.body, q.author_id, qf.user_id
      ql.user_id
    ORDER BY
      COUNT(ql.user_id) DESC
    LIMIT
      ?
    SQL

    questions.map { |question| Question.new(question)}
  end
end

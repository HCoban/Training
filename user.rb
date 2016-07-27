class User < QuestionsDBMB
  attr_accessor :id, :fname, :lname

  def self.all
    super('users')
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def save
    if @id
      QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
        UPDATE
          users
        SET
          fname = ?, lname = ?
        WHERE
          id = ?
      SQL

    else
      QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

  def self.find_by_id(id)
    super(id, 'users')
  end

  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    SELECT
      *
    FROM
      users
    WHERE
      fname = ? AND lname = ?
    SQL
    return nil if user.empty?

    User.new(user.first)
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    average = QuestionsDatabase.instance.execute(<<-SQL, @id)
    SELECT
      ROUND((CAST(COUNT(ql.id) AS FLOAT) / COUNT(DISTINCT(q.id))), 2) AS av
    FROM
      questions AS q
      LEFT OUTER JOIN question_likes as ql ON q.id = ql.question_id
    WHERE
      q.author_id = ? AND q.id
    SQL

    return average.first['av']
  end
end

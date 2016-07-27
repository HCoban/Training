
class QuestionsDBMB
  def self.find_by_id(id, table)

    sql_string = "SELECT
          *
        FROM
          #{table}
        WHERE
          id = ?"

    result = QuestionsDatabase.instance.execute(sql_string, id)

    return nil if result.empty?

    self.new(result.first)
  end

  def self.all(table)
    data = QuestionsDatabase.instance.execute("SELECT * FROM #{table}")
    data.map { |datum| QuestionFollow.new(datum) }
  end
end

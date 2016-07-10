class Student
  attr_reader :name, :grade, :id
  def initialize(name, grade)
    @name = name
    @grade = grade
  end
  def self.create_table
    DB[:conn].execute("CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade TEXT);")
  end
  def self.drop_table
    DB[:conn].execute("DROP TABLE students;")
  end
  def self.create(name:, grade:)
    student = self.new(name, grade)
    student.save
    student
  end
  def save
    DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?, ?);",@name,@grade)
    @id = DB[:conn].execute("SELECT id FROM students ORDER BY id DESC LIMIT 1;")[0][0]
  end
end

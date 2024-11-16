require 'minitest/autorun'
require 'minitest/reporters'

require_relative '../students'

unless ENV['RM_INFO']
Minitest::Reporters.use! [
                           Minitest::Reporters::SpecReporter.new,
                           Minitest::Reporters::HtmlReporter.new(
                             report_filename: 'test_results.html',
                             clean: true,
                             add_timestamp: true
                           )

                         ]
end

class TestStudent < Minitest::Test
  def setup
    @student = Student.new("Tomashevskyi", "Pavlo", "2005-08-30")
    Student.add_student(@student)
  end

  def teardown
    Student.class_variable_set(:@@students, [])
  end

  def test_initialize
    assert_equal "Tomashevskyi", @student.surname
    assert_instance_of Date, @student.date_of_birth
  end

  def test_add_student
    assert_equal 1, Student.class_variable_get(:@@students).size
  end

  def test_remove_student
    Student.remove_student(@student)
    assert_equal 0, Student.class_variable_get(:@@students).size
  end

  def test_calculate_age
    assert_equal 19, @student.calculate_age
  end

  def test_get_students_by_name
    students = Student.get_students_by_name("Pavlo")
    assert_equal 1, students.size
    assert_equal "Pavlo", students.first.name
  end
end

describe Student do
  before do
    @student = Student.new("Tomashevskyi", "Pavlo", "2005-08-30")
    Student.add_student(@student)
  end

  after do
    Student.class_variable_set(:@@students, [])
  end

  it "initializes correctly" do
    _(@student.surname).must_equal "Tomashevskyi"
    _(@student.name).must_equal "Pavlo"
    _(@student.date_of_birth).must_be_instance_of Date
  end

  it "adds students correctly" do
    _(Student.class_variable_get(:@@students).size).must_equal 1
  end

  it "removes students correctly" do
    Student.remove_student(@student)
    _(Student.class_variable_get(:@@students).size).must_equal 0
  end

  it "calculates age correctly" do
    _(@student.calculate_age).must_equal 19
  end

  it "gets students by name correctly" do
    students = Student.get_students_by_name("Pavlo")
    _(students.size).must_equal 1
    _(students.first.name).must_equal "Pavlo"
  end
end
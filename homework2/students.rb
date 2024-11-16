require 'date'
class Student
  @@students = []
  attr_reader :surname, :name, :date_of_birth

  public

  def initialize(surname, name, date_of_birth)
    @surname = surname
    @name = name
    @date_of_birth = validate_date_of_birth(date_of_birth)

  end

  def validate_date_of_birth(date_of_birth)
    pars_dat = Date.parse(date_of_birth)
    if pars_dat >= Date.today
      raise ArgumentError, "Date is incorrect"
    end

    pars_dat
  end

  def self.add_student(student)
    duplicate = false

    @@students.each do |s|
      if s.surname == student.surname && s.name == student.name && s.date_of_birth == student.date_of_birth
        duplicate = true
        break
      end
    end

      unless duplicate
        @@students << student
    end
  end

  def calculate_age
    today = Date.today
    age = today.year - @date_of_birth.year
    age -= 1 if today < @date_of_birth.next_year(age)
    age
  end

  def self.remove_student(student)
    @@students.delete_if { |s| s.surname == student.surname && s.name == student.name && s.date_of_birth == student.date_of_birth }
  end

  def self.get_students_by_age(age)
    today = Date.today
    @@students.select do |student|
      student_age = calculate_age(student)
      student_age == age
    end
  end

  def self.get_students_by_name(name)
    @@students.select { |student| student.name == name }
  end

end

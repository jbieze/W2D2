require 'byebug'

class Employee
  attr_accessor :salary

  def initialize(salary)
    @salary = salary
  end

  def bonus(multiplier)
    @salary * multiplier
  end

end

class Manager < Employee

  attr_accessor :employees

  def initialize(salary, employees = [])
    @employees = employees
    super(salary)
  end

  def bonus(multiplier)
    total_salary(@employees) * multiplier
  end

  def total_salary(arr)

    arr.reduce(0) do |acc, employee|
      sum = acc + employee.salary
      if employee.is_a?(Manager)
        sum += total_salary(employee.employees)
      end
      sum
    end
  end

end

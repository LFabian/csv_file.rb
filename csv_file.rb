require 'faker'
require 'csv'

class Person 
  attr_accessor :first_name

  def initialize(first_name)  
    @first_name = first_name
  end 
end 


def number_of_persons(n)
  arry = []
  n.times do 
    arry << Person.new(Faker::Name.first_name) 
    end
  arry  
end 

class PersonWriter 

  def initialize(file, array) 
    @file = file 
    @array = array 
  end  
  
  def create_csv   
      CSV.open(@file, "w") do |csv|
        @array.each do |people|
          csv << [people.first_name]
        end
      end
  end   
end   

class PersonParser 

  def initialize(file)
    @file = file 
  end 
  
  def people
    arry = []
    CSV.foreach(@file) do |person|
      arry << Person.new(person[0]) 
    end 
    arry 
  end 
end 

people = number_of_persons(8)
person_writer = PersonWriter.new("people.csv", people)
person_writer.create_csv

parser = PersonParser.new('people.csv')
p people = parser.people
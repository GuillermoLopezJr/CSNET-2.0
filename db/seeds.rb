# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).


@i = Instructor.create!({:first_name => "Jeff", :last_name => "Huang", :email => "i1@gmail.com", :password => "password", :password_confirmation => "password", :is_admin => true})
@i2 = Instructor.create!({:first_name => "Jim", :last_name => "Jimmy", :email => "i2@gmail.com", :password => "password", :password_confirmation => "password", :is_admin => false})
@s = Student.create!({:first_name =>"Jane", :last_name => "Doe", :email => "s1@gmail.com", :password => "password", :password_confirmation => "password"})
@ta = Assistant.create!(first_name: "Patrick", last_name: "Star", email: "ta1@gmail.com", password: "password", password_confirmation: "password")
@c = Course.create!(instructor_id: @i.id, name: "Software Engineering", number: 431, year: 2017, session: "SPRING")
@a = Assignment.create!(course_id: @c.id, name: "Reading 1", course_num: @c.number, due_date: "2017-01-01")

@c.assistants << @ta
@c.students << @s


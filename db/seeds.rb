# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Instructor.create!({:email => "i1@gmail.com", :password => "password", :password_confirmation => "password", :is_admin => true})
Student.create!({:email => "s1@gmail.com", :password => "password", :password_confirmation => "password"})
Assistant.create!(email: "ta1@gmail.com", password: "password", password_confirmation: "password")
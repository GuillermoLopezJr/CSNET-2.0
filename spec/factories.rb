FactoryGirl.define do
  factory :instructor do
    email "user@gmail.com"
    password "password"
  end

  factory :course do
    name "csce"
    number 313
  end


end

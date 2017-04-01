FactoryGirl.define do
  factory :assistant do
    
  end
  factory :submission do
    name "MyString"
    assignment "MyString"
    attachment "MyString"
  end
  factory :student do
    email "student@gmail.com"
    password "password"
  end

  factory :instructor do
    email "user@gmail.com"
    password "password"
  end

  factory :course do
    name "csce"
    number 313
  end

end

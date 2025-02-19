FactoryBot.define do
  factory :user do
    email { "MyString@gmail.com" }
    password_digest { "MyString" }
  end
end

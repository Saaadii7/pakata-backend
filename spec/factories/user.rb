FactoryBot.define do
  factory :user do
    email { "saad@gmail.com" }
    first_name { "Saad" }
    last_name { "Mahmood" }
    dob { "25-10-1995" }
    password { "12345678" }
  end
end

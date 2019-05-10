FactoryBot.define do
  factory :user do
    firstname { "doan" }
    lastname { "vu"}
    address { "Quang Nam"}
    phone { "0328944440"}
    email { "vu@gmail.com" }
    role {1}
    password {"123456"}
    password_confirmation {"123456"}
  end
end

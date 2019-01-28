FactoryBot.define do
  factory :user, class: User do
    name { "aaa" }
    email { "aaa@gmail.com" }
    password_digest { "aaaaaa" }
  end
end

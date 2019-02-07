#Userを作成（権限無し）
3.times do |n|
  name = Faker::Pokemon.name
  email = Faker::Internet.email
  password = "aaaaaa"
  User.create!(
    name: name,
    email: email,
    password_digest: password,
    admin: false,
    password: password,
    # password_confirmation: password,
)
end

#Userを作成（権限有り）
# User.create!(
#   name: "admin",
#   email: "admin@gmail.com",
#   password_digest: "password",
#   admin: true,
#   password: "aaaaaa",
#   )

#Userが作成したとするtaskを作成
users = User.all

users.each do |user|
  6.times do
    user.tasks.create!(
      name: Faker::Lorem.word,
      content: Faker::Lorem.sentence,
      # limit_on: Faker::Time.between(Date.current, Data.current.ago(1.month)),
      status: 0,
      priority: 0
    )
  end
end

#Label データ作成
work = Label.create!(
  name: "仕事"
  )
dinner = Label.create!(
  name: "夕飯"
  )
drink = Label.create!(
  name: "飲み会"
  )

#taskと紐づく中間テーブルをLabel情報も使って作成する
tasks = Task.all

tasks.each_with_index do |task,i|
  task.labelings.create!(label_id: work.id) if i.even?
  task.labelings.create!(label_id: dinner.id) if i.even?
  task.labelings.create!(label_id: drink.id) if i.even?
end

#Factory Bot を使用します、という記述
FactoryBot.define do
  #作成するテストデータの名前を「task」とする
  #(実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で生成します)
  factory :task, class: Task do
    name { 'testtesttest1' }
    content { 'samplesample1' }
  end

  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにする」と指定する
  factory :second_task, class: Task do
    name { 'testtesttest2' }
    content { 'samplesample2' }
  end

  factory :third_task, class: Task do
    name { 'testtesttest3' }
    content { 'samplesample3' }
  end

end

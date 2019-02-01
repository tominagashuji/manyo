#Factory Bot を使用します、という記述
FactoryBot.define do
  #作成するテストデータの名前を「task」とする
  #(実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で生成します)
  factory :task, class: Task do
    name { 'testtesttest1' }
    content { 'samplesample1' }
    limit_on { '20010101' }
    status { 'nowork' }
    priority { 'low' }
  end

  factory :task01, class: Task do
    name { 'task01' }
    content { 'content01' }
    status { 'nowork' }
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

  factory :limit_on_sort01, class: Task do
    name { 'limit_on_sort01_name' }
    content { 'limit_on_sort01_content' }
    limit_on { '20000101' }
  end

  factory :limit_on_sort02, class: Task do
    name { 'limit_on_sort02_name' }
    content { 'limit_on_sort02_content' }
    limit_on { '21111111' }
  end

  factory :search_01, class: Task do
    name { 'search_name01' }
    content { 'search_content01' }
    limit_on { '20000101' }
    status { 'nowork' }
    priority { 'low' }
  end

  factory :search_02, class: Task do
    name { 'search_name02' }
    content { 'search_content02' }
    limit_on { '20000102' }
    status { 'work' }
    priority {'medium'}
  end

  factory :search_03, class: Task do
    name { 'search_name01' }
    content { 'search_content01' }
    limit_on { '20000103' }
    status { 'comp' }
    priority {'high'}
  end

  factory :search_04, class: Task do
    name { 'search_name04' }
    content { 'search_content04' }
    limit_on { '20000104' }
    status { 'comp' }
  end

  factory :pagenation_01, class: Task do
    name {'pagenation_name_01'}
    content {'pagenation_content_01'}
    limit_on { '20000101' }
  end
  factory :pagenation_02, class: Task do
    name {'pagenation_name_02'}
    content {'pagenation_content_02'}
    limit_on { '20000102' }
  end
  factory :pagenation_03, class: Task do
    name {'pagenation_name_03'}
    content {'pagenation_content_03'}
    limit_on { '20000103' }
  end
  factory :pagenation_04, class: Task do
    name {'pagenation_name_04'}
    content {'pagenation_content_04'}
    limit_on { '20000104' }
  end
  factory :pagenation_05, class: Task do
    name {'pagenation_name_05'}
    content {'pagenation_content_05'}
    limit_on { '20000105' }
  end
  factory :pagenation_06, class: Task do
    name {'pagenation_name_06'}
    content {'pagenation_content_06'}
    limit_on { '20000106' }
  end

end

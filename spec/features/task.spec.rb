#このrequire でcapybaraなどのfeaturespecに必要な機能をしよう可能な状態にしています。

require 'rails_helper'

#このRSpec。featureの右側にテスト項目の名称を書きます(do~end でグループ化されてる)
RSpec.feature "1.タスク管理機能",type: :feature do
  #scenario(itのalias)の中に、確認したい各項目のテストの処理を書きます。
  background do
    #あらかじめタスク一覧のテストで使用するためのタスクを二つ作った！
    # Task.create!(name: 'test_task_01', content: 'testtesttest')
    # Task.create!(name: 'test_task_02', content: 'samplesample')
    FactoryBot.create(:task)
  end

  scenario "タスク一覧テスト" do
    #tasks_path に visit する（タスク一覧ページに遷移する）
    visit tasks_path

    ####RSpecでのデバッグ行
    # save_and_open_page
    # expect(page).to have_content 'aaaaa'

    #visit(到着した)expect(page)に(タスク一覧ページに)「testtesttest」「samplesample」という文字列が
    #have_content されているか？（含まれているか？）という事をexpectする（確認・期待する）テストを書いている
    expect(page).to have_content 'testtesttest1'
    expect(page).to have_content 'samplesample1'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in 'task_name', with: 'name'
    fill_in 'task_content', with: 'content'
    click_on '登録する'
    visit tasks_path
    expect(page).to have_content 'name'
    expect(page).to have_content 'content'
  end

  scenario "タスク詳細のテスト" do
    visit tasks_path
    click_on '詳細'
    expect(page).to have_content 'testtesttest1'
    expect(page).to have_content 'samplesample1'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    visit tasks_path
    expect(page).to have_content 'testtesttest3'
    expect(page).to have_content 'samplesample3'
    expect(page).to have_content 'testtesttest2'
    expect(page).to have_content 'samplesample2'
    expect(page).to have_content 'testtesttest1'
    expect(page).to have_content 'samplesample1'
  end
end

RSpec.feature "2.終了期限テスト",type: :feature do
  background do
    FactoryBot.create(:task)
    FactoryBot.create(:limit_on_sort01)
    FactoryBot.create(:limit_on_sort02)
  end

  scenario "終了期限作成テスト" do
    visit new_task_path
    fill_in 'task_name', with: 'name'
    fill_in 'task_content', with: 'content'
    fill_in 'task_limit_on', with: DateTime.new(2011, 12, 24).yesterday
    click_on '登録する'
    visit tasks_path
    expect(page).to have_content '2011-12-23'
  end

  scenario "終了期限でソートするボタンのテスト" do
    visit tasks_path
    click_on '終了期限でソートする'
    expect(page).to have_content 'limit_on_sort02_name'
    expect(page).to have_content 'limit_on_sort02_content'
    expect(page).to have_content '2111-11-11'
    expect(page).to have_content 'limit_on_sort01_name'
    expect(page).to have_content 'limit_on_sort01_content'
    expect(page).to have_content '2000-01-01'
    expect(page).to have_content 'testtesttest1'
    expect(page).to have_content 'samplesample1'
    expect(page).to have_content '1900-01-01'
  end
end

RSpec.feature "3.検索機能テスト",type: :feature do
  background do
    FactoryBot.create(:search_01)
    FactoryBot.create(:search_02)
    FactoryBot.create(:search_03)
    FactoryBot.create(:search_04)
  end

  scenario "名前検索テスト" do
    visit tasks_path
    fill_in 'task_name', with: 'search_name01'
    click_on '検索する'

    expect(page).to have_content 'search_name01'
    expect(page).to have_content '2000-01-01'
    expect(page).to have_content '未着手'
    expect(page).to have_content 'search_name01'
    expect(page).to have_content '2000-01-03'
    expect(page).to have_content '完了'
  end

  scenario "ステータス検索テスト" do
    visit tasks_path
    select '完了', from: 'task[status]'
    click_on '検索する'
    expect(page).to have_content 'search_name01'
    expect(page).to have_content '2000-01-03'
    expect(page).to have_content '完了'
    expect(page).to have_content 'search_name04'
    expect(page).to have_content '2000-01-04'
    expect(page).to have_content '完了'
  end

  scenario "名前、ステータス同時検索テスト" do
    visit tasks_path
    fill_in 'task_name', with: 'search_name02'
    select '着手中', from: 'task[status]'
    click_on '検索する'
    expect(page).to have_content 'search_name02'
    expect(page).to have_content '2000-01-02'
    expect(page).to have_content '着手中'
  end
end

RSpec.feature "4.優先度ソートテスト",type: :feature do
  background do
    FactoryBot.create(:search_01)
    FactoryBot.create(:search_02)
    FactoryBot.create(:search_03)
  end

  scenario "優先順位ソート" do
    visit tasks_path
    click_on '優先度でソートする'
    expect(page).to have_content '高'
    expect(page).to have_content '中'
    expect(page).to have_content '低'
  end
end

RSpec.feature "5.ページネーションテスト",type: :feature do
  background do
    FactoryBot.create(:pagenation_01)
    FactoryBot.create(:pagenation_02)
    FactoryBot.create(:pagenation_03)
    FactoryBot.create(:pagenation_04)
    FactoryBot.create(:pagenation_05)
    FactoryBot.create(:pagenation_06)
  end

  scenario "ページネーション動作確認" do
    visit tasks_path
    click_on 'Next'
    save_and_open_page
    expect(page).to have_content 'pagenation_name_01'
  end
end

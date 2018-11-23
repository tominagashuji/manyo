#このrequire でcapybaraなどのfeaturespecに必要な機能をしよう可能な状態にしています。

require 'rails_helper'

#このRSぺc。reatureの右側にテスト項目の名称を書きます(do~end でグループ化されてる)
RSpec.feature "タスク管理機能",type: :feature do
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
    save_and_open_page
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

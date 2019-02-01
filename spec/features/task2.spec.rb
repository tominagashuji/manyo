require 'rails_helper'

describe 'タスク管理機能', type: :feature do
  describe '一覧表示機能' do
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA',email: 'a@example.com')}
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB',email: 'b@example.com')}
    let!(:task_a) { FactoryBot.create(:task,name: '最初のタスク',user: user_a)}

    before do
      # FactoryBot.create(:task, name: '最初のタスク', user: user_a)
      # user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
      # FactoryBot.create(:task, name: '最初のタスク', user: user_a)
      visit login_path
      # fill_in 'session_email', with: 'a@example.com'
      # fill_in 'session_password', with: 'password'
      fill_in 'session_email', with: login_user.email
      fill_in 'session_password', with: login_user.password
      click_button 'Log in'
    end

    context 'ユーザーAがログインしている時' do
      let(:login_user){user_a}
      it 'ユーザーAが作成したタスクが表示される' do
        expect(page).to have_content '最初のタスク'
      end
    end
    context 'ユーザーBがログインしている時' do
      let(:login_user){user_b}
      it 'ユーザーBが作成したタスクがのみが表示される' do
        expect(page).to have_no_content '最初のタスク'
      end
    end

    describe '詳細表示機能' do
      context 'ユーザーAがログインしている時' do
        let(:login_user){user_a}

        before do
          visit task_path(task_a)
        end

        it 'ユーザーAが作成したタスクが表示される' do
          expect(page).to have_content '最初のタスク'
        end
      end
    end

    describe 'タスク作成テスト' do
      context 'ユーザーAがログインしている時' do
        let(:login_user){user_a}

        before do
          visit new_task_path
        end

        it 'ユーザーAが作成したタスクが表示される' do
          fill_in 'task_name', with: 'aaa'
          fill_in 'task_content', with: 'aaaaaa'
          click_button '登録する'
          expect(page).to have_content 'aaa'
          expect(page).to have_content 'aaaaaa'
        end
      end
    end

    describe 'task機能の操作テスト' do
      context 'ユーザーAがログインしている時' do
        let(:login_user){user_a}

        before do
          task01 = FactoryBot.create(:task, name: 'name01', created_at: '2001-01-01', user: user_a)
          task02 = FactoryBot.create(:task, name: 'name02', created_at: '2001-01-02', user: user_a)
          task03 = FactoryBot.create(:task, name: 'name03', created_at: '2001-01-03', user: user_a)
          visit tasks_path
        end

        it 'タスクが作成日付の降順に並んでいるかのテスト' do
          expect(page).to have_content 'name03'
          expect(page).to have_content 'name02'
          expect(page).to have_content 'name01'
        end
      end
    end

    describe '終了期限テスト' do
      context 'ユーザーAがログインしている時' do
        let(:login_user){user_a}

        before do
          task01 = FactoryBot.create(:task, name: 'name01', created_at: '2001-01-01', limit_on: '2001-02-01', status: 0, priority: 0, user: user_a)
          task02 = FactoryBot.create(:task, name: 'name02', created_at: '2001-01-02', limit_on: '2001-02-02', status: 1, priority: 1, user: user_a)
          task03 = FactoryBot.create(:task, name: 'name03', created_at: '2001-01-03', limit_on: '2001-02-03', status: 2, priority: 2, user: user_a)
          task04 = FactoryBot.create(:task, name: 'name04', created_at: '2001-01-04', limit_on: '2001-02-04', status: 0, priority: 1, user: user_a)
          task05 = FactoryBot.create(:task, name: 'name05', created_at: '2001-01-05', limit_on: '2001-02-05', status: 1, priority: 2, user: user_a)
          task06 = FactoryBot.create(:task, name: 'name06', created_at: '2001-01-06', limit_on: '2001-02-06', status: 2, priority: 0, user: user_a)
          visit tasks_path
        end

        it 'タスクが作成日付の降順に並んでいるかのテスト' do
          click_on '終了期限でソートする'
          expect(page).to have_content '2001-02-06'
          expect(page).to have_content '2001-02-05'
          expect(page).to have_content '2001-02-04'
        end

        it '名前検索テスト' do
          fill_in 'task_name', with: 'name01'
          click_on '検索する'
          expect(page).to have_content 'name01'
        end

        it 'ステータス検索テスト' do
          select '完了', from: 'task[status]'
          click_on '検索する'
          expect(page).to have_content '完了'
        end

        it '名前、ステータス同時検索テスト' do
          fill_in 'task_name', with: 'name0'
          select '完了', from: 'task[status]'
          click_on '検索する'
          expect(page).to have_content 'name03'
        end

        it '優先度ソートテスト' do
          click_on '優先度でソートする'
          expect(page).to have_content '高'
          expect(page).to have_content '中'
          expect(page).to have_content '低'
        end

        it 'ページネーション動作確認' do
          click_on 'Next'
          expect(page).to have_content 'name02'
          expect(page).to have_content 'name01'
          save_and_open_page
        end

      end
    end
  end
end

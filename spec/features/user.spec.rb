require 'rails_helper'

RSpec.feature "1.ユーザー登録機能",type: :feature do
  background do
    FactoryBot.create(:user)
  end

  scenario "ユーザー作成のテスト" do
    visit new_user_path
    fill_in 'user_name', with: 'create_name'
    fill_in 'user_email', with: 'create_email@gmail.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button '登録する'
    expect(page).to have_content 'create_name'
    expect(page).to have_content 'create_email@gmail.com'
  end

  scenario "ユーザーログイン・プロフィール確認テスト" do
    visit login_path
    fill_in 'session_email', with: 'aaa@gmail.com'
    fill_in 'session_password', with: 'aaaaaa'
    save_and_open_page
    click_button 'Login'
    visit user_path(User.first)

    expect(page).to have_content 'aaa'
    expect(page).to have_content 'aaa@gmail.com'
  end

end

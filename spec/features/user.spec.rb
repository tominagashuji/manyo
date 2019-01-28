require 'rails_helper'

RSpec.feature "1.ユーザー登録機能",type: :feature do
  background do
    FactoryBot.create(:user)
  end

  scenario "ユーザー作成のテスト" do
  end
end

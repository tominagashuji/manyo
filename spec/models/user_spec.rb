require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # before do
  #   user_a = FactoryBot.create(:user,name: 'aaa',email:'aaa@gmail.com')
  #   FactroyBot.create(:task, name: '最初のタスク', user: user_a)
  # end

  it "nameとemail,passwordの内容が記載されていればバリデーションが通る" do
    user = User.new(name: 'aaa',email: 'aaa@gmail.com', password: 'aaaaaa')
    expect(user).to be_valid
  end

  it "name が空はバリデーションが通らない" do
    user = User.new(name: '',email: 'aaa@gmail.com', password: 'aaaaaa')
    expect(user).not_to be_valid
  end
  it "name は 30文字まで" do
    user = User.new(name: 'a'*31 ,email: 'aaa@gmail.com', password: 'aaaaaa')
    expect(user).not_to be_valid
  end

  it "email が空はバリデーションが通らない" do
    user = User.new(name: 'aaa',email: '', password: 'aaaaaa')
    expect(user).not_to be_valid
  end
  it "email は255まで" do
    user = User.new(name: 'aaa',email: 'a'*246 + '@gmail.com', password: 'aaaaaa')
    expect(user).not_to be_valid
  end

  it "password が空はバリデーションが通らない" do
    user = User.new(name: 'aaaaaa',email: 'aaa@gmail.com', password: '')
    expect(user).not_to be_valid
  end
  it "password は6文字以上" do
    user = User.new(name: 'aaaaaa',email: 'aaa@gmail.com', password: 'aaaaa')
    expect(user).not_to be_valid
  end
end

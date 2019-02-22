require 'rails_helper'

RSpec.describe Task, type: :model do
  #before は it が実行される前に毎回実行される、そのためitが実行される毎にuserが増えていた
  before do
    @user = FactoryBot.create(:user)
    # @task = FactoryBot.create(:task01)
    user = User.create(name: 'aaa',email: 'aaa@gmail.com', password: 'aaaaaa')
    # @task = FactoryBot.create(:task01)
  end

  it "nameとcontentに内容が記載されていればバリデーションが通る" do
    # task = Task.new(name: '成功テスト', content: '成功テスト',user_id: 1)
    task = Task.new(name: '成功テスト', content: '成功テスト',user_id: @user.id)
    expect(task).to be_valid
    # binding.pry
  end

  it "nameが空ならバリデーションが通らない" do
    # task = Task.new(name: '', content: '失敗テスト',user_id: 2)
    task = Task.new(name: '', content: '失敗テスト',user_id: @user.id)
    expect(task).not_to be_valid
  end

  it "contentが空ならバリデーションが通らない" do
    # task = Task.new(name: '失敗テスト', content: '',user_id: 3)
    task = Task.new(name: '失敗テスト', content: '',user_id: @user.id)
    expect(task).not_to be_valid
  end

  it "name検索テスト" do
    # task01 = Task.create(name: 'name01', content: 'content01', user_id: 4)
    task01 = Task.create(name: 'name01', content: 'content01', user_id: @user.id)
    task02 = Task.create(name: 'name02', content: 'content02', user_id: @user.id)
    task03 = Task.create(name: 'name33', content: 'content33', user_id: @user.id)
    tasks = Task.name_search("name0")
    expect(tasks).to include task01, task02
  end

  it "status検索テスト" do
    # task01 = Task.create(name: 'name01', content: 'content01', status: 'nowork',user_id: 5)
    task01 = Task.create(name: 'name01', content: 'content01', status: 'nowork',user_id: @user.id)
    task02 = Task.create(name: 'name02', content: 'content02', status: 'work',user_id: @user.id)
    task03 = Task.create(name: 'name33', content: 'content33', status: 'comp',user_id: @user.id)
    tasks = Task.status_search("nowork")
    expect(tasks).to include task01
  end

  it "name,status検索テスト" do
    # task01 = Task.create(name: 'name01', content: 'content01', status: 'nowork',user_id: 6)
    task01 = Task.create(name: 'name01', content: 'content01', status: 'nowork',user_id: @user.id)
    task02 = Task.create(name: 'name02', content: 'content02', status: 'work',user_id: @user.id)
    task03 = Task.create(name: 'name03', content: 'content33', status: 'comp',user_id: @user.id)
    tasks = Task.all
    tasks = tasks.name_search("name0")
    tasks = tasks.status_search("work")
    expect(tasks).to include task02
  end

  it "label 検索テスト" do
    # task01 = Task.create(name: 'name01', content: 'content01', status: 'nowork',user_id: @user.id)
    # task02 = Task.create(name: 'name02', content: 'content02', status: 'work',user_id: @user.id)
    # task03 = Task.create(name: 'name03', content: 'content33', status: 'comp',user_id: @user.id)
    # tasks = Task.all
    # tasks = tasks.label_search("0")
    # expect(tasks).to include task02
    # binding.pry
  end

  it "name,status,label検索テスト" do
  end

end

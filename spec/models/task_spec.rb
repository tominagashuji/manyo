require 'rails_helper'

RSpec.describe Task, type: :model do
  #事前にデータを用意しようとしたが上手く行かないので一旦保留
  # before do
  #   @task = FactoryBot.create(:task01)
  # end

  it "nameが空ならバリデーションが通らない" do
    task = Task.new(name: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end

  it "contentが空ならバリデーションが通らない" do
    task = Task.new(name: '失敗テスト', content: '')
    expect(task).not_to be_valid
  end

  it "nameとcontentに内容が記載されていればバリデーションが通る" do
    task = Task.new(name: '成功テスト', content: '成功テスト')
    expect(task).to be_valid
  end

  it "name検索テスト" do
    # task01 = @task
    task01 = Task.create(name: 'name01', content: 'content01', )
    task02 = Task.create(name: 'name02', content: 'content02', )
    task03 = Task.create(name: 'name33', content: 'content33', )
    tasks = Task.name_search("name0")
    expect(tasks).to include task01, task02
  end

  it "status検索テスト" do
    task01 = Task.create(name: 'name01', content: 'content01', status: 'nowork')
    task02 = Task.create(name: 'name02', content: 'content02', status: 'work')
    task03 = Task.create(name: 'name33', content: 'content33', status: 'comp')
    tasks = Task.status_search("nowork")
    expect(tasks).to include task01
  end

  it "name,status検索テスト" do
    task01 = Task.create(name: 'name01', content: 'content01', status: 'nowork')
    task02 = Task.create(name: 'name02', content: 'content02', status: 'work')
    task03 = Task.create(name: 'name03', content: 'content33', status: 'comp')
    tasks = Task.name_status_search("name0","work")
    expect(tasks).to include task02
  end

end

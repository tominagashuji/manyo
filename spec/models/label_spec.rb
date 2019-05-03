require 'rails_helper'

RSpec.describe Label, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

  it "name が記載されればバリデーションが通る" do
    label = Label.new(name: 'aaa')
    expect(label).to be_valid
  end

  it "name が空はバリデーションが通らない" do
    label = Label.new(name: '')
    expect(label).not_to be_valid
  end

  it "name が４０文字以上はバリデーションが通らない" do
    label =Label.new(name: 'a'*41)
    expect(label).not_to be_valid
  end

end
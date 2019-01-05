class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true

  # ステップ15対応 enum status: [:xxx, :bbb, :ccc]
  enum status: {
    nowork: 0, # 未着手
    work: 1,   # 着手
    comp: 2,  # 完了
  }
end

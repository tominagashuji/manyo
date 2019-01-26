class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true

  # ステップ15対応 enum status: [:xxx, :bbb, :ccc]
  enum status: {
    nowork: 0, # 未着手
    work: 1,   # 着手
    comp: 2,  # 完了
  }
  # scope
  #
  scope :limit_on_sorted, -> { order(limit_on: :desc) }#limit_onカラムを降順
  scope :priority_sorted, -> { order(priority: :desc) }#priorityカラムを降順
  scope :created_at_sorted, -> { order(created_at: :desc) }#created_atカラムを降順

  # nameから一致する条件を返す
  scope :name_search , -> name {where('name like ?', "%#{name}%")}
  # statusから一致する条件を返す
  scope :status_search, -> status {where(status: status)}
  # name と statusから一致する条件を返す
  scope :name_status_search, -> (name, status) { where("name like ?", "%#{name}%").where(status: status)}

  # ステップ16対応 優先順位
  enum priority: { low: 0, medium: 1, high: 2,}
  # priority から一致するものを探す
  scope :priority_search, -> priority{where(priority: priority)}

  # アソシエーション
  belongs_to :user
  
end

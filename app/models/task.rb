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
  # scope :name_status_search, -> (name, status) { where("name like ?", "%#{name}%").where(status: status)}

  # name status label から一致する条件を返す
  scope :name_status_current_user_search, -> (name, status, current_user_id) { where("name LIKE ?", "%#{ name }%").where(status: status).where(user_id: current_user_id) }
  # name label から一致する条件を返す
  scope :name_current_user_search, -> (name, current_user_id) { where("name LIKE ?", "%#{ name }%").where(user_id: current_user_id) }
  # status label から一致する条件を返す
  scope :status_current_user_search, -> (status, current_user_id) { where(status: status).where(user_id: current_user_id) }
  # label から一致する条件を返す
  scope :label_search, ->(label) do
    task_ids = Labeling.where(label_id: label).pluck(:task_id)
    where(id: task_ids) if label
  end

  scope :order_by_expired_at, ->(sort) { all.order(expired_at: :desc) if sort }
  scope :order_by_priority, ->(sort) { all.order(priority: :desc) if sort }

  # ステップ16対応 優先順位
  enum priority: { low: 0, medium: 1, high: 2,}
  # priority から一致するものを探す
  scope :priority_search, -> priority{where(priority: priority)}

  # アソシエーション
  belongs_to :user
  #step24 ラベル対応
  has_many :labelings
  has_many :labels, through: :labelings, source: :label, inverse_of: :tasks

  #親から子を作成する時に必要な設定（親：tasks,子：labels）
  accepts_nested_attributes_for :labels
end

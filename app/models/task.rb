class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true

  enum status: [:xxx, :bbb, :ccc]
end

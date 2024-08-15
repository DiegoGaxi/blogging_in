class Blog < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories, join_table: :blog_categories
  has_one_attached :image

  validates :title, presence: true
  validates :content, presence: true
end
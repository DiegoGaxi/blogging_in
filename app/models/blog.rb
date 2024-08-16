class Blog < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories, join_table: :blog_categories
  has_one_attached :image

  validates :title, presence: true
  validates :content, presence: true
  validate :categories_present

  private

  def categories_present
    if category_ids.empty?
      errors.add(:category_ids, "Debe seleccionar al menos una categoría")
    end
  end
end
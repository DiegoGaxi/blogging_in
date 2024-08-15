class CreateCategoriesAndBlogCategories < ActiveRecord::Migration[7.0]
  def change
    # Create the categories table
    create_table :categories do |t|
      t.string :name, null: false

      t.timestamps
    end

    # Create the join table between blogs and categories
    create_table :blog_categories do |t|
      t.references :blog, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end

    # Add an index to the join table for uniqueness
    add_index :blog_categories, [:blog_id, :category_id], unique: true
  end
end

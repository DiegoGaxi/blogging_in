class CreateBlogs < ActiveRecord::Migration[7.0]
  def change
    create_table :blogs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.integer :likes_count, default: 0
      t.string :video_url

      t.timestamps
    end
  end
end

FactoryBot.define do
  factory :blog do
    association :user
    title { Faker::Book.title }
    content { Faker::Lorem.paragraph }
    likes_count { 0 }
    video_url { Faker::Internet.url }

    after(:build) do |blog|
      # Asegúrate de que haya al menos una categoría asociada al blog
      if blog.categories.empty?
        blog.categories << create(:category)
      end
    end
  end
end

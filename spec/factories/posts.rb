FactoryBot.define do
  factory :post do
    content { 'blah blah blah' }

    after(:build) do |post|
      post.images.attach(io: File.open('spec/support/images/test_image.jpg'),
                         filename: 'test_image.jpg',
                         content_type: 'image/jpg')
    end
  end
end

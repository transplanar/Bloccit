#TODO Make sure labels factory works




#  let(:comment) { Comment.create!(body: 'Comment Body', post: post, user: user) }


# include RandomData
#
# FactoryGirl.define do
#   factory :post do
#     title RandomData.random_sentence
#     body RandomData.random_paragraph
#     topic
#     user
#     rank 0.0
#   end
# end

FactoryGirl.define do
  factory :label do
    name RandomData.random_sentence
  end
end

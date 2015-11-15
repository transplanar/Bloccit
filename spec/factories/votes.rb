


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

include RandomData

FactoryGirl.define do
  factory :vote do
    value rand(1..20)
    post
    user
  end
end

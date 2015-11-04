include RandomData

50.times do
    Post.create!(
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph
    )
end

posts = Post.all

100.times do
    Comment.create!(
        post: posts.sample,
        body: RandomData.random_paragraph
    )
end

counter = 0

50.times do
   Advertisement.create!(title: "New Deal #{counter}",copy: "Check out our deals!", price: 1000 + counter ) 
   
   counter +=1
end

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
        
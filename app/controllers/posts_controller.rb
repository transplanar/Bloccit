class PostsController < ApplicationController
  def index
    @posts = Post.all
    censor_posts
  end

  def show
  end

  def new
  end

  def edit
  end
  
  def censor_posts
    @posts.each_with_index do |post, index|
      if (index+1) % 5 == 0
        post.title = "SPAM"
      end
    end
  end
end

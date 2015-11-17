class FavoriteMailer < ActionMailer::Base
  default from: "transplanar@gmail.com"

  def new_comment(user, post, comment)
    headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
    headers["References"] = "<post/#{post.id}@your-app-name.example>"

    @user = user
    @post = post
    @comment = comment

    #NOTE Altered for testing
    #mail(to: user.email, subject: "New comment on #{post.title}")
    mail(to: "transplanar@gmail.com", subject: "New comment on #{post.title}")
  end
end

class UserMailer < ApplicationMailer
  default from: 'notifications@rottenmangoes.com'

  def delete_email(user)
    @user = user
    mail(to: @user.email, subject: "You have been deleted from the system")
  end

end

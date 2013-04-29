class UserMailer < ActionMailer::Base

  include Devise::Mailers::Helpers

  default from: "medachref.sethom@captaindash.com"
  def confirmation_instructions(record)
    devise_mail(record, :confirmation_instructions)
  end

  def reset_password_instructions(record)
    devise_mail(record, :reset_password_instructions)
  end

  def unlock_instructions(record)
    devise_mail(record, :unlock_instructions)
  end

  def welcome_email(user)
    @user = user
    mail(:to => @user.email, :subject => "Welcome to HR Factory")
  end

  def reset_pwd(user)
  @user=user
  mail(:to =>@user.email, :subject => "Reset password instruction")
  end
# you can then put any of your own methods here
end

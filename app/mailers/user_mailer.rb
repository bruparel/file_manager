class UserMailer < ActionMailer::Base

  def comment_email_from_us(commented_on_user_model, commenting_user,
                              email_subject, email_text)
    mail(:to => commented_on_user_model.email,
    :cc      => APP_CONFIG['admin_email_from'],
    :from    => commenting_user.email,
    :subject => email_subject,
    :body    => email_text,
    :sent_on => Time.now)
  end

  def comment_email_to_us(commented_on_user_model, commenting_user,
                            email_subject, email_text)
    mail(:to => APP_CONFIG['admin_email_to'],
    :cc      => commented_on_user_model.email,
    :from    => commenting_user.email,
    :subject => email_subject,
    :body    => email_text,
    :sent_on => Time.now)
  end

end


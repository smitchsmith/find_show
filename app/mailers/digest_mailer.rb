class DigestMailer < ApplicationMailer
  def digest(user_digest)
    @digest = user_digest
    mail(to: @digest.user_email, subject: 'findshow weekly update')
  end
end

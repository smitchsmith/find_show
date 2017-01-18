class DigestMailer < ApplicationMailer
  def digest(user_digest)
    @digest = user_digest
    mail(to: @digest.user_email, subject: 'Findshow Weekly Update!')
  end
end

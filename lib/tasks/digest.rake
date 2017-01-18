namespace :digest do
  desc "Send Weekly Digest"
  task send: :environment do
    User.find_each do |user|
      digest = UserDigest.new(user)
      DigestMailer.digest(digest).deliver if digest.has_content?
    end
  end
end

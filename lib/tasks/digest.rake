namespace :digest do
  desc "Send Weekly Digest"
  task send: :environment do
    Sync::OhMyRockness.import
    UserDigest.run
  end
end

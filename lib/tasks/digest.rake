namespace :digest do
  desc "Send Weekly Digest"
  task send: :environment do
    Sync::OhMyRockness.import
    Sync::Spotify.sync
    UserDigest.run
  end
end

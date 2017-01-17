class ArtistsController < ApplicationController
  def index
    digest = UserDigest.new(User.first)
    DigestMailer.digest(digest).deliver

    @artists = current_user.artists
  end
end

class UserDigest < Struct.new(:user)
  PERIOD = 1.week

  delegate :email, to: :user, prefix: true

  def has_content?
    # (new_events + upcoming_events).any?
    true
  end

  def new_events
    @new_events ||= user.followed_artist_events.where("events.created_at > ?", PERIOD.ago)
  end

  def upcoming_events
    @upcoming_events ||= user.followed_artist_events.where(date: upcoming_dates)
  end

  private

  def upcoming_dates
    (Time.now)..(PERIOD.from_now)
  end
end

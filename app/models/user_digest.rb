class UserDigest < Struct.new(:user)
  PERIOD = 1.week

  delegate :email, to: :user, prefix: true

  def new_events
    @new_events ||= user.followed_artist_events
      .where("events.created_at > ?", PERIOD.ago)
      .where("events.id NOT IN (?)", upcoming_events.pluck(:id))
  end

  def upcoming_events
    @upcoming_events ||= user.followed_artist_events.where(date: upcoming_dates)
  end

  private

  def upcoming_dates
    (Time.now)..(PERIOD.from_now)
  end
end

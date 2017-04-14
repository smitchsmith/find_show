class UserDigest < Struct.new(:user)
  PERIOD = 1.week

  delegate :email, to: :user, prefix: true

  def self.run
    # User.subscribed.find_each do |user|
    User.where(id: 1).each do |user|
      digest = new(user)
      DigestMailer.digest(digest).deliver if digest.has_content?
    end
  end

  def has_content?
    new_events.any? || upcoming_events.any?
  end

  def new_events
    @new_events ||= user.followed_artist_events
      .where("events.created_at > ?", PERIOD.ago)
      .where("events.id NOT IN (?)", upcoming_event_ids)
      .where("events.date > ?", Time.now)
      .ordered
  end

  def upcoming_events
    @upcoming_events ||= Event.where(id: upcoming_event_ids).ordered
  end

  def upcoming_event_ids
    @upcoming_event_ids ||= user.followed_artist_events.where(date: upcoming_dates).pluck(:id)
  end

  private

  def upcoming_dates
    (Time.now)..(PERIOD.from_now)
  end
end

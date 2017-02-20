module Activateable
  extend ActiveSupport::Concern

  class_methods do
    def active
      where(active: true)
    end

    def inactive
      where(active: false)
    end
  end

  def activate
    update_attribute(:active, true)
  end

  def deactivate
    update_attribute(:active, false)
  end

  def inactive?
    !active?
  end
end

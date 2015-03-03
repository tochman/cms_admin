module CurrentUser
  extend ActiveSupport::Concern

  module ClassMethods
    def current_user=(user)
      Thread.current[:current_user] = user
    end

    def current_user
      Thread.current[:current_user]
    end

    def as_user(user, &block)
      self.current_user = user
      yield
    ensure
      self.current_user = nil
    end
  end
end
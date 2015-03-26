module CMSAdmin
  class User < ActiveRecord::Base

    include CurrentUser
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, #:registerable,
           :recoverable, :rememberable, :trackable, :validatable

    has_many :news
    has_many :events

    validates :email, presence: true #redundant? Is devise validating this per default?


    def display_name
      self.name || self.email
    end

    def self.find_for_authentication(conditions)
      unscoped { super(conditions) }
    end

  end
end


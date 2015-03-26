module CMSAdmin
  class Admin < User

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    #devise :database_authenticatable, :trackable, :timeoutable, :lockable

    before_save do
      self.admin = true
    end

    def self.default_scope
      where admin: true
    end
  end
end




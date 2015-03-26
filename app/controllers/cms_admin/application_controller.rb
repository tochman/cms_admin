module CmsAdmin
  class ApplicationController < ActionController::Base
    include CmsAdmin

    before_filter :login_required

    def login_required
      binding.pry
      redirect_to new_user_session_path unless user_signed_in?
    end

    def require_admin!
      unless current_user && current_user.admin?
        refuse_access!
      end
    end
    def refuse_access!
      sign_out
      redirect_to(new_user_session_path)
    end

  end
end

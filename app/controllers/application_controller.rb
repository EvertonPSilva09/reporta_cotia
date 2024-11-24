class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: %i[index show]

  def authorize_admin
    redirect_to root_path, alert: 'Not authorized' unless current_user.admin?
  end

  def authorize_moderator
    redirect_to root_path, alert: 'Not authorized' unless current_user.moderator? || current_user.admin?
  end
end

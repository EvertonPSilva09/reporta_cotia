class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_locale

  def authorize_admin
    redirect_to root_path, alert: 'Not authorized' unless current_user.admin?
  end

  def authorize_moderator
    redirect_to root_path, alert: 'Not authorized' unless current_user.moderator? || current_user.admin?
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end

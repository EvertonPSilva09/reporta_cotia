class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_locale

  def authorize_admin
    redirect_to(user_signed_in? ? (current_user.admin? ? root_path : root_path) : root_path, alert: 'Não Autorizado')
  end

  def authorize_moderator
    redirect_to(user_signed_in? ? (current_user.moderator? ? root_path : root_path) : root_path, alert: 'Não Autorizado')
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end

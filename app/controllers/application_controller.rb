class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_locale

  def authorize_admin
    unless user_signed_in? && current_user.admin?
      redirect_to root_path, alert: 'Não Autorizado'
    end
  end

  def authorize_moderator
    unless user_signed_in? && current_user.moderator?
      redirect_to root_path, alert: 'Não Autorizado'
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end

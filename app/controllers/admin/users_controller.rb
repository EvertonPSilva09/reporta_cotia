class Admin::UsersController < ApplicationController
  before_action :authorize_admin

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'O perfil de usuário foi atribuido com sucesso!'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:role)
  end
end
class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy approve]
  before_action :authorize_moderator, only: [:approve]
  before_action :authorize_user!, only: %i[edit update]

  def index
    if user_signed_in?
      if current_user.admin? || current_user.moderator?
        @reports = Report.all
      else
        @reports = Report.where(status: :approved).or(Report.where(user: current_user))
      end
    else
      @reports = Report.where(status: :approved)
    end

    if params[:category_id].present?
      @reports = @reports.where(category_id: params[:category_id])
    end

    if params[:address_id].present?
      @reports = @reports.where(address_id: params[:address_id])
    end

    if params[:search].present?
      @reports = @reports.where('title LIKE ? OR description LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    end
  end

  def show
    authorize_view
  end

  def new
    @report = current_user.reports.build
  end

  def create
    @report = current_user.reports.build(report_params)
    if @report.save
      redirect_to reports_path, notice: 'Report criado com sucesso e está aguardando a aprovação da equipe de moderação.'
    else
      render :new
    end
  end

  def edit
    authorize_view
  end

  def update
    if params[:report][:remove_images]
      params[:report][:remove_images].each do |image_id|
        image = @report.images.find(image_id)
        image.purge
      end
    end

    if @report.update(report_params.except(:images))
      if params[:report][:images]
        params[:report][:images].each do |image|
          @report.images.attach(image)
        end
      end
      redirect_to @report, notice: 'Report atualizado com sucesso.'
    else
      render :edit
    end
  end

  def pending
    if current_user.admin? || current_user.moderator?
      @reports = Report.where(status: :pending)
    else
      redirect_to reports_path, alert: 'Não atorizado'
    end
  end

  def approve
    if @report.approved!
      redirect_to reports_path, notice: 'O report foi aprovado com sucesso.'
    else
      redirect_to reports_path, alert: 'Falha na aprovação do report.'
    end
  end

  def destroy
    @report.destroy
    redirect_to reports_path, notice: 'O report foi deletado com sucesso.'
  end

  def new
    @report = current_user.reports.build
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def authorize_user!
    redirect_to reports_path, alert: 'Você não está autorizado a editar esse report.' unless @report.user == current_user || current_user.admin?
  end

  def authorize_view
    unless @report.approved? || @report.user == current_user || current_user.admin? || current_user.moderator?
      redirect_to(root_path, alert: 'Não autorizado')
    end
  end

  def report_params
    params.require(:report).permit(:title, :description, :category_id, :address_id, :status, images:[], )
  end
end
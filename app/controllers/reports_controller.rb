class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]
  def index
    @reports = Report.all
    #render json: @reports
  end

  def show
    @report = Report.find(params[:id])
  end

  def new
    @report = current_user.reports.build
  end

  def create
    @report = current_user.reports.build(report_params)
    if @report.save
      redirect_to reports_path, notice: 'Report was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @report.update(report_params)
      redirect_to reports_path, notice: 'Report was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def authorize_user!
    redirect_to reports_path, alert: 'You are not authorized  to edit this report.' unless @report.user == current_user
  end

  def report_params
    params.require(:report).permit(:title, :description, :category_id, :address_id)
  end
end
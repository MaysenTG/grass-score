class ReportsController < ApplicationController
  before_action :set_model
  before_action :set_report, only: [:show]

  def index
  end

  def show
  end

  def set_record
    model = params[:model].constantize
    return if model.nil?

    @record = model.find(params[:id])
  end

  def set_model
    @model = params[:model]

    redirect_to reports_path, notice: "#{params[:model]} is not a valid model" if @model.nil?
  end
end

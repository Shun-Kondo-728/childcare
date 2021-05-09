class CalenderController < ApplicationController
  def index
    @calenders = Calender.all
  end

  def new
    @calender = Calender.new
  end

  def show
    @calender = Calender.find(params[:id])
  end

  def create
    Calender.create(calender_params)
    redirect_to calenders_path
  end

  def destroy
    @calender = Calender.find(params[:id])
    @calender.destroy
    redirect_to calenders_path, notice: "削除しました"
  end

  def edit
    @calender = Calender.find(params[:id])
  end

  def update
    @calender = Calender.find(params[:id])
    if @calender.update(calender_parameter)
      redirect_to calenders_path, notice: "編集しました"
    else
      render 'edit'
    end
  end

  private

  def calender_params
    params.require(:calender).permit(:name, :start_time)
  end
end

class BandsController < ApplicationController
  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      render :show
    else
      flash.now[:errors] = ["Band name couldn't be saved"]
      render :new
    end
  end

  def index
    @bands = Band.all
    render :index
  end

  def show
    @band = Band.find_by(id: params[:id])
    render :show
  end



  private

  def band_params
    params.require(:band).permit(:name)
  end
end

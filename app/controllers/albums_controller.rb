class AlbumsController < ApplicationController

  def new
    @bands = Band.all
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      render :show
    else
      flash.now[:errors] = [@album.errors.full_messages]
      flash.now[:errors] << ["Album couldn't be added"]
      @bands = Band.all
      @album = Album.new
      render :new
    end
  end

  def show
    @album = Album.find_by(album_params)
    render :show
  end

  private

  def album_params
    params.require(:album).permit(:title, :version)
  end
end

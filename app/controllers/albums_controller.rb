class AlbumsController < ApplicationController
  before_action :set_album, only: %i[ show edit update destroy ]

  # GET /albums or /albums.json
  def index
    @collection = Collection.find(params[:collection_id])
    @albums = @collection.albums
  end

  # GET /albums/1 or /albums/1.json
  def show
    @collection = Collection.find(params[:collection_id])
    @album = @collection.albums.find(params[:id])
  end

  # GET /albums/new
  def new
    @collection = Collection.find(params[:collection_id])
    @album = @collection.albums.new
  end

  # GET /albums/1/edit
  def edit
    @collection = Collection.find(params[:collection_id])
    @album = @collection.albums.find(params[:id])
  end

  # POST /albums or /albums.json
  def create
    @collection = Collection.find(params[:collection_id])
    @album = @collection.albums.create(album_params)

    respond_to do |format|
      if @album.save
        format.html { redirect_to collection_albums_url,
        notice: "Álbum criado com sucesso." }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1 or /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to @album, notice: "Album was successfully updated." }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1 or /albums/1.json
  def destroy
    @collection = Collection.find(params[:collection_id])
    @album = @collection.albums.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to collection_albums_url,
      notice: "Album deletado com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Collection.find(params[:collection_id]).albums.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def album_params
      params.require(:album).permit(:title, :poster, :description)
    end
end

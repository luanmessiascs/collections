class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]

  # GET /items or /items.json
  def index
    @collection = Collection.find(params[:collection_id])
    @album = @collection.albums.find(params[:album_id])
    @items = @album.items
  end

  # GET /items/1 or /items/1.json
  def show
    @collection = Collection.find(params[:collection_id])
    @album = @collection.albums.find(params[:album_id])
    @item = @album.items.find(params[:id])
  end

  # GET /items/new
  def new
    @collection = Collection.find(params[:collection_id])
    @album = @collection.albums.find(params[:album_id])
    @item = @album.items.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items or /items.json
  def create
    @collection = Collection.find(params[:collection_id])
    @album = @collection.albums.find(params[:album_id])
    @item = @album.items.create(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to collection_album_item_url(@collection, @album, @item),
        notice: "Item criado com sucesso." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @collection = Collection.find(params[:collection_id])
    @album = @collection.albums.find(params[:album_id])
    @item = @album.items.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to collection_album_items_url,
      notice: "Item deletado com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @collection = Collection.find(params[:collection_id])
      @album = @collection.albums.find(params[:album_id])
      @item = @album.items.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:title, :description)
    end
end

class BookmarksController < ApplicationController

  before_action :set_list, only: [:edit, :create, :update, :show, :destroy]

  def index
    @bookmarks = Bookmark.all
  end

  def show
    @bookmarks = Bookmark.find(params[:id])
  end

  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      raise
      render :new
    end
  end

  def edit
    @bookmarks = Bookmark.find(params[:id])
  end

  def update
    if @bookmarks.update(bookmark_params)
      redirect_to bookmark_path(@bookmarks)
    else
      render :new
    end
  end

  def destroy
    @bookmarks.destroy
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end

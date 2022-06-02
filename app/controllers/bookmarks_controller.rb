class BookmarksController < ApplicationController
  before_action :set_bookmarks, only: [:show, :edit, :update, :destroy]

  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  def create
    @bookmark = Bookmark.new(bookmarks_params)
    @list = List.find(params[:list_id])
    @bookmark.list = @list
    # @movie = Movie.find(params[:bookmark][:movie])
    # @bookmark.movie = @movie
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to bookmark_url, notice: 'bookmark was successfully destroyed.'
  end

  private

  def set_bookmarks
    @bookmark = Bookmark.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bookmarks_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end

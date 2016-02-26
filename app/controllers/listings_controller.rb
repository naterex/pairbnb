class ListingsController < ApplicationController
  before_action :find_listing, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :create, :edit, :update, :delete]

  def new
    @listing = current_user.listings.build
  end

  def create
    @listing = current_user.listings.build(listing_params)

    if @listing.save
      redirect_to @listing
    else
      flash.now[:error] = @listing.errors.full_messages.first
      render 'new'
    end
  end

  def show
  end

  def homepage
    @listings = Listing.all
  end

  def index
    if params[:search]
      if params[:search] == ""
        @index_title = "All Listings"
      else
        @index_title = "Search results for: '#{params[:search]}' "
      end

      @listings = Listing.search(params[:search]).order("created_at DESC")
    else
      @index_title = "My Listings"
      @listings = current_user.listings.all
    end
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      flash.now[:success] = "Successfully updated listing."
      redirect_to @listing
    else
      flash.now[:error] = @listing.errors.full_messages.first
      render 'edit'
    end
  end

  def destroy
    @listing.destroy
    flash.now[:success] = "Successfully deleted listing."
    redirect_to root_path
  end


  private

  def find_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title, :about, :room_type, :property_type, :bedrooms, :bathrooms, :guests, :address, :city, :state, :zip, :country, {photos: []}, :photos_cache, :remove_photos )
  end

end

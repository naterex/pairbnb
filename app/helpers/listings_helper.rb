module ListingsHelper

  def popular_search_for(location)
    listings_path + "?search=" + location.to_s
  end

end

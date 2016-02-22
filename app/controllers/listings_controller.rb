class ListingsController < ApplicationController
  before_action :require_login, only: [:new]

  def index
  end
end

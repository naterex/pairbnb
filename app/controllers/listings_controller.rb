class ListingsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :delete]

  def index
  end
end

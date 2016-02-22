class UsersController < Clearance::UsersController

  def create
    # byebug
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      flash.now[:error] = @user.errors.full_messages.first
      render template: "users/new"
    end
  end

end

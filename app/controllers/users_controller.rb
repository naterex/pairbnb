class UsersController < Clearance::UsersController

  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      flash.now[:error] = @user.errors.full_messages.first
      render template: "users/new"
    end
  end

  private

  def user_from_params
      first_name = user_params.delete(:first_name)
      last_name = user_params.delete(:last_name)
      email = user_params.delete(:email)
      password = user_params.delete(:password)

      Clearance.configuration.user_model.new(user_params).tap do |user|
        user.first_name = first_name
        user.last_name = last_name
        user.email = email
        user.password = password
      end
    end

end

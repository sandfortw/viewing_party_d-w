class Admin::UsersController < ApplicationController

  def show
    @user = User.find(current_user.id)
    render "/users/show"
  end
end
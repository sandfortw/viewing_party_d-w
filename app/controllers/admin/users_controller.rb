# frozen_string_literal: true

module Admin
  class UsersController < Admin::BaseController
    def show
      @user = User.find(current_user.id)
      render '/users/show'
    end
  end
end

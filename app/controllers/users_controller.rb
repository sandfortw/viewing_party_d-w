# frozen_string_literal: true

class UsersController < ApplicationController
  def new; end

  def show; end

  def create
    user = User.new(user_params)
    unless user.save
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to register_path
    else
      flash[:notice] = "User: #{user.name}, has been created!"
      redirect_to user_path(user)
    end
  end

  private
    def user_params
      params.permit(:name, :email)
    end
end

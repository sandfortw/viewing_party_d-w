# frozen_string_literal: true

class UsersController < ApplicationController
  def new; end

  def show
    @user = User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save && params[:password] == params[:password_confirmation]
      flash[:notice] = "User: #{user.name}, has been created!"
      redirect_to user_path(user)
    else
      flash[:alert] = 'Passwords do not match' if params[:password] != params[:password_confirmation]
      flash[:error] = user.errors.full_messages.join(', ')
      redirect_to register_path
    end
  end

  def login_form

  end

def login_user
  user = User.find_by(email: params[:email])
  if user.authenticate(params[:password])
    session[:user_id] = user.id
    flash[:success] = "Welcome, #{user.name}!"
    redirect_to user_path(user)
  else
    flash[:error] = "Sorry, your credentials are bad."
    render :login_form
  end
end

  private

  def user_params
    params.permit(:name, :email, :password)
  end
end

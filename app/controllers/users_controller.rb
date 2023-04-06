# frozen_string_literal: true

class UsersController < ApplicationController
  def new; end

  def show
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      flash[:error] = "You must be logged in or register to access your dashboard."
      redirect_to root_path
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:notice] = "User: #{user.name}, has been created!"
      redirect_to dashboard_path
    else
      flash[:error] = user.errors.full_messages.join(', ')
      redirect_to register_path
    end
  end

  def login_form; end

  def login_user
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}!"
      redirect_to dashboard_path
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form, status: 400
    end
  end

  def logout_user
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out!"
    redirect_to root_path
  end

  
private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end

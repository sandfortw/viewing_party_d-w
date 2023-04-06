class Admin::DashboardController < Admin::BaseController

  def index
    @user = User.find(current_user.id)
    @users = User.where('users.role = 0')
  end

end
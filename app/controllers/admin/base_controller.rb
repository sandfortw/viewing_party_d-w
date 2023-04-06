# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    before_action :require_admin

    private

    def require_admin
      return if current_admin?

      flash[:error] = 'Not Authorized'
      redirect_to root_path
    end
  end
end

class UserController < ApplicationController
  def update
    current_user.status = params[:status]
    current_user.save
  end
end

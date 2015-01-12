class UserController < ApplicationController
  def update
    if current_user.status != params[:status]
      current_user.status = params[:status]
      current_user.save
    end
    UserStatusHistory.create( {
      user_id: current_user.id,
      status: params[:status]
    } )
  end
end

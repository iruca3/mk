class UserController < ApplicationController
  before_action :authenticate_user!
  
  def update
    if current_user.status != params[:status]
      current_user.status = params[:status]
      current_user.save
      UserStatusHistory.create( {
        user_id: current_user.id,
        status: params[:status]
      } )
    end
  end

  def update_option
    unless [ 0, 100, 200 ].index( params[:span].to_i )
      render text: 'Invalid' and return
    end
    current_user.span = params[:span].to_i
    current_user.save

  end
end

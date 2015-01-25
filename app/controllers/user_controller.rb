require 'rss'

class UserController < ApplicationController
  before_action :authenticate_user!
  
  def update
    if ( current_user.last_status && current_user.last_status.status != params[:status] ) || params[:image]
      UserStatusHistory.create( {
        user_id: current_user.id,
        image: params[:image],
        status: params[:status]
      } )
    end
  end

  def update_option
    unless [ 0, 100, 200 ].index( params[:span].to_i )
      render text: 'Invalid' and return
    end
    current_user.span = params[:span].to_i
    current_user.rss_url = params[:rss_url]
    current_user.save

  end

  def rss
    rss = RSS::Parser.parse( current_user.rss_url )
    @article = rss.items.first
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)      not null
#  created_at             :datetime
#  updated_at             :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  failed_attempts        :integer          default(0), not null
#  locked_at              :datetime
#  span                   :integer          default(0), not null
#  rss_url                :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :friend_relations, class_name: 'Friend', foreign_key: :user_id
  has_many :friends, through: :friend_relations, foreign_key: :friend_id, class_name: 'User'
  has_many :user_status_histories

  module Span
    DAILY = 0
    WEEKLY = 100
    MONTHLY = 200
  end

  def span_ms
    if self.span == 0
      return 24 * 60 * 60 * 1000
    elsif self.span == 100
      return 7 * 24 * 60 * 60 * 1000
    else
      return 31 * 24 * 60 * 60 * 1000
    end
  end

  def status_history_json
    history_array = []
    self.user_status_histories.each do |hist|
      hist = hist.decorate
      history_array.push( {
        time: hist.created_at.to_i,
        time_str: hist.created_at.strftime( '%Y/%m/%d %H:%m:%S' ),
        status: hist.status_with_link,
        image_thumb_url: hist.image.url( :thumb2x ),
        image_url: hist.image.url,
        span: self.span_ms
      } )
    end
    JSON.generate( history_array )
  end

  def last_status
    return UserStatusHistory.new( created_at: DateTime.now ) if self.user_status_histories.count <= 0
    return self.user_status_histories.order( 'id DESC' ).first
  end

end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)      not null
#  status                 :text
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
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :friend_relations, class_name: 'Friend', foreign_key: :user_id
  has_many :friends, through: :friend_relations, foreign_key: :friend_id, class_name: 'User'
  has_many :user_status_histories

  def status_history_json
    history_array = []
    self.user_status_histories.each do |hist|
      history_array.push( {
        time: hist.created_at.to_i,
        status: hist.status
      } )
    end
    JSON.generate( history_array )
  end

end

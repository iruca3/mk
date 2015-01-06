# == Schema Information
#
# Table name: friends
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  friend_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Friend < ActiveRecord::Base
  belongs_to :user, foreign_key: :user_id
  belongs_to :friend, foreign_key: :friend_id, class_name: 'User'
end

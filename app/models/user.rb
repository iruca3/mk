# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  status     :text
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  has_many :friend_relations, class_name: 'Friend', foreign_key: :user_id
  has_many :friends, through: :friend_relations, foreign_key: :friend_id, class_name: 'User'
end

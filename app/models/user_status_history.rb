# == Schema Information
#
# Table name: user_status_histories
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  status     :text
#  created_at :datetime
#  updated_at :datetime
#

class UserStatusHistory < ActiveRecord::Base
  belongs_to :user
end

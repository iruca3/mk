# == Schema Information
#
# Table name: user_status_histories
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  status     :text
#  created_at :datetime
#  updated_at :datetime
#  image      :string(255)
#

require 'test_helper'

class UserStatusHistoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

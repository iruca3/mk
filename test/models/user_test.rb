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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

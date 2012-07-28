require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "add_url" do 
    url = "http://galaxyheavyblow.web.fc2.com/"
    user = User.find(1)
    user.add_url(url)
  end

end

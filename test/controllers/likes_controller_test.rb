require 'test_helper'

class LikesControllerTest < ActionController::TestCase
  setup do
    @jen = users(:jen_straight_thirties)
    @jack = users(:jack_straight_thirties)
  end

  test "should post create" do
    post :create, id: @jen, match_id: @jack
    assert_response 302
  end

  test "should post destroy" do
    post :destroy, id: @jen, match_id: @jack
    assert_response 302
  end
end

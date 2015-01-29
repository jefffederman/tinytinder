require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @jen = users(:jen_straight_thirties)
    @jack = users(:jack_straight_thirties)
    @harry = users(:harry_straight_thirties)
    @howard = users(:howard_straight_thirties)
    @richard = users(:richard_straight_thirties)
    @mark = users(:mark_straight_thirties)
    @derek = users(:mark_straight_thirties)

    @ron = users(:ron_gay_twenties)
    @barbara = users(:barbara_straight_twenties)

    @jen.liked_users << @jack
    @jack.liked_users << @jen
    @harry.liked_users << @jen
    @howard.liked_users << @jen
    @jen.rejected_users << @richard
  end

  test "#age_interest" do
    assert_equal([33, 37], @jen.age_interest)
  end

  test "#age_interest=" do
    bill = User.new(login: "bill", age: 30, age_interest: "28 - 32", gender: 'male', gender_interest: 'female')
    assert_equal(28, bill.age_interest_min)
    assert_equal(32, bill.age_interest_max)
  end

  test "#likes_me?" do
    assert(@jen.likes_me?(@jack))
    refute(@jen.likes_me?(@mark))
  end

  test "#sample_compatible_user" do
    sampled_logins = 1000.times.map { @jen.sample_compatible_user.login }

    users_who_like_her_count = sampled_logins.count('harry_straight_thirties') + sampled_logins.count('howard_straight_thirties')
    remaining_users_count = sampled_logins.count('mark_straight_thirties') + sampled_logins.count('derek_straight_thirties')

    refute(sampled_logins.include?('ron_gay_twenties'), "Should not see somone incompatible.")

    refute(sampled_logins.include?('richard_straight_thirties'), "Should not see somone she doesn't like.")

    refute(sampled_logins.include?('jack_straight_thirties'), "Should not see someone compatible but whome she likes already.")

    assert_equal([], sampled_logins.uniq - ['harry_straight_thirties', 'howard_straight_thirties', 'mark_straight_thirties', 'derek_straight_thirties'], "Should only return compatible, not liked, not rejected users.")

    assert_in_delta(666, users_who_like_her_count, 50, 'Should return users who like her ~2/3 of the time.')

    assert_in_delta(333, remaining_users_count, 50, 'Should return other compatible users ~1/3 of the time.')
  end

end

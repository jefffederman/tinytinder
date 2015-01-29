class User < ActiveRecord::Base
  has_many :matches
  has_many :liked_users, through: :matches, source: :liked_user
  has_many :rejects
  has_many :rejected_users, through: :rejects, source: :rejected_user

  validates :login, presence: true, uniqueness: true

  def age_interest
    [age_interest_min, age_interest_max]
  end

  def age_interest=(ages)
    range = ages.split('-').map(&:to_i)
    self.age_interest_min = range.min
    self.age_interest_max = range.max
  end

  def sample_compatible_user
    likes = compatible_users.select { |u| likes_me? u }.shuffle
    others = (compatible_users - likes).shuffle
    [likes.take(2), others.take(1)].flatten.sample
  end

  def likes_me?(other)
    users_who_like_me.include? other
  end

  private

  def users_who_like_me
    self.class.joins(:matches).where(matches: { match_id: id })
  end

  def compatible_users
    all_compatible_users - liked_users - rejected_users
  end

  def all_compatible_users
    users_in_my_age_range.all & users_of_the_right_gender.all & users_ok_with_my_age.all & users_ok_with_my_gender.all
  end

  def users_in_my_age_range
    self.class.where('age BETWEEN ? AND ?', age_interest_min, age_interest_max).where.not(id: id)
  end

  def users_of_the_right_gender
    users = if gender_interest == 'both'
      self.class.all
    else
      self.class.where('gender = ?', gender_interest)
    end
    users.where.not(id: id)
  end

  def users_ok_with_my_age
    self.class.where('age_interest_min <= ? AND age_interest_max >= ?', age, age).where.not(id: id)
  end

  def users_ok_with_my_gender
    self.class.where('gender_interest IN (?, "both")', gender).where.not(id: id)
  end

end

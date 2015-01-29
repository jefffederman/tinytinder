User.destroy_all

logins = (0..999).map { Faker::Internet.user_name << rand(100).to_s }

genders = (0..999).map { ['female', 'male'].sample }

gender_interests = (0..999).map do |n|
  case
  when n < 200
    ['female', 'male'].sample
  when n < 250
    'both'
  else
    if genders[n] == 'female'
      'male'
    else
      'female'
    end
  end
end

twenties_and_below = (0..249).map { rand(18..29) }
thirties = (0..399).map { rand(30..39) }
forties = (0..199).map { rand(40..49) }
fifties = (0..99).map { rand(50..59) }
sixties = (0..29).map { rand(60..69) }
seventies_plus = (0..19).map { rand(70..89) }

ages = [twenties_and_below + thirties + forties + fifties + sixties + seventies_plus].flatten.shuffle
age_interest_maxes = ages.map { |age| age + 2 }
age_interest_mins = ages.map { |age| age - 2 }

(0..999).each do |n|
  User.create(
    login: logins[n],
    gender: genders[n],
    gender_interest: gender_interests[n],
    age: ages[n],
    age_interest_min: age_interest_mins[n],
    age_interest_max: age_interest_maxes[n]
  )
end
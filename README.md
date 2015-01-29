README

Notes:

* `rake db:seed` will populate the database with 1000 users

* Built and tested with Ruby 2.2.0 and Rails 4.2.0

Ideas for improving the match rate:

* Giving users the ability to add photos (or connect photos from an existing account, e.g., Instagram)

* Allow users to add more detailed biographical information

* Giving users the option to answer a few questions that have high predictive value re a romantic connection (and figuring out those questions!)

* Using the above data/questions, create a reductive match score/percentage and front-load (somewhat) according to that

* Get feedback from users who've met matches for dates, see how it compares with the match score and then tinker with the match score weighting/inputs to get something more in line with real world results

Some things I would've done development-wise with more time:

* More efficient query to identify compatible users

* More efficient/flexible weighted sort for compatible users, giving preference to users who already like the user

* More robust/flexible way to collect age range data in user form, e.g., range slider and hidden fields for `age_interest_min` and `age_interest_max`, rather than using custom setter `age_interest=`
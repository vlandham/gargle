# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gargle_session',
  :secret      => 'e4ee6854e14b27cdf8b575c1d47acd13b5cf750ab14520133462cf10bebef194ab919f83cbd6e5f191fed4024805ded5f87a65f4aa6d33a97148fbe3927a06ad'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

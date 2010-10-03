# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gazela_session',
  :secret      => '8d56d6200bf9fcee1629f2d8cf23e07b14a53be416716f617402f472fd51f272e4eb0df8f42a45087f0fd816702cbcf98ca6dcf20fca089f7a18f13965e5299b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

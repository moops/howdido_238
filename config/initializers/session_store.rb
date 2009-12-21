# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_howdido_session',
  :secret      => '11146433b54b4fafaf53724abdb3d6f5998b86ffa85ae11cca66f038d1985e5e47ec96ca4fe86af5b164933f6eadb70257a15640e8ec3cc0c437da73c3934553'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

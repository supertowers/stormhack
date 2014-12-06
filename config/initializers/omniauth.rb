
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
    # provider :facebook, FACEBOOK_APP_ID, FACEBOOK_APP_SECRET
    provider :facebook, "705842406200466", "c8608c9e1273f495f2bbbf4c904bb47b"
end

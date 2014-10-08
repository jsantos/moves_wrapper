class User < ActiveRecord::Base
  def self.initialize_with_omniauth(auth)
  	User.new(
  		provider: auth["provider"],
  		uid: auth["uid"],
  		user_id: auth["extra"]["raw_info"]["userId"],
  		token: auth["credentials"]["token"],
  		refresh_token: auth["credentials"]["refresh_token"],
  		token_expires_at: auth["credentials"]["expires_at"]
  	)
  end

  def moves
  	@moves ||= Moves::Client.new(token)
  end
end
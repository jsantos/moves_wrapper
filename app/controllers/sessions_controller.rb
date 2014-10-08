class SessionsController < ApplicationController
	def create
		puts auth_hash.to_yaml
  	user = User.find_by(provider: auth_hash["provider"].to_s, uid: auth_hash["uid"].to_s) || User.initialize_with_omniauth(auth_hash)
  	user.update_attributes(
  		token: auth_hash["credentials"]["token"],
  		refresh_token: auth_hash["credentials"]["refresh_token"],
  		token_expires_at: auth_hash["credentials"]["expires_at"]
		)
  	session[:user_id] = user.id
  	redirect_to moves_data_url, :notice => "Signed in!"
  end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, :notice => "Signed out!"
	end

	private

	def auth_hash
		request.env["omniauth.auth"]
	end
end
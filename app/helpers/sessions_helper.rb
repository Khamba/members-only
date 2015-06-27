module SessionsHelper

	#return a random remember_token
	def remember_token(length = 32)
		SecureRandom.urlsafe_base64(length)
	end

	private
	#log a user in
	def log_in(user)
		session[:user_id] = user.id
	end

	#get currently looged in user or nil
	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
		if @current_user
			return @current_user
		elsif @current_user = User.find_by(id: cookies.signed[:user_id])
			if @current_user.remember_digest && BCrypt::Password.new(@current_user.remember_digest) == cookies[:remember_token]
				return @current_user
			else
				return @current_user = nil
			end
		else
			return nil
		end
	end

	#redirect not logged in user
	def redirect_not_logged_in_user(path = root_url)
		if current_user.nil?
			redirect_to path
		end
	end

	#redirect logged in user
	def redirect_logged_in_user(path = root_url)
		unless current_user.nil?
			redirect_to path
		end
	end

	#logout current user
	def logout
		@current_user = nil
		session[:user_id] = nil
		session.delete(:user_id)
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	def remember_user_with_signed_cookie(user)
		remember_token = self.remember_token
		user.update_attribute(:remember_digest, BCrypt::Password.create(remember_token))
		cookies[:remember_token] = { value: remember_token, expires: 2.weeks.from_now }
		cookies.signed[:user_id] = { value: user.id, expires: 2.weeks.from_now }
	end

end

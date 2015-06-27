class SessionsController < ApplicationController

	def new
		redirect_logged_in_user
	end

	def create
		redirect_logged_in_user
		@user = User.find_by(email: params[:sessions][:email])
		if @user && @user.authenticate(params[:sessions][:password])
			log_in @user
			if params[:sessions][:remember_me] == '1'
				remember_user_with_signed_cookie(@user)
				flash[:remember_digest] = @user.remember_digest
			end
			redirect_logged_in_user
		else
			flash.now[:error] = 'Invalid email/password combo'
			render 'sessions/new'
		end
	end

	def destroy
		logout
		redirect_not_logged_in_user
	end

end

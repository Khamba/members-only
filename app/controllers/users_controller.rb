class UsersController < ApplicationController

	before_action :redirect_not_logged_in_user, only: :show

	def show
		@user = User.find(params[:id])
	end

	def new
		redirect_logged_in_user
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Welcome #{@user.name} to Saurabh Sikchi's website"
			log_in @user
			redirect_logged_in_user
		else
			flash.now[:error] = "Error signing up"
			render 'users/new'
		end
	end

	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

end

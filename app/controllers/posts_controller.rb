class PostsController < ApplicationController

	before_action :redirect_not_logged_in_user, only: [:new, :create]

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(content: params[:post][:content], user_id: current_user.id)
		if @post.save
			flash[:success] = "Post saved"
			redirect_to root_url
		else
			flash.now[:error] = 'Invalid post'
			render :new
		end
	end

	def index
		@posts = Post.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
	end

	def show
		@post = Post.find(params[:id])
		@current_user = current_user
	end

end

class PostsController < ApplicationController
	before_action :authenticate_user!

	def new
		@post =Post.new
	end
	# creating a new post
	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		if @post.save!
			redirect_to :posts,notice:  "Post added to you profile"
		end
	end

	# index for friends and own posts
	def index
		@our_posts = current_user.posts
		
	end

	# deleting the post
	def destroy
		@post=Post.find(params[:id])
		if @post.user_id == current_user.id
			@post.destroy
			redirect_to :posts,notice:  "Post has been deleted"
		end
	end
	def post_params
		params.permit(:post,:user_id)
	end
end

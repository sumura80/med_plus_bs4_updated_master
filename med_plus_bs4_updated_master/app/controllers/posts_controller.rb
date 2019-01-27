class PostsController < ApplicationController
		before_action :find_post ,only: [:show, :edit, :update, :destroy]
		before_action :authenticate_user!, except:[:index, :show]
		before_action :check_user, except:[:index, :show]

	def index
		if params[:category].blank?
    	@posts = Post.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @posts = Post.where(:category_id => @category_id)
    end
	end

	def show
		 @post = Post.find_by(id: params[:id])
		 @posts = Post.all
		#showでは@postしか使わなかったのでほかを削除
    #@likes = Like.where(prototype_id: params[:id])
    @comments_by_votes = @post.comments.order_by_voute_count
	end

	def new
		#@post = Post.new
		@post = current_user.posts.build
		@categories = Category.all.map{ |c| [c.name, c.id]}
		@post.extraimgs.build
	end

	def create
		@post = current_user.posts.build(post_params)
		@post.category_id = params[:category_id]

		if @post.save
			redirect_to @post
  	else
  		render 'edit'
  	end
	end

	def edit	
		@categories = Category.all.map{ |c| [c.name, c.id]}
	  @post.extraimgs.build
	end

	def update
		 @post.category_id = params[:category_id]
		 
  	if @post.update(post_params)
  		redirect_to post_path
  	else
  		render 'edit'
  	end
	end

	def destroy
		 @post.destroy
  	 redirect_to root_path
	end

	private
  def post_params
  	params.require(:post).permit(:id, :title, :description, :image,
  	 :category_id, :category_id,:title_jp, :description_jp,
  	 extraimgs_attributes:[ :id, :extraimg_name, :extraimage,
  	 	:extraimg_description,:post_id, :_destroy ])
  end

  def find_post
  	@post = Post.find(params[:id])
  end

  def check_user
		unless current_user.admin?
			flash[:alert] = "Sorry, only Administrator can edit"
			redirect_to root_path
		end
	end


end

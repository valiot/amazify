class PagesController < ApplicationController
	def home
		@categories = Category.all
		@articles = Article.where(status: :approved).page(params[:page]).per(12).order(created_at: :desc)
		if params[:slug]
			@category = @categories.find_by(slug: params[:slug])
			@articles = @category.articles.page(params[:page]).per(12).order(created_at: :desc)
			@slug = @category.slug
		end
		respond_to do |format|
			format.html
			format.js
		end
	end

	def registra_face
		@return   	= ''
		@user				=	 User.find_by(id_facebook: params[:id_facebook])
		if !@user
			@user   	= User.new(param_user)
			if @user.save
				@return = 'crd' #Usuario creado
			else
				@return = 'crdE' #Error al crear usuario
			end
		end
		if @return == ''
			json_response(@user)
		else
			render :text => @return
		end
	end

	def param_user
		params.permit(:name, :id_facebook, :email)
	end

	def update_user
		User.update(param_update_user)
		@user				=	 User.find_by(email: params[:email])
		json_response(@user)
	end

	def param_update_user
		params.permit(:name, :email)
	end

	def og_link
		@url				=	Article.find_by(id: params[:id]).link
	end
end

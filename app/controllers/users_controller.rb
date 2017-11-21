class UsersController < ApplicationController
	layout 'og_link', only: [:article]

	def registra_face
		@user = User.find_by(id_facebook: params[:id_facebook])
		if @user
			json_response(@user)
		else
			User.create(param_user)
		end
  end

	def param_user
		params.permit(:name, :id_facebook, :email)
	end

	def update_user
		User.update(param_update_user)
		@user = User.find_by(email: params[:email])
		json_response(@user)
	end

	def param_update_user
		params.permit(:name, :email)
	end

	def article
		if params[:id]
			@url = Article.find(params[:id]).link
		else
			redirect_to "/"
		end
	end

end
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

  def update_user
    @user = User.find_by(email: params[:email])
    if @user
      User.update(param_update_user)
      @new_user = User.find_by(email: params[:email])
      json_response(@new_user)
    end
  end

  def article
    if params[:id]
      @url = Article.find(params[:id]).link
    else
      redirect_to "/"
    end
  end

  private

  def param_user
    params.permit(:name, :id_facebook, :email)
  end

  def param_update_user
    params.permit(:name, :email)
  end

end
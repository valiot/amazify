class UsersController < ApplicationController
  layout 'og_link', only: [:article]
  protect_from_forgery :except =>[:user_assistance]

  def registra_face
    @user = User.find_by(id_facebook: params[:id_facebook])
    if @user
      json_response(@user)
    else
      User.create(param_user)
      subscribe_newsletter
    end
  end

  def update_user
    @user = User.find_by(id_facebook: params[:id_facebook])
    if @user
      if @user.email != params[:email]
        subscribe_newsletter('unsubscribed', @user.email, @user.name)
        subscribe_newsletter()
      end
      User.update(param_user)
      @new_user = User.find_by(email: params[:email])
      json_response(@new_user)
    end
  end

  def user_assistance
    id_user = User.find_by(id_facebook: params[:id_facebook]).id
    UsersAssistance.create(id_user: id_user, from: params[:from])
  end

  def article
    if params[:id]
      @url = Article.find(params[:id]).link
    else
      redirect_to "/"
    end
  end

  def check_newsletter
    @member = Mailchimp.connect.lists(ENV['MAILCHIMP_LIST_ID']).members(params[:email])
    render plain: @member
  end

  def subscribe_newsletter(status = 'subscribed', email = params[:email], name = params[:name])
    Mailchimp.connect.lists(ENV['MAILCHIMP_LIST_ID']).members.create_or_update(
      email_address: email,
      name: name,
      status: status
    )
  end

  private

  def param_user
    params.permit(:name, :id_facebook, :email)
  end

end
class UsersController < ApplicationController
  layout 'og_link', only: [:article, :podcast]
  protect_from_forgery except: :user_assistance

  def register_face
    @user = User.find_by(id_facebook: params[:id_facebook])
    if @user
      json_response(@user)
    else
      data = param_user
      data[:password] = ENV['SECURE_PASSWORD']
      User.create(data)
      subscribe_newsletter
    end
  end

  def update_user
    @user = User.find_by(id_facebook: params[:id_facebook])
    if @user
      if @user.email != params[:email]
        subscribe_newsletter('unsubscribed', @user.email, @user.name)
        subscribe_newsletter
      end
      User.update(param_user)
      @new_user = User.find_by(email: params[:email])
      json_response(@new_user)
    end
  end

  def user_assistance
    user = User.find_by(id_facebook: params[:id_facebook])
    Assistance.create(user: user, from: params[:from])
  end

  def article
    if params[:id]
      @url = Article.find(params[:id]).link
    else
      redirect_to "/"
    end
  end

  def podcast
    if params[:id] && params[:medium]
      medium = params[:medium] + '_link'
      if Podcast.find(params[:id]).respond_to? (medium)
        return Podcast.find(params[:id]).public_send(medium)
      end
    end
    redirect_to "/"
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

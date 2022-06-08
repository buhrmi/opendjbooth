class SessionsController < ApplicationController
  def new
    if params[:provider]
      # Just render the ERB template that automatically makes a POST request to /auth/:provider
      render layout: false
    else
      render inertia: 'sessions/new'
    end
  end

  def create
    if request.env['omniauth.auth'].present?
      create_from_omniauth
    else
      create_from_email
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_url
  end

  private
  def create_from_omniauth
    identity = Identity.from_omniauth!(request.env["omniauth.auth"])
    if identity.dj.nil?
      identity.dj = current_dj || Dj.find_by_email(identity.provider_info['email'])
    end
    if identity.dj.nil?
      unless identity.provider_info['email']
        raise ActionController::BadRequest.new("Sorry, this #{provider.capitalize} account has no verified email address.")
      end
      name = identity.provider_info['name'] || identity.provider_info['nickname'] || identity.provider_info['username']
      identity.dj = Dj.create!(email: identity.provider_info['email'], name: name)
    end
    identity.save!
    session[:dj_id] = identity.dj.id
    # flash[:notice] = "Your #{provider.capitalize} has been linked"
  end

  # def create_from_email
  #   dj = Dj.find_by_email(params[:email])
  #   if dj && dj.authenticate(params[:password])
  #     session[:user_id] = dj.id
  #     flash[:notice] = "You have been logged in."
  #     redirect_to current_user
  #   else
  #     flash[:error] = "Email or password is incorrect. Please try again."
  #     redirect_to new_session_path
  #   end
  # end
end
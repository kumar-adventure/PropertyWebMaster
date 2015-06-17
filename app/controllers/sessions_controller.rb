class SessionsController < ApplicationController
  def create
    user = User.omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    sign_in_and_redirect user
  end

  def destroy
    session[:user_id] = nil
  end
end

# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: :destroy

  def new
    respond_to do |f|
      f.html
      f.js { render 'new' }
    end
  end

  def create
    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password])
      sign_in user
      flash[:success] = "Welcome back, #{current_user.name}!"
    else
      flash.now[:warning] = 'Incorrect email and/or password!'
    end
    respond_to do |f|
      f.js { render 'create' }
    end
  end

  def destroy
    sign_out
    flash[:success] = 'See you later!'
    redirect_to root_path
  end
end

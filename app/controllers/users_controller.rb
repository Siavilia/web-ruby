# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: %i[edit update destroy]
  before_action :set_user!, only: %i[edit update destroy]
  before_action :authorize_user!
  after_action :verify_authorized

  def edit; end

  def destroy
    sign_out
    @user.destroy
    flash[:success] = 'User deleted!'
    redirect_to root_path
  end

  def update
    if @user.update user_params
      flash[:success] = 'Your profile was successfully updated!'
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  def new
    @user = User.new
    respond_to do |f|
      f.html
      f.js
    end
  end

  def create
    @user = User.new user_params
    respond_to do |f|
      if @user.save
        sign_in @user
        flash[:success] = "#{t('.create')}#{current_user.name}!"
      end
      f.js { render 'create' }
    end
  end

  private

  def set_user!
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end

  def authorize_user!
    authorize(@user || User)
  end
end

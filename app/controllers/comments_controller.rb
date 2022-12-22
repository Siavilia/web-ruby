# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_question!
  before_action :set_comment!, except: :create
  before_action :authorize_comment!
  after_action :verify_authorized

  def update
    if @comment.update update_comment_params
      flash[:success] = t('.update')
      # else
      # render :edit
    end
    respond_to do |f|
      f.js { render 'update' }
    end
  end

  def edit
    respond_to do |f|
      f.html
      f.js { render 'edit' }
    end
  end

  def create
    @comment = @question.comments.build create_comment_params

    if @comment.save
      flash[:success] = t('.create')
    else
      @comments = @question.comments.order created_at: :desc
    end
    respond_to do |f|
      f.js { render 'create' }
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = 'Comment deleted!'
    respond_to do |f|
      f.js { render 'delete' }
    end
    # redirect_to question_path(@question)
  end

  private

  def create_comment_params
    params.require(:comment).permit(:body).merge(user: current_user)
  end

  def update_comment_params
    params.require(:comment).permit(:body)
  end

  def set_question!
    @question = Question.find params[:question_id]
  end

  def set_comment!
    @comment = @question.comments.find params[:id]
  end

  def authorize_comment!
    authorize(@comment || Comment)
  end
end

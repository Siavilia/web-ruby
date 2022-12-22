# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :require_authentication, except: %i[show index]
  before_action :set_question!, only: %i[show destroy edit update]
  before_action :authorize_question!
  after_action :verify_authorized
  before_action :new, only: %i[index]

  def index
    @questions = Question.order(created_at: :desc)
  end

  def show
    @comment = @question.comments.build
    @comments = @question.comments.order(created_at: :desc)
  end

  def destroy
    @id = @question.id
    @question.destroy
    flash[:success] = 'Question delete!'
    respond_to do |f|
      f.js { render 'delete' }
    end
  end

  def edit
    respond_to do |f|
      f.html
      f.js { render 'edit' }
    end
  end

  def update
    if @question.update question_params
      flash[:success] = t('.update')
    end
    respond_to do |f|
      f.js { render 'update' }
    end
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build question_params
    flash[:success] = t('.create') if @question.save
    respond_to do |f|
      f.js { render 'create' }
    end
  end

  private

  def set_question!
    @question = Question.find params[:id]
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def authorize_question!
    authorize(@question || Question)
  end

  def check_if_editing
    refuse_with_method_not_allowed if current_user.id != @user.id
  end

  def refuse_with_method_not_allowed
    respond_to do |format|
      format.all { render html: File.read('public/405.html').html_safe, status: :method_not_allowed }
    end
  end
end

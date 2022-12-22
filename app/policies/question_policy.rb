# frozen_string_literal: true

class QuestionPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def update?
    user&.author?(record)
  end

  def destroy?
    user&.author?(record)
  end
end

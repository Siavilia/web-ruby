# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def new?
    true
  end

  def create?
    true
  end

  def edit?
    record == user
  end

  def update?
    record == user
  end

  def destroy?
    record == user
  end
end

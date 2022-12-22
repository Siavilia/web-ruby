# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  after(:all) { User.delete_all }
  it 'validates a normal user' do
    user = User.new(email: 'test@test.test', name: 'test', password: 'test', password_confirmation: 'test')
    expect(user).to be_valid
  end

  it 'does not validate empty user' do
    expect(User.new).not_to be_valid
  end

  it 'does not validate a user with mismatching confirmation or invalid email' do
    user_password = User.new(name: 'test', email: 'test@test.test', password: 'pswd', password_confirmation: 'dwsp')
    user_email = User.new(name: 'test', email: 'email', password: 'test', password_confirmation: 'test')
    expect(user_password).not_to be_valid
    expect(user_email).not_to be_valid
  end

  it 'does not validate non-unique email' do
    User.create(name: 'test', email: 'test@test.test', password: 'test')
    match_email = User.new(name: 'new_user', email: 'test@test.test', password: 'test')
    expect(match_email).not_to be_valid
  end
end

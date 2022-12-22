# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
def create_user(name = 'test', email = 'test@test.test', password = 'test')
  User.create(name: name, email: email, password: password)
end

def signin(email = 'test@test.test', password = 'test')
  click_on 'Log In'
  fill_in 'Input e-mail', with: email
  fill_in 'Input a password', with: password
  click_on 'Sign in'
end

RSpec.describe 'Account system', type: :feature do
  before(:each) do
    User.delete_all
    visit root_path
  end

  it 'does not allow to sign in as nonexistent user', js: true do
    signin
    expect(page.body).to include 'Incorrect email and/or password!'
  end

  it 'allows user to sign in', js: true do
    create_user
    signin
    expect(page.body).to include 'test'
  end

  it 'allows to register a user', js: true do
    click_on 'Log In'
    click_on 'Sign Up'
    fill_in 'user[name]', with: 'test'
    fill_in 'user[email]', with: 'test@test.test'
    fill_in 'user[password]', with: 'test'
    fill_in 'user[password_confirmation]', with: 'test'
    click_on 'Register'
    expect(User.find_by(email: 'test@test.test')).not_to be_nil
    expect(page.body).to include 'test'
  end

  it 'not allows to register a user', js: true do
    click_on 'Log In'
    click_on 'Sign Up'
    fill_in 'user[name]', with: ''
    fill_in 'user[email]', with: 'test@test.test'
    fill_in 'user[password]', with: ''
    fill_in 'user[password_confirmation]', with: ''
    click_on 'Register'
    expect(User.find_by(email: 'test@test.test')).to be_nil
    expect(page.body).to include "Password can't be blank"
    expect(page.body).to include "Name can't be blank"
    expect(page.body).to include 'Name is too short (minimum is 2 characters)'
  end

  it 'Should log out', js: true do
    create_user
    signin
    click_on 'test'
    click_on 'Log out'
    expect(page.body).to include('See you later!')
  end

  it 'allows a user to edit own account', js: true do
    visit root_path
    create_user
    signin
    click_on 'test'
    click_on 'Profile'
    fill_in 'user[name]', with: 'newtest'
    click_on 'Save'
    expect(page.body).to include('Your profile was successfully updated!')
    user = User.find_by(email: 'test@test.test')
    expect(user.name).to eq('newtest')
  end

  it 'Should destoy', js: true do
    create_user
    signin
    click_on 'test'
    click_on 'Profile'
    page.accept_confirm do
      click_on 'Delete'
    end
    visit '/'
    expect(User.find_by(email: 'test@test.test')).to be_nil
  end
end

# rubocop:enable Metrics/BlockLength

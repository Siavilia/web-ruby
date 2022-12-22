# frozen_string_literal: true

require 'rails_helper'

def create_question(title = 'title', body = 'body')
  visit '/questions'
  fill_in 'Input a title', with: title
  fill_in 'Input a text', with: body
  click_on 'Submit'
end

def create_user(name = 'test', email = 'test@test.test', password = 'test')
  User.create(name: name, email: email, password: password)
end

def signin(email = 'test@test.test', password = 'test')
  visit root_path
  click_on 'Log In'
  fill_in 'Input e-mail', with: email
  fill_in 'Input a password', with: password
  click_on 'Sign in'
end

RSpec.describe 'Question access system', type: :feature do
  before(:each) do
    create_user
    signin
  end

  it 'allow create question', js: true do
    create_question
    expect(page.body).to include 'title'
    expect(Question.find_by(title: 'title')).not_to be_nil
  end

  it 'allow create comment', js: true do
    create_question
    click_on 'title'
    fill_in 'Input your comment', with: 'commenttest'
    click_on 'Submit'
    expect(page.body).to include 'commenttest'
    expect(Comment.find_by(body: 'commenttest')).not_to be_nil
  end
end

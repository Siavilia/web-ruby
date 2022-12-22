# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  after(:all) { User.delete_all }
  it 'validates a normal comment' do
    user = User.create(email: 'test@test.test', name: 'test', password: 'test')
    question = user.questions.build(title: 'title', body: 'body')
    expect(question.comments.build(body: 'body', user_id: question.user_id)).to be_valid
  end

  it 'does not validate empty comment' do
    expect(Question.new).not_to be_valid
  end
end

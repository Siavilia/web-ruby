# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  after(:all) { User.delete_all }
  it 'validates a normal question' do
    user = User.create(email: 'test@test.test', name: 'test', password: 'test')
    expect(user.questions.build(title: 'title', body: 'body')).to be_valid
  end

  it 'does not validate empty question' do
    expect(Question.new).not_to be_valid
  end
end

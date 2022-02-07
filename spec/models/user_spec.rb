require 'rails_helper'

RSpec.describe User, type: :model do
  
  before do
    @user = User.new(
      name: 'Timothy',
      email: 'tim@bob.com',
      password: 'hashbrown',
      password_confirmation: 'hashbrown',
    )
  end
  
  describe 'Validations' do
    

    it 'saves a user successfully' do
      expect(@user.save).to be true
      expect(@user.errors.full_messages).to be_empty
    end

    it "does not save if password is missing" do
      @user.password = nil
      expect(@user.save).to be false
    end

    it "does not save if password_confirmation is missing" do
      @user.password_confirmation = ''
      expect(@user.save).to be false
    end

    it "does not save if password and password_confirmation are not equal" do
      @user.password = 'bobothy'
      @user.password_confirmation = 'timothy'
      expect(@user.save).to be false
    end

    it "does not save if password is less than 6 characters" do
      @user.password = 'bob'
      @user.password_confirmation = 'tim'
      expect(@user.save).to be false
    end

    it 'does not save if name is missing' do
      @user.name = nil
      @user.save
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'does not save if email is missing' do
      @user.email = nil
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'does not save if email is not unique' do
      @user2 = User.new(
        name: 'Stan',
        email: 'TIM@bob.com',
        password: 'banana',
        password_confirmation: 'banana'
      )
      @user.save
      @user2.save
      expect(@user2.errors.full_messages).to include('Email has already been taken')
    end

  end

  describe '.authenticate_with_credentials' do

    it 'does not authenticat if wrong credentials' do
      @user.save
      email = 'something@bob.com'

      user = User.authenticate_with_credentials(email, @user.password)
      expect(user).to be_nil
    end
    
    it 'authenticates even if theres whitespace around email' do
      @user.save
      email = ' tim@bob.com '

      user = User.authenticate_with_credentials(email, @user.password)
      expect(user).not_to be_nil
    end

    it 'authenticates even if email has wrong casing' do
      @user.save
      email = 'tiM@bob.com'

      user = User.authenticate_with_credentials(email, @user.password)
      expect(user).not_to be_nil
    end

  end
end
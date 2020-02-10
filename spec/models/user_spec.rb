require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "User model validations" do
    it "is valid with valid attributes" do
      expect(User.new(email:'zamirmanihar@yopmail.com', password: '123456')).to be_valid
    end

    it "is not valid without an email" do
      expect(User.new(password: '123456', role: 'owner', status: 'approved', name: 'zamir' )).to_not be_valid
    end

    it "is not valid without a password" do
      expect(User.new(email: 'zamir@gmail.com', role: 'owner', status: 'approved', name: 'zamir' )).to_not be_valid
    end

    it "is not valid without an invalid email" do
      expect(User.new(email: 'zamirgmailcom', password: '123456', role: 'owner', status: 'approved', name: 'zamir' )).to_not be_valid
    end

    it "is not valid when password length is less than 6 character" do
      expect(User.new(email: 'zamir@gmail.com', password: '12345', role: 'owner', status: 'approved', name: 'zamir' )).to_not be_valid
    end
  end
end

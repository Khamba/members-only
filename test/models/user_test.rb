require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(name: 'sample_user', email: 'mail@example.com', password: 'foobar', password_confirmation: 'foobar')
	end
  
	test "rejects invalid emails" do
		@user.email = 'mail@example'
		assert_not @user.save
		@user.email = 'mail@example.jk.hg+12.3'
		assert_not @user.save
		@user.email = 'mailexample'
		assert_not @user.save
		@user.email = '  @example.com'
		assert_not @user.save
		@user.email = nil
		assert_not @user.save
	end

	test "rejects if password and password_confirmation are not same" do
		@user.password_confirmation = 'foo'
		assert_not @user.save
	end

	test "rejects pass less than 5 characters" do
		@user.password = @user.password_confirmation = 'ab'
		assert_not @user.save
	end

	test "rejects blank passwords" do
		@user.password = "       "
		assert_not @user.save
	end

	test "rejects blank name" do
		@user.name = "    "
		assert_not @user.save
	end

	test "accepts all valid data" do
		assert @user.save
	end

end

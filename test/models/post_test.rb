require 'test_helper'

class PostTest < ActiveSupport::TestCase

	def setup
		@post = posts(:post1)
	end
  
	test "content cannot be blank" do
		@post.content = "  "
		assert_not @post.save
	end

	test "user_id cannot be nil" do
		@post.user_id = nil
		assert_not @post.save
	end

	test "valid post is saved" do
		assert @post.save
	end

end

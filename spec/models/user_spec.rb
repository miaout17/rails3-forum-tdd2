# == Schema Information
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  admin                :boolean         default(FALSE)
#
# Indexes
#
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#

require File.expand_path("../../spec_helper.rb", __FILE__)

describe User do
  it "could get its posts" do
    user = Factory(:user)
    post = Factory.build(:post, :user => user)
    post.save
    user.reload
    user.posts.count.should == 1
    user.posts.should include(post)
  end

  it "is not admin by default" do
    user = Factory(:user)
    user.admin?.should == false
  end

  it "cannot modify its admin premission by params" do
    user = Factory(:user)
    params = { :admin => true }
    user.update_attributes(params)
    user.admin?.should == false
  end

end

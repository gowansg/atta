describe Atta::Api do
  context "GET /users/:user_id" do
    it "returns the user with the specified id" do
      user = Fabricate(:user)
      get "/users/#{user.id}"
      last_response.body.should eql user.to_json
    end
  end

  context "POST /users" do
    it "creates and returns a new user" do
      username = "POST /users test"
      attributes = Fabricate.attributes_for(:user, username: username, id: 8)
      post "/users", attributes
      last_response.body.should eql User.first(:username => username).to_json
      end
  end

  context "PUT /users/:user_id" do
    it "returns the updated user" do
      user = Fabricate(:user, active: false, username: "another test passed")
      username = user.username
      put "/users/#{user.id}", user.attributes
      last_response.body.should eql user.to_json
      user.active.should eql false
      user.username.should eql username
    end
  end

  context "DELETE /users/:user_id" do
    it "deletes the specified user" do
      user = Fabricate(:user, username: "delete test")
      User.get(user.id).should_not eql nil
      delete "/users/#{user.id}"
      last_response.body.should eql true.to_json
      User.get(user.id).should eql nil
    end
  end
end
describe Atta::Api do
  context "GET /tags" do
    it "returns all tags" do
      Tag.destroy
      tags = []
      10.times { |i| tags << Fabricate(:tag) }
      get "/tags"
      last_response.body.should eql tags.to_json
    end
  end
  
  context "/tags/:tag_id" do
    it "returns the tag with the specified id" do
      tags = []
      5.times { tags << Fabricate(:tag) }
      tags.each_index do |i|
        get "tags/#{tags[i].id}"
        last_response.body.should eql tags[i].to_json
      end
    end
  end

  context "POST /tags" do
    it "returns the newly created tag" do
      name = "test"
      post "/tags", :name => name
      last_response.body.should eql Tag.first(:name => name).to_json
    end
  end

  context "/tags/:tag_id" do
    it "returns the updated tag" do
      tag = Tag.first
      name = tag.name = "updated tag"
      put "/tags/#{tag.id}", tag.attributes
      last_response.body.should eql tag.to_json
      tag.name.should eql name
    end
  end

  context "/tags/:tag_id" do
    it "deletes the specified tag" do
      task = Fabricate(:task_with_tags, description: "delete tag task")
      tag = task.tags.first
      delete "/tags/#{tag.id}"
      TagTask.all(:tag => tag).should == []
      Tag.get(tag.id).should eql nil
      Task.get(task.id).should eql task
      task.should_not eql nil
      last_response.body.should eql true.to_json
    end
  end
end
describe Task do

  it "cannot be created without a project id" do
  	task = Task.new
    task = Task.new(:project_id => 12, :id => 12, :name => 'name', :description => 'dsf')
    task.project_id.should eql 12
  end
end
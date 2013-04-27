describe TimeEntry do
  
  it { should belong_to :task }
  it { should validate_presence_of :start_time }
  it { should validate_presence_of :end_time }
  it { should validate_presence_of :type }
  it { should validate_presence_of :created_on }

  describe :type do
    it "should default to :timed" do
      Fabricate(:time_entry).type.should eql :timed
    end
  end
end
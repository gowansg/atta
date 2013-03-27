describe User do
  
  it { should validate_length_of(:username).within(1..50) }

  describe :username do
    it "cannot be whitespace only" do
      user = User.new(:username => "      ")
      user.valid?.should eql false

      user.username = "\n"
      user.valid?.should eql false

      user.username = "\t"
      user.valid?.should eql false

      user.username = "\r"
      user.valid?.should eql false

      user.username = "   \r\n\t"
      user.valid?.should eql false
    end

    it "cannot be longer than 50 characters" do
      User.new(:username => "a" * 51).valid?.should eql false    
    end

    it "can be between 1 and 50 characters" do
      User.new(:username => "b").valid?.should eql true
    end
  end
end
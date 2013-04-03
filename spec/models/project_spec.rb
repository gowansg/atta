describe Project do

  it { should validate_length_of(:name).within(0..50) }
  it { should validate_length_of(:description).within(0..500) }
  it { should validate_presence_of :created_on }
  it { should have_many :tasks }
  it { should have_many :users }
end
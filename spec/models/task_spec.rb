describe Task do
  
  it { should belong_to :project }
  it { should have_many :time_entries }
  it { should validate_length_of(:description).within(0..500) }
  it { should validate_length_of(:name).within(0..100) }
end
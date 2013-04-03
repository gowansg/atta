require_relative "task"

class Project
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :length => 0..50
  property :description, String, :length => 0..500
  property :created_on, DateTime, :required => true, 
    :default => lambda { |r, p| Time.now }, :writer => :private

  property :deleted, Boolean
  property :deleted_on, DateTime

  has n, :users, :through => Resource
  has n, :tasks

  def add_contributors(*contributors)
    contributors.each { |c| users.add(c) unless users.include?(c) }
  end

  def remove_contributors()

  end

  def ==(object)
    return true if self == object
    return @id == object.id
  end
end
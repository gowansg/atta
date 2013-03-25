require "data_mapper"
require_relative "time_entry"

class Task
  include DataMapper::Resource
  
 property :id, Serial
 property :name, String
 property :description, String
 property :project_id, Integer

 has n, :time_entries

 # def initalize(project_id)
 #   @project_id = project_id
 # end
end
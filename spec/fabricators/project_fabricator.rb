Fabricator(:project) do
  id { sequence(:project) }
  name 'Test Project'
  description 'A descriptive description'
end

Fabricator(:project_x, from: :project) do
  name "Project X"
  description "Something something something"
end


Fabricator(:project_runway, from: :project) do

end

Fabricator(:project_gotham, from: :project) do

end
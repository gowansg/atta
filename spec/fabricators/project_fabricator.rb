Fabricator(:project) do
  id { sequence(:project) }
  name 'Test Project'
  description 'A descriptive description'
end

Fabricator(:project_x, from: :project) do
  name "Project X"
  description "Something something something"
end


Fabricator(:project_with_tags, from: :project) do
  name "Project Runway"
  tasks(count: 1) { |attrs, i| Fabricate(:task, :tags => [Fabricate(:tag)]) }
end

Fabricator(:project_with_five_users, from: :project) do
  name "Project Gotham"
  users(count: 5) { |attrs, i| Fabricate(:user, username: "test user#{i}") }
end

Fabricator(:project_with_three_tasks, from: :project) do
  name "Project with tasks"
  tasks(count: 3) { |attrs, i| Fabricate(:task) }
end
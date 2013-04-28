Fabricator(:project) do
  name "Test Project"
  description "A descriptive description"
  users(count: 1) { |attrs| Fabricate(:user) }
end

Fabricator(:project_with_tasks, from: :project) do
  name "Project with some work did"
  tasks(count: 3) { |attrs| Fabricate(:task, project_id: attrs[:id]) }
end

Fabricator(:project_with_tags, from: :project_with_tasks) do
  tasks(count: 4) { |attrs| Fabricate(:task_with_tags, project_id: attrs[:id]) }
end


Fabricator(:project_with_five_users, from: :project) do
  name "A popular project"
  users(count: 5) { |attrs| Fabricate(:user, username: "user#{attrs[:id]}") }
end

Fabricator(:project_with_time_entries, from: :project) do
  tasks(count: 3) do |attrs| 
    Fabricate(:task_with_time_entries, project_id: attrs[:id])
  end
end
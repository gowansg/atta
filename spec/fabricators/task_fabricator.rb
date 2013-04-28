Fabricator(:task) do
  name { |attrs| "task#{attrs[:id]}" }
  description { |attrs| "description for #{attrs[:name]}" }
  project
end

Fabricator(:task_with_tags, from: :task) do
  tags(count: 4) { |attrs, i| Fabricate(:tag) }
end

Fabricator(:task_with_time_entries, from: :task) do
  time_entries(count: 2) { |attrs| Fabricate(:time_entry, task_id: attrs[:id]) }
end
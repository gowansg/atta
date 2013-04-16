Fabricator(:task) do
  id { sequence(:task) }
  name { |attrs| "task#{attrs[:id]}" }
  description { |attrs| "description for #{attrs[:name]}" }
end
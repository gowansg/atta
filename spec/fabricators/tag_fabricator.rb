Fabricator(:tag) do
  id { sequence(:tag) }
  name { |attrs| "tag#{attrs[:id]}" }
end

Fabricator(:test_tag, from: :tag) do
  name "test"
end
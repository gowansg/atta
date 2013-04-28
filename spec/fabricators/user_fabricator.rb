Fabricator(:user) do
  username { |attrs| "user#{attrs[:id]}" }
  email { |attrs| "#{attrs[:username]}@email.com" }
end

Fabricator(:user_with_two_projects, from: :user) do
  projects(count: 2) do |i| 
    Fabricate(:project, description: "existing project#{i}", 
      project_user_id: attrs[:id] )
  end
end

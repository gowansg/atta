Fabricator(:user) do
  username { |attrs| "user#{attrs[:id]}" }
  email { |attrs| "#{attrs[:username]}@email.com" }
end
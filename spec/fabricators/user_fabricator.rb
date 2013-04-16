Fabricator(:user) do
  id { sequence(:user) }
  username "Dr. Hand Banana"
end

Fabricator(:test_user, from: :user) do

end

Fabricator(:gowansg, from: :user) do
end
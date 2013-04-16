Fabricator(:time_entry) do
  id { sequence(:time_entry) }
  start_time { Time.now }
  end_time { |attrs| attrs[:start_time] + (60 * 15) }
  created_on { |attrs| attrs[:start_time] }
  type :timed
end
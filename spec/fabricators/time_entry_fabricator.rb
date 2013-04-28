Fabricator(:time_entry) do
  start_time { Time.now }
  end_time { |attrs| attrs[:start_time] + (60 * 15) }
  type :timed
  task
end
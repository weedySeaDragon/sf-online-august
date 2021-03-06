After '@javascript' do
  Capybara.send('session_pool').each do |_, session|
    next unless session.driver.is_a?(Capybara::Poltergeist::Driver)
    session.driver.restart
  end
end

Before '@stripe' do
  StripeMock.start
end

After '@stripe' do
  StripeMock.stop
end

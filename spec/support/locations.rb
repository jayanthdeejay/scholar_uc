# frozen_string_literal: true
module Locations
  def go_to_dashboard_works
    visit '/dashboard/works'
    expect(page).to have_selector('li.active', text: "My Works")
  end

  def go_to_user_profile
    within '#user_utility_links' do
      first(".dropdown a").click
      click_link "View Profile"
    end
  end
end

RSpec.configure do |config|
  config.include Locations
end

# frozen_string_literal: true

Given('the user is on the {string} page') do |page_nm|
  case page_nm.downcase
  when 'sign in'
    visit new_user_session_path
  when 'new auction'
    visit new_auction_item_path
  else
    raise 'Unknown path'
  end
end

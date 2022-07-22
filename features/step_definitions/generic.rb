# frozen_string_literal: true

Before do
  @data = ActiveSupport::HashWithIndifferentAccess.new
end

def human_to_factory(class_name)
  class_name.downcase.underscore.gsub(' ', '_')
end

def create_object(factory_name, factory_opts = {}, data_label = nil)
  @data[data_label || factory_name] = FactoryBot.create(factory_name, factory_opts)
end

Given('the user is logged in') do
  visit new_user_session_path
  fill_in 'Email', with: @data['user'].email
  fill_in 'Password', with: 'test123456'
  click_on 'Log in'
  expect(page).to have_content('Signed in successfully.')
end

Given('a {string} exists') do |class_name|
  create_object(human_to_factory(class_name))
end

Given('the {string} has the attribute {string} with value of {string}') do |class_name, attribute_name, val|
  update_hash = { attribute_name => val }
  @data[human_to_factory(class_name)].update(update_hash)
end

Given('the user has a list of {string}') do |class_name|
  5.times do
    create_object(human_to_factory(class_name), user: @data[:user])
  end
end

Given('the user has a {string}') do |class_name|
  create_object(class_name, user: @data[:user])
end

Given('the user has a {string} known as {string}') do |class_name, label|
  create_object(human_to_factory(class_name), { user: @data[:user] }, label)
end

Then('the user should see {string}') do |content|
  expect(page).to have_content(content)
end

Then('the user should not see {string}') do |content|
  expect(page).to_not have_content(content)
end

Given('the {string} has {int} {string}') do |owner, count, class_name|
  count.times do
    create_object(human_to_factory(class_name), { human_to_factory(@data[owner].model_name.human) => @data[owner] })
  end
end

When('the user fills in {string} with {string}') do |field, value|
  fill_in field, with: value
end

When('the user presses {string}') do |button|
  click_on button
end

Given('the {string} has a {string}') do |owner, class_name|
  obj = FactoryBot.build(class_name.downcase.underscore)
  @data[owner].send("#{human_to_factory(class_name)}=", obj)
  @data[owner].save
end

When('the user clicks on {string}') do |string|
  click_on string
end

Then('the user does not see the {string}') do |data_class|
  model = @data[data_class]
  expect { page.find(id: dom_id(model)) }.to raise_error(Capybara::ElementNotFound)
end

Given('the user is on the page for the {string}') do |class_name|
  url = polymorphic_path(@data[class_name])
  visit url
end

When('the user selects {string} from {string}') do |value, label|
  select value, from: label
end

When('the user selects {string} from {string} within the {string} section') do |value, label, aria_label|
  within("[aria-label='#{aria_label}']") do
    select value, from: label
  end
end

Then('the user should see {string} within the {string} section') do |content, aria_label|
  within("[aria-label='#{aria_label}']") do
    expect(page).to have_content(content)
  end
end

When('the user presses {string} within {string}') do |btn_label, aria_label|
  within("[aria-label='#{aria_label}']") do
    click_on btn_label
  end
end

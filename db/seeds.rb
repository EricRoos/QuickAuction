user = AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
puts "Seeded Admin User #{user.email}"

5.times do
  user = FactoryBot.create(:user)
  puts "Seeded: #{user.email}"
end
Rake::Task['feature_flags:init'].invoke
Rake::Task['contracts:init'].invoke
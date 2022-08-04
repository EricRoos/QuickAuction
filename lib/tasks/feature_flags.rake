# frozen_string_literal: true

namespace :feature_flags do
  task reset: :environment do
    Flipper::Adapters::ActiveRecord::Feature.destroy_all
    Rake::Task['feature_flags:init'].invoke
  end
  task init: :environment do
    config_path = Rails.root.join('config', 'feature_flags.yml')
    yml = YAML.load_file(config_path)[Rails.env]
    yml.each do |feature, enabled|
      if Flipper::Adapters::ActiveRecord::Feature.where(key: feature).exists?
        puts "#{feature} already exists. Skipping."
        next
      end
      method_map = { true => :enable, false => :disable }
      method = method_map[enabled]
      puts "Flipper.#{method} #{feature}"
      Flipper.send(method, feature)
    end
  end
end

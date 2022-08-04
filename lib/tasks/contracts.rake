# frozen_string_literal: true

namespace :contracts do
  task reset: :environment do
    FinePrint::Contract.destroy_all
    Rake::Task['contracts:init'].invoke
  end

  task init: :environment do
    I18n.t('contracts').each do |contract_name, details|
      if FinePrint::Contract.where(name: contract_name).exists?
        puts "#{contract_name} exists. Skipping."
        next
      end
      puts "Seeding contract #{contract_name}"
      FinePrint::Contract.create(name: contract_name, content: details['content_html'], title: details['title'])
    end
  end
end

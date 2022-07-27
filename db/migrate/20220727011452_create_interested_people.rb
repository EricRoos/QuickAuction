class CreateInterestedPeople < ActiveRecord::Migration[7.0]
  def change
    create_table :interested_people do |t|
      t.string :email

      t.timestamps
    end
  end
end

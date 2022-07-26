class CreateHelpArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :help_articles do |t|
      t.string :title

      t.timestamps
    end
  end
end

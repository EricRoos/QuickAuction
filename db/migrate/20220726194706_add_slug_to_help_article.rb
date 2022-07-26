class AddSlugToHelpArticle < ActiveRecord::Migration[7.0]
  def change
    add_column :help_articles, :slug, :string
    add_index :help_articles, :slug
  end
end

class AddContentAndTitleToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :content, :string
    add_column :documents, :title, :string
  end
end

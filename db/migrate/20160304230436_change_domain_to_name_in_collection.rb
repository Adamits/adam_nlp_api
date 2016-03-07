class ChangeDomainToNameInCollection < ActiveRecord::Migration
  def change
    rename_column :collections, :domain, :name
  end
end

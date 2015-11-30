class CreateCollection < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :domain, :default => "general"
      t.integer :document_frequency
    end
  end
end

class CreateCollectionTerm < ActiveRecord::Migration
  def change
    create_table :collection_terms do |t|
      t.belongs_to :collection, index: true
      t.belongs_to :term, index: true
      t.integer :document_frequency
    end
  end
end

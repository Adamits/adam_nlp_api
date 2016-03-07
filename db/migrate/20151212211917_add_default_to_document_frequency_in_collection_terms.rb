class AddDefaultToDocumentFrequencyInCollectionTerms < ActiveRecord::Migration
  def change
    change_column :collection_terms, :document_frequency, :integer, :default => 0
  end
end

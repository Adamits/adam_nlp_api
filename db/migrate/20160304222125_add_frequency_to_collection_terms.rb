class AddFrequencyToCollectionTerms < ActiveRecord::Migration
  def change
    add_column :collection_terms, :frequency, :integer, :default => 0
  end
end

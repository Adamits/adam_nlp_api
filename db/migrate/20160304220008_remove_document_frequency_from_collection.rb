class RemoveDocumentFrequencyFromCollection < ActiveRecord::Migration
  def change
    remove_column :collections, :document_frequency, :integer
  end
end

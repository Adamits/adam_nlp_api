class AddDocumentFrequencyToTerm < ActiveRecord::Migration
  def change
    add_column :terms, :document_frequency, :integer, :default => 0
  end
end

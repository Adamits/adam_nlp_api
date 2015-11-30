class AddDefaultValueToFrequencyAttribute < ActiveRecord::Migration
  def change
    change_column :document_terms, :frequency, :integer, :default => 0
  end
end

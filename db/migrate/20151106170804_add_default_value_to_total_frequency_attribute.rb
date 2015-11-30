class AddDefaultValueToTotalFrequencyAttribute < ActiveRecord::Migration
  def change
    change_column :terms, :total_frequency, :integer, :default => 0
  end
end

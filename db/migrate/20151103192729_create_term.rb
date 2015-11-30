class CreateTerm < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :name
      t.integer :total_frequency
    end
  end
end

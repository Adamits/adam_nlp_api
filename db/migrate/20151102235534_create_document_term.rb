class CreateDocumentTerm < ActiveRecord::Migration
  def change
    create_table :document_terms do |t|
      t.belongs_to :document, index: true
      t.belongs_to :term, index: true
      t.integer :frequency
    end
  end
end

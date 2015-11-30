class DocumentTerm < ActiveRecord::Base

  belongs_to :document
  belongs_to :term
  has_many :documents, through: :document_terms
end

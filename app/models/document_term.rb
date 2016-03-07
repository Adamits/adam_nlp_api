class DocumentTerm < ActiveRecord::Base

  belongs_to :document
  belongs_to :term
end

class CollectionTerm < ActiveRecord::Base

  belongs_to :collection
  belongs_to :term
end

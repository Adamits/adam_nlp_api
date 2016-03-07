class Collection < ActiveRecord::Base

  has_many :documents
  has_many :collection_terms
  has_many :terms, through: :collection_terms
end

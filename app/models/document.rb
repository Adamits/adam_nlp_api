class Document < ActiveRecord::Base

  belongs_to :collection
  has_many :document_terms
  has_many :terms, through: :document_terms
  has_many :bigrams

  #after a document is created, associate term objects to it, and increment the tf, df, and total_frequencies of those terms.
  after_create :generate_terms, :update_document_frequencies_of_terms

  def contains_term?(term_name)
    term = Term.where(name: term_name)
    terms.include?(term)
  end

  def add_to_collection(collection_name)
    collection = Collection.where(domain: collection_name).last || Collection.new(domain: collection_name)
    collection.documents << self
    collection.save
  end

  private
  def generate_terms
    tokenize(content).each do |token|
      term = Term.where(name: token).last || Term.create(name: token)
      term.update_attributes(total_frequency: term.total_frequency + 1)
      self.terms << term
      document_term = DocumentTerm.where(term_id: term, document_id: self).last || DocumentTerm.create(term_id: term, document_id: self)
      document_term.update_attributes(frequency: document_term.frequency + 1)
    end
  end

  def update_document_frequencies_of_terms
    terms.each do |term|
      term.update_attributes(document_frequency: term.document_frequency + 1)
    end
  end

  def tokenize(string)
    tokens = (string).gsub(/[^a-zA-Z0-9 - ' _]/, "").downcase
    tokens.split(' ')
  end
end

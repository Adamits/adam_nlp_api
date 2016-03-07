class Document < ActiveRecord::Base

  belongs_to :collection
  has_many :document_terms
  has_many :terms, through: :document_terms
  has_many :bigrams

  #after a document is created, associate term objects to it, and increment the tf, df, and total_frequencies of those terms.
  after_create :generate_or_update_terms
  before_destroy :decrement_document_frequencies_of_terms

  def contains_term?(term_name)
    term = Term.where(name: term_name)
    terms.include?(term)
  end

  private
  def generate_or_update_terms
    tokenize(title + content).each do |token|
      term = Term.where(name: token).last || Term.create(name: token)
      unless has_term?(term)
        self.terms << term
        collection.terms << term
        term.increment_document_frequency
        term.increment_document_frequency_by_collection(collection)
      end
      term.increment_term_frequency(self)
      term.increment_term_frequency_by_collection(collection)
    end
  end

  def decrement_document_frequencies_of_terms
    terms.each do |term|
      term.decrement_document_frequency
      term.decrement_document_frequencies_of_terms_by_collection(collection)
    end
  end

  def tokenize(string)
    tokens = (string).gsub(/[^a-zA-Z0-9 - ' _]/, "").downcase
    tokens.split(' ')
  end

  def has_term?(term)
    terms.include?(term)
  end
end

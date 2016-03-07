class Term < ActiveRecord::Base
  belongs_to :bigram
  has_many :document_terms
  has_many :collection_terms
  has_many :documents, through: :document_terms, dependent: :destroy
  has_many :collections, through: :collection_terms, dependent: :destroy

  validates_presence_of :name

  def frequency(document)
    document_terms.where(document: document).last.frequency
  end

  def tf_score(document)
    frequency(document).to_f / document.document_terms.count.to_f
  end

  def tf_idf(document)
    idf_score = Math.log(Document.count.to_f / (document_frequency == 0 ? 1 : document_frequency).to_f)
    tf_score(document) * idf_score
  end

  def document_frequency_by_collection(collection)
    collection_terms.where(collection_id: collection).last.document_frequency
  end

  def frequency_by_collection(collection)
    collection_terms.where(collection: collection).last.frequency
  end

  def tf_idf_by_collection(document, collection)
    idf_score = Math.log(Document.count.to_f / (document_frequency_by_collection(collection) == 0 ? 1 : document_frequency_by_collection(collection)).to_f)
    tf_score(document) * idf_score
  end

  def increment_term_frequency(document)
    update_attributes(total_frequency: total_frequency + 1)
    document_term = document_terms.where(document_id: document.id).last
    document_term.update_attributes(frequency: document_term.frequency + 1)
  end

  def decrement_term_frequency(document)
    update_attributes(total_frequency: total_frequency - 1)
    document_term = document_terms.where(document_id: document.id).last
    document_term.update_attributes(frequency: frequency - 1)
  end

  def increment_document_frequency
    update_attributes(document_frequency: document_frequency + 1)
  end

  def decrement_document_frequency
    update_attributes(document_frequency: document_frequency - 1)
  end

  def increment_term_frequency_by_collection(collection)
    collection_term = collection_terms.where(collection_id: collection.id).last
    collection_term.update_attributes(frequency: collection_term.frequency + 1)
  end

  def decrement_term_frequency_by_collection(collection)
    collection_term = collection_terms.where(collection_id: collection.id).last
    collection_term.update_attributes(frequency: collection_term.frequency - 1)
  end

  def increment_document_frequency_by_collection(collection)
    collection_term = collection_terms.where(collection_id: collection.id).last
    collection_term.update_attributes(document_frequency: collection_term.document_frequency + 1)
  end

  def decrement_document_frequencies_of_terms_by_collection(collection)
    collection_term = collection_terms.where(collection_id: collection.id).last
    collection_term.update_attributes(document_frequency: collection_term.document_frequency - 1)
  end
end

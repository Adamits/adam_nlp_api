class Term < ActiveRecord::Base

  belongs_to :bigram
  has_many :document_terms

  validates_presence_of :name

  def term_frequency(document)
    document_terms.where(term: self, document: document).last.frequency
  end

  def tf_idf(document)
    tf_score = term_frequency(document).to_f / document.document_terms.count.to_f
    idf_score = Math.log(Document.count.to_f / (document_frequency == 0 ? 1 : document_frequency).to_f)
    tf_score * idf_score
  end
end

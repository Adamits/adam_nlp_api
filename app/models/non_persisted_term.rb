class NonPersistedTerm

  attr_accessor :name, :frequency

  def initialize(name, document_size)
    @name = name
    @frequency = 1.0
    @document_size = document_size
  end

  def document_frequency
    @document_frequency ||= Term.where(name: @name).last ? Term.where(name: @name).last.document_frequency + 1.0 : 1.0
  end

  def increment_frequency
    @frequency += 1.0
  end

  def tf_idf
    tf_score = @frequency / @document_size
    idf_score = Math.log(Document.count.to_f / @document_frequency)
    tf_score * idf_score
  end
end

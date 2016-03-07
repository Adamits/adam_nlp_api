class NonPersistedDocument

  def initialize(options = {})
    @title = options[:title] if options[:title].present?
    @content = options[:content] if options[:content].present?
    @collection_name = options[:collection_name].present? ? options[:collection_name] : "general"
  end

  def terms
    terms_hash = {}
    tokens = tokenize(@title + @content)
    term_count = tokens.size
    tokens.each do |token|
      if terms_hash[token].present?
        terms_hash[token].increment_frequency
      else
        terms_hash[token] = NonPersistedTerm.new(token, term_count)
      end
    end
    terms_hash.values
  end

  private
  def tokenize(string)
    tokens = (string).gsub(/[^a-zA-Z0-9 - ' _]/, "").downcase
    tokens.split(' ')
  end
end

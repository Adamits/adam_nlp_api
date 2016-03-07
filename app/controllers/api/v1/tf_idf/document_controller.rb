module Api::V1
  class TfIdf::DocumentController < ApiController::TfIdfController

    def add
      @document = Document.new(document_params)
      if @document.save
        render json: {success: true}
      end
    end

    def remove

    end

    def update_term_scores
      collection_name = document_params.delete(:collection_name) || "general"
      @collection = Collection.where(name: collection_name).last || Collection.create(name: collection_name)
      @document = Document.new(document_params.merge(collection: @collection))
      @response = {}
      if @document.save
        @document.terms.each do |term|
          @response[term.name] = {term_frequency: term.frequency(@document), document_frequency: term.document_frequency, tf_idf_weighted_score:  term.tf_idf(@document)}
        end
        render json: @response
      end
    end

    def get_term_scores
      @document = NonPersistedDocument.new(document_params)
      @response = {}
      @document.terms.each do |term|
        @response[term.name] = {term_frequency: term.frequency, document_frequency: term.document_frequency, tf_idf_weighted_score:  term.tf_idf}
      end
      render json: @response
    end

    private
    def document_params
      params.require(:document).permit(:title, :content, :collection_name)
    end
  end
end

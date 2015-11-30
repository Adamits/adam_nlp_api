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

    def term_scores
      @document = Document.new(document_params)
      @response = {}
      if @document.save
        @document.terms.each do |term|
          @response[term.name] = {term_frequency: term.term_frequency(@document), document_frequency: term.document_frequency, tf_idf_weighted_score:  term.tf_idf(@document)}
        end
        @document.add_to_collection(params[:document][:collection_name] || "general")
        render json: @response
      end
    end

    private
    def document_params
      params.require(:document).permit(:title, :content)
    end
  end
end

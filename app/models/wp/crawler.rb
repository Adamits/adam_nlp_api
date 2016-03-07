class Wp::Crawler

  def initialize(url, options={})
    @url = Wp::Url.new(url)
    @collection_name = options[:collection_name]
    @keyword = options[:keyword] ? options[:keyword] : ""
  end

  def run
    (url_name_queue = []) << @url.full
    while url_name_queue.any?
      begin
        response = Wp::Response.new(url_name_queue.first)
      rescue ArgumentError
        next
      end
      (@responses ||= []) << response.scrape
      puts generate_payload(response)
      if generate_payload(response)
        HTTParty.post("http://localhost:3000/api/v1/tf_idf/document/term_scores",
          :body => generate_payload(response).to_json,
          :headers => { 'Content-Type' => 'application/json' } )
      end
      (crawled ||= []) << response.url.full
      url_name_queue << response.links.map { |link| link.full if link.crawlable_link?(@url.subdomain) }.compact
      url_name_queue.flatten!.shift
      url_name_queue = url_name_queue - crawled
    end
    @responses
  end

  private
  def generate_payload(response)
    payload = { document: { title: response.title, content: response.content } } unless response.content.blank?
    payload.merge(collection_name: @collection_name) if payload && @collection_name
    payload
  end
end

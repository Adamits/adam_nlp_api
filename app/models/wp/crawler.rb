class Wp::Crawler

  def initialize(url, options={})
    @url = Wp::Url.new(url)
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
      (crawled ||= []) << response.url.full
      url_name_queue << response.links.map { |link| link.full if link.crawlable_link?(@url.subdomain) }.compact
      url_name_queue.flatten!.shift
      url_name_queue = url_name_queue - crawled
      puts "\n \n #{url_name_queue}"
    end
    @responses.count
  end
end

class Wp::Response

  def initialize(url)
    @url = Wp::Url.new(url)
    begin
      @doc = Nokogiri::HTML(open(process_uri(url)))
    rescue
     raise ArgumentError
    end
    @body = @doc.at_css("body")
    @content_wrapper = @body.at_css(".content > .post")
  end

  def url
    @url
  end

  def scrape
    @links = []
    @body.css("a").each do |anchor|
      @links << Wp::Url.new(anchor["href"])
    end
    if @content_wrapper
      @title = @content_wrapper.at_css("h2").text
    end
    self
  end

  def links
    @links || []
  end

  def title
    @title || ""
  end

  private
  def process_uri(uri)
    require 'open-uri'
    require 'open_uri_redirections'
    open(uri, :allow_redirections => :safe) do |r|
      r.base_uri.to_s
    end
  end
end

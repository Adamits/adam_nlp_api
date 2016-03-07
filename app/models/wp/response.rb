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
      p_tag_in_content = @content_wrapper.css("p:nth-of-type(4)").first
      @content = p_tag_in_content.parent.css("p").map(&:text) if p_tag_in_content
      @content.pop if @content
      @content = @content.join(" ") if @content
      # The idea is that 4 <p> tags in a row indicates a high level of certainty that we
      # have a handle on the actual blog content. So we take the text of all <p> tags in the parent
    end
    self
  end

  def links
    @links || []
  end

  def title
    @title || ""
  end

  def content
    @content || ""
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

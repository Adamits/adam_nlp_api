class Wp::Url

  def initialize(url)
    @full = url
  end

  def full
    @full
  end

  def protocol
    @protocol ||= @full.split(":")[0]
  end

  def subdomain
    @subdomain ||= @full.split(".")[0].gsub("#{protocol}://", "")
  end

  def domain
    @domain ||= @full.partition(".")[1].gsub(/\?(.*)/, "")
  end

  def params
    @params ||= @full.split("?")[1] || ""
  end

  def crawlable_link?(original_subdomain)
    @full.present? && subdomain == original_subdomain && !params.match(/replytocom\=|share\=/) && !full.match(/\#comments/)
  end
end

class SiteValidator
  def self.validate(url: url, code: code)
    agent = Mechanize.new
    agent.get(url) do |page|
      content = page.at('meta[@name="stormhack-validation"]')[:content]
      return content == code
    end
  end
end
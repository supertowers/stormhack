class SiteValidator
  def self.validate(url: url, code: code)
    agent = Mechanize.new
    agent.get(url) do |page|
      content = page.at('meta[@name="stormhack-validation"]')
      if content.nil?
        return false
      else
        return content[:content] == code
      end
    end
  end
end
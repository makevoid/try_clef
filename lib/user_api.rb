class UserApi
  def self.get(token:)
    url  = "#{CLEF_API_BASE}/info?access_token=#{token}"
    resp = HTTParty.get url
    user = resp.fetch 'info'
    Hashie::Mash.new user
  end
end

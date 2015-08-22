class Clef
  def self.post(code:)
    data = {
      body: {
        code:       code,
        app_id:     CLEF_APP_ID,
        app_secret: CLEF_APP_SECRET,
      }
    }

    url = "#{CLEF_API_BASE}/authorize"
    HTTParty.post url, data
  end
end

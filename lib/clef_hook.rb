class TryClef < Sinatra::Base
  
  get '/login' do
    validate_state!

    code = params[:code]
    data = {
      body: {
        code:       code,
        app_id:     CLEF_APP_ID,
        app_secret: CLEF_APP_SECRET,
      }
    }

    url = "#{CLEF_API_BASE}/authorize"
    response = HTTParty.post url, data

    if response['success']
      access_token = response.fetch 'access_token'
      url = "#{CLEF_API_BASE}/info?access_token=#{access_token}"
      response = HTTParty.get url

      if response['success']
        info = response.fetch 'info'
        unless user = User.first(clef_id: info['id'])
           user = User.create(
             email:   info['email'],
             clef_id: info['id'],
           )
        end
        session[:user_id] = user[:id]
        @user = user
        redirect "/"
      else
        p response['error']
      end
    else
      p response['error']
    end
  end

  def validate_state!
    is_valid_state = session.has_key?(:state) &&
        session[:state].length > 0            &&
        session[:state] == params[:state]

    if is_valid_state
      session.delete :state
    else
      halt 403, invalid_state_message
    end
  end

  def invalid_state_message
    "The state parameter didn't match what was passed in to the Clef button."
  end

end

class TryClef < Sinatra::Base

  # error handling

  extend StringUtils
  STATUS = Rack::Utils::HTTP_STATUS_CODES.map{ |code, name| Hash[underscore(name), code]  }

  def render_error?(status, response)
    unless response['success']
      p response['error']
      halt STATUS[status], haml(:error)
    end
  end

  # route

  get '/login' do
    validate_state!

    response = Clef.post code: params[:code]
    render_error? :unauthorized, response
    access_token = response.fetch 'access_token'

    api_user = UserApi.get token: access_token
    render_error? :unauthorized, response

    user = User.create(
      email:   api_user.email,
      clef_id: api_user.id,
    ) unless user = User.first(clef_id: api_user.id)

    session[:user_id] = user[:id]
    @user = user
    redirect "/"
  end

  # helpers

  def validate_state!
    if state_valid?
      session.delete :state
    else
      halt 403, invalid_state_message
    end
  end

  def state_valid?
    session.has_key?(:state)      &&
      session[:state].length > 0  &&
      session[:state] == params[:state]
  end

  def invalid_state_message
    "The state parameter didn't match what was passed in to the Clef button."
  end

end

class OAuth2
  
  def initialize(client_id)
    @client = Client.get(client_id) || {}
  end

  def valid_authorization_request?(request_params)
    return request_params[:response_type] =~ /code/i
           && request_params[:client_id] == @client.id
           && valid_redirect_uri?(request_params[:redirect_uri])    
  end

private:

  def valid_redirect_uri?(uri)
    return @client.redirect_uri.casecmp(uri).zero?
  end
end
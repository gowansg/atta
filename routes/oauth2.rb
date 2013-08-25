class Atta::Api < Sinatra::Base
  get "/oauth/authorize", :provides => [:html] do
    client = Client.first(client_id: params[:client_id])
    haml :authorization_notice if client && 
                                  client.redirect_uri
                                        .casesmp(params[:redirect_uri])
                                        .zero?
    
    haml :invalid_client_notice 
  end

  post "/oauth/authorize" do

  end

  post "/oauth/access_token" do
    code = params[:code]
    grant_type = params[:grant_type]
    client_id = params[:client_id]
    client_secret = params[:client_secret]

    Client.first(secret: params[:client_secret])
  end
end
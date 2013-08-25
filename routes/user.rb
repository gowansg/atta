class Atta::Api < Sinatra::Base
  delete "/users/:user_id" do
    user = User.get(params[:user_id])
    user.projects.all.destroy
    user.destroy.to_json
  end

  get "/users/:user_id" do
    User.get(params[:user_id]).to_json
  end

  post "/users" do
    user = User.create(:username => params[:username], :email => params[:email])
    user.to_json if user.valid?
  end
  
  put "/users/:user_id" do
    user = User.get(params[:user_id])
    user.update(:username => params[:username] || user.username,
                :active => params[:active] || user.active,
                :email => params[:email] || user.email)
    user.to_json if user.valid?
  end
end
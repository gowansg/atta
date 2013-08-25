class Atta::Api < Sinatra::Base
  delete "/tags/:tag_id" do
    tag = Tag.get(params[:tag_id])
    tag.tasks.all.destroy
    tag.destroy.to_json 
  end

  get "/tags" do
    respond_with Tag.all
  end

  get "/tags/:tag_id" do
    respond_with Tag.get(params[:tag_id])
  end

  post "/tags" do
    tag = Tag.create(:name => params[:name], :tasks => params[:tasks] || [])
    respond_with tag if tag.valid?
  end

  put "/tags/:tag_id" do
    tag = Tag.get(params[:tag_id])
    tag.update(:name => params[:name] || tag.name)
    respond_with tag if tag.valid?
  end
end
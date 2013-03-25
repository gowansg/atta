require 'sinatra'
require 'openid'


class API < Sinatra::Base

  get '/'

  end

  get '/project/:user_id'

  end

  get '/project/:project_id'

  end

  get '/user/:user_id'

  end

  get '/task/:project_id'

  end

  get '/time_entry/:taskid'

  end
end
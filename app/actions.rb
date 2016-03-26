# Homepage (Root path)
get '/' do
  erb :index
end

get '/dashboard' do
  erb :'dashboard/index'
end

get '/register' do
  erb :'register/index'
end

get '/settings' do
  erb :'settings/index'
end

get '/redirection' do
  erb :'register/redirection'
end
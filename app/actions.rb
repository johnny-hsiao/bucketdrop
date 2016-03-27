require 'pry'
require_relative 'helpers.rb'

# Homepage (Root path)
get '/' do
  erb :index
end

post '/login' do
  user = User.find_by(username: params[:username])
  if user && user[:password] == params[:password]
    session[:login_error] = nil
    session[:user_id] = user[:id]
    redirect :'/dashboard'
  else
    session[:login_error] = "Invalid Username/Password. Please try again."
    erb :index
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect :'/'
end

get '/signup/form' do
  session[:password_match_error] = nil
  session[:signup_error_missing_fields] = nil
  @user = User.new
  erb :signup  
end

post '/signup' do
  # binding.pry
  @user = User.new(
    first_name: params[:first_name], 
    last_name: params[:last_name], 
    username: params[:username], 
    email: params[:email], 
    password: params[:password]
  )
  if params[:password] == params[:confirm_password]
    if @user.save
      redirect :'/signup_success'
    else
      session[:signup_error_missing_fields] = "Missing required fields"
      erb :signup
    end

  else
    session[:password_match_error] = "Passwords do not match."
    erb :signup
  end
end

get '/signup_success' do
  erb :signup_success
end

get '/dashboard' do
  check_user
  @new = params["name"]
  erb :'dashboard/index'
end

post '/buckets/new' do
  check_user
  @bucket = Bucket.new(name: params[:name])
  @bucket.user = @user
  if @bucket.save
    redirect :'/dashboard'
  end
end

post '/buckets/update' do
end

delete '/buckets/delete' do

  check_user
  get_bucket
  @bucket.destroy

  redirect :'/dashboard'
end


put '/items/update' do
  check_user
  get_item
  @item[:name] = params[:name]
  @item.save
  update_bucket(@item)
end

put '/items/update_status' do
  check_user
  get_item
  toggle_status(@item)
  @item.save
  update_bucket(@item)
end

post '/items/new' do
  check_user
  get_bucket
  @item = @bucket.items.new(name: params[:name])
  @item.user = @user
  if @item.save
    update_bucket(@item)
    erb :'dashboard/index'
  end
end


delete '/items/delete' do
  # binding.pry
  check_user
  get_item
  @item.destroy
  redirect :'/dashboard'

end


### bucket requests ###
put '/items/bucket_title' do
  check_user
  get_bucket
  @bucket[:name] = params[:name]
  @bucket.updated_at = Time.now
  @bucket.save
end

delete '/items/delete_bucket' do
  check_user
  get_bucket
  @bucket.destroy
end


### SETTINGS REQUESTS ###
get '/settings' do
  check_user
  erb :'settings/index'
end

put '/settings/update_username_password' do
  check_user
  session[:settings_username_update] = change_username(params[:username])
  session[:settings_password_update] = change_password(params[:old_password], params[:new_password], params[:confirmed_password])
end


get '/friends' do
  erb :'friends/index'
end


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
  @bucket = @user.buckets.new(name: params[:name])
  if @bucket.save
    erb :'dashboard/index'
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

post '/buckets/:id/new_item' do
  # redirect :'/'
  check_user
  puts params
  if params[:name]
    bucket = Bucket.find_by(id: params[:bucket_id])
    item = bucket.items.new(name: params[:name])
    item.save
    erb :'dashboard/index'
  else
    redirect :'/'
  end
end

# post '/items/edit' do
#   # binding.pry
#   # redirect :'/'
#   check_user
#   get_item
#   bucket_id = @item[:bucket_id]
#   @item[:name] = params[:name]
#   if @item.save
#     redirect :'/dashboard'
#   else
#     redirect :'/'
#   end
# end

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

get '/settings' do
  check_user
  erb :'settings/index'
end

post '/bucket/edit' do
  check_user
  get_item
  bucket_id = @item[:bucket_id]
  @item[:name] = params[:name]
  if @item.save
    
    redirect :'/dashboard'
  else
    redirect :'/'
  end
end


get '/test' do
  @new = params[:name]
  @new
end
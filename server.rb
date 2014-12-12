require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require 'rack-flash'
require 'pry-byebug'
require 'json' #why?

#bundle exec ruby server.rb


require_relative 'lib/petshopserver.rb'

# class Petshopserver::Server < Sinatra::Application
  configure do
    set :bind, '0.0.0.0'
    enable :sessions
    use Rack::Flash
  end

  helpers do
    def mydb
      # establish connection to db here
    end
  end

  # before do
  #   if session['user_id']
  #     user_id = session['user_id']
  #     db = Petshopserver.create_db_connection 'petshopserver'
  #     @current_user = Petshopserver::UsersRepo.find db, user_id
  #   else
  #     @current_user = {'username' => 'anonymous', 'id' => 1}
  #   end
  # end

get '/' do
  if session['user_id']
    user_id = session['user_id']
    db = Petshopserver.create_db_connection 'petshopserver'
    @current_user = Petshopserver::UsersRepo.find db, user_id
  else
      @current_user = {'username' => 'anonymous', 'id' => 1}
    end
  erb :index
end

# #
# ...the rest are JSON endpoints
#
get '/shops' do
  headers['Content-Type'] = 'application/json'
  RestClient.get("http://pet-shop.api.mks.io/shops")
end

post '/signin' do
  params = JSON.parse request.body.read

  username = params['username']
  password = params['password']

  # TODO: Grab user by username from database and check password
  #user = { 'username' => 'alice', 'password' => '123' }
  db = Petshopserver.create_db_connection 'petshopserver'
  user = Petshopserver::UsersRepo.find_by_username(db, username)

  if password == user['password']
    headers['Content-Type'] = 'application/json'
    session['user_id'] = user['id']
    # 
    user[:cats] =[]
    user[:dogs] =[]

    user.to_json
    # TODO: Return all pets adopted by this user
    # TODO: Set session[:user_id] so the server will remember this user has logged in
    #$sample_user.to_json
  else
    status 401
  end
end

 # # # #
# Cats #
# # # #
get '/shops/:id/cats' do
  headers['Content-Type'] = 'application/json'
  id = params[:id]
  # TODO: Grab from database instead
  RestClient.get("http://pet-shop.api.mks.io/shops/#{id}/cats")
end

put '/shops/:shop_id/cats/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  id = params[:id]
  # TODO: Grab from database instead
  RestClient.put("http://pet-shop.api.mks.io/shops/#{shop_id}/cats/#{id}",
    { adopted: true }, :content_type => 'application/json')
  # TODO (after you create users table): Attach new cat to logged in user
end


 # # # #
# Dogs #
# # # #
get '/shops/:id/dogs' do
  headers['Content-Type'] = 'application/json'
  id = params[:id]
  # TODO: Update database instead
  RestClient.get("http://pet-shop.api.mks.io/shops/#{id}/dogs")
end

put '/shops/:shop_id/dogs/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  id = params[:id]
  # TODO: Update database instead
  RestClient.put("http://pet-shop.api.mks.io/shops/#{shop_id}/dogs/#{id}",
    { adopted: true }, :content_type => 'application/json')
  # TODO (after you create users table): Attach new dog to logged in user
end


# $sample_user = {
#   id: 999,
#   username: 'alice',
#   cats: [
#     { shop_id: 1, name: "NaN Cat",  adopted: true, id: 44 },
#     { shop_id: 8, name: "Meowzer",  id: 8, adopted: "true" }
#   ],
#   dogs: [
#     { shop_id: 1, name: "Leaf Pup", id: 2, adopted: "true" }
#   ]
# }

# end 
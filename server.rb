require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require 'rack-flash'
require 'pry-byebug'
require 'json' # why?
require 'pg'   # new

#bundle exec ruby server.rb
#bundle exec rspec

require_relative 'lib/petshopserver.rb'
  
  configure do
    set :bind, '0.0.0.0'
    enable :sessions
    use Rack::Flash
  end

  helpers do
    def mydb
      db = Petshopserver.create_db_connection 'petshopserver'
    end
  end


#   before do
#     if session['user_id'] # if it exists, the user is logged in
#       user_id = session['user_id']
#       db = Petshopserver.create_db_connection 'petshopserver'
#       @current_user = Petshopserver::UsersRepo.find db, user_id
#     else
#       @current_user = {'username' => 'anonymous', 'id' => 1}
#     end
#   end
# #
# for session you use a symbol 

# This is our only html view...
#
get '/' do
  if session['user_id']
    # TODO: Grab user from database
    # @current_user = $sample_user
    user_id = session['user_id']
    @current_user = Petshopserver::UsersRepo.find mydb, user_id
  end
  erb :index
end

get '/logout' do
  session.delete 'user_id'
  redirect to '/'
end

# #
# ...the rest are JSON endpoints
#

get '/shops' do
  # shopscatsdogs = Petshopserver.seed_db(mydb)
  
  # headers['Content-Type'] = 'application/json'
  # RestClient.get("http://pet-shop.api.mks.io/shops")

  shops = Petshopserver::ShopsRepo.get_all_shops mydb
  shops.to_json
end



post '/signin' do
  params = JSON.parse request.body.read

  username = params['username']
  password = params['password']

  # TODO: Grab user by username from database and check password
  #user = { 'username' => 'alice', 'password' => '123' }
  user = Petshopserver::UsersRepo.find_by_username(mydb, username)

  if password == user['password']
    # headers['Content-Type'] = 'application/json'
    session['user_id'] = user['id']
    # 
    # user[:cats] =[]
    # user[:dogs] =[]
    

    user.to_json
    # TODO: Return all pets adopted by this user
    # TODO: Set session[:user_id] so the server will remember this user has logged in
    #$sample_user.to_json
  else
    status 401
  end
end

# user_id = session['user_id']
# db = Petshopserver.create_db_connection 'petshopserver'
# @current_user = Petshopserver::UsersRepo.find db, user_id

 # # # #
# Cats #
# # # #
get '/shops/:id/cats' do
  headers['Content-Type'] = 'application/json'
  id = params[:id]
  # TODO: Grab from database instead
  cats = Petshopserver::CatsRepo.all_from_shop(mydb, id)
  JSON.generate(cats)
end

put '/shops/:shop_id/cats/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  id = params[:id]
  # TODO: Grab from database instead
    adopt_info = {
      type: 'cat',
      user_id: session['user_id'],
      pet_id: id
    }
  cat = Petshopserver::UsersRepo.get_cat_by_id(mydb, id)
  if(cat['adopted'].class.name == 'string')
    Petshopserver::UsersRepo.adopt(mydb, adopt_info)
  end
  # TODO (after you create users table): Attach new cat to logged in user
end


 # # # #
# Dogs #
# # # #
get '/shops/:id/dogs' do
  headers['Content-Type'] = 'application/json'
  id = params[:id]
  # TODO: Update database instead
  dogs = Petshopserver::DogsRepo.all_from_shop(mydb, id)
  JSON.generate(dogs)
end

put '/shops/:shop_id/dogs/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  id = params[:id]
  # TODO: Update database instead
  adopt_info = {
      type: 'dog',
      user_id: session['user_id'],
      pet_id: id
    }
  dog = Petshopserver::UsersRepo.get_dog_by_id(mydb, id)
  if(dog['adopted'].class.name == 'string')
    Petshopserver::UsersRepo.adopt(mydb, adopt_info)
  end
  # TODO (after you create users table): Attach new dog to logged in user
end


# $sample_user = {
#   id: 999,
#   username: 'alice',
#   cats: [
#     { shopId: 1, name: "NaN Cat", imageUrl: "http://i.imgur.com/TOEskNX.jpg", adopted: true, id: 44 },
#     { shopId: 8, name: "Meowzer", imageUrl: "http://www.randomkittengenerator.com/images/cats/rotator.php", id: 8, adopted: "true" }
#   ],
#   dogs: [
#     { shopId: 1, name: "Leaf Pup", imageUrl: "http://i.imgur.com/kuSHji2.jpg", happiness: 2, id: 2, adopted: "true" }
#   ]
# }

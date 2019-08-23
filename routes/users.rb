get '/sessions/new' do
	erb :login
end

post '/sessions' do
	user = User.find_by(email: params[:email])
	if user && user.authenticate(params[:password])
		session[:user_id] = user.id
		redirect '/'
	else
		@message = "Invalid email or password"
		erb :login
	end
end

delete '/sessions' do
	session[:user_id] = nil
	redirect '/'
end

get '/users/new' do
	@error_messages = []
	erb :user_new
end

post '/users' do
  user = User.new
  user.email = params[:email]
  user.username = params[:username]
  user.password = params[:password]
  user.address_line_1 = params[:address_line_1]
  user.suburb = params[:suburb]
  user.postcode = params[:postcode]
  postcode = "http://v0.postcodeapi.com.au/suburbs/#{params[:postcode]}.json"
  result = HTTParty.get(postcode)
  user.lon = result[0]["longitude"]
  user.lat = result[0]["latitude"]
  user.availability = params[:availability]
  if user.save
    redirect '/sessions/new'
  else
    @error_messages = user.errors.full_messages
    erb :user_new
  end
end

get '/users/:id/edit_password' do
  @error_messages = []
  erb :user_edit_password
end

get '/users/:id' do
  @error_messages = []
  erb :user_edit
end

put '/users/:id/password' do
  user = User.find(params[:id])
  if user.authenticate(params[:current_password])
    user.password = params[:password]
    if user.save
      @error_messages = []
      @success_message = "Your password was successfully updated"
      erb :user_edit
    else
      @error_messages = user.errors.full_messages
      erb :user_edit_password
    end
  else
    @error_messages = ["Current password is incorrect"]
    erb :user_edit_password
  end
end

put '/users/:id' do
  user = User.find(params[:id])
  user.email = params[:email]
  user.username = params[:username]
  user.address_line_1 = params[:address_line_1]
  user.suburb = params[:suburb]
  user.postcode = params[:postcode]
  postcode = "http://v0.postcodeapi.com.au/suburbs/#{params[:postcode]}.json"
  result = HTTParty.get(postcode)
  user.lon = result[0]["longitude"]
  user.lat = result[0]["latitude"]
  user.availability = params[:availability]
  if user.authenticate(params[:password])
    user.password = params[:password]
    if user.save
      @error_messages = []
      @success_message = "Your details were successfully updated"
      erb :user_edit
    else
      @error_messages = user.errors.full_messages
      erb :user_edit
    end
  else
    @error_messages = ["Incorrect password"]
    erb :user_edit
  end
end

# get '/api/location/postcode' do
#   postcode = "http://v0.postcodeapi.com.au/suburbs/3000.json"
#   result = HTTParty.get(postcode)
#   result[0].to_json
#   binding.pry
# end
require 'pry'    
require 'sinatra'
require 'sinatra/flash'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'fog/aws'
require 'httparty'
require 'geocoder'

__FILE__
require 'sinatra/reloader' if development?
also_reload File.expand_path(__dir__, + 'models/*') if development?
also_reload File.expand_path(__dir__, + 'views/*') if development?
also_reload File.expand_path(__dir__, + 'routes/*') if development?

require_relative 'database_config'
require_relative 'models/item'
require_relative 'models/offer_status'
require_relative 'models/offer'
require_relative 'models/photo'
require_relative 'models/user'

enable :sessions

helpers do
  def logged_in?
    !!current_user
  end

  def current_user
    User.find_by(id: session[:user_id])
  end
end

before do
  if !logged_in?
    if request.path != '/' && request.path != '/sessions/new' && request.path != '/sessions' && request.path != '/users/new' && request.path != '/users'
      redirect '/sessions/new' 
    end
  end
end

after do 
  ActiveRecord::Base.connection.close
end

get '/' do
  @items = Item.all
  erb :index
end

get '/api/my_items' do
  content_type :json
  items = Item.where(user_id: current_user.id)
  response = []
  items.each do |item|
    object = {}
    object[:id] = item.id
    object[:title] = item.title
    object[:url] = item.photos.first.image_link.url
    object[:offers] = item.reviewer_offers.length
    response << object
  end
  response.to_json
end

get '/api/sort_by_distance/:km' do
  content_type :json

  items = Item.near([current_user.lat, current_user.lon], params[:km], units: :km).to_json(include: :photos)

  # sanitized_distance_query = ActiveRecord::Base.sanitize_sql_array ["( 6371 * acos( cos( radians(?) ) * cos( radians( lat ) ) * cos( radians( lon ) - radians(?) ) + sin( radians(?) ) * sin( radians( lat ) ) ) )", current_user.lat, current_user.lon, current_user.lat]

  # sanitized_distance_query_with_alias = sanitized_distance_query + " AS calculated_distance"

  # data = User.select("users.id, username, postcode #{sanitized_distance_query_with_alias}").joins(:items).where("#{sanitized_distance_query} < ?", params[:km]).order("calculated_distance")

  # data.to_json
end 

require_relative 'routes/users'
require_relative 'routes/items'
require_relative 'routes/offers'